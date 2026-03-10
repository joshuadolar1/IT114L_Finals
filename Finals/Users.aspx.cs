using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Finals
{
    public partial class Users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Index.aspx");
            }

            if (!IsPostBack)
            {
                lblUser.Text = Session["FullName"].ToString();
                LoadUsers();
            }

            // Enable/disable password validators based on whether we're adding or editing
            if (hfUserID.Value == "0")
            {
                rfvPassword.Enabled = true;
                revPassword.Enabled = true;
            }
            else
            {
                rfvPassword.Enabled = false;
                revPassword.Enabled = false;
            }
        }

        private void LoadUsers()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT UserID, Username, FullName, Email, Phone, Address FROM Users WHERE UserType='User' ORDER BY Username";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string connectionString = ConfigurationManager.ConnectionStrings["LibraryDB"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    int userID = Convert.ToInt32(hfUserID.Value);

                    if (userID == 0)
                    {
                        // Check if username already exists
                        string checkQuery = "SELECT COUNT(*) FROM Users WHERE Username = @username";
                        using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                        {
                            checkCmd.Parameters.AddWithValue("@username", txtUsername.Text.Trim());
                            int count = (int)checkCmd.ExecuteScalar();

                            if (count > 0)
                            {
                                lblMessage.Text = "Username already exists! Please choose another.";
                                lblMessage.CssClass = "text-danger fw-bold";
                                return;
                            }
                        }

                        // Insert new user
                        string query = @"INSERT INTO Users (Username, Password, FullName, Email, Phone, Address, UserType) 
                                       VALUES (@username, @password, @fullname, @email, @phone, @address, 'User')";

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@username", txtUsername.Text.Trim());
                            cmd.Parameters.AddWithValue("@password", txtPassword.Text.Trim());
                            cmd.Parameters.AddWithValue("@fullname", txtFullName.Text.Trim());
                            cmd.Parameters.AddWithValue("@email", string.IsNullOrEmpty(txtEmail.Text) ? (object)DBNull.Value : txtEmail.Text.Trim());
                            cmd.Parameters.AddWithValue("@phone", string.IsNullOrEmpty(txtPhone.Text) ? (object)DBNull.Value : txtPhone.Text.Trim());
                            cmd.Parameters.AddWithValue("@address", string.IsNullOrEmpty(txtAddress.Text) ? (object)DBNull.Value : txtAddress.Text.Trim());

                            cmd.ExecuteNonQuery();
                        }

                        lblMessage.Text = "User added successfully!";
                        lblMessage.CssClass = "text-success fw-bold";
                    }
                    else
                    {
                        // Check if username already exists for another user
                        string checkQuery = "SELECT COUNT(*) FROM Users WHERE Username = @username AND UserID != @userID";
                        using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                        {
                            checkCmd.Parameters.AddWithValue("@username", txtUsername.Text.Trim());
                            checkCmd.Parameters.AddWithValue("@userID", userID);
                            int count = (int)checkCmd.ExecuteScalar();

                            if (count > 0)
                            {
                                lblMessage.Text = "Username already exists! Please choose another.";
                                lblMessage.CssClass = "text-danger fw-bold";
                                return;
                            }
                        }

                        // Update existing user
                        string query = @"UPDATE Users SET Username=@username, FullName=@fullname, Email=@email, 
                                       Phone=@phone, Address=@address WHERE UserID=@userID";

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@username", txtUsername.Text.Trim());
                            cmd.Parameters.AddWithValue("@fullname", txtFullName.Text.Trim());
                            cmd.Parameters.AddWithValue("@email", string.IsNullOrEmpty(txtEmail.Text) ? (object)DBNull.Value : txtEmail.Text.Trim());
                            cmd.Parameters.AddWithValue("@phone", string.IsNullOrEmpty(txtPhone.Text) ? (object)DBNull.Value : txtPhone.Text.Trim());
                            cmd.Parameters.AddWithValue("@address", string.IsNullOrEmpty(txtAddress.Text) ? (object)DBNull.Value : txtAddress.Text.Trim());
                            cmd.Parameters.AddWithValue("@userID", userID);

                            cmd.ExecuteNonQuery();
                        }

                        lblMessage.Text = "User updated successfully!";
                        lblMessage.CssClass = "text-success fw-bold";
                    }
                }

                ClearForm();
                LoadUsers();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            hfUserID.Value = "0";
            txtUsername.Text = "";
            txtPassword.Text = "";
            txtFullName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            txtAddress.Text = "";
            lblFormTitle.Text = "Add New User";
            lblMessage.Text = "";

            // Clear validators
            foreach (BaseValidator validator in Page.Validators)
            {
                validator.IsValid = true;
            }
        }

        protected void gvUsers_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditUser")
            {
                int userID = Convert.ToInt32(e.CommandArgument);
                LoadUserForEdit(userID);
            }
            else if (e.CommandName == "DeleteUser")
            {
                int userID = Convert.ToInt32(e.CommandArgument);
                DeleteUser(userID);
            }
        }

        private void LoadUserForEdit(int userID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Users WHERE UserID = @userID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@userID", userID);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        hfUserID.Value = userID.ToString();
                        txtUsername.Text = reader["Username"].ToString();
                        txtFullName.Text = reader["FullName"].ToString();
                        txtEmail.Text = reader["Email"] == DBNull.Value ? "" : reader["Email"].ToString();
                        txtPhone.Text = reader["Phone"] == DBNull.Value ? "" : reader["Phone"].ToString();
                        txtAddress.Text = reader["Address"] == DBNull.Value ? "" : reader["Address"].ToString();
                        txtPassword.Text = ""; // Don't show password
                        lblFormTitle.Text = "Edit User";

                        // Disable password validators for edit
                        rfvPassword.Enabled = false;
                        revPassword.Enabled = false;
                    }
                }
            }
        }

        private void DeleteUser(int userID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Check if user has any BORROWED books (not returned)
                string checkBorrowedQuery = "SELECT COUNT(*) FROM BorrowingRecords WHERE UserID = @userID AND Status = 'Borrowed'";
                using (SqlCommand checkCmd = new SqlCommand(checkBorrowedQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@userID", userID);
                    int borrowedCount = (int)checkCmd.ExecuteScalar();

                    if (borrowedCount > 0)
                    {
                        lblMessage.Text = "Cannot delete user because they have books that are still borrowed! Please return all books first.";
                        lblMessage.CssClass = "text-danger fw-bold";
                        return;
                    }
                }

                // First, delete all borrowing records for this user (history)
                string deleteRecordsQuery = "DELETE FROM BorrowingRecords WHERE UserID = @userID";
                using (SqlCommand deleteRecordsCmd = new SqlCommand(deleteRecordsQuery, conn))
                {
                    deleteRecordsCmd.Parameters.AddWithValue("@userID", userID);
                    deleteRecordsCmd.ExecuteNonQuery();
                }

                // Then delete the user
                string deleteUserQuery = "DELETE FROM Users WHERE UserID = @userID";
                using (SqlCommand deleteUserCmd = new SqlCommand(deleteUserQuery, conn))
                {
                    deleteUserCmd.Parameters.AddWithValue("@userID", userID);
                    deleteUserCmd.ExecuteNonQuery();
                }
            }

            // Reload users after successful deletion
            LoadUsers();

            // Show success message
            lblMessage.Text = "User deleted successfully!";
            lblMessage.CssClass = "text-success fw-bold";
        }

        protected void gvUsers_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
        {
            gvUsers.PageIndex = e.NewPageIndex;
            LoadUsers();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Index.aspx");
        }
    }
}
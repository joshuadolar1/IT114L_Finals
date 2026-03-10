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
    public partial class Borrowing : System.Web.UI.Page
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
                LoadDropDowns();
                LoadBorrowingRecords();
            }
        }

        private void LoadDropDowns()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                // Load Users
                string userQuery = "SELECT UserID, FullName FROM Users WHERE UserType='User' ORDER BY FullName";
                SqlDataAdapter daUsers = new SqlDataAdapter(userQuery, conn);
                DataTable dtUsers = new DataTable();
                daUsers.Fill(dtUsers);

                ddlUsers.DataSource = dtUsers;
                ddlUsers.DataTextField = "FullName";
                ddlUsers.DataValueField = "UserID";
                ddlUsers.DataBind();
                ddlUsers.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select User --", "0"));

                // Load Available Books
                string bookQuery = "SELECT BookID, Title FROM Books WHERE AvailableQuantity > 0 ORDER BY Title";
                SqlDataAdapter daBooks = new SqlDataAdapter(bookQuery, conn);
                DataTable dtBooks = new DataTable();
                daBooks.Fill(dtBooks);

                ddlBooks.DataSource = dtBooks;
                ddlBooks.DataTextField = "Title";
                ddlBooks.DataValueField = "BookID";
                ddlBooks.DataBind();
                ddlBooks.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Book --", "0"));
            }
        }

        private void LoadBorrowingRecords()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT r.RecordID, u.FullName as UserName, b.Title as BookTitle, 
                                        r.BorrowDate, r.DueDate, r.ReturnDate, r.Status
                                 FROM BorrowingRecords r
                                 INNER JOIN Users u ON r.UserID = u.UserID
                                 INNER JOIN Books b ON r.BookID = b.BookID
                                 ORDER BY r.CreatedDate DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvRecords.DataSource = dt;
                gvRecords.DataBind();
            }
        }

        protected void btnBorrow_Click(object sender, EventArgs e)
        {
            if (ddlUsers.SelectedValue == "0" || ddlBooks.SelectedValue == "0")
            {
                lblBorrowMessage.Text = "Please select both user and book!";
                lblBorrowMessage.CssClass = "text-danger";
                return;
            }

            int userID = Convert.ToInt32(ddlUsers.SelectedValue);
            int bookID = Convert.ToInt32(ddlBooks.SelectedValue);
            int dueDays = Convert.ToInt32(txtDueDays.Text);

            string connectionString = ConfigurationManager.ConnectionStrings["LibraryDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Check if book is available
                string checkQuery = "SELECT AvailableQuantity FROM Books WHERE BookID = @bookID";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@bookID", bookID);
                    int available = Convert.ToInt32(checkCmd.ExecuteScalar());

                    if (available <= 0)
                    {
                        lblBorrowMessage.Text = "Book is not available!";
                        lblBorrowMessage.CssClass = "text-danger";
                        return;
                    }
                }

                // Create borrowing record
                string borrowQuery = @"INSERT INTO BorrowingRecords (UserID, BookID, DueDate, Status) 
                                      VALUES (@userID, @bookID, DATEADD(day, @dueDays, GETDATE()), 'Borrowed')";

                using (SqlCommand borrowCmd = new SqlCommand(borrowQuery, conn))
                {
                    borrowCmd.Parameters.AddWithValue("@userID", userID);
                    borrowCmd.Parameters.AddWithValue("@bookID", bookID);
                    borrowCmd.Parameters.AddWithValue("@dueDays", dueDays);
                    borrowCmd.ExecuteNonQuery();
                }

                // Update available quantity
                string updateQuery = "UPDATE Books SET AvailableQuantity = AvailableQuantity - 1 WHERE BookID = @bookID";
                using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                {
                    updateCmd.Parameters.AddWithValue("@bookID", bookID);
                    updateCmd.ExecuteNonQuery();
                }
            }

            lblBorrowMessage.Text = "Book borrowed successfully!";
            lblBorrowMessage.CssClass = "text-success";

            // Refresh data
            LoadDropDowns();
            LoadBorrowingRecords();
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtReturnID.Text))
            {
                lblReturnMessage.Text = "Please enter Record ID!";
                lblReturnMessage.CssClass = "text-danger";
                return;
            }

            int recordID = Convert.ToInt32(txtReturnID.Text);

            string connectionString = ConfigurationManager.ConnectionStrings["LibraryDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Get book ID from record
                string getBookQuery = "SELECT BookID FROM BorrowingRecords WHERE RecordID = @recordID AND Status = 'Borrowed'";
                int bookID = 0;

                using (SqlCommand getCmd = new SqlCommand(getBookQuery, conn))
                {
                    getCmd.Parameters.AddWithValue("@recordID", recordID);
                    object result = getCmd.ExecuteScalar();

                    if (result == null)
                    {
                        lblReturnMessage.Text = "Invalid Record ID or book already returned!";
                        lblReturnMessage.CssClass = "text-danger";
                        return;
                    }

                    bookID = Convert.ToInt32(result);
                }

                // Update return record
                string returnQuery = "UPDATE BorrowingRecords SET ReturnDate = GETDATE(), Status = 'Returned' WHERE RecordID = @recordID";
                using (SqlCommand returnCmd = new SqlCommand(returnQuery, conn))
                {
                    returnCmd.Parameters.AddWithValue("@recordID", recordID);
                    returnCmd.ExecuteNonQuery();
                }

                // Update available quantity
                string updateQuery = "UPDATE Books SET AvailableQuantity = AvailableQuantity + 1 WHERE BookID = @bookID";
                using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                {
                    updateCmd.Parameters.AddWithValue("@bookID", bookID);
                    updateCmd.ExecuteNonQuery();
                }
            }

            lblReturnMessage.Text = "Book returned successfully!";
            lblReturnMessage.CssClass = "text-success";
            txtReturnID.Text = "";

            // Refresh data
            LoadDropDowns();
            LoadBorrowingRecords();
        }

        protected void gvRecords_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
        {
            gvRecords.PageIndex = e.NewPageIndex;
            LoadBorrowingRecords();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Index.aspx");
        }
    }
}
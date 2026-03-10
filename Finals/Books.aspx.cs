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
    public partial class Books : System.Web.UI.Page
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
                LoadYears();
                LoadBooks();
            }
        }

        private void LoadYears()
        {
            try
            {
                // Load years from 1900 to current year + 5
                int currentYear = DateTime.Now.Year;
                for (int year = currentYear + 5; year >= 1900; year--)
                {
                    ddlYear.Items.Add(new System.Web.UI.WebControls.ListItem(year.ToString(), year.ToString()));
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading years: " + ex.Message;
                lblMessage.CssClass = "text-danger fw-bold";
            }
        }

        private void LoadBooks()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    string query = "SELECT BookID, Title, Author, Category, Publisher, PublicationYear, Quantity, AvailableQuantity FROM Books ORDER BY Title";
                    SqlDataAdapter da = new SqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvBooks.DataSource = dt;
                    gvBooks.DataBind();

                    if (dt.Rows.Count == 0)
                    {
                        lblMessage.Text = "No books found in the database.";
                        lblMessage.CssClass = "text-info fw-bold";
                    }
                }
                catch (SqlException ex)
                {
                    lblMessage.Text = "Database error: " + ex.Message;
                    lblMessage.CssClass = "text-danger fw-bold";
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error loading books: " + ex.Message;
                    lblMessage.CssClass = "text-danger fw-bold";
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string connectionString = ConfigurationManager.ConnectionStrings["LibraryDB"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try
                    {
                        conn.Open();

                        int bookID = Convert.ToInt32(hfBookID.Value);
                        int quantity = Convert.ToInt32(ddlQuantity.SelectedValue);

                        if (bookID == 0)
                        {
                            // Insert new book
                            string query = @"INSERT INTO Books (Title, Author, Category, Publisher, PublicationYear, Quantity, AvailableQuantity) 
                                           VALUES (@title, @author, @category, @publisher, @year, @quantity, @quantity)";

                            using (SqlCommand cmd = new SqlCommand(query, conn))
                            {
                                cmd.Parameters.AddWithValue("@title", txtTitle.Text.Trim());
                                cmd.Parameters.AddWithValue("@author", txtAuthor.Text.Trim());
                                cmd.Parameters.AddWithValue("@category", ddlCategory.SelectedValue);

                                // Publisher - handle NULL
                                if (string.IsNullOrEmpty(txtPublisher.Text.Trim()))
                                {
                                    cmd.Parameters.AddWithValue("@publisher", DBNull.Value);
                                }
                                else
                                {
                                    cmd.Parameters.AddWithValue("@publisher", txtPublisher.Text.Trim());
                                }

                                // Year - handle NULL
                                if (string.IsNullOrEmpty(ddlYear.SelectedValue))
                                {
                                    cmd.Parameters.AddWithValue("@year", DBNull.Value);
                                }
                                else
                                {
                                    cmd.Parameters.AddWithValue("@year", Convert.ToInt32(ddlYear.SelectedValue));
                                }

                                cmd.Parameters.AddWithValue("@quantity", quantity);

                                int rowsAffected = cmd.ExecuteNonQuery();

                                if (rowsAffected > 0)
                                {
                                    lblMessage.Text = "Book added successfully!";
                                    lblMessage.CssClass = "text-success fw-bold";
                                }
                                else
                                {
                                    lblMessage.Text = "Failed to add book!";
                                    lblMessage.CssClass = "text-danger fw-bold";
                                    return;
                                }
                            }
                        }
                        else
                        {
                            // Get current quantity to calculate new available quantity
                            string getCurrentQuery = "SELECT Quantity, AvailableQuantity FROM Books WHERE BookID = @bookID";
                            int currentQuantity = 0;
                            int currentAvailable = 0;

                            using (SqlCommand getCmd = new SqlCommand(getCurrentQuery, conn))
                            {
                                getCmd.Parameters.AddWithValue("@bookID", bookID);
                                SqlDataReader reader = getCmd.ExecuteReader();
                                if (reader.Read())
                                {
                                    currentQuantity = reader["Quantity"] != DBNull.Value ? Convert.ToInt32(reader["Quantity"]) : 0;
                                    currentAvailable = reader["AvailableQuantity"] != DBNull.Value ? Convert.ToInt32(reader["AvailableQuantity"]) : 0;
                                }
                                reader.Close();
                            }

                            // Calculate new available quantity
                            int quantityDifference = quantity - currentQuantity;
                            int newAvailable = currentAvailable + quantityDifference;
                            if (newAvailable < 0) newAvailable = 0;

                            // Update existing book
                            string query = @"UPDATE Books SET Title=@title, Author=@author, 
                                           Category=@category, Publisher=@publisher, PublicationYear=@year, 
                                           Quantity=@quantity, AvailableQuantity=@newAvailable WHERE BookID=@bookID";

                            using (SqlCommand cmd = new SqlCommand(query, conn))
                            {
                                cmd.Parameters.AddWithValue("@title", txtTitle.Text.Trim());
                                cmd.Parameters.AddWithValue("@author", txtAuthor.Text.Trim());
                                cmd.Parameters.AddWithValue("@category", ddlCategory.SelectedValue);

                                // Publisher - handle NULL
                                if (string.IsNullOrEmpty(txtPublisher.Text.Trim()))
                                {
                                    cmd.Parameters.AddWithValue("@publisher", DBNull.Value);
                                }
                                else
                                {
                                    cmd.Parameters.AddWithValue("@publisher", txtPublisher.Text.Trim());
                                }

                                // Year - handle NULL
                                if (string.IsNullOrEmpty(ddlYear.SelectedValue))
                                {
                                    cmd.Parameters.AddWithValue("@year", DBNull.Value);
                                }
                                else
                                {
                                    cmd.Parameters.AddWithValue("@year", Convert.ToInt32(ddlYear.SelectedValue));
                                }

                                cmd.Parameters.AddWithValue("@quantity", quantity);
                                cmd.Parameters.AddWithValue("@newAvailable", newAvailable);
                                cmd.Parameters.AddWithValue("@bookID", bookID);

                                int rowsAffected = cmd.ExecuteNonQuery();

                                if (rowsAffected > 0)
                                {
                                    lblMessage.Text = "Book updated successfully!";
                                    lblMessage.CssClass = "text-success fw-bold";
                                }
                                else
                                {
                                    lblMessage.Text = "Failed to update book!";
                                    lblMessage.CssClass = "text-danger fw-bold";
                                    return;
                                }
                            }
                        }

                        ClearForm();
                        LoadBooks();
                    }
                    catch (SqlException ex)
                    {
                        // Handle SQL errors
                        if (ex.Number == 2627) // Unique constraint violation
                        {
                            lblMessage.Text = "Duplicate entry!";
                        }
                        else if (ex.Number == 547) // Foreign key constraint violation
                        {
                            lblMessage.Text = "Cannot delete/update because related records exist!";
                        }
                        else
                        {
                            lblMessage.Text = "Database error: " + ex.Message;
                        }
                        lblMessage.CssClass = "text-danger fw-bold";
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Error: " + ex.Message;
                        lblMessage.CssClass = "text-danger fw-bold";
                    }
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            hfBookID.Value = "0";
            txtTitle.Text = "";
            txtAuthor.Text = "";
            txtPublisher.Text = "";
            lblAvailableQuantity.Text = "";
            lblFormTitle.Text = "Add New Book";
            lblMessage.Text = "";

            // Clear all dropdown selections
            ddlCategory.ClearSelection();
            ddlYear.ClearSelection();
            ddlQuantity.ClearSelection();
        }

        protected void gvBooks_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditBook")
            {
                int bookID = Convert.ToInt32(e.CommandArgument);
                LoadBookForEdit(bookID);
            }
            else if (e.CommandName == "DeleteBook")
            {
                int bookID = Convert.ToInt32(e.CommandArgument);
                DeleteBook(bookID);
            }
        }

        private void LoadBookForEdit(int bookID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    string query = "SELECT * FROM Books WHERE BookID = @bookID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@bookID", bookID);
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            hfBookID.Value = bookID.ToString();
                            txtTitle.Text = reader["Title"].ToString();
                            txtAuthor.Text = reader["Author"].ToString();
                            txtPublisher.Text = reader["Publisher"] == DBNull.Value ? "" : reader["Publisher"].ToString();

                            // Clear selected values first to prevent multiple selection error
                            ddlCategory.ClearSelection();
                            ddlYear.ClearSelection();
                            ddlQuantity.ClearSelection();

                            // Set category dropdown
                            string category = reader["Category"] != DBNull.Value ? reader["Category"].ToString() : "";
                            if (!string.IsNullOrEmpty(category))
                            {
                                System.Web.UI.WebControls.ListItem item = ddlCategory.Items.FindByValue(category);
                                if (item != null)
                                    item.Selected = true;
                            }

                            // Set year dropdown
                            if (reader["PublicationYear"] != DBNull.Value)
                            {
                                string year = reader["PublicationYear"].ToString();
                                System.Web.UI.WebControls.ListItem yearItem = ddlYear.Items.FindByValue(year);
                                if (yearItem != null)
                                    yearItem.Selected = true;
                            }

                            // Set quantity dropdown
                            string quantity = reader["Quantity"].ToString();
                            System.Web.UI.WebControls.ListItem qtyItem = ddlQuantity.Items.FindByValue(quantity);
                            if (qtyItem != null)
                                qtyItem.Selected = true;

                            lblAvailableQuantity.Text = reader["AvailableQuantity"].ToString();
                            lblFormTitle.Text = "Edit Book";
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error loading book: " + ex.Message;
                    lblMessage.CssClass = "text-danger fw-bold";
                }
            }
        }

        private void DeleteBook(int bookID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Check if book is currently borrowed
                    string checkBorrowedQuery = "SELECT COUNT(*) FROM BorrowingRecords WHERE BookID = @bookID AND Status = 'Borrowed'";
                    using (SqlCommand checkCmd = new SqlCommand(checkBorrowedQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@bookID", bookID);
                        int borrowedCount = (int)checkCmd.ExecuteScalar();

                        if (borrowedCount > 0)
                        {
                            lblMessage.Text = "Cannot delete book because it is currently borrowed! Please wait for return.";
                            lblMessage.CssClass = "text-danger fw-bold";
                            return;
                        }
                    }

                    // Check if book has any borrowing history (even returned books)
                    string checkHistoryQuery = "SELECT COUNT(*) FROM BorrowingRecords WHERE BookID = @bookID";
                    using (SqlCommand checkHistoryCmd = new SqlCommand(checkHistoryQuery, conn))
                    {
                        checkHistoryCmd.Parameters.AddWithValue("@bookID", bookID);
                        int historyCount = (int)checkHistoryCmd.ExecuteScalar();

                        if (historyCount > 0)
                        {
                            // Option 1: Delete borrowing records first, then delete the book
                            string deleteRecordsQuery = "DELETE FROM BorrowingRecords WHERE BookID = @bookID";
                            using (SqlCommand deleteRecordsCmd = new SqlCommand(deleteRecordsQuery, conn))
                            {
                                deleteRecordsCmd.Parameters.AddWithValue("@bookID", bookID);
                                deleteRecordsCmd.ExecuteNonQuery();
                            }

                            // Then delete the book
                            string deleteBookQuery = "DELETE FROM Books WHERE BookID = @bookID";
                            using (SqlCommand deleteBookCmd = new SqlCommand(deleteBookQuery, conn))
                            {
                                deleteBookCmd.Parameters.AddWithValue("@bookID", bookID);
                                deleteBookCmd.ExecuteNonQuery();
                            }

                            lblMessage.Text = "Book and its borrowing history deleted successfully!";
                            lblMessage.CssClass = "text-success fw-bold";
                        }
                        else
                        {
                            // No history, just delete the book
                            string deleteBookQuery = "DELETE FROM Books WHERE BookID = @bookID";
                            using (SqlCommand deleteBookCmd = new SqlCommand(deleteBookQuery, conn))
                            {
                                deleteBookCmd.Parameters.AddWithValue("@bookID", bookID);
                                deleteBookCmd.ExecuteNonQuery();
                            }

                            lblMessage.Text = "Book deleted successfully!";
                            lblMessage.CssClass = "text-success fw-bold";
                        }
                    }
                }
                catch (SqlException ex)
                {
                    // More detailed error message
                    if (ex.Number == 547) // Foreign key constraint violation
                    {
                        lblMessage.Text = "This book has borrowing history and cannot be deleted. Please delete borrowing records first.";
                    }
                    else
                    {
                        lblMessage.Text = "Database error: " + ex.Message;
                    }
                    lblMessage.CssClass = "text-danger fw-bold";
                }
            }

            LoadBooks();
        }

        protected void gvBooks_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
        {
            gvBooks.PageIndex = e.NewPageIndex;
            LoadBooks();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Index.aspx");
        }
    }
}
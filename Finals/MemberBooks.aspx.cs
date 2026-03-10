using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Finals
{
    public partial class MemberBooks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("MemberLogin.aspx");
            }

            if (!IsPostBack)
            {
                lblUser.Text = Session["FullName"].ToString();
                LoadBooks();
            }
        }

        private void LoadBooks(string searchTerm = "")
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    string query;
                    SqlCommand cmd;

                    if (string.IsNullOrEmpty(searchTerm))
                    {
                        // Load all books
                        query = "SELECT BookID, Title, Author, Category, Publisher, PublicationYear, Quantity, AvailableQuantity FROM Books ORDER BY Title";
                        cmd = new SqlCommand(query, conn);
                    }
                    else
                    {
                        // Search books by title or author
                        query = @"SELECT BookID, Title, Author, Category, Publisher, PublicationYear, Quantity, AvailableQuantity 
                                 FROM Books 
                                 WHERE Title LIKE @search OR Author LIKE @search 
                                 ORDER BY Title";
                        cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@search", "%" + searchTerm + "%");
                    }

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptBooks.DataSource = dt;
                    rptBooks.DataBind();

                    // Show/hide no results message
                    if (dt.Rows.Count == 0)
                    {
                        lblNoBooks.Text = "No books found matching your search.";
                        lblNoBooks.Visible = true;
                    }
                    else
                    {
                        lblNoBooks.Visible = false;
                    }
                }
                catch (Exception ex)
                {
                    // Show error message
                    lblMessage.Text = "Error loading books: " + ex.Message;
                    lblMessage.CssClass = "text-danger";
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadBooks(txtSearch.Text.Trim());
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            LoadBooks();
        }

        protected void rptBooks_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Borrow")
            {
                try
                {
                    int bookID = Convert.ToInt32(e.CommandArgument);
                    int userID = Convert.ToInt32(Session["UserID"]);

                    string connectionString = ConfigurationManager.ConnectionStrings["LibraryDB"].ConnectionString;

                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();

                        // Check if user already borrowed this book
                        string checkQuery = "SELECT COUNT(*) FROM BorrowingRecords WHERE UserID = @userID AND BookID = @bookID AND Status = 'Borrowed'";
                        using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                        {
                            checkCmd.Parameters.AddWithValue("@userID", userID);
                            checkCmd.Parameters.AddWithValue("@bookID", bookID);

                            int alreadyBorrowed = (int)checkCmd.ExecuteScalar();
                            if (alreadyBorrowed > 0)
                            {
                                lblMessage.Text = "You have already borrowed this book!";
                                lblMessage.CssClass = "text-danger";
                                return;
                            }
                        }

                        // Check available quantity
                        string availQuery = "SELECT AvailableQuantity FROM Books WHERE BookID = @bookID";
                        using (SqlCommand availCmd = new SqlCommand(availQuery, conn))
                        {
                            availCmd.Parameters.AddWithValue("@bookID", bookID);
                            int available = Convert.ToInt32(availCmd.ExecuteScalar());

                            if (available <= 0)
                            {
                                lblMessage.Text = "Book is not available!";
                                lblMessage.CssClass = "text-danger";
                                return;
                            }
                        }

                        // Create borrowing record
                        string borrowQuery = @"INSERT INTO BorrowingRecords (UserID, BookID, DueDate, Status) 
                                              VALUES (@userID, @bookID, DATEADD(day, 7, GETDATE()), 'Borrowed')";

                        using (SqlCommand borrowCmd = new SqlCommand(borrowQuery, conn))
                        {
                            borrowCmd.Parameters.AddWithValue("@userID", userID);
                            borrowCmd.Parameters.AddWithValue("@bookID", bookID);
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

                    lblMessage.Text = "Book borrowed successfully!";
                    lblMessage.CssClass = "text-success";
                    LoadBooks(); // Refresh the list
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error borrowing book: " + ex.Message;
                    lblMessage.CssClass = "text-danger";
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Index.aspx");
        }
    }
}
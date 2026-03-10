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
    public partial class MyBorrowedBooks : System.Web.UI.Page
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
                LoadBorrowedBooks();
            }
        }

        private void LoadBorrowedBooks()
        {
            int userID = Convert.ToInt32(Session["UserID"]);
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                // Current borrowed books
                string currentQuery = @"SELECT b.Title, b.Author, r.BorrowDate, r.DueDate
                                       FROM BorrowingRecords r
                                       INNER JOIN Books b ON r.BookID = b.BookID
                                       WHERE r.UserID = @userID AND r.Status = 'Borrowed'
                                       ORDER BY r.DueDate";

                SqlDataAdapter daCurrent = new SqlDataAdapter(currentQuery, conn);
                daCurrent.SelectCommand.Parameters.AddWithValue("@userID", userID);
                DataTable dtCurrent = new DataTable();
                daCurrent.Fill(dtCurrent);
                gvCurrentBooks.DataSource = dtCurrent;
                gvCurrentBooks.DataBind();

                // Borrowing history
                string historyQuery = @"SELECT b.Title, b.Author, r.BorrowDate, r.ReturnDate, r.Status
                                       FROM BorrowingRecords r
                                       INNER JOIN Books b ON r.BookID = b.BookID
                                       WHERE r.UserID = @userID AND r.Status = 'Returned'
                                       ORDER BY r.ReturnDate DESC";

                SqlDataAdapter daHistory = new SqlDataAdapter(historyQuery, conn);
                daHistory.SelectCommand.Parameters.AddWithValue("@userID", userID);
                DataTable dtHistory = new DataTable();
                daHistory.Fill(dtHistory);
                gvHistory.DataSource = dtHistory;
                gvHistory.DataBind();

                if (dtCurrent.Rows.Count == 0 && dtHistory.Rows.Count == 0)
                {
                    lblMessage.Text = "You haven't borrowed any books yet.";
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
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Finals
{
    public partial class Dashboard : System.Web.UI.Page
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
                LoadStatistics();
            }
        }

        private void LoadStatistics()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Total Users (count of user accounts)
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE UserType='User'", conn))
                {
                    lblTotalUsers.Text = cmd.ExecuteScalar().ToString();
                }

                // Total Books (count of unique book titles)
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Books", conn))
                {
                    lblTotalBooks.Text = cmd.ExecuteScalar().ToString();
                }

                // Books Borrowed (count of books currently checked out)
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM BorrowingRecords WHERE Status='Borrowed'", conn))
                {
                    lblBorrowedBooks.Text = cmd.ExecuteScalar().ToString();
                }

                // Available Books (total copies available to borrow)
                using (SqlCommand cmd = new SqlCommand("SELECT ISNULL(SUM(AvailableQuantity), 0) FROM Books", conn))
                {
                    int totalAvailable = (int)cmd.ExecuteScalar();
                    lblAvailableBooks.Text = totalAvailable.ToString();
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
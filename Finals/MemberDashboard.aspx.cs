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
    public partial class MemberDashboard : System.Web.UI.Page
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

                // Total Books (count of unique titles)
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Books", conn))
                {
                    lblTotalBooks.Text = cmd.ExecuteScalar().ToString();
                }

                // Books Borrowed by this member
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM BorrowingRecords WHERE UserID = @userID AND Status = 'Borrowed'", conn))
                {
                    cmd.Parameters.AddWithValue("@userID", Session["UserID"]);
                    lblBorrowedBooks.Text = cmd.ExecuteScalar().ToString();
                }

                // Available Books (total copies available)
                using (SqlCommand cmd = new SqlCommand("SELECT ISNULL(SUM(AvailableQuantity), 0) FROM Books", conn))
                {
                    lblAvailableBooks.Text = cmd.ExecuteScalar().ToString();
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
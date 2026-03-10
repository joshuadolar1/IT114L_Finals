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
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
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

                // Active Members
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE UserType='User' AND IsActive=1", conn))
                {
                    lblActiveMembers.Text = cmd.ExecuteScalar().ToString();
                }

                // Books Borrowed
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM BorrowingRecords WHERE Status='Borrowed'", conn))
                {
                    lblBooksBorrowed.Text = cmd.ExecuteScalar().ToString();
                }

                // Available Books (total copies)
                using (SqlCommand cmd = new SqlCommand("SELECT ISNULL(SUM(AvailableQuantity), 0) FROM Books", conn))
                {
                    lblAvailableBooks.Text = cmd.ExecuteScalar().ToString();
                }
            }
        }
    }
}
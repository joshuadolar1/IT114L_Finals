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
    public partial class MemberLogin : System.Web.UI.Page
    {
        protected void btnMemberLogin_Click(object sender, EventArgs e)
        {
            string username = txtMemberUsername.Text.Trim();
            string password = txtMemberPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please enter username and password";
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["LibraryDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                // Check if user exists and is a member (UserType = 'User')
                string query = "SELECT UserID, Username, FullName FROM Users WHERE Username = @username AND Password = @password AND UserType = 'User' AND IsActive = 1";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@username", username);
                    cmd.Parameters.AddWithValue("@password", password);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        Session["UserID"] = reader["UserID"].ToString();
                        Session["Username"] = reader["Username"].ToString();
                        Session["FullName"] = reader["FullName"].ToString();
                        Session["UserType"] = "User";

                        Response.Redirect("MemberDashboard.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Invalid username or password";
                    }
                }
            }
        }
    }
}
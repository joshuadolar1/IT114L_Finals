<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MemberLogin.aspx.cs" Inherits="Finals.MemberLogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Member Login - Library System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <style>
        .login-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            background-color: white;
        }
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .login-header i {
            font-size: 3rem;
            color: #0d6efd;
        }
        .login-header h2 {
            color: #333;
            margin-top: 10px;
        }
        .login-header p {
            color: #666;
            font-size: 0.9rem;
        }
        .btn-login {
            padding: 10px;
            font-weight: 500;
        }
        .back-link {
            text-align: center;
            margin-top: 20px;
        }
        .back-link a {
            color: #666;
            text-decoration: none;
        }
        .back-link a:hover {
            color: #0d6efd;
        }
    </style>
</head>
<body class="bg-light">
    <form id="form1" runat="server">
        <div class="container">
            <div class="login-container">
                <div class="login-header">
                    <i class="bi bi-person-circle"></i>
                    <h2>Member Login</h2>
                    <p>Enter your credentials to access the library</p>
                </div>
                
                <!-- Username Field -->
                <div class="mb-3">
                    <label for="txtMemberUsername" class="form-label fw-bold">
                        <i class="bi bi-person"></i> Username
                    </label>
                    <asp:TextBox ID="txtMemberUsername" runat="server" 
                        CssClass="form-control form-control-lg" 
                        placeholder="Enter your username">
                    </asp:TextBox>
                </div>
                
                <!-- Password Field -->
                <div class="mb-4">
                    <label for="txtMemberPassword" class="form-label fw-bold">
                        <i class="bi bi-lock"></i> Password
                    </label>
                    <asp:TextBox ID="txtMemberPassword" runat="server" 
                        TextMode="Password" 
                        CssClass="form-control form-control-lg" 
                        placeholder="Enter your password">
                    </asp:TextBox>
                </div>
                
                <!-- Login Button -->
                <asp:Button ID="btnMemberLogin" runat="server" 
                    Text="Login as Member" 
                    CssClass="btn btn-primary btn-lg w-100 btn-login" 
                    OnClick="btnMemberLogin_Click" />
                
                <!-- Message Label -->
                <asp:Label ID="lblMessage" runat="server" 
                    CssClass="text-danger mt-3 d-block text-center">
                </asp:Label>
                
                <!-- Info Text -->
                <div class="mt-4 text-center small text-muted">
                    <p class="mb-1">Default Librarian: admin / admin123</p>
                    <p>Members: Created by librarian</p>
                </div>
                
                <!-- Back to Home Link -->
                <div class="back-link">
                    <a href="Index.aspx">
                        <i class="bi bi-arrow-left"></i> Back to Home
                    </a>
                </div>
            </div>
        </div>
    </form>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
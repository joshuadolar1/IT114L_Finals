<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LibrarianLogin.aspx.cs" Inherits="Finals.LibrarianLogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Librarian Login - Library System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .login-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="login-container bg-light">
                <h2 class="text-center mb-4">Library Management System</h2>
                <h5 class="text-center mb-4">Librarian Login</h5>
                
                <div class="mb-3">
                    <label for="txtUsername" class="form-label">Username</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                
                <div class="mb-3">
                    <label for="txtPassword" class="form-label">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                </div>
                
                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary w-100" OnClick="btnLogin_Click" />
                
                <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mt-3 d-block text-center"></asp:Label>
                
                <div class="mt-3 text-center">
                    <a href="Index.aspx">← Back to Home</a>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
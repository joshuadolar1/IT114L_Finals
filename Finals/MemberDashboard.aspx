<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MemberDashboard.aspx.cs" Inherits="Finals.MemberDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Member Dashboard - Library System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-dark bg-success">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Library Management System (Member)</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="MemberDashboard.aspx">Dashboard</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="MemberBooks.aspx">Browse Books</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="MyBorrowedBooks.aspx">My Borrowed Books</a>
                        </li>
                    </ul>
                    <span class="navbar-text text-white me-3">
                        Welcome, <asp:Label ID="lblUser" runat="server"></asp:Label> (Member)
                    </span>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-outline-light" OnClick="btnLogout_Click" />
                </div>
            </div>
        </nav>

        <div class="container mt-4">
            <h2>Member Dashboard</h2>
            
            <div class="row mt-4">
                <div class="col-md-4">
                    <div class="card text-white bg-primary mb-3">
                        <div class="card-header">Total Books</div>
                        <div class="card-body">
                            <h3 class="card-title"><asp:Label ID="lblTotalBooks" runat="server" Text="0"></asp:Label></h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-warning mb-3">
                        <div class="card-header">Books Borrowed</div>
                        <div class="card-body">
                            <h3 class="card-title"><asp:Label ID="lblBorrowedBooks" runat="server" Text="0"></asp:Label></h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-success mb-3">
                        <div class="card-header">Available Books</div>
                        <div class="card-body">
                            <h3 class="card-title"><asp:Label ID="lblAvailableBooks" runat="server" Text="0"></asp:Label></h3>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="row mt-3">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header bg-info text-white">
                            Quick Actions
                        </div>
                        <div class="card-body">
                            <a href="MemberBooks.aspx" class="btn btn-primary me-2">Browse Books</a>
                            <a href="MyBorrowedBooks.aspx" class="btn btn-warning">View My Borrowed Books</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
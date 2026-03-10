<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Finals.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard - Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Library Management System</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="Dashboard.aspx">Dashboard</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Users.aspx">Users</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Books.aspx">Books</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Borrowing.aspx">Borrowing</a>
                        </li>
                    </ul>
                    <span class="navbar-text text-white me-3">
                        Welcome, <asp:Label ID="lblUser" runat="server"></asp:Label>
                    </span>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-outline-light" OnClick="btnLogout_Click" />
                </div>
            </div>
        </nav>

        <div class="container mt-4">
            <h2>Dashboard</h2>
            <div class="row mt-4">
                <div class="col-md-3">
                    <div class="card text-white bg-primary mb-3">
                        <div class="card-header">Total Users</div>
                        <div class="card-body">
                            <h3 class="card-title"><asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label></h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-success mb-3">
                        <div class="card-header">Total Books</div>
                        <div class="card-body">
                            <h3 class="card-title"><asp:Label ID="lblTotalBooks" runat="server" Text="0"></asp:Label></h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-warning mb-3">
                        <div class="card-header">Borrowed Books</div>
                        <div class="card-body">
                            <h3 class="card-title"><asp:Label ID="lblBorrowedBooks" runat="server" Text="0"></asp:Label></h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-info mb-3">
                        <div class="card-header">Available Books</div>
                        <div class="card-body">
                            <h3 class="card-title"><asp:Label ID="lblAvailableBooks" runat="server" Text="0"></asp:Label></h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
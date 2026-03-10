<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyBorrowedBooks.aspx.cs" Inherits="Finals.MyBorrowedBooks" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Borrowed Books - Library System</title>
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
                            <a class="nav-link" href="MemberDashboard.aspx">Dashboard</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="MemberBooks.aspx">Browse Books</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="MyBorrowedBooks.aspx">My Borrowed Books</a>
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
            <h2>My Borrowed Books</h2>
            
            <!-- Currently Borrowed Books -->
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    Currently Borrowed Books
                </div>
                <div class="card-body">
                    <asp:GridView ID="gvCurrentBooks" runat="server" AutoGenerateColumns="False" 
                        CssClass="table table-striped table-bordered" EmptyDataText="No books currently borrowed">
                        <Columns>
                            <asp:BoundField DataField="Title" HeaderText="Book Title" />
                            <asp:BoundField DataField="Author" HeaderText="Author" />
                            <asp:BoundField DataField="BorrowDate" HeaderText="Borrowed On" DataFormatString="{0:MM/dd/yyyy}" />
                            <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:MM/dd/yyyy}" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            
            <!-- Borrowing History -->
            <div class="card">
                <div class="card-header bg-secondary text-white">
                    Borrowing History
                </div>
                <div class="card-body">
                    <asp:GridView ID="gvHistory" runat="server" AutoGenerateColumns="False" 
                        CssClass="table table-striped table-bordered" EmptyDataText="No borrowing history">
                        <Columns>
                            <asp:BoundField DataField="Title" HeaderText="Book Title" />
                            <asp:BoundField DataField="Author" HeaderText="Author" />
                            <asp:BoundField DataField="BorrowDate" HeaderText="Borrowed On" DataFormatString="{0:MM/dd/yyyy}" />
                            <asp:BoundField DataField="ReturnDate" HeaderText="Returned On" DataFormatString="{0:MM/dd/yyyy}" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            
            <asp:Label ID="lblMessage" runat="server" CssClass="text-info mt-3 d-block"></asp:Label>
        </div>
    </form>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
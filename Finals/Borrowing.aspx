<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Borrowing.aspx.cs" Inherits="Finals.Borrowing" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Borrowing Management - Library System</title>
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
                            <a class="nav-link" href="Dashboard.aspx">Dashboard</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Users.aspx">Users</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Books.aspx">Books</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="Borrowing.aspx">Borrowing</a>
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
            <h2>Borrowing Management</h2>
            
            <!-- Borrow Book Panel -->
            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            Borrow Book
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label class="form-label">Select User</label>
                                <asp:DropDownList ID="ddlUsers" runat="server" CssClass="form-select"></asp:DropDownList>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Select Book</label>
                                <asp:DropDownList ID="ddlBooks" runat="server" CssClass="form-select"></asp:DropDownList>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Due Date (Days to borrow)</label>
                                <asp:TextBox ID="txtDueDays" runat="server" CssClass="form-control" TextMode="Number" Text="7"></asp:TextBox>
                            </div>
                            <asp:Button ID="btnBorrow" runat="server" Text="Borrow Book" CssClass="btn btn-primary" OnClick="btnBorrow_Click" />
                            <asp:Label ID="lblBorrowMessage" runat="server" CssClass="ms-3"></asp:Label>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-success text-white">
                            Return Book
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label class="form-label">Enter Record ID to Return</label>
                                <asp:TextBox ID="txtReturnID" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                            </div>
                            <asp:Button ID="btnReturn" runat="server" Text="Return Book" CssClass="btn btn-success" OnClick="btnReturn_Click" />
                            <asp:Label ID="lblReturnMessage" runat="server" CssClass="ms-3"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Borrowing Records Grid -->
            <div class="card">
                <div class="card-header bg-info text-white">
                    Borrowing Records
                </div>
                <div class="card-body">
                    <asp:GridView ID="gvRecords" runat="server" AutoGenerateColumns="False" 
                        CssClass="table table-striped table-bordered" AllowPaging="True" PageSize="10"
                        OnPageIndexChanging="gvRecords_PageIndexChanging">
                        <Columns>
                            <asp:BoundField DataField="RecordID" HeaderText="ID" />
                            <asp:BoundField DataField="UserName" HeaderText="Borrower" />
                            <asp:BoundField DataField="BookTitle" HeaderText="Book" />
                            <asp:BoundField DataField="BorrowDate" HeaderText="Borrow Date" DataFormatString="{0:MM/dd/yyyy}" />
                            <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:MM/dd/yyyy}" />
                            <asp:BoundField DataField="ReturnDate" HeaderText="Return Date" DataFormatString="{0:MM/dd/yyyy}" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                        </Columns>
                        <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" />
                        <PagerStyle CssClass="pagination justify-content-center" />
                    </asp:GridView>
                </div>
            </div>
        </div>
    </form>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
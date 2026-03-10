<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Books.aspx.cs" Inherits="Finals.Books" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Book Management - Library System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <style>
        .card-header {
            font-weight: bold;
        }
        .table th {
            background-color: #f8f9fa;
        }
        .btn-sm {
            margin: 2px;
        }
        .validation-error {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }
        .required-field::after {
            content: " *";
            color: #dc3545;
            font-weight: bold;
        }
        .alert {
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">
                    <i class="bi bi-journal-bookmark-fill"></i> Library Management System
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="Dashboard.aspx">
                                <i class="bi bi-speedometer2"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Users.aspx">
                                <i class="bi bi-people"></i> Users
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="Books.aspx">
                                <i class="bi bi-book"></i> Books
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Borrowing.aspx">
                                <i class="bi bi-arrow-left-right"></i> Borrowing
                            </a>
                        </li>
                    </ul>
                    <span class="navbar-text text-white me-3">
                        <i class="bi bi-person-circle"></i> <asp:Label ID="lblUser" runat="server"></asp:Label> (Admin)
                    </span>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-outline-light" OnClick="btnLogout_Click" CausesValidation="false" />
                </div>
            </div>
        </nav>

        <div class="container mt-4">
            <h2 class="mb-4">
                <i class="bi bi-book-half"></i> Book Management
            </h2>
            
            <!-- Add/Edit Book Panel -->
            <div class="card mb-4 shadow">
                <div class="card-header bg-primary text-white">
                    <i class="bi bi-plus-circle"></i> <asp:Label ID="lblFormTitle" runat="server" Text="Add New Book"></asp:Label>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-bold required-field">
                                    <i class="bi bi-book"></i> Title
                                </label>
                                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" 
                                    placeholder="Enter book title"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvTitle" runat="server" 
                                    ControlToValidate="txtTitle" 
                                    ErrorMessage="Title is required" 
                                    CssClass="validation-error" 
                                    Display="Dynamic">
                                    <i class="bi bi-exclamation-circle"></i> Title is required
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold required-field">
                                    <i class="bi bi-pencil"></i> Author
                                </label>
                                <asp:TextBox ID="txtAuthor" runat="server" CssClass="form-control" 
                                    placeholder="Enter author name"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvAuthor" runat="server" 
                                    ControlToValidate="txtAuthor" 
                                    ErrorMessage="Author is required" 
                                    CssClass="validation-error" 
                                    Display="Dynamic">
                                    <i class="bi bi-exclamation-circle"></i> Author is required
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold required-field">
                                    <i class="bi bi-tags"></i> Category
                                </label>
                                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="">-- Select Category --</asp:ListItem>
                                    <asp:ListItem Value="Fiction">Fiction</asp:ListItem>
                                    <asp:ListItem Value="Non-Fiction">Non-Fiction</asp:ListItem>
                                    <asp:ListItem Value="Science">Science</asp:ListItem>
                                    <asp:ListItem Value="History">History</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvCategory" runat="server" 
                                    ControlToValidate="ddlCategory" 
                                    InitialValue="" 
                                    ErrorMessage="Please select a category" 
                                    CssClass="validation-error" 
                                    Display="Dynamic">
                                    <i class="bi bi-exclamation-circle"></i> Please select a category
                                </asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-bold">
                                    <i class="bi bi-building"></i> Publisher
                                </label>
                                <asp:TextBox ID="txtPublisher" runat="server" CssClass="form-control" 
                                    placeholder="Enter publisher name (optional)"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold">
                                    <i class="bi bi-calendar"></i> Publication Year
                                </label>
                                <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="">-- Select Year (optional) --</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold required-field">
                                    <i class="bi bi-sort-numeric-up"></i> Quantity
                                </label>
                                <asp:DropDownList ID="ddlQuantity" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="">-- Select Quantity --</asp:ListItem>
                                    <asp:ListItem Value="1">1</asp:ListItem>
                                    <asp:ListItem Value="2">2</asp:ListItem>
                                    <asp:ListItem Value="3">3</asp:ListItem>
                                    <asp:ListItem Value="4">4</asp:ListItem>
                                    <asp:ListItem Value="5">5</asp:ListItem>
                                    <asp:ListItem Value="6">6</asp:ListItem>
                                    <asp:ListItem Value="7">7</asp:ListItem>
                                    <asp:ListItem Value="8">8</asp:ListItem>
                                    <asp:ListItem Value="9">9</asp:ListItem>
                                    <asp:ListItem Value="10">10</asp:ListItem>
                                    <asp:ListItem Value="15">15</asp:ListItem>
                                    <asp:ListItem Value="20">20</asp:ListItem>
                                    <asp:ListItem Value="25">25</asp:ListItem>
                                    <asp:ListItem Value="30">30</asp:ListItem>
                                    <asp:ListItem Value="40">40</asp:ListItem>
                                    <asp:ListItem Value="50">50</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" 
                                    ControlToValidate="ddlQuantity" 
                                    InitialValue="" 
                                    ErrorMessage="Please select quantity" 
                                    CssClass="validation-error" 
                                    Display="Dynamic">
                                    <i class="bi bi-exclamation-circle"></i> Please select quantity
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold">
                                    <i class="bi bi-check-circle"></i> Available Quantity
                                </label>
                                <asp:Label ID="lblAvailableQuantity" runat="server" CssClass="form-control-plaintext fw-bold text-success"></asp:Label>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Validation Summary -->
                    <asp:ValidationSummary ID="vsSummary" runat="server" 
                        CssClass="alert alert-danger" 
                        HeaderText="Please fix the following errors:" 
                        DisplayMode="BulletList" />
                    
                    <asp:HiddenField ID="hfBookID" runat="server" Value="0" />
                    <hr />
                    <asp:Button ID="btnSave" runat="server" Text="Save Book" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancel_Click" CausesValidation="false" />
                    <asp:Label ID="lblMessage" runat="server" CssClass="ms-3 fw-bold"></asp:Label>
                </div>
            </div>
            
            <!-- Books Grid -->
            <div class="card shadow">
                <div class="card-header bg-success text-white">
                    <i class="bi bi-list-ul"></i> Book List
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <asp:GridView ID="gvBooks" runat="server" AutoGenerateColumns="False" 
                            CssClass="table table-striped table-bordered table-hover" 
                            DataKeyNames="BookID"
                            OnRowCommand="gvBooks_RowCommand" 
                            AllowPaging="True" PageSize="10"
                            OnPageIndexChanging="gvBooks_PageIndexChanging"
                            BorderWidth="0"
                            GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="Title" HeaderText="Title" HeaderStyle-CssClass="bg-light" />
                                <asp:BoundField DataField="Author" HeaderText="Author" HeaderStyle-CssClass="bg-light" />
                                <asp:BoundField DataField="Category" HeaderText="Category" HeaderStyle-CssClass="bg-light" />
                                <asp:BoundField DataField="Publisher" HeaderText="Publisher" HeaderStyle-CssClass="bg-light" />
                                <asp:BoundField DataField="PublicationYear" HeaderText="Year" HeaderStyle-CssClass="bg-light" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="Quantity" HeaderText="Total" HeaderStyle-CssClass="bg-light" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="AvailableQuantity" HeaderText="Available" HeaderStyle-CssClass="bg-light" ItemStyle-HorizontalAlign="Center" />
                                <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="bg-light" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-sm btn-warning"
                                            CommandName="EditBook" CommandArgument='<%# Eval("BookID") %>' 
                                            ToolTip="Edit this book"
                                            CausesValidation="false" />
                                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-sm btn-danger"
                                            CommandName="DeleteBook" CommandArgument='<%# Eval("BookID") %>'
                                            OnClientClick="return confirm('Are you sure you want to delete this book?');" 
                                            ToolTip="Delete this book"
                                            CausesValidation="false" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" />
                            <PagerStyle CssClass="pagination justify-content-center mt-3" />
                            <EmptyDataTemplate>
                                <div class="alert alert-info text-center">
                                    <i class="bi bi-info-circle"></i> No books found.
                                </div>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Footer -->
        <footer class="footer mt-5 py-3 bg-light">
            <div class="container text-center">
                <span class="text-muted">© 2026 Library Management System. All rights reserved.</span>
            </div>
        </footer>
    </form>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
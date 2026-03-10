<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="Finals.Users" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Management - Library System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <style>
        .card-header {
            font-weight: bold;
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
        .form-text {
            font-size: 0.875rem;
        }
        .table th {
            background-color: #f8f9fa;
        }
        .btn-sm {
            margin: 2px;
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
                            <a class="nav-link active" href="Users.aspx">
                                <i class="bi bi-people"></i> Users
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Books.aspx">
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
                <i class="bi bi-people-fill"></i> User Management
            </h2>
            
            <!-- Add/Edit User Panel -->
            <div class="card mb-4 shadow">
                <div class="card-header bg-primary text-white">
                    <i class="bi bi-plus-circle"></i> <asp:Label ID="lblFormTitle" runat="server" Text="Add New User"></asp:Label>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <!-- Username Field -->
                            <div class="mb-3">
                                <label class="form-label fw-bold required-field">
                                    <i class="bi bi-person"></i> Username
                                </label>
                                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" 
                                    placeholder="Enter username (min. 3 characters)"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                                    ControlToValidate="txtUsername" 
                                    ErrorMessage="Username is required" 
                                    CssClass="validation-error" 
                                    Display="Dynamic">
                                    <i class="bi bi-exclamation-circle"></i> Username is required
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revUsername" runat="server" 
                                    ControlToValidate="txtUsername" 
                                    ValidationExpression="^[a-zA-Z0-9_]{3,20}$" 
                                    ErrorMessage="Username must be 3-20 characters (letters, numbers, underscore only)" 
                                    CssClass="validation-error" 
                                    Display="Dynamic">
                                    <i class="bi bi-exclamation-circle"></i> Username must be 3-20 characters (letters, numbers, underscore only)
                                </asp:RegularExpressionValidator>
                            </div>

                            <!-- Password Field -->
                            <div class="mb-3">
                                <label class="form-label fw-bold required-field">
                                    <i class="bi bi-lock"></i> Password
                                </label>
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" 
                                    CssClass="form-control" placeholder="Enter password (min. 6 characters)"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                                    ControlToValidate="txtPassword" 
                                    ErrorMessage="Password is required for new users" 
                                    CssClass="validation-error" 
                                    Display="Dynamic">
                                    <i class="bi bi-exclamation-circle"></i> Password is required for new users
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revPassword" runat="server" 
                                    ControlToValidate="txtPassword" 
                                    ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,20}$" 
                                    ErrorMessage="Password must be 6-20 characters with at least 1 uppercase, 1 lowercase, 1 number, and 1 special character" 
                                    CssClass="validation-error" 
                                    Display="Dynamic">
                                    <i class="bi bi-exclamation-circle"></i> Password must be 6-20 characters with uppercase, lowercase, number, and special character
                                </asp:RegularExpressionValidator>
                                <small class="form-text text-muted">
                                    <i class="bi bi-info-circle"></i> Required for new users. Min 6 chars with uppercase, lowercase, number, and special character.
                                </small>
                            </div>

                            <!-- Full Name Field -->
                            <div class="mb-3">
                                <label class="form-label fw-bold required-field">
                                    <i class="bi bi-card-text"></i> Full Name
                                </label>
                                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" 
                                    placeholder="Enter full name"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvFullName" runat="server" 
                                    ControlToValidate="txtFullName" 
                                    ErrorMessage="Full Name is required" 
                                    CssClass="validation-error" 
                                    Display="Dynamic">
                                    <i class="bi bi-exclamation-circle"></i> Full Name is required
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revFullName" runat="server" 
                                    ControlToValidate="txtFullName" 
                                    ValidationExpression="^[a-zA-Z\s]{2,50}$" 
                                    ErrorMessage="Full Name must contain only letters and spaces (2-50 characters)" 
                                    CssClass="validation-error" 
                                    Display="Dynamic">
                                    <i class="bi bi-exclamation-circle"></i> Full Name must contain only letters (2-50 characters)
                                </asp:RegularExpressionValidator>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <!-- Email Field -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">
                                    <i class="bi bi-envelope"></i> Email
                                </label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" 
                                    placeholder="Enter email address" TextMode="Email"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                                    ControlToValidate="txtEmail" 
                                    ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" 
                                    ErrorMessage="Please enter a valid email address" 
                                    CssClass="validation-error" 
                                    Display="Dynamic">
                                    <i class="bi bi-exclamation-circle"></i> Please enter a valid email address
                                </asp:RegularExpressionValidator>
                            </div>

                            <!-- Phone Field -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">
                                    <i class="bi bi-telephone"></i> Phone
                                </label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" 
                                    placeholder="Enter phone number"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="revPhone" runat="server" 
                                    ControlToValidate="txtPhone" 
                                    ValidationExpression="^[\d\s\+\-\(\)]{10,15}$" 
                                    ErrorMessage="Please enter a valid phone number (10-15 digits)" 
                                    CssClass="validation-error" 
                                    Display="Dynamic">
                                    <i class="bi bi-exclamation-circle"></i> Please enter a valid phone number (10-15 digits)
                                </asp:RegularExpressionValidator>
                            </div>

                            <!-- Address Field -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">
                                    <i class="bi bi-geo-alt"></i> Address
                                </label>
                                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" 
                                    TextMode="MultiLine" Rows="3" placeholder="Enter address"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="revAddress" runat="server" 
                                    ControlToValidate="txtAddress" 
                                    ValidationExpression="^[a-zA-Z0-9\s,.-]{5,200}$" 
                                    ErrorMessage="Address must be 5-200 characters" 
                                    CssClass="validation-error" 
                                    Display="Dynamic">
                                    <i class="bi bi-exclamation-circle"></i> Address must be 5-200 characters
                                </asp:RegularExpressionValidator>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Validation Summary -->
                    <asp:ValidationSummary ID="vsSummary" runat="server" 
                        CssClass="alert alert-danger" 
                        HeaderText="Please fix the following errors:" 
                        DisplayMode="BulletList" />
                    
                    <asp:HiddenField ID="hfUserID" runat="server" Value="0" />
                    <hr />
                    <asp:Button ID="btnSave" runat="server" Text="Save User" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancel_Click" CausesValidation="false" />
                    <asp:Label ID="lblMessage" runat="server" CssClass="ms-3 fw-bold"></asp:Label>
                </div>
            </div>
            
            <!-- Users Grid -->
            <div class="card shadow">
                <div class="card-header bg-success text-white">
                    <i class="bi bi-list-ul"></i> User List
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" 
                            CssClass="table table-striped table-bordered table-hover" 
                            DataKeyNames="UserID"
                            OnRowCommand="gvUsers_RowCommand" 
                            AllowPaging="True" PageSize="10"
                            OnPageIndexChanging="gvUsers_PageIndexChanging"
                            BorderWidth="0"
                            GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="Username" HeaderText="Username" HeaderStyle-CssClass="bg-light" />
                                <asp:BoundField DataField="FullName" HeaderText="Full Name" HeaderStyle-CssClass="bg-light" />
                                <asp:BoundField DataField="Email" HeaderText="Email" HeaderStyle-CssClass="bg-light" />
                                <asp:BoundField DataField="Phone" HeaderText="Phone" HeaderStyle-CssClass="bg-light" />
                                <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="bg-light" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-sm btn-warning"
                                            CommandName="EditUser" CommandArgument='<%# Eval("UserID") %>' 
                                            ToolTip="Edit this user"
                                            CausesValidation="false" />
                                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-sm btn-danger"
                                            CommandName="DeleteUser" CommandArgument='<%# Eval("UserID") %>'
                                            OnClientClick="return confirm('Are you sure you want to delete this user?');" 
                                            ToolTip="Delete this user"
                                            CausesValidation="false" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" />
                            <PagerStyle CssClass="pagination justify-content-center mt-3" />
                            <EmptyDataTemplate>
                                <div class="alert alert-info text-center">
                                    <i class="bi bi-info-circle"></i> No users found.
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
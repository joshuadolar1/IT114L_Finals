<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MemberBooks.aspx.cs" Inherits="Finals.MemberBooks" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Browse Books - Library System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <style>
        .book-card {
            transition: transform 0.2s;
            height: 100%;
        }
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .available-badge {
            background-color: #28a745;
            color: white;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 0.8rem;
        }
        .unavailable-badge {
            background-color: #dc3545;
            color: white;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 0.8rem;
        }
        .search-box {
            max-width: 500px;
            margin: 0 auto 30px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-dark bg-success">
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
                            <a class="nav-link" href="MemberDashboard.aspx">
                                <i class="bi bi-speedometer2"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="MemberBooks.aspx">
                                <i class="bi bi-book"></i> Browse Books
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="MyBorrowedBooks.aspx">
                                <i class="bi bi-list-check"></i> My Borrowed Books
                            </a>
                        </li>
                    </ul>
                    <span class="navbar-text text-white me-3">
                        <i class="bi bi-person-circle"></i> <asp:Label ID="lblUser" runat="server"></asp:Label>
                    </span>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-outline-light" OnClick="btnLogout_Click" />
                </div>
            </div>
        </nav>

        <div class="container mt-4">
            <h2 class="text-center mb-4">
                <i class="bi bi-book-half"></i> Browse Books
            </h2>
            
            <!-- Search Box -->
            <div class="search-box">
                <div class="input-group">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control form-control-lg" 
                        placeholder="Search by title or author..."></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary" OnClick="btnClear_Click" />
                </div>
            </div>
            
            <!-- Books Grid -->
            <div class="row">
                <asp:Repeater ID="rptBooks" runat="server" OnItemCommand="rptBooks_ItemCommand">
                    <ItemTemplate>
                        <div class="col-md-4 col-sm-6 mb-4">
                            <div class="card book-card h-100 shadow-sm">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <h5 class="card-title mb-0"><%# Eval("Title") %></h5>
                                        <span class='<%# Convert.ToInt32(Eval("AvailableQuantity")) > 0 ? "available-badge" : "unavailable-badge" %>'>
                                            <%# Eval("AvailableQuantity") %> available
                                        </span>
                                    </div>
                                    
                                    <h6 class="card-subtitle mb-3 text-muted">
                                        <i class="bi bi-person"></i> <%# Eval("Author") %>
                                    </h6>
                                    
                                    <p class="card-text small">
                                        <span class="badge bg-secondary me-1"><%# Eval("Category") %></span>
                                        <%# !string.IsNullOrEmpty(Eval("Publisher").ToString()) ? "<br/><i class='bi bi-building'></i> " + Eval("Publisher") : "" %>
                                        <%# Eval("PublicationYear") != DBNull.Value ? "<br/><i class='bi bi-calendar'></i> " + Eval("PublicationYear") : "" %>
                                    </p>
                                    
                                    <div class="d-flex justify-content-between align-items-center mt-3">
                                        <small class="text-muted">
                                            <i class="bi bi-layers"></i> Total: <%# Eval("Quantity") %>
                                        </small>
                                        
                                        <asp:Button ID="btnBorrow" runat="server" 
                                            Text='<%# Convert.ToInt32(Eval("AvailableQuantity")) > 0 ? "Borrow" : "Not Available" %>' 
                                            CssClass='<%# Convert.ToInt32(Eval("AvailableQuantity")) > 0 ? "btn btn-sm btn-success" : "btn btn-sm btn-secondary disabled" %>'
                                            CommandName="Borrow" 
                                            CommandArgument='<%# Eval("BookID") %>'
                                            Enabled='<%# Convert.ToInt32(Eval("AvailableQuantity")) > 0 %>' />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            
            <!-- No Results Message -->
            <asp:Label ID="lblNoBooks" runat="server" CssClass="text-center d-block mt-4 text-muted" Visible="false">
                <i class="bi bi-info-circle"></i> No books found.
            </asp:Label>
            
            <!-- Message Label -->
            <asp:Label ID="lblMessage" runat="server" CssClass="text-center d-block mt-3 fw-bold"></asp:Label>
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
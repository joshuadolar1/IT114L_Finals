<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Finals.Index" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <style>
        /* Simple and clean style */
        body {
            background-color: #f8f9fa;
        }
        
        /* Fixed login buttons at top right */
        .login-buttons {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1000;
        }
        
        .btn-login {
            padding: 8px 20px;
            margin: 0 5px;
            border-radius: 20px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .btn-member {
            background-color: #0d6efd;
            color: white;
            border: 2px solid #0d6efd;
        }
        
        .btn-member:hover {
            background-color: #0b5ed7;
            color: white;
        }
        
        .btn-librarian {
            background-color: #198754;
            color: white;
            border: 2px solid #198754;
        }
        
        .btn-librarian:hover {
            background-color: #157347;
            color: white;
        }
        
        /* Header section */
        .header-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 60px 0 40px 0;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .library-icon {
            font-size: 5rem;
            margin-bottom: 20px;
        }
        
        /* Stats cards */
        .stat-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            transition: transform 0.3s;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: #667eea;
        }
        
        .stat-label {
            color: #6c757d;
            font-size: 1.1rem;
        }
        
        /* Feature boxes */
        .feature-box {
            background: white;
            border-radius: 10px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            height: 100%;
        }
        
        .feature-icon {
            font-size: 2.5rem;
            color: #667eea;
            margin-bottom: 15px;
        }
        
        .feature-title {
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }
        
        .feature-text {
            color: #6c757d;
        }
        
        /* How it works */
        .step-box {
            text-align: center;
            padding: 20px;
        }
        
        .step-number {
            width: 40px;
            height: 40px;
            background: #667eea;
            color: white;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin-bottom: 15px;
        }
        
        /* Footer */
        .footer {
            background: #343a40;
            color: white;
            padding: 30px 0;
            margin-top: 50px;
        }
        
        /* Welcome text */
        .welcome-text {
            font-size: 1.2rem;
            opacity: 0.9;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .login-buttons {
                position: static;
                text-align: center;
                margin-top: 20px;
            }
            
            .btn-login {
                display: inline-block;
                margin: 5px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Fixed Login Buttons -->
        <div class="login-buttons">
            <a href="MemberLogin.aspx" class="btn-login btn-member">
                <i class="bi bi-person"></i> Member Login
            </a>
            <a href="LibrarianLogin.aspx" class="btn-login btn-librarian">
                <i class="bi bi-shield-lock"></i> Librarian Login
            </a>
        </div>

        <!-- Header Section -->
        <div class="header-section">
            <div class="container">
                <i class="bi bi-journal-bookmark-fill library-icon"></i>
                <h1 class="display-4">Library Management System</h1>
                <p class="welcome-text">Welcome to our school library! Borrow books, read, learn, and explore.</p>
            </div>
        </div>

        <!-- Stats Section -->
        <div class="container mb-5">
            <div class="row">
                <div class="col-md-3 col-6">
                    <div class="stat-card">
                        <div class="stat-number">
                            <asp:Label ID="lblTotalBooks" runat="server" Text="0"></asp:Label>
                        </div>
                        <div class="stat-label">Total Books</div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="stat-card">
                        <div class="stat-number">
                            <asp:Label ID="lblActiveMembers" runat="server" Text="0"></asp:Label>
                        </div>
                        <div class="stat-label">Active Members</div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="stat-card">
                        <div class="stat-number">
                            <asp:Label ID="lblBooksBorrowed" runat="server" Text="0"></asp:Label>
                        </div>
                        <div class="stat-label">Books Borrowed</div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="stat-card">
                        <div class="stat-number">
                            <asp:Label ID="lblAvailableBooks" runat="server" Text="0"></asp:Label>
                        </div>
                        <div class="stat-label">Available Now</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Features Section -->
        <div class="container mb-5">
            <h3 class="text-center mb-4">What We Offer</h3>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="feature-box">
                        <i class="bi bi-book feature-icon"></i>
                        <h5 class="feature-title">Wide Collection</h5>
                        <p class="feature-text">We have books for every taste - fiction, non-fiction, academic, and more.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-box">
                        <i class="bi bi-arrow-repeat feature-icon"></i>
                        <h5 class="feature-title">Easy Borrowing</h5>
                        <p class="feature-text">Simple process to borrow and return books. Track your borrowed books online.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-box">
                        <i class="bi bi-clock feature-icon"></i>
                        <h5 class="feature-title">7-Day Borrowing</h5>
                        <p class="feature-text">Borrow books for up to 7 days. Extend if no one else is waiting.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- How It Works Section -->
        <div class="container mb-5">
            <h3 class="text-center mb-4">How It Works</h3>
            <div class="row">
                <div class="col-md-3 col-6 mb-3">
                    <div class="step-box">
                        <div class="step-number">1</div>
                        <h6>Sign Up / Login</h6>
                        <small class="text-muted">Create account or login</small>
                    </div>
                </div>
                <div class="col-md-3 col-6 mb-3">
                    <div class="step-box">
                        <div class="step-number">2</div>
                        <h6>Browse Books</h6>
                        <small class="text-muted">Find books you like</small>
                    </div>
                </div>
                <div class="col-md-3 col-6 mb-3">
                    <div class="step-box">
                        <div class="step-number">3</div>
                        <h6>Borrow</h6>
                        <small class="text-muted">Click borrow to take book</small>
                    </div>
                </div>
                <div class="col-md-3 col-6 mb-3">
                    <div class="step-box">
                        <div class="step-number">4</div>
                        <h6>Return</h6>
                        <small class="text-muted">Return within 7 days</small>
                    </div>
                </div>
            </div>
        </div>

        <!-- Call to Action -->
        <div class="container text-center mb-5">
            <div class="p-4 bg-light rounded-3">
                <h4>Ready to start reading?</h4>
                <p class="text-muted">Join our library community today!</p>
                <a href="MemberLogin.aspx" class="btn btn-primary btn-lg">
                    <i class="bi bi-box-arrow-in-right"></i> Get Started
                </a>
            </div>
        </div>

        <!-- Simple Footer -->
        <footer class="footer">
            <div class="container text-center">
                <p class="mb-0">Library Management System - College Project 2026</p>
                <small class="text-white-50">Created by: Your Name</small>
            </div>
        </footer>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
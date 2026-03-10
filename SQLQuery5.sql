USE LibraryDB_2026;
GO

-- Create Users Table
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) UNIQUE NOT NULL,
    Password NVARCHAR(100) NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    Address NVARCHAR(200),
    UserType NVARCHAR(20) DEFAULT 'User', -- 'Admin' or 'User'
    CreatedDate DATETIME DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1
);
GO

-- Create Books Table
CREATE TABLE Books (
    BookID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(200) NOT NULL,
    Author NVARCHAR(100) NOT NULL,
    ISBN NVARCHAR(20) UNIQUE,
    Category NVARCHAR(50),
    Publisher NVARCHAR(100),
    PublicationYear INT,
    Quantity INT DEFAULT 1,
    AvailableQuantity INT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE()
);
GO

-- Create Borrowing Records Table
CREATE TABLE BorrowingRecords (
    RecordID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    BookID INT FOREIGN KEY REFERENCES Books(BookID),
    BorrowDate DATETIME DEFAULT GETDATE(),
    DueDate DATETIME,
    ReturnDate DATETIME NULL,
    Status NVARCHAR(20) DEFAULT 'Borrowed', -- 'Borrowed', 'Returned', 'Overdue'
    CreatedDate DATETIME DEFAULT GETDATE()
);
GO

-- Insert default admin user (password: admin123)
INSERT INTO Users (Username, Password, FullName, Email, UserType) 
VALUES ('admin', 'admin123', 'System Administrator', 'admin@library.com', 'Admin');
GO

-- Insert sample books
INSERT INTO Books (Title, Author, ISBN, Category, Publisher, PublicationYear, Quantity, AvailableQuantity) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', '978-0-7432-7356-5', 'Fiction', 'Scribner', 1925, 3, 3),
('To Kill a Mockingbird', 'Harper Lee', '978-0-06-112008-4', 'Fiction', 'HarperCollins', 1960, 2, 2),
('1984', 'George Orwell', '978-0-452-28423-4', 'Science Fiction', 'Plume', 1949, 4, 4),
('Pride and Prejudice', 'Jane Austen', '978-0-14-143951-8', 'Romance', 'Penguin Classics', 1813, 2, 2),
('The Catcher in the Rye', 'J.D. Salinger', '978-0-316-76948-0', 'Fiction', 'Little, Brown', 1951, 3, 3);
GO

-- Verify the tables were created
SELECT 'Users' AS TableName, COUNT(*) AS RecordCount FROM Users
UNION ALL
SELECT 'Books', COUNT(*) FROM Books
UNION ALL
SELECT 'BorrowingRecords', COUNT(*) FROM BorrowingRecords;
GO
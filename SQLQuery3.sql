USE LibraryDB_2026;
GO

-- Drop the existing table (this will delete ALL data!)
DROP TABLE Books;
GO

-- Recreate the table with IsDeleted column
CREATE TABLE Books (
    BookID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(200) NOT NULL,
    Author NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50),
    Publisher NVARCHAR(100),
    PublicationYear INT,
    Quantity INT DEFAULT 1,
    AvailableQuantity INT DEFAULT 1,
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedDate DATETIME DEFAULT GETDATE()
);
GO

-- Insert sample data
INSERT INTO Books (Title, Author, Category, Publisher, PublicationYear, Quantity, AvailableQuantity, IsDeleted) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 'Scribner', 1925, 3, 3, 0),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 'HarperCollins', 1960, 2, 2, 0),
('1984', 'George Orwell', 'Science Fiction', 'Plume', 1949, 4, 4, 0),
('Pride and Prejudice', 'Jane Austen', 'Romance', 'Penguin Classics', 1813, 2, 2, 0),
('The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 'Little, Brown', 1951, 3, 3, 0);
GO

-- Verify the data
SELECT * FROM Books;
GO
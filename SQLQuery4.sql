USE LibraryDB_2026;
GO

-- Check if IsDeleted column exists
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Books' AND COLUMN_NAME = 'IsDeleted')
BEGIN
    ALTER TABLE Books ADD IsDeleted BIT NOT NULL DEFAULT 0;
    PRINT 'IsDeleted column added successfully!';
END
ELSE
BEGIN
    PRINT 'IsDeleted column already exists.';
END
GO

-- Update any NULL values to 0
UPDATE Books SET IsDeleted = 0 WHERE IsDeleted IS NULL;
GO

-- Show all books to verify
SELECT BookID, Title, Author, Category, Publisher, PublicationYear, Quantity, AvailableQuantity, IsDeleted FROM Books;
GO
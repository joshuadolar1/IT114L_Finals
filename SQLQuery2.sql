USE LibraryDB_2026;
GO

-- Check if IsDeleted column exists, if not add it
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

-- Verify the column was added
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Books' 
ORDER BY ORDINAL_POSITION;
GO

-- Update any existing books to have IsDeleted = 0 (not deleted)
UPDATE Books SET IsDeleted = 0 WHERE IsDeleted IS NULL;
GO

-- Show the table structure
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Books';
GO
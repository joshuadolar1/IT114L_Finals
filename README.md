Library Management System
A simple web-based Library Management System built with ASP.NET Web Forms and SQL Server. This system allows librarians to manage books and users, and allows members to browse and borrow books.

📋 Features
For Librarians (Admin)
Dashboard with statistics (total books, users, borrowed books)

Book Management (Add, Edit, Delete books)

User Management (Add, Edit, Delete members)

Borrowing Management (View all records, return books)

Track who borrowed which books

For Members
Browse available books

Search books by title or author

Borrow available books

View currently borrowed books

View borrowing history

🛠️ Technology Stack
Frontend: ASP.NET Web Forms, HTML, CSS, Bootstrap 5

Backend: C#, .NET Framework 4.7.2

Database: Microsoft SQL Server

Tools: Visual Studio 2022, SQL Server Management Studio (SSMS)

🚀 How to Run the System
Prerequisites:
Make sure you have the following installed:

Visual Studio 2022 (Community Edition is free)

Download from: https://visualstudio.microsoft.com/

During installation, select ".NET desktop development" workload

SQL Server Express (or any SQL Server)

Download from: https://www.microsoft.com/en-us/sql-server/sql-server-downloads

Or install SQL Server Management Studio (SSMS) only and use LocalDB that comes with Visual Studio

.NET Framework 4.7.2 (usually comes with Visual Studio)

Step-by-Step Setup
Step 1: Download the Project
Clone the repository:

text
git clone https://github.com/yourusername/LibraryManagementSystem.git
Or download the ZIP file and extract it

Step 2: Open the Project in Visual Studio
Open Visual Studio 2022

Click File → Open → Project/Solution

Navigate to the project folder and select Finals.sln

Click Open

Step 3: Create the Database
Option A: Using SQL Server Management Studio (SSMS)

Open SQL Server Management Studio

Connect to your server (usually .\SQLEXPRESS or .\SQLEXPRESS01)

Click File → Open → File

Browse to the project folder and select LibraryDB.sql

Click Open

Press F5 or click Execute to run the script

Verify the database was created in Object Explorer

Option B: Using Visual Studio

In Visual Studio, open View → SQL Server Object Explorer

Right-click on SQL Server and select Add SQL Server

Connect to your local server

Open the LibraryDB.sql file from the project

Click Execute to run the script

Step 4: Update the Connection String
In Visual Studio, open Web.config

Find the connection string section:
==================================================================================================

xml
<connectionStrings>
    <add name="LibraryDB" 
         connectionString="Data Source=.\SQLEXPRESS01;Initial Catalog=LibraryDB;Integrated Security=True" 
         providerName="System.Data.SqlClient" />
</connectionStrings>

==================================================================================================

Change the Data Source to match your SQL Server instance:

If using SQL Express: Data Source=.\SQLEXPRESS

If using LocalDB: Data Source=(localdb)\MSSQLLocalDB

If using full SQL Server: Data Source=YOUR_COMPUTER_NAME

Step 5: Run the Application
In Visual Studio, press F5 or click Debug → Start Debugging

The browser will open with the landing page (Index.aspx)

You should see the Library Management System homepage

Step 6: Test the System
Default Admin Login:

Username: admin

Password: admin123

Test Member Login:

First create a user in the Users page (as admin)

Then login as that user using the Member Login page

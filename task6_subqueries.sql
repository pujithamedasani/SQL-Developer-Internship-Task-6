-- Staff table
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Role VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

-- Insert into Staff
INSERT INTO Staff (Name, Role, Email) VALUES
('Johnson', 'Librarian', 'johnson@gmail.com'),
('Ram', 'Assistant', 'ram@gmail.com');


-- Members table
CREATE TABLE Members (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    JoinDate DATE
);

-- Insert into Members
INSERT INTO Members (Name, Email, JoinDate) VALUES
('Doe','doe@gmail.com', '2025-06-20'),
('Jane','jane@gmail.com', '2025-03-12');


-- Books table
CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(200) NOT NULL,
    ISBN VARCHAR(20) UNIQUE,
    Status ENUM('Available', 'Loaned', 'Reserved') DEFAULT 'Available'
);

-- Insert into Books
INSERT INTO Books (Title, ISBN, Status) VALUES
('The Great Gatsby', '9780743273565', 'Available'),
('1984', '9780451524935', 'Loaned'),
("A Good Girl's Guide to Murder", '9780061120084', 'Reserved');

-- Reservations table
CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT,
    MemberID INT,
    ReservationDate DATE NOT NULL,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Insert into Reservations
INSERT INTO Reservations (BookID, MemberID, ReservationDate) VALUES
(1, 2, '2025-06-20');


-- Loans table
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT,
    MemberID INT,
    StaffID INT,
    LoanDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

-- Insert into Loans
INSERT INTO Loans (BookID, MemberID, StaffID, LoanDate, DueDate, ReturnDate) VALUES
(2, 1, 1, '2025-06-01', '2025-06-15', NULL);


-- Fines table
CREATE TABLE Fines (
    FineID INT PRIMARY KEY AUTO_INCREMENT,
    LoanID INT,
    StaffID INT,
    Amount DECIMAL(6,2) NOT NULL,
    IssuedDate DATE NOT NULL,
    Paid BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

-- Insert into Fines
INSERT INTO Fines (LoanID, StaffID, Amount, IssuedDate, Paid) VALUES
(1, 2, 25.00, '2025-06-20', FALSE);

--subquery with select
SELECT s.Name, 
(SELECT COUNT(*) FROM Loans l WHERE l.StaffID = s.StaffID) AS TotalLoans
FROM Staff s;

--subquery with where with in
SELECT m.Name, m.Email
FROM Members m
WHERE m.MemberID IN (SELECT r.MemberID FROM Reservations r);

--subquery with exists
SELECT s.Name
FROM Staff s
WHERE EXISTS (SELECT 1 
              FROM Fines f 
              WHERE f.StaffID = s.StaffID);

--scalar subquery
SELECT b.Title, 
       (SELECT m.Name FROM Members m WHERE m.MemberID = l.MemberID) AS BorrowerName
FROM Books b
JOIN Loans l ON b.BookID = l.BookID
WHERE b.Status = 'Loaned';

--correlated subquery
SELECT Name FROM Members M
WHERE EXISTS (
    SELECT 1 FROM Fines F
    JOIN Loans L ON L.LoanID = F.LoanID
    WHERE L.MemberID = M.MemberID AND F.Paid = FALSE
);

--subquery with from
SELECT StaffID, AVG(Amount) AS AverageFine
FROM (SELECT f.StaffID, f.Amount 
      FROM Fines f) AS FineDetails
GROUP BY StaffID;



1. Subquery in SELECT Clause :
  
Description: Retrieve the name of each staff member along with the total number of loans they have processed.

Syntax:
  
SELECT column, (SELECT COUNT(*) FROM ...) WHERE ... FROM ...;

Query:

SELECT s.Name, 
(SELECT COUNT(*) FROM Loans l WHERE l.StaffID = s.StaffID) AS TotalLoans
FROM Staff s;

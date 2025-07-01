6. Subquery in FROM Clause :

Description: 
- Calculate the average fine amount for loans issued by each staff member, using a subquery as a derived table.
- A subquery used as a temporary table in the FROM clause.

Syntax:

SELECT * FROM (SELECT ... FROM ...) AS alias;

Query:

SELECT StaffID, AVG(Amount) AS AverageFine
FROM (SELECT f.StaffID, f.Amount 
      FROM Fines f) AS FineDetails
GROUP BY StaffID;

Output:

+---------+-------------+
| StaffID | AverageFine |
+---------+-------------+
|       2 |   25.000000 |
+---------+-------------+

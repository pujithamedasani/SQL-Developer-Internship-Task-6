5. Correlated Subquery :
  
Description: A subquery that refers to the outer query’s row, evaluated row by row.

Syntax:

SELECT column FROM table1
WHERE EXISTS (SELECT 1 FROM table2 WHERE table2.column = table1.column);

Query:

SELECT Name FROM Members M
WHERE EXISTS (
    SELECT 1 FROM Fines F
    JOIN Loans L ON L.LoanID = F.LoanID
    WHERE L.MemberID = M.MemberID AND F.Paid = FALSE
);

--Finds members who have unpaid fines.

Output:

+------+
| Name |
+------+
| Doe  |
+------+

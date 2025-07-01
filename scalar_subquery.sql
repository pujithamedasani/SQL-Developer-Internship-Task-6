4. Scalar Subquery :

Description:
- List all books that have been loaned out, along with the member's name who borrowed them.
- A scalar subquery returns a single value, which can be used in a SELECT clause.

Syntax:

SELECT column, (SELECT COUNT(*) FROM ...) AS alias FROM ...;

Query:

SELECT b.Title, 
       (SELECT m.Name FROM Members m WHERE m.MemberID = l.MemberID) AS BorrowerName
FROM Books b
JOIN Loans l ON b.BookID = l.BookID
WHERE b.Status = 'Loaned';

Output:

+-------+--------------+
| Title | BorrowerName |
+-------+--------------+
| 1984  | Doe          |
+-------+--------------+

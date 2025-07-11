2. Subquery in WHERE with IN Clause :
  
Description:
  - Find all members who have reserved books, using a subquery to filter based on the Reservations table.
  - Checks if a value exists in a list returned by a subquery.
Syntax:

SELECT * FROM table
WHERE column IN (SELECT column FROM other_table WHERE ...);

Query:

SELECT m.Name, m.Email
FROM Members m
WHERE m.MemberID IN (SELECT r.MemberID FROM Reservations r);

Output:

+------+----------------+
| Name | Email          |
+------+----------------+
| Jane | jane@gmail.com |
+------+----------------+

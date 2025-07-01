3. Using EXISTS with Subquery :

Description:
-Checks whether the subquery returns any result ,more efficient for existence checks
-List all staff members who have issued fines.

Syntax:
SELECT * FROM table
WHERE EXISTS (SELECT 1 FROM other_table WHERE condition);

Query:

SELECT s.Name
FROM Staff s
WHERE EXISTS (SELECT 1 
              FROM Fines f 
              WHERE f.StaffID = s.StaffID);

Output:

+------+
| Name |
+------+
| Ram  |
+------+

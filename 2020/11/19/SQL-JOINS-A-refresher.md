---
path: "./2020/11/19/SQL-JOINS-A-refresher.md"
date: "2020-11-19T10:41:18"
title: "SQL JOINS - A Refresher"
description: "A summary of SQL JOIN"
tags: ["SQL", "join", "inner join", "left join", "left outer join", "right join", "right outer join", "full join", "full outer join"]
lang: "en-us"
---

### Quick Intro

There are four basic types of SQL joins: `INNER`, `LEFT`, `RIGHT`, and `FULL`. An intuitive
way to explain the difference between these four types is by using a Venn diagram
which shows logical relations between data sets.  

__A Venn Diagram Illustrating SQL Joins__
<br/>
![SQL Joins](./sql-joins.png)

Lets explain the join types by applying them to some data.

Table name: `student`


roll_number |	name        |	age
------------|-------------|-----
1		        | Obi Kate    |	21
2		        | Kruger Dave |	23
3		        | Sadiq Omar  |	22


Table name: `student_course`


course_id | 	course_name |	roll_number 	
----------|---------------|------------
1		      | Math		      | 2
2		      | Poetry		    | 3
3		      | Accounting	  | 4

### INNER JOIN

`Inner join` aka `join` Returns all rows from both tables as long as the condition
satisfies i.e value of the common field will be same.

```sql
SELECT student_course.course_name, student.student_name FROM student
INNER JOIN student_course ON student.roll_number = student_course.roll_number;
```

course_name |	student_name		
------------|--------------
Math		    | Kruger Dave
Poetry		  | Sadiq Omar


### LEFT JOIN

`Left join` aka `left outer join` returns all the rows of the table on the left
side of the join and matching rows for the table on the right side of join. The
rows for which there is no matching row on the right side, the result-set will
contain `NULL`.

```sql
SELECT student_course.course_name, student.student_name FROM student
LEFT JOIN student_course ON student.roll_number = student_course.roll_number;
```

course_name |	student_name		
------------|--------------
NULL        | Obi Kate
Math		    | Kruger Dave
Poetry		  | Sadiq Omar


### RIGHT JOIN

`Right join` aka `right outer join` returns all the rows of the table on the
right side of the join and matching rows for the table on the left side of join.
The rows for which there is no matching row on left side, the result-set will
contain `NULL`.

```sql
SELECT student_course.course_name, student.student_name FROM student
RIGHT JOIN student_course ON student.roll_number = student_course.roll_number;
```

course_name |	student_name		
------------|--------------
Math		    | Kruger Dave
Poetry		  | Sadiq Omar
Accounting  | NULL


### FULL JOIN

`Full join` aka `full outer join` returns the result of both LEFT JOIN and RIGHT
JOIN. The result-set will contain all the rows from both the tables. The rows for
which there is no matching, the result-set will contain `NULL`.

```sql
SELECT student_course.course_name, student.student_name FROM student
FULL JOIN student_course ON student.roll_number = student_course.roll_number;
```

course_name |	student_name		
------------|--------------
NULL        | Obi Kate
Math		    | Kruger Dave
Poetry		  | Sadiq Omar
Accounting  | NULL

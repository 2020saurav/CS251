Q 1.1:

select distinct employees.emp_no from employees inner join dept_emp on employees.emp_no=dept_emp.emp_no where (floor(datediff(curdate(),birth_date)/365)>60) and (dept_emp.from_date>employees.hire_date);

OUTPUT : 9116 rows in set (1.53 sec)
------------------------------------------------------------
Q 1.2 i (One employee is counted once)

select t.title, count(*) from (select salaries.emp_no as eno, salaries.salary from salaries where salaries.salary > 100000 group by salaries.emp_no) as s inner join titles as t on s.eno = t.emp_no group by t.title;	

OUTPUT :
+--------------------+----------+
| title              | count(*) |
+--------------------+----------+
| Assistant Engineer |      264 |
| Engineer           |     2199 |
| Manager            |        4 |
| Senior Engineer    |     2557 |
| Senior Staff       |    14644 |
| Staff              |    12840 |
| Technique Leader   |      258 |
+--------------------+----------+
7 rows in set (0.00 sec)
-------------------------------------------------------------

Q 1.2 ii (Counting each employee as many time he/she appeared : Question was unclear)
select t.title, count(*) from (select salaries.emp_no as eno, salaries.salary from salaries where salaries.salary > 100000 ) as s inner join titles as t on s.eno = t.emp_no group by t.title;
OUTPUT :
+--------------------+----------+
| title              | count(*) |
+--------------------+----------+
| Assistant Engineer |      964 |
| Engineer           |     7890 |
| Manager            |       11 |
| Senior Engineer    |     9237 |
| Senior Staff       |    79644 |
| Staff              |    67345 |
| Technique Leader   |      923 |
+--------------------+----------+
7 rows in set (0.00 sec)
------------------------------------------------------------------

Q 1.3.


select m.dept_no,count(*) from dept_manager as m, dept_emp as d
where (m.from_date = d.from_date) and (m.dept_no = d.dept_no)
group by m.dept_no;

OUTPUT:
+---------+----------+
| dept_no | count(*) |
+---------+----------+
| d001    |        5 |
| d002    |        6 |
| d003    |        3 |
| d004    |       44 |
| d005    |       25 |
| d006    |        5 |
| d007    |       14 |
| d008    |        3 |
| d009    |       13 |
+---------+----------+
9 rows in set (0.00 sec)
--------------------------------------------------------------------
Q2 .

2.1
create table emp_prsnl (

	emp_no int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name varchar(25) NOT NULL,
	dob date NOT NULL

	check name like "%s%"

);


2.2

create table emp_prfsnl (

	emp_no int(11) NOT NULL,
	desgn varchar(25) default 'Trainee',
	salary int(11) NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL

	#check salary >= 1000 and from_date<to_date

);
------------------------------------------------
Q 3.

3.1 alter table emp_prsnl AUTO_INCREMENT = '10001';

3.2 alter table emp_prsnl add address varchar(250) NOT NULL;

	
3.3 alter table emp_prfsnl add constraint check salary <= 100000;

--------------------------------------------------

Q 4.

4.1
insert into emp_prsnl (name,dob) select first_name,birth_date from employees where (birth_date<'1960-01-01' and birth_date > '1950-01-01') and employees.first_name like "%d%";

4.2
ERROR 1062 (23000): Duplicate entry '10001' for key 'PRIMARY'
-----------------------------------------------------

Q 5

alter table emp_prsnl add gender ENUM('M','F');

update emp_prsnl set address = 'DELHI' where gender ='M';

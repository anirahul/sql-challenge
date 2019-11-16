-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/rO1Lpy
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

----  DDL 

CREATE TABLE "employees" (
    "emp_no" integer   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(100)   NOT NULL,
    "last_name" varchar(100)   NOT NULL,
    "gender" char(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" integer   NOT NULL,
    "dept_no" varchar(10)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" integer   NOT NULL,
    "title" varchar(50)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(10)   NOT NULL,
    "emp_no" integer   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" integer   NOT NULL,
    "salary" float   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "departments" (
    "dept_no" varchar(10)   NOT NULL,
    "dept_name" varchar(100)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

alter table "dept_manager" alter column "dept_no" set data type varchar(10);
alter table "dept_emp" alter column "dept_no" set data type varchar(10);
alter table "departments" alter column "dept_no" set data type varchar(10);

drop table dept_manager;
drop table dept_emp;
drop table departments;

-------   DML
---1.List the following details of each employee: employee number, last name, first name, gender, and salary.
select e.emp_no, e.last_name, e.first_name, e.gender, s.salary from employees e, salaries s
where e.emp_no = s.emp_no;

---2.List employees who were hired in 1986.

select * from employees where hire_date >= '01/01/86' and hire_date <= '12/31/86';

---3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

select m.dept_no, d.dept_name, e.emp_no,e.last_name,e.first_name, m.from_date, m.to_date 
from employees e, dept_manager m, departments d 
where
e.emp_no = m.emp_no and
d.dept_no = m.dept_no;

---4. List the department of each employee with the following information: employee number, last name, first name, and department name.

select e.emp_no,e.last_name,e.first_name,d.dept_name  
from employees e, departments d, dept_emp de 
where
de.emp_no = e.emp_no and
d.dept_no = de.dept_no;

---5. List all employees whose first name is "Hercules" and last names begin with "B."
select * from employees 
where
first_name = 'Hercules' and
last_name like 'B%';

---6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
select e.emp_no,e.last_name,e.first_name,d.dept_name  
from employees e, departments d, dept_emp de 
where
de.emp_no = e.emp_no and
d.dept_no = de.dept_no
and d.dept_name = 'Sales';

---7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select e.emp_no,e.last_name,e.first_name,d.dept_name  
from employees e, departments d, dept_emp de 
where
de.emp_no = e.emp_no and
d.dept_no = de.dept_no
and d.dept_name in ('Sales', 'Development');

---8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

Select last_name, count(*) from employees group by last_name order by last_name;

    



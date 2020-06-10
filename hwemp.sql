-- upload csv files
select * from departments;
copy departments
from '/Applications/sql/data/departments.csv'delimiter',' csv header;

select * from dept_emp ;
copy dept_emp
from '/Applications/sql/data/dept_emp.csv'delimiter',' csv header;
	
select * from dept_manager;
copy dept_manager
from '/Applications/sql/data/dept_manager.csv'delimiter',' csv header;

select * from employees;
copy employees
from '/Applications/sql/data/employees.csv'delimiter',' csv header;

select * from salaries ;
copy salaries
from '/Applications/sql/data/salaries.csv'delimiter',' csv header;

select * from titles;
copy titles 
from '/Applications/sql/data/titles.csv'delimiter',' csv header;



-- 1. List the following details of each employee: 
--employee number, last name, first name, gender, and salary.

select employees.emp_no, 
		employees.last_name, 
		employees.first_name, 
		employees.sex, 
		salaries.salary
--select *
from employees 
join salaries on (employees.emp_no = salaries.emp_no);


-- 2.List employees who were hired in 1986.
select emp_no,
	first_name,
	last_name,
	hire_date
from employees
where hire_date >= '1986-01-01' and hire_date < '1987-01-01';


-- 3.List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.

select d.dept_no,
		d.dept_name,
		e.emp_no,
		e.last_name, 
		e.first_name
-- select *
from employees e
join dept_manager dm on (e.emp_no=dm.emp_no)
join departments d on (dm.dept_no=d.dept_no);


-- 4. List the department of each employee with the following information: 
--    employee number, last name, first name, and department name.

select e.emp_no,
		e.last_name,
		e.first_name,
		d.dept_name
from employees e
left join dept_emp de on (e.emp_no=de.emp_no)
left join departments d on (de.dept_no=d.dept_no);


-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select * from employees
where first_name like 'Hercules'
and last_name like 'b%';

-- 6. List all employees in the Sales department, 
---including their employee number, last name, first name, and department name.

--create view
create view x as
select e.emp_no,e.last_name,e.first_name,d.dept_name
from employees e
left join dept_emp de on (e.emp_no=de.emp_no)
left join departments d on (de.dept_no=d.dept_no);
-- use view
select * 
from x
where dept_name like 'Sales';

-- 7. List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
select * 
from x
where dept_name like 'Sales'
or dept_name like 'Development';

-- 8. In descending order, 
--list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name,count(emp_no) as sharing_name
from employees
group by last_name
order by sharing_name desc;





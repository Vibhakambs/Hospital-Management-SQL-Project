-- assignment 7--
-- mangement sytem --

create database hospital_management_system;
use hospital_management_system;

-- 1. department table
create table department(dept_id int auto_increment primary key,
dept_name varchar(50) not null unique,
floor_no int not null check(floor_no > 0));

-- 2. doctor table
create table doctor(doctor_id int auto_increment primary key,
doctor_name varchar(50) not null,
spec varchar(50) not null,
phone varchar(10) unique,
salary decimal(10,2) not null check(salary > 0),
dept_id int not null,
foreign key(dept_id)
references department(dept_id));

-- 3. patient table
create table patient(patient_id int auto_increment primary key,
patient_name varchar(50) not null,
gender varchar(10) not null,
age int not null check(age > 0),
phone varchar(10) unique,
address varchar(100));

-- 4. appointment table
create table appointment(appointment_id int auto_increment primary key,
patient_id int not null,
doctor_id int not null,
appointment_date date not null,
appointment_time time not null,
status varchar(20) default 'pending',
foreign key(patient_id)references patient(patient_id),
foreign key(doctor_id)references doctor(doctor_id));

-- 5. bill table
create table bill(bill_id int auto_increment primary key,
 patient_id int not null,
appointment_id int not null,
amount decimal(10,2) not null check(amount > 0),
bill_date date not null,
payment_status varchar(20) default 'pending',
foreign key(patient_id)references patient(patient_id),
foreign key(appointment_id)references appointment(appointment_id));

-- inserting all records
-- department table values 
insert into department(dept_name, floor_no)values('Cardiology', 1),
('Neurology', 2),('Orthopedics', 3),
('Pediatrics', 4),('Dermatology', 5);

-- doctors tables values 
insert into doctor(doctor_name, spec, phone, salary, dept_id)values
('dr. amit sharma', 'cardiologist', '9876543210', 85000, 1),
('dr. murnmai patil', 'neurologist', '9876543211', 90000, 2),
('dr. rahul deshmukh', 'orthopedic', '9876543212', 75000, 3),
('dr. supriya joshi', 'pediatrician', '9876543213', 70000, 4),
('dr. rani kulkarni', 'dermatologist', '9876543214', 65000, 5),
('dr. raj mehta', 'cardiologist', '9876543215', 82000, 1),
('dr. yash shah', 'neurologist', '9876543216', 88000, 2);

-- insert patient data
insert into patient(patient_name, gender, age, phone, address)values
('vibhawari kamble', 'female', 22, '9876500001', 'pune'),
('shital pawar', 'female', 23, '9876500002', 'pune'),
('yogeshwari shinde', 'female', 22, '9876500003', 'nashik'),
('rohit jadhav', 'male', 35, '9876500004', 'mumbai'),
('shravni pawar', 'female', 28, '9876500005', 'pune'),
('varad kamble', 'male', 40, '9876500006', 'satara'),
('urmila shelar', 'female', 50, '9876500007', 'kolhapur');

-- insert appointment data
insert into appointment(patient_id, doctor_id, appointment_date, appointment_time, status)values
(1, 1, '2026-08-01', '10:00:00', 'completed'),
(2, 2, '2026-08-02', '11:00:00', 'completed'),
(3, 3, '2026-08-03', '12:00:00', 'pending'),
(4, 4, '2026-08-04', '10:30:00', 'completed'),
(5, 5, '2026-08-05', '11:30:00', 'pending'),
(6, 6, '2026-08-06', '09:30:00', 'completed'),
(7, 7, '2026-08-07', '01:00:00', 'pending');

-- insert bill data
insert into bill(patient_id, appointment_id, amount, bill_date, payment_status)values
(1, 8, 5000, '2026-08-01', 'paid'),
(2, 9, 7500, '2026-08-02', 'paid'),
(3, 10, 3000, '2026-08-03', 'pending'),
(4, 11, 4500, '2026-08-04', 'paid'),
(5, 12, 2500, '2026-08-05', 'pending'),
(6, 13, 9000, '2026-08-06', 'paid'),
(7, 14, 6000, '2026-08-07', 'pending');

-- display all records
select * from department;
select * from doctor;
select * from patient;
select * from appointment;
select * from bill;

-- where clause
-- Patients from Pune 
select * from patient where address = 'pune';

-- Patients older than 30
select * from patient where age > 30;

-- doctors with salary greater than 80000
select * from doctor where salary > 80000;

-- female patients
select * from patient where gender = 'female';

-- 2. ORDER BY

-- doctors according to salary
select * from doctor
order by salary;

-- doctors with highest salary first
select * from doctor
order by salary desc;

-- patients according to age
select * from patient
order by age desc;

-- 3. LIMIT
-- top 3 highest paid doctors
select * from doctor order by salary desc limit 3;

-- first 5 patients
select * from patient limit 5;

-- 4. UPDATE
-- update patient address
update patient set address = 'mumbai' where patient_id = 3;

-- update doctor salary
update doctor set salary = 95000 where doctor_id = 1;

-- update appointment status
update appointment set status = 'completed' where appointment_id = 10;

-- update bill payment status
update bill set payment_status = 'paid' where bill_id = 17;

-- 5. AGGREGATE FUNCTIONS
-- count total patients
select count(*) as total_patients from patient;

-- count total doctors
select count(*) as total_doctors from doctor;

-- total salary of all doctors
select sum(salary) as total_salary from doctor;

-- average doctor salary
select avg(salary) as average_salary from doctor;

-- highest doctor salary
select max(salary) as highest_salary from doctor;

-- lowest doctor salary
select min(salary) as lowest_salary from doctor;

-- total bill amount
select sum(amount) as total_bill from bill;

-- average bill amount
select avg(amount) as average_bill from bill;

-- 6. GROUP BY
-- number of doctors in each department
select dept_id, count(*) as total_doctors from doctor group by dept_id;

-- number of patients according to gender
select gender, count(*) as total_patients from patient group by gender;

-- number of bills according to payment status
select payment_status, count(*) as total_bills from bill group by payment_status;

-- 7. HAVING
-- departments having more than one doctor
select dept_id, count(*) as total_doctors from doctor
group by dept_id having count(*) > 1;

-- payment status having more than 2 bills
select payment_status, count(*) as total_bills from bill
group by payment_status having count(*) > 2;

-- 8. INNER JOIN
-- doctor and department details
select d.doctor_name, d.spec, dp.dept_name
from doctor d inner join department dp
on d.dept_id = dp.dept_id;

-- patient and appointment details
select p.patient_name, a.appointment_date, a.appointment_time, a.status
from patient p inner join appointment a
on p.patient_id = a.patient_id;

-- patient, doctor and appointment details
select p.patient_name, d.doctor_name, d.spec, a.appointment_date,a.appointment_time, a.status
from patient p inner join appointment a
on p.patient_id = a.patient_id
inner join doctor d
on a.doctor_id = d.doctor_id;

-- 9. PATIENT BILL DETAILS
select p.patient_name,b.amount,b.bill_date,b.payment_status
from patient pinner join bill b
on p.patient_id = b.patient_id;

-- 10. COMPLETE HOSPITAL DETAILS
select p.patient_name,d.doctor_name,d.spec,dp.dept_name,a.appointment_date,a.appointment_time,a.status,b.amount,b.payment_status
from patient p inner join appointment a
on p.patient_id = a.patient_id inner join doctor d
on a.doctor_id = d.doctor_id inner join department dp
on d.dept_id = dp.dept_id inner join bill b
on p.patient_id = b.patient_id;

-- 11. LEFT JOIN

-- all departments and their doctors
select dp.dept_name, d.doctor_name
from department dp left join doctor d
on dp.dept_id = d.dept_id;

-- all patients and their appointments
select p.patient_name, a.appointment_date, a.status
from patient p left join appointment a
on p.patient_id = a.patient_id;

-- 12. RIGHT JOIN

select dp.dept_name, d.doctor_name
from department dp right join doctor d
on dp.dept_id = d.dept_id;

-- 13. UNION

select doctor_name as name from doctor
union
select patient_name as name from patient;

-- 14. SUBQUERIES
-- doctors earning more than average salary
select * from doctor
where salary > (select avg(salary)from doctor);

-- doctor with highest salary
select * from doctor
where salary = (select max(salary)from doctor);

-- bills greater than average bill
select * from bill
where amount > (select avg(amount)from bill);

-- patient having highest bill
select * from patient
where patient_id = (select patient_id from bill where amount = (select max(amount)from bill));

-- 15. EXISTS
-- patients who have appointments
select * from patient p
where exists (select *from appointment a where a.patient_id = p.patient_id);

-- 16. IN SUBQUERY

-- doctors working in cardiology or neurology
select * from doctor
where dept_id in (select dept_id from department where dept_name in ('Cardiology', 'Neurology'));

-- 17. VIEW

create view patient_appointment_details as select
p.patient_name,d.doctor_name,d.spec,a.appointment_date,a.appointment_time,a.status
from patient p inner join appointment a
on p.patient_id = a.patient_id inner join doctor d
on a.doctor_id = d.doctor_id;

-- display view
select * from patient_appointment_details;

-- 18. SECOND VIEW

create view patient_bill_details as
select p.patient_name,b.amount,b.bill_date,b.payment_status
from patient p inner join bill b
on p.patient_id = b.patient_id;

-- display view
select * from patient_bill_details;

-- 19. INDEX

create index idx_patient_name on patient(patient_name);

create index idx_doctor_spec
on doctor(spec);

-- display indexes
show index from patient;

show index from doctor;

-- 20. TCL - COMMIT

start transaction;
update doctor
set salary = 90000
where doctor_id = 1;
commit;

-- 21. TCL - ROLLBACK

start transaction;
update doctor
set salary = 100000
where doctor_id = 2;
rollback;

-- 22. TCL - SAVEPOINT

start transaction;
update doctor
set salary = 95000
where doctor_id = 1;
savepoint s1;

update doctor
set salary = 100000
where doctor_id = 2;
rollback to s1;
commit;

-- 23. STORED PROCEDURE - SHOW DOCTORS

delimiter //
create procedure show_doctors()
begin
select * from doctor;
end //
delimiter ;

call show_doctors();

-- 24. STORED PROCEDURE - GET PATIENT

delimiter //
create procedure get_patient(in pid int)
begin
    select * from patient
    where patient_id = pid;
end //
delimiter ;

call get_patient(1);

-- 25. STORED PROCEDURE - GET DOCTOR SALARY

delimiter //
create procedure get_doctor_salary(in did int)
begin
    select doctor_name, salary
    from doctor
    where doctor_id = did;
end //
delimiter ;

call get_doctor_salary(1);

-- 26. TRIGGER - PAYMENT STATUS

delimiter //
create trigger before_bill_insert
before insert on bill
for each row
begin
    if new.payment_status is null then
        set new.payment_status = 'pending';
    end if;
end //
delimiter ;

-- 27. TRIGGER - CHECK BILL AMOUNT

delimiter //
create trigger check_bill_amount
before insert on bill
for each row
begin
    if new.amount <= 0 then
        signal sqlstate '45000'
        set message_text = 'Bill amount must be greater than zero';
    end if;
end //
delimiter ;

-- 28. PROJECT-SPECIFIC QUERIES

-- pending appointments
select * from appointment where status = 'pending';

-- completed appointments
select * from appointment where status = 'completed';

-- unpaid bills
select * from bill where payment_status = 'pending';

-- paid bills
select * from bill
where payment_status = 'paid';

-- total paid amount
select sum(amount) as total_paid
from bill
where payment_status = 'paid';

-- total pending amount
select sum(amount) as total_pending
from bill where payment_status = 'pending';

-- oldest patient
select * from patient order by age desc limit 1;

-- youngest patient
select * from patient order by age limit 1;

-- highest bill
select * from bill order by amount desc limit 1;
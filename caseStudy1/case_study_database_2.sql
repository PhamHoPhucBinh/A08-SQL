create database caseStudy1;
use caseStudy1;
create table employee(
employee_id INT primary key not null,
employee_name varchar(45),
employee_birthday DATE,
employee_id_card varchar(45),
employee_salary DOUBLE,
employee_phone varchar(45),
employee_email varchar(45),
employee_address varchar(45),
position_id int,
education_degree_id int,
division_id int,
username varchar(255),
foreign key (position_id) references  `position`(position_id),
foreign key (education_degree_id) references education_degree(education_degree_id),
foreign key (division_id) references division(division_id),
foreign key (username) references user(username)
);

create table user(
username varchar(225) primary key,
`password` varchar(225)
);

create table user_role(
role_id int,
username varchar(255),
foreign key (username) references user(username),
foreign key (role_id) references role(role_id)
);
create table `role` (
role_id int primary key,
role_name varchar(255)
);

create table division(
division_id int primary key not null,
division_name varchar(45)
);

create table education_degree(
education_degree_id int primary key not null,
education_degree_name varchar(45)
);
create table `position`(
position_id int,
position_name varchar(45)
);

create table customer(
customer_id int primary key not null,
customer_type_id int,
customer_name varchar(45),
customer_birthday date,
customer_gender bit(1),
customer_id_card varchar(45),
customer_phone varchar(45),
customer_email varchar(45),
customer_address varchar(45)
);

create table contract(
contract_id int primary key not null,
contract_start_date datetime,
contract_end_date datetime,
contract_deposit double,
contract_total_money double,
employee_id int,
customer_id int,
service_id int
);

create table attach_service(
attach_service_id int primary key not null,
attach_service_name varchar(45),
attach_service_cost double,
attach_service_unit int,
attach_service_status varchar(45)
);

create table contract_detail(
contract_detail_id int primary key not null,
contract_id int,
attach_service_id int,
quantity int,
foreign key (contract_id) references contract(contract_id),
foreign key (attach_service_id) references attach_service(attach_service_id)
);

create table service(
service_id int primary key not null,
service_name varchar(45),
service_area int,
service_cost double,
service_max_people int,
rent_type_id int,
service_type_id int,
standard_room varchar(45),
description_other_convenience varchar(45),
pool_area double,
number_of_floors int,
foreign key (rent_type_id) references service(rent_type_id),
foreign key (service_type_id) references service_type(service_type_id)
);

create table service_type(
service_type_id int  not null primary key,
service_type_name varchar(45)
);

create table rent_type(
rent_type_id int primary key  not null,
rent_type_name varchar(45),
rent_type_cost double
);



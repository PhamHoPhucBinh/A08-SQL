create view customer_views AS
select customerNumber, customerName, Phone
from customers;
select * from customer_views;


create or replace view customer_views as
select customerNumber,customerName,phone,addressLine1
from customers
where city = 'Nantes';

select * from customer_views;
drop view customer_views;
alter table customers add unique index unit_index_customerNumber(customerNumber);
alter table customers add index fullname_index(contactLastName,contactFirstName);
select * from customers where contactLastName = 'Nantes';
alter table customers drop index idx_customerName;

create or replace view contact_data as
select customerNumber,contactLastName,contactFirstName,customerName,phone
from customers;

select * from contact_data;
explain select * from `customers` where customerName = 'Land Of Toys Inc.';
-- câu lệnh thêm :  index ALTER TABLE customers ADD INDEX idx_customerName(customerName);
alter table `customers` add index idx_customerName(customerName);
explain select * from `customers` where customerName = 'Land Of Toys Inc.';
-- xóa index :  ALTER TABLE customers DROP INDEX idx_full_name; 
alter table customers add index idx_full_name(contactLastName,contactFirstName);
alter table customers drop index idx_full_name;


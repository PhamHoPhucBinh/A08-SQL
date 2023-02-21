delimiter //
create procedure getCustomerById(IN cusNum INT(3))
begin
select * from customers where customerNumber = cusNum;
end //
delimiter ;

call getCustomerById(50);
drop procedure getCustomerById;
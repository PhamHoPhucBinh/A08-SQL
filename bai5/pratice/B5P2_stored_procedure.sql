DELIMITER // 
create procedure findAllCustomers()
Begin 
select customerNumber,customerName from customers;
end //
delimiter ;

call findAllCustomers;
drop procedure findAllCustomers;
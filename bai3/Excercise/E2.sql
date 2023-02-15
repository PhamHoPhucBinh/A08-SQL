use quanlybanhang;
insert into customer
values (1,'Minh Quan',10),(2,'Ngoc Oanh',20),
(3,'Hong Ha',50);
insert into `order`(cID,oDate,oTotalPrice)
values (1,'2006-03-21',null),
(2,'2006-03-23',null),
(1,'2006-03-16',null);

insert into product (pName,pPrice)
values ('May Giat',3),('Tu Lanh',5),('Dieu Hoa',7),
('Quat',1),('Bep Dien',2);

insert orderdetail (odQTY)
values (3),(7),(2),(1),(8),(4),(3);

select oID,oDate,oTotalPrice from `order` ;
select customer.cName ,product.pName, `order`.cID,customer.cID  from customer,`order`,product;
select * from customer c
join `order` o on c.cid = o.cid;

select cID,cName 
from customer
where not exists ( select cID from `order` 
where cID = customer.cID);





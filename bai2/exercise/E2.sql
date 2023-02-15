create database QuanLyBanHang;
use QuanLyBanhang;
create table Customer(
cID int auto_increment primary key,
cName nvarchar(45),
cAge int
);
create table `Order`(
oID int auto_increment primary key,
cID int ,
oDate date,
oTotalPrice double,
foreign key (cID) references Customer(cID)
);
create table `Product`(
pID int auto_increment primary key,
pName nvarchar(50),
pPrice double
);
create table OrderDetail(
pID INT,
oID int,
odQTY varchar(50),
foreign key (pID) references`Product`(pID),
foreign key (oID) references `Order`(oID)
);

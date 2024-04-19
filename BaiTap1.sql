create database QuanLyBanHang;
use QuanLyBanHang;

create table Customer (
                          cID int PRIMARY KEY AUTO_INCREMENT,
                          cName varchar(255) not null unique,
                          cAge int not null
);

create table `Order` (
                         oID int PRIMARY KEY AUTO_INCREMENT,
                         cID int,
                         oDate Date,
                         oTotalPrice DECIMAL not null
);

alter table `Order` add constraint fk_Order_Customer FOREIGN KEY (cID) REFERENCES Customer(cID);

create table Product (
                         pID int PRIMARY KEY AUTO_INCREMENT,
                         pName varchar(25) not null unique,
                         pPrice DECIMAL not null
);

create table OrderDetail (
                             oID int,
                             pID int,
                             odQTY int not null
);

alter table OrderDetail add constraint fk_OrderDetail_Order FOREIGN KEY (oID) REFERENCES `Order`(oID);
alter table OrderDetail add constraint fk_OrderDetail_Product FOREIGN KEY (pID) REFERENCES Product(pID);
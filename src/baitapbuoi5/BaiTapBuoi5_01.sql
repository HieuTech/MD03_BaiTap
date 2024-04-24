create database buoi05_01;
       use buoi05_01;

CREATE TABLE Products (
                          Id INT AUTO_INCREMENT PRIMARY KEY,
                          productCode VARCHAR(50),
                          productName VARCHAR(100),
                          productPrice DECIMAL(10, 2),
                          productAmount INT,
                          productDescription TEXT,
                          productStatus VARCHAR(20)
);
INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES ('P001', 'iPhone 13', 999.99, 50, 'The latest iPhone model', 'Available');

INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES ('P002', 'Samsung Galaxy S22', 899.99, 40, 'Samsung flagship smartphone', 'Available');

INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES ('P003', 'MacBook Pro 2023', 1999.99, 30, 'High-performance laptop from Apple', 'Available');

INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES ('P004', 'Dell XPS 15', 1499.99, 25, 'Powerful laptop for professionals', 'Available');


create index index_id on Products(Id);
create index index_Price_Name on Products(productPrice, productName);

explain analyze select productCode from Products;
# -> Table scan on Products  (cost=0.65 rows=4) (actual time=0.026..0.0324 rows=4 loops=1)
create index index_productCode on Products(productCode);


explain analyze select productCode from Products;
# -> Covering index scan on Products using index_productCode  (cost=0.65 rows=4) (actual time=0.0346..0.0417 rows=4 loops=1)

#4

create view view_selectProduct
as select productCode, productName, productPrice, productStatus

   from Products;

select * from view_selectProduct;
drop view view_selectProduct;

#5
#procedure select all product
delimiter //
create procedure  selectAll()
begin
    select * from Products;
end ;//

call selectAll();


create database QuanLiTaiLieu;
       use QuanLiTaiLieu;
-- Creating the 'account' table
CREATE TABLE account (
                         acc_id INT PRIMARY KEY,
                         user_name VARCHAR(30),
                         password VARCHAR(30),
                         permission BIT,
                         acc_status BIT
);

-- Creating the 'bill' table
CREATE TABLE bill (
                      bill_id INT PRIMARY KEY,
                      bill_code VARCHAR(10),
                      bill_type BIT,
                      acc_id_created INT,
                      created DATE,
                      auth_date DATE,
                      FOREIGN KEY (acc_id_created) REFERENCES account(acc_id)
);

-- Creating the 'bill_detail' table
CREATE TABLE bill_detail (
                             bill_detail_id INT PRIMARY KEY,
                             bill_id INT,
                             product_id INT,
                             quantity INT,
                             price FLOAT,
                             FOREIGN KEY (bill_id) REFERENCES bill(bill_id),
                             FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Creating the 'product' table
CREATE TABLE product (
                         product_id INT PRIMARY KEY,
                         product_name VARCHAR(150),
                         manufacturer VARCHAR(200),
                         created DATE,
                         batch TINYINT,
                         quantity INT,
                         product_status BIT
);

-- Inserting data into 'account'
INSERT INTO account (acc_id, user_name, password, permission, acc_status) VALUES
                                                                              (1, 'user1', 'pass1', 1, 1),
                                                                              (2, 'user2', 'pass2', 0, 1),
                                                                              (3, 'user3', 'pass3', 1, 0);

-- Inserting data into 'product'
INSERT INTO product (product_id, product_name, manufacturer, created, batch, quantity, product_status) VALUES
                                                                                                           (1, 'Product A', 'Manufacturer A', '2024-04-01', 1, 100, 1),
                                                                                                           (2, 'Product B', 'Manufacturer B', '2024-03-01', 2, 150, 1),
                                                                                                           (3, 'Product C', 'Manufacturer C', '2024-02-01', 3, 200, 0);

-- Inserting data into 'bill'
INSERT INTO bill (bill_id, bill_code, bill_type, acc_id_created, created, auth_date) VALUES
                                                                                         (1, 'B001', 1, 1, '2024-04-20', '2024-04-21'),
                                                                                         (2, 'B002', 0, 2, '2024-04-18', '2024-04-19'),
                                                                                         (3, 'B003', 1, 1, '2024-04-22', NULL);

-- Inserting data into 'bill_detail'
INSERT INTO bill_detail (bill_detail_id, bill_id, product_id, quantity, price) VALUES
                                                                                   (1, 1, 1, 2, 500.0),
                                                                                   (2, 1, 2, 3, 750.0),
                                                                                   (3, 2, 3, 1, 1000.0);

#1
select * from account where acc_id not in
(select bill.acc_id_created from  bill);


#2
select * from bill where bill_id in
(select bill_id from bill_detail where quantity >= 2);

#3
select * from product where product_id not in
(select product_id from bill_detail);

#4
select * from product where product_id in
(select product_id from bill_detail where quantity <= 1);

#5
select * from bill where bill_type = '2023-03-13';
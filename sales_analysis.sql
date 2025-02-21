create database sales_analysis;

use sales_analysis;
-- customer table 
create table customers(
customer_id int auto_increment primary key,
name varchar(100) not null,
email varchar(100)unique not null,
signup_data date not null,
region varchar(50) not null
);
SET SQL_SAFE_UPDATES = 0;

-- update customers
-- set signup_data = "signup_date";



alter table customers change signup_data signup_date date;

-- products table
create table products(
product_id int auto_increment primary key,
product_name varchar(100) not null,
category varchar(50),
price decimal(10,2) not Null
);

 -- orders table
create table orders (
order_id int auto_increment primary key,
customer_id int,
order_date date not null,
total_amount decimal(10,2),
 foreign key (customer_id) references customers(customer_id) on delete cascade
);
select * from orders;

DELETE FROM orders;

-- order_details table
create table order_details(
order_details_id int auto_increment primary key,
order_id int ,
product_id int,
quantity INT not null,
foreign key(order_id) references orders(order_id) on delete cascade,
foreign key(product_id) references products(product_id) on delete cascade

);

-- populating the tables 

 -- customer ddata

insert into customers (name,email,signup_date,region) values
('Lawrence Osuru','lawrence@gmail.com','2025-02-21','Nairobi'),
('Caleb Oduor','caleb@gmail.com','2024-02-21','Bsia'),
('Brenda Awino','brenda@gmail.com','2025-01-21','Kisumu'),
('Sharon Akinyi','sharon@gmail.com','2023-02-21','Mombasa'),
('Immaculate Osuru','immaculate@gmail.com','2025-02-21','Nairobi'),
('Vivian Neema','neema@gmail.com','2025-02-21','Nairobi');
select * from customers;





-- products data

INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 20000.00),
('Smartphone', 'Electronics', 15000.00),
('Headphones', 'Accessories', 800.00),
('Desk Chair', 'Furniture', 7000.00);

select * from products;

-- orders data 

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2025-02-01', 7000.00),
(2, '2025-02-05', 800.00),
(3, '2025-02-10', 15000.00),
(4, '2025-02-15', 20000.00),
(5, '2025-02-21', 27000.00),
(6, '2025-02-13', 20000.00);

select * from orders;



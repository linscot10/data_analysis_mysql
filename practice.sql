create DATABASE practice;

use practice;

-- customer table

CREATE Table customers(
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL ,
    email VARCHAR(100) UNIQUE,
    join_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO customers(name,email) VALUES
("Lawrence Scott", "osurulawrence@gmail.com"),
("Caleb Osuru","calebosuru@gmail.com");


INSERT INTO customers (name, email, join_date) VALUES
('John Doe', 'john.doe@example.com', '2023-01-15 10:30:00'),
('Jane Smith', 'jane.smith@example.com', '2023-02-20 12:45:00'),
('Sam Johnson', 'sam.johnson@example.com', '2023-03-10 14:00:00'),
('Emily Davis', 'emily.davis@example.com', '2023-04-05 16:15:00'),
('Michael Brown', 'michael.brown@example.com', '2023-05-25 09:00:00'),
('Sarah Wilson', 'sarah.wilson@example.com', '2023-06-11 18:30:00'),
('David Lee', 'david.lee@example.com', '2023-07-22 08:00:00'),
('Laura King', 'laura.king@example.com', '2023-08-03 11:20:00'),
('Chris Martinez', 'chris.martinez@example.com', '2023-09-14 13:40:00'),
('Olivia Moore', 'olivia.moore@example.com', '2023-10-01 17:50:00');


ALTER TABLE customers ADD phone VARCHAR(20);

ALTER TABLE customers MODIFY name VARCHAR(150);

alter table customers DROP phone;

DROP table customers;

SELECT * from customers

-- products table

create Table products(
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) not NULL,
    price DECIMAL(10,2)NOT NULL,
    category VARCHAR(50)
)

DROP Table products;

ALTER table products
MODIFY COLUMN product_id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE products AUTO_INCREMENT = 0;


insert INTO products(name,price,category)VALUES
("laptops",20000.00,"Electronics"),
("denim",2000.00,"clothes"),
("Plata",150.00,"Utensils");

-- Insert dummy products
INSERT INTO products (name, price, category) VALUES
('Laptop', 799.99, 'Electronics'),
('Smartphone', 499.99, 'Electronics'),
('Wireless Headphones', 129.99, 'Electronics'),
('Tablet', 299.99, 'Electronics'),
('Bluetooth Speaker', 89.99, 'Electronics'),
('Gaming Mouse', 39.99, 'Accessories'),
('Keyboard', 49.99, 'Accessories'),
('Smartwatch', 199.99, 'Electronics'),
('4K Monitor', 349.99, 'Electronics'),
('External Hard Drive', 79.99, 'Accessories');



SELECT * from products;

show  CREATE TABLE products;


CREATE Table orders(
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    quantity INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    Foreign Key (customer_id) REFERENCES customers(customer_id),
    Foreign Key (product_id) REFERENCES products(product_id)
);

INSERT INTO orders (customer_id, product_id, quantity) VALUES 
(1, 1, 2),
(2, 2, 1);

-- Insert dummy orders
INSERT INTO orders (customer_id, product_id, quantity, order_date) VALUES
(1, 1, 1, '2023-01-15 10:30:00'),  -- John Doe buys 1 Laptop
(2, 2, 2, '2023-02-20 12:45:00'),  -- Jane Smith buys 2 Smartphones
(3, 3, 3, '2023-03-10 14:00:00'),  -- Sam Johnson buys 3 Wireless Headphones
(4, 4, 1, '2023-04-05 16:15:00'),  -- Emily Davis buys 1 Tablet
(5, 5, 5, '2023-05-25 09:00:00'),  -- Michael Brown buys 5 Bluetooth Speakers
(6, 6, 2, '2023-06-11 18:30:00'),  -- Sarah Wilson buys 2 Gaming Mice
(7, 7, 4, '2023-07-22 08:00:00'),  -- David Lee buys 4 Keyboards
(8, 8, 1, '2023-08-03 11:20:00'),  -- Laura King buys 1 Smartwatch
(9, 9, 2, '2023-09-14 13:40:00'),  -- Chris Martinez buys 2 4K Monitors
(10, 10, 1, '2023-10-01 17:50:00'); -- Olivia Moore buys 1 External Hard Drive

ALTER TABLE orders
ADD CONSTRAINT orders_ibfk_2
FOREIGN KEY (product_id)
REFERENCES products(product_id);

SELECT * from orders;

ALTER TABLE orders
DROP FOREIGN KEY orders_ibfk_2;


show CREATE TABLE orders;



-- ANALYSE

-- total number of customers

SELECT count(*) AS total_customers from customers;
SELECT * from customers;

-- total number of  products

select count(*) AS total_products from products;
SELECT * from products;
-- total orders

select count(*) AS total_orders from orders;
SELECT * from orders;


-- total quantity of products ordered 

SELECT quantity from orders ;

SELECT SUM(quantity) AS total_quantity_ordered
from orders;


SELECT SUM(p.price * o.quantity) AS total_sales
 FROM orders o 
 JOIN products p ON o.product_id =p.product_id;

 SELECT AVG(quantity) AS avg_order_quantity
FROM orders;


SELECT 
    p.name AS product_name,
    SUM(o.quantity) AS total_quantity_ordered
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.name;

--  1. INNER JOIN
-- returns only the macthing raws from both tables

SELECT * from orders 
INNER JOIN customers ON orders.customer_id=customers.customer_id;

-- LEFT JOIN (or LEFT OUTER JOIN)
-- returns all rows from the left table and matched rows from the right table

SELECT * from customers
LEFT JOIN orders ON customers.customer_id=orders.customer_id;

--  RIGHT JOIN (or RIGHT OUTER JOIN)
-- returns all rows from the right table and matched rows from the left

SELECT * FROM orders 
RIGHT JOIN customers ON orders.customer_id =customers.customer_id;

-- FULL JOIN (or FULL OUTER JOIN)
-- returns all rows when there is  match in either table

SELECT * from orders
FULL JOIN customers ON orders.customer_id =customers.customer_id;;

SELECT * 
FROM orders 
LEFT JOIN customers ON orders.customer_id = customers.customer_id

UNION

SELECT * 
FROM orders 
RIGHT JOIN customers ON orders.customer_id = customers.customer_id;


-- 🧪 Practice Task: Combine Sales and Customer Data
-- 🔧 Tables Setup:

CREATE TABLE customers1 (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  city VARCHAR(100)
);

CREATE TABLE sales (
  id INT PRIMARY KEY,
  customer_id INT,
  product VARCHAR(100),
  amount DECIMAL(10,2),
  sale_date DATE
);


INSERT INTO customers1 (id, name, city) VALUES
(1, 'Alice Johnson', 'New York'),
(2, 'Bob Smith', 'Los Angeles'),
(3, 'Carol Davis', 'Chicago'),
(4, 'David Lee', 'Houston'),
(5, 'Eva Brown', 'Phoenix');

SELECT * FROM customers1;
INSERT INTO sales (id, customer_id, product, amount, sale_date) VALUES
(101, 1, 'Laptop', 1200.00, '2024-11-15'),
(102, 1, 'Mouse', 25.99, '2024-12-01'),
(103, 2, 'Keyboard', 45.00, '2025-01-05'),
(104, 3, 'Monitor', 300.00, '2025-02-10'),
(105, 4, 'Tablet', 499.99, '2025-03-03'),
(106, 2, 'Laptop', 1100.00, '2025-03-15'),
(107, 5, 'Phone', 899.00, '2025-04-01'),
(108, 5, 'Headphones', 199.99, '2025-04-15');


SELECT * FROM sales;

-- Get total sales per customer;
SELECT c.name, SUM(s.amount) AS total_sales
FROM customers1 c
JOIN sales s ON c.id = s.customer_id
GROUP BY c.name;


--  Find customers who haven’t made a purchase

SELECT name
FROM customers1
WHERE id NOT IN (SELECT customer_id FROM sales);

-- Show customers and their purchases (include those with no sales)
SELECT c.name, s.product, s.amount
FROM customers1 c
LEFT JOIN sales s ON c.id = s.customer_id;

--  Find top spender

SELECT c.name, SUM(s.amount) AS total
FROM customers1 c
JOIN sales s ON c.id = s.customer_id
GROUP BY c.name
ORDER BY total DESC
LIMIT 1;

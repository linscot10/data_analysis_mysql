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
("Caleb Osuru","calebosuru@gmail.com")


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
("Plata",150.00,"Utensils")


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
ALTER TABLE orders
ADD CONSTRAINT orders_ibfk_2
FOREIGN KEY (product_id)
REFERENCES products(product_id);

SELECT * from orders;

ALTER TABLE orders
DROP FOREIGN KEY orders_ibfk_2;


show CREATE TABLE orders;


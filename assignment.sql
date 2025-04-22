-- Active: 1744364707698@@127.0.0.1@5432@bookstore_db
-- create book table
CREATE Table books(
    id serial PRIMARY KEY,
    title varchar(255) NOT NULL,
    author varchar(255) NOT NULL,
    published_year date NOT NULL,
    stock INTEGER NOT NULL,
    price numeric(10, 2) NOT NULL
);
 SELECT * from books;

-- create customer table
CREATE TABLE customers(
    customer_id serial PRIMARY KEY,
    name varchar(255) NOT NULL,
    email varchar(255) NOT NULL UNIQUE,
    joined_date date NOT NULL
);
SELECT * from customers;
ALTER Table customers
 RENAME COLUMN customer_id to id;

-- create orders table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id) ON DELETE CASCADE,
    book_id INTEGER REFERENCES books(id) ON DELETE CASCADE,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
SELECT * from orders;

-- //! -- 1. Insert a new book into the book table.

INSERT INTO books (id, title, author, price, stock, published_year) VALUES
(1, 'The Pragmatic Programmer', 'Andrew Hunt', 40.00, 10, 1999),
(2, 'Clean Code', 'Robert C. Martin', 35.00, 5, 2008),
(3, 'You Don''t Know JS', 'Kyle Simpson', 30.00, 8, 2014),
(4, 'Refactoring', 'Martin Fowler', 50.00, 3, 1999),
(5, 'Database Design Principles', 'Jane Smith', 20.00, 0, 2018);

-- //! -- 2. Insert a new customer into the customers table.
INSERT INTO customers (id, name, email, joined_date) VALUES
(1, 'Alice', 'alice@email.com', '2023-01-10'),
(2, 'Bob', 'bob@email.com', '2022-05-15'),
(3, 'Charlie', 'charlie@email.com', '2023-06-20');

-- //! -- 3. Insert a new order into the orders table.
INSERT INTO orders (id, customer_id, book_id, quantity, order_date) VALUES
(1, 1, 2, 1, '2024-03-10'),
(2, 2, 1, 1, '2024-02-20'),
(3, 1, 3, 2, '2024-03-05');

--problem-1:
SELECT * FROM books
    WHERE stock = 0;

--problem-2:
 SELECT * FROM books
 ORDER BY price DESC LIMIT 1;

--problem-3:
SELECT customers.name, SUM(orders.quantity) AS total_orders
FROM orders
JOIN customers ON orders.customer_id = customers.id
GROUP BY customers.name;


--problem-4:
SELECT SUM(book.price* orders.quantity) as total_revenue FROM orders
 JOIN books ON orders.book_id = book.id;


--problem-5:
SELECT customers.name, SUM(orders.quantity) AS total_orders
FROM orders
JOIN customers ON orders.customer_id = customers.id
GROUP BY customers.name
HAVING SUM(orders.quantity) > 1;

--problem-6:
SELECT round(avg(price),2) as avg_book_price from  book;

--problem-7--update the price of all books published before 2000 by 10%:
UPDATE books
SET price=price*1.10
WHERE published_year<2000;

--problem-8--delete all who did not place any orders:
DELETE FROM customers
WHERE id
 NOT IN 
(SELECT DISTINCT customer_id FROM orders);
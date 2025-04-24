-- Active: 1744364707698@@127.0.0.1@5432@bookstore_db
-- create book table

--problem-1:
SELECT * FROM books
    WHERE stock = 0;

--problem-2:
 SELECT * FROM books
 ORDER BY price DESC LIMIT 1;

--problem-3:
SELECT name, SUM(quantity) AS total_orders
FROM orders
JOIN customers USING (customer_id)
GROUP BY name;



--problem-4:
SELECT SUM(books.price* orders.quantity) as total_revenue FROM orders
 JOIN books ON orders.book_id = books.id;


--problem-5:
SELECT name, SUM(quantity) AS total_orders
FROM orders
JOIN customers USING (customer_id)
GROUP BY name
HAVING SUM(orders.quantity)> 1;
;

--problem-6:
SELECT round(avg(price),2) as avg_book_price from  books;

--problem-7--update the price of all books published before 2000 by 10%:
UPDATE books
SET price=price*1.10
WHERE published_year<2000;

--problem-8--delete all who did not place any orders:
DELETE FROM customers
WHERE customer_id
 NOT IN 
(SELECT DISTINCT customer_id FROM orders);
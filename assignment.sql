-- Active: 1744364707698@@127.0.0.1@5432@bookstore_db
CREATE Table book(
    id serial PRIMARY KEY,
    title varchar(255) NOT NULL,
    author varchar(255) NOT NULL,
    published_year date NOT NULL,
    stock INTEGER NOT NULL,
    price numeric(10, 2) NOT NULL
);
 SELECT * from book;
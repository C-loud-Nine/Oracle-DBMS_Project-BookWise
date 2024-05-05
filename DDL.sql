DROP TABLE Orders;
DROP TABLE Employees;
DROP TABLE Sales;
DROP TABLE Inventory;
DROP TABLE Genre;
DROP TABLE Customers;
DROP TABLE Books;
DROP TABLE Authors;




set pagesize 100
set linesize 200



-- Create the Books table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    genre_id INT,
    price DECIMAL(10, 2),
    publication_date DATE,
    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id) ON DELETE CASCADE
);

-- Create the Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(20),
    address VARCHAR(255)
);

-- Create the Genre table
CREATE TABLE Genre (
    genre_id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- Create the Inventory table
CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY,
    book_id INT,
    quantity INT,
    available NUMBER(1),
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);

-- Create the Sales table
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    book_id INT,
    sale_date DATE,
    total_price DECIMAL(10, 2),
    employee_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id) ON DELETE CASCADE
);

-- Create the Employees table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(20),
    position VARCHAR(100),
    hire_date DATE
);

-- Create the Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    book_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);


-- Create the Authors table
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    name VARCHAR(255),
    nationality VARCHAR(100),
    birth_date DATE,
    death_date DATE
);




-- Add a new column "description" to the "Genre" table
ALTER TABLE Genre ADD description VARCHAR(255);

-- Drop the "description" column from the "Genre" table
ALTER TABLE Genre DROP COLUMN description;

-- Modify the data type of the "phone_number" column in the "Employees" table to VARCHAR(30)
ALTER TABLE Employees MODIFY phone_number VARCHAR(30);

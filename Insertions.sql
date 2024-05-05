
-- Books table
INSERT INTO Books (book_id, title, author, genre_id, price, publication_date) VALUES
(101, 'Norwegian Wood', 'Haruki Murakami', 301, 14.99, DATE '1987-08-04');

INSERT INTO Books (book_id, title, author, genre_id, price, publication_date) VALUES
(102, 'To Kill a Mockingbird', 'Harper Lee', 304, 12.50, DATE '1960-07-11');

INSERT INTO Books (book_id, title, author, genre_id, price, publication_date) VALUES
(103, '1984', 'George Orwell', 303, 10.99, DATE '1949-06-08');

INSERT INTO Books (book_id, title, author, genre_id, price, publication_date) VALUES
(104, 'The Great Gatsby', 'F. Scott Fitzgerald', 301, 11.25, DATE '1925-04-10');

INSERT INTO Books (book_id, title, author, genre_id, price, publication_date) VALUES
(105, 'Pride and Prejudice', 'Jane Austen', 304, 9.75, DATE '1813-01-28');

-- Customers table
INSERT INTO Customers (customer_id, name, email, phone_number, address) VALUES
(201, 'Alice Smith', 'alice@example.com', '123-456-7890', '123 Main St');

INSERT INTO Customers (customer_id, name, email, phone_number, address) VALUES
(202, 'Bob Johnson', 'bob@example.com', '456-789-0123', '456 Elm St');

INSERT INTO Customers (customer_id, name, email, phone_number, address) VALUES
(203, 'Charlie Brown', 'charlie@example.com', '789-012-3456', '789 Oak St');

INSERT INTO Customers (customer_id, name, email, phone_number, address) VALUES
(204, 'David Lee', 'david@example.com', '012-345-6789', '012 Pine St');

INSERT INTO Customers (customer_id, name, email, phone_number, address) VALUES
(205, 'Eva Davis', 'eva@example.com', '345-678-9012', '345 Cedar St');

-- Genre table
INSERT INTO Genre (genre_id, name) VALUES
(301, 'Fiction');

INSERT INTO Genre (genre_id, name) VALUES
(302, 'Mystery');

INSERT INTO Genre (genre_id, name) VALUES
(303, 'Science Fiction');

INSERT INTO Genre (genre_id, name) VALUES
(304, 'Romance');

INSERT INTO Genre (genre_id, name) VALUES
(305, 'Fantasy');

-- Inventory table
INSERT INTO Inventory (inventory_id, book_id, quantity, available) VALUES
(401, 101, 20, 1);

INSERT INTO Inventory (inventory_id, book_id, quantity, available) VALUES
(402, 102, 15, 1);

INSERT INTO Inventory (inventory_id, book_id, quantity, available) VALUES
(403, 103, 25, 1);

INSERT INTO Inventory (inventory_id, book_id, quantity, available) VALUES
(404, 104, 30, 1);

INSERT INTO Inventory (inventory_id, book_id, quantity, available) VALUES
(405, 105, 18, 1);

-- Sales table
INSERT INTO Sales (sale_id, customer_id, book_id, sale_date, total_price, employee_id) VALUES
(801, 201, 101, DATE '2023-01-15', 74.95, 601);

INSERT INTO Sales (sale_id, customer_id, book_id, sale_date, total_price, employee_id) VALUES
(802, 202, 102, DATE '2023-02-20', 62.50, 602);

INSERT INTO Sales (sale_id, customer_id, book_id, sale_date, total_price, employee_id) VALUES
(803, 203, 103, DATE '2023-03-25', 54.95, 603);

INSERT INTO Sales (sale_id, customer_id, book_id, sale_date, total_price, employee_id) VALUES
(804, 204, 104, DATE '2023-04-30', 67.50, 604);

INSERT INTO Sales (sale_id, customer_id, book_id, sale_date, total_price, employee_id) VALUES
(805, 205, 105, DATE '2023-05-05', 48.75, 605);

-- Employees table
INSERT INTO Employees (employee_id, name, email, phone_number, position, hire_date) VALUES
(601, 'John Doe', 'john@example.com', '567-890-1234', 'Manager', DATE '2020-01-01');

INSERT INTO Employees (employee_id, name, email, phone_number, position, hire_date) VALUES
(602, 'Jane Smith', 'jane@example.com', '678-901-2345', 'Sales Associate', DATE '2020-02-01');

INSERT INTO Employees (employee_id, name, email, phone_number, position, hire_date) VALUES
(603, 'Michael Brown', 'michael@example.com', '789-012-3456', 'Cashier', DATE '2020-03-01');

INSERT INTO Employees (employee_id, name, email, phone_number, position, hire_date) VALUES
(604, 'Emily Johnson', 'emily@example.com', '890-123-4567', 'Assistant Manager', DATE '2020-04-01');

INSERT INTO Employees (employee_id, name, email, phone_number, position, hire_date) VALUES
(605, 'William Davis', 'william@example.com', '901-234-5678', 'Supervisor', DATE '2020-05-01');


-- Orders table
INSERT INTO Orders (order_id, customer_id, book_id, order_date, quantity) VALUES
(201, 201, 101, DATE '2023-01-01', 3);

INSERT INTO Orders (order_id, customer_id, book_id, order_date, quantity) VALUES
(202, 202, 102, DATE '2023-02-02', 2);

INSERT INTO Orders (order_id, customer_id, book_id, order_date, quantity) VALUES
(203, 203, 103, DATE '2023-03-03', 1);

INSERT INTO Orders (order_id, customer_id, book_id, order_date, quantity) VALUES
(204, 204, 104, DATE '2023-04-04', 4);

INSERT INTO Orders (order_id, customer_id, book_id, order_date, quantity) VALUES
(205, 205, 105, DATE '2023-05-05', 2);



-- Insert 5 entries into the Authors table
INSERT INTO Authors (author_id, name, nationality, birth_date, death_date) VALUES
(701, 'Haruki Murakami', 'Japanese', DATE '1949-01-12', NULL);

INSERT INTO Authors (author_id, name, nationality, birth_date, death_date) VALUES
(702, 'Harper Lee', 'American', DATE '1926-04-28', DATE '2016-02-19');

INSERT INTO Authors (author_id, name, nationality, birth_date, death_date) VALUES
(703, 'George Orwell', 'British', DATE '1903-06-25', DATE '1950-01-21');

INSERT INTO Authors (author_id, name, nationality, birth_date, death_date) VALUES
(704, 'F. Scott Fitzgerald', 'American', DATE '1896-09-24', DATE '1940-12-21');

INSERT INTO Authors (author_id, name, nationality, birth_date, death_date) VALUES
(705, 'Jane Austen', 'British', DATE '1775-12-16', DATE '1817-07-18');

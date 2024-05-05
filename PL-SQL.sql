

-- Retrieve all books authored by "Haruki Murakami"
SELECT * FROM Books WHERE author = 'Haruki Murakami';

-- Retrieve titles and authors of books in the "Fiction" genre
SELECT title, author FROM Books WHERE genre_id = (SELECT genre_id FROM Genre WHERE name = 'Fiction');

-- Retrieve books written by American authors in the "Romance" genre
SELECT * FROM Books WHERE author IN (SELECT name FROM Authors WHERE nationality = 'American') AND genre_id IN (SELECT genre_id FROM Genre WHERE name = 'Romance');

-- Retrieve names and emails of customers who bought the book "Norwegian Wood"
SELECT name, email FROM Customers WHERE customer_id IN (SELECT customer_id FROM Sales WHERE book_id = (SELECT book_id FROM Books WHERE title = 'Norwegian Wood'));

-- Add a new column "description" to the "Genre" table
ALTER TABLE Genre ADD description VARCHAR(255);

-- Drop the "description" column from the "Genre" table
ALTER TABLE Genre DROP COLUMN description;

-- Modify the data type of the "phone_number" column in the "Employees" table to VARCHAR(30)
ALTER TABLE Employees MODIFY phone_number VARCHAR(30);

-- Drop the "Sales" table from the database
DROP TABLE Sales;

-- Drop the "available" column from the "Inventory" table
ALTER TABLE Inventory DROP COLUMN available;

-- Update the price of books authored by "Haruki Murakami" to $15.99
UPDATE Books SET price = 15.99 WHERE author = 'Haruki Murakami';

-- Delete a record from the "Inventory" table where the "inventory_id" is 401
DELETE FROM Inventory WHERE inventory_id = 401;

-- Retrieve book IDs from both the "Inventory" and "Sales" tables meeting certain conditions and combine the results using UNION
SELECT book_id FROM Inventory WHERE quantity > 0 INTERSECT SELECT book_id FROM Sales WHERE total_price > 1000;

-- Retrieve book IDs of books that are in inventory and were sold within a specific date range
SELECT book_id FROM Inventory WHERE quantity > 0 INTERSECT SELECT book_id FROM Sales WHERE sale_date BETWEEN TO_DATE('2023-01-01', 'YYYY-MM-DD') AND TO_DATE('2024-01-01', 'YYYY-MM-DD');

-- Retrieve distinct authors of books sold within a specific date range
SELECT DISTINCT author FROM Books WHERE book_id IN (SELECT DISTINCT book_id FROM Sales WHERE sale_date BETWEEN TO_DATE('2023-01-01', 'YYYY-MM-DD') AND TO_DATE('2023-12-31', 'YYYY-MM-DD'));

-- Calculate total sales for each employee and display their names
WITH TotalSales AS (
    SELECT employee_id, SUM(total_price) AS total_sales
    FROM Sales
    GROUP BY employee_id
)
SELECT e.name AS employee_name, ts.total_sales
FROM TotalSales ts
JOIN Employees e ON ts.employee_id = e.employee_id;

-- Retrieve book titles, authors, and available quantities
WITH AvailableBooks AS (
    SELECT book_id, SUM(quantity) AS total_quantity
    FROM Inventory
    WHERE available = 1
    GROUP BY book_id
)
SELECT b.title, b.author, ab.total_quantity
FROM AvailableBooks ab
JOIN Books b ON ab.book_id = b.book_id;

-- Retrieve the maximum price from the "Books" table
SELECT MAX(price) AS max_price FROM Books;

-- Retrieve customers who made purchases and have the address '123 Main St'
SELECT * FROM Customers WHERE (customer_id IN (SELECT DISTINCT customer_id FROM Sales)) AND (address = '123 Main St');

-- Retrieve books that are either in inventory or have a price less than $15.00
SELECT * FROM Books WHERE (book_id IN (SELECT book_id FROM Inventory)) OR (price < 15.00);

-- Retrieve employees who are not managers and were hired after January 1, 2020
SELECT * FROM Employees WHERE (position != 'Manager') AND (hire_date > TO_DATE('2020-01-01', 'YYYY-MM-DD'));

-- Search for book titles containing the substring 'Nor'
SELECT title, author FROM Books WHERE title LIKE '%Nor%';

-- Create a view "BookDetails" containing title, author, and price from the "Books" table
CREATE VIEW BookDetails AS SELECT title, author, price FROM Books;

-- PL/SQL Block to retrieve and display details of an author based on ID
SET SERVEROUTPUT ON;
DECLARE 
    author_id Authors.author_id%TYPE;
    author_name Authors.name%TYPE;
    author_nationality Authors.nationality%TYPE;
    author_birth_date Authors.birth_date%TYPE;
    author_death_date Authors.death_date%TYPE;
BEGIN
    SELECT author_id, name, nationality, birth_date, death_date 
    INTO author_id, author_name, author_nationality, author_birth_date, author_death_date 
    FROM Authors 
    WHERE author_id = 703;
    
    DBMS_OUTPUT.PUT_LINE('Author ID: ' || author_id || ' Name: ' || author_name || 
                         ' Nationality: ' || author_nationality || ' Birth Date: ' || author_birth_date || 
                         ' Death Date: ' || author_death_date);
END;
/

-- PL/SQL Block to insert a record into the "Inventory" table and display the inserted record
SET SERVEROUTPUT ON;
DECLARE
    inventory_id Inventory.inventory_id%TYPE := 207;
    book_id Inventory.book_id%TYPE := 104;
    quantity Inventory.quantity%TYPE := 25;
    available NUMBER(1) := 1; -- Assuming 1 indicates available
BEGIN
    INSERT INTO Inventory (inventory_id, book_id, quantity, available)
    VALUES (inventory_id, book_id, quantity, available);
    DBMS_OUTPUT.PUT_LINE('Row inserted successfully into Inventory table.');
END;
/

-- PL/SQL Block to retrieve and display a specific record from the "Inventory" table
SET SERVEROUTPUT ON;
DECLARE
    counter NUMBER;
BEGIN
    SELECT * INTO counter FROM Inventory WHERE inventory_id = 207;
    DBMS_OUTPUT.PUT_LINE('Counter: ' || counter);
END;
/

-- PL/SQL Block to retrieve and display details of an employee based on ID, handling exceptions
SET SERVEROUTPUT ON;
DECLARE
    emp_row Employees%ROWTYPE;
BEGIN
    BEGIN
        SELECT employee_id, name, email, phone_number, position, hire_date
        INTO emp_row.employee_id, emp_row.name, emp_row.email, emp_row.phone_number, emp_row.position, emp_row.hire_date
        FROM Employees
        WHERE employee_id = 603;
        
        -- Print employee details
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_row.employee_id);
        DBMS_OUTPUT.PUT_LINE('Name: ' || emp_row.name);
        DBMS_OUTPUT.PUT_LINE('Email: ' || emp_row.email);
        DBMS_OUTPUT.PUT_LINE('Phone Number: ' || emp_row.phone_number);
        DBMS_OUTPUT.PUT_LINE('Position: ' || emp_row.position);
        DBMS_OUTPUT.PUT_LINE('Hire Date: ' || TO_CHAR(emp_row.hire_date, 'YYYY-MM-DD'));
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No employee found with ID 603.');
    END;
END;
/

-- PL/SQL Block to retrieve and display details of all books using a cursor
SET SERVEROUTPUT ON;
DECLARE 
    CURSOR book_cursor IS SELECT * FROM Books;
    book_row Books%ROWTYPE;
BEGIN
    OPEN book_cursor;
    FETCH book_cursor INTO book_row.book_id, book_row.title, book_row.author, book_row.genre_id, book_row.price, book_row.publication_date;
    WHILE book_cursor%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE('Book ID: ' || book_row.book_id || ', Title: ' || book_row.title || ', Author: ' || book_row.author || ', Genre ID: ' || book_row.genre_id || ', Price: ' || book_row.price || ', Publication Date: ' || book_row.publication_date);
        DBMS_OUTPUT.PUT_LINE('Row count: ' || book_cursor%ROWCOUNT);
        FETCH book_cursor INTO book_row.book_id, book_row.title, book_row.author, book_row.genre_id, book_row.price, book_row.publication_date;
    END LOOP;
    CLOSE book_cursor;
END;
/

-- PL/SQL Block to retrieve and display names of predefined genres using VARRAY
SET SERVEROUTPUT ON;
DECLARE
    counter NUMBER;
    TYPE NAMEARRAY IS VARRAY(5) OF Genre.name%TYPE;
    A_NAME NAMEARRAY := NAMEARRAY();
BEGIN
    FOR x IN 1..5
    LOOP
        A_NAME.EXTEND();
        CASE x
            WHEN 1 THEN A_NAME(x) := 'Fiction';
            WHEN 2 THEN A_NAME(x) := 'Mystery';
            WHEN 3 THEN A_NAME(x) := 'Science Fiction';
            WHEN 4 THEN A_NAME(x) := 'Romance';
            WHEN 5 THEN A_NAME(x) := 'Fantasy';
        END CASE;
    END LOOP;
    
    FOR i IN A_NAME.FIRST..A_NAME.LAST
    LOOP
        DBMS_OUTPUT.PUT_LINE('Genre Name: ' || A_NAME(i));
    END LOOP;
END;
/

-- PL/SQL Block to retrieve and display nationalities of predefined authors using VARRAY and CASE statements
SET SERVEROUTPUT ON;
DECLARE 
    counter NUMBER := 1;
    author_name2 Authors.name%TYPE;
    TYPE NAMEARRAY IS VARRAY(5) OF Authors.name%TYPE;
    A_NAME NAMEARRAY := NAMEARRAY('Haruki Murakami', 'Harper Lee', 'George Orwell', 'F. Scott Fitzgerald', 'Jane Austen');
BEGIN
    FOR x IN A_NAME.FIRST..A_NAME.LAST
    LOOP
        SELECT name INTO author_name2 FROM Authors WHERE name = A_NAME(x);
        IF author_name2 = 'Haruki Murakami' THEN
            DBMS_OUTPUT.PUT_LINE(author_name2 || ' was born in Japan');
        ELSIF author_name2 = 'Harper Lee' THEN
            DBMS_OUTPUT.PUT_LINE(author_name2 || ' was born in America');
        ELSIF author_name2 = 'George Orwell' THEN
            DBMS_OUTPUT.PUT_LINE(author_name2 || ' was born in the United Kingdom');
        ELSIF author_name2 = 'F. Scott Fitzgerald' THEN
            DBMS_OUTPUT.PUT_LINE(author_name2 || ' was born in America');
        ELSE
            DBMS_OUTPUT.PUT_LINE(author_name2 || ' was born in the United Kingdom');
        END IF;
    END LOOP;
END;
/

-- Create a stored procedure to retrieve and display book information
CREATE OR REPLACE PROCEDURE proc_book_info(
  book_id_param IN NUMBER,
  book_title OUT VARCHAR2,
  updated_book_id IN OUT NUMBER
)
AS
  t_msg VARCHAR2(100);
BEGIN
  t_msg := 'Book information: ';
  SELECT title INTO book_title FROM Books WHERE book_id = book_id_param;
  updated_book_id := book_id_param + 1; 
  DBMS_OUTPUT.PUT_LINE(t_msg || book_title || ', Book ID: ' || book_id_param || ', Updated Book ID: ' || updated_book_id);
END;
/

-- Call the stored procedure to retrieve and display book information
SET SERVEROUTPUT ON;
DECLARE 
  book_id_input Books.book_id%TYPE := 101;
  book_title_output Books.title%TYPE;
  updated_book_id_output NUMBER;
BEGIN
  proc_book_info(book_id_input, book_title_output, updated_book_id_output);
END;
/

-- Create a function to retrieve customer name based on ID
CREATE OR REPLACE FUNCTION get_customer_name(customer_id_param IN NUMBER) RETURN VARCHAR2 AS
  customer_name_value Customers.name%TYPE;
BEGIN
  SELECT name INTO customer_name_value FROM Customers WHERE customer_id = customer_id_param;
  RETURN customer_name_value;
END;
/

-- Call the function to retrieve and display customer name
SET SERVEROUTPUT ON;
DECLARE
  customer_name_var VARCHAR2(255);
BEGIN
  customer_name_var := get_customer_name(201);
  DBMS_OUTPUT.PUT_LINE('Customer Name: ' || customer_name_var);
END;
/

-- Create a trigger to update inventory after each sale
CREATE OR REPLACE TRIGGER update_inventory_after_sale
AFTER INSERT ON Sales
FOR EACH ROW
DECLARE
    v_book_id Books.book_id%TYPE;
BEGIN
    v_book_id := :NEW.book_id;
    UPDATE Inventory
    SET quantity = quantity - 1
    WHERE book_id = v_book_id;
END;
/

-- Insert a record into the "Sales" table and check if the quantity has been updated in the "Inventory" table
INSERT INTO Sales (sale_id, customer_id, book_id, sale_date, total_price, employee_id) 
VALUES (809, 201, 101, DATE '2023-06-10', 14.99, 601);

-- Check the "Inventory" table to see if the quantity has been updated
SELECT * FROM Inventory WHERE book_id = 101;

-- SELECT 
-- 	first_name, 
--     last_name, 
--     points, 
--     (points + 10) * 100 AS 'discount factor'
-- FROM customers 

-- SELECT DISTINCT state  -- get unique data, remove the duplicates
-- FROM customers

-- SELECT 
-- 	name, 
--     unit_price,
--     unit_price * 1.1 AS 'new price'
-- FROM products

-- SELECT *
-- FROM customers
-- -- WHERE state != 'VA'
-- WHERE birth_date > '1990-01-01'
-- -- > >= < <= = != 

-- -- get the orders placed this year
-- SELECT *
-- FROM orders
-- WHERE order_date >= '2019-01-01'

-- SELECT *
-- FROM customers
-- WHERE birth_date > '1990-01-01' AND points > 1000
-- WHERE birth_date > '1990-01-01' OR points > 1000 AND
-- 	  state = 'VA'  -- last two condition are true
-- -- AND is evaluated first. 
-- WHERE birth_date > '1990-01-01' OR 
-- 	  (points > 1000 AND state = 'VA' )
-- WHERE NOT (birth_date > '1990-01-01' OR points > 1000 ) 
-- -- equals to WHERE birth_date <= '1990-01-01' AND points<= 1000

-- -- From the order_items table, get the items
-- --	for order #6
-- -- 	where the total price is greater than 30
-- SELECT *
-- FROM order_items
-- WHERE order_id = 6 AND (quantity * unit_price) > 30

-- SELECT *
-- FROM customers
-- WHERE state = 'VA' OR state = 'GA' OR state = 'FL'
-- WHERE state IN ('VA', 'FL', 'GA')
-- WHERE state NOT IN ('VA', 'FL', 'GA')

-- -- Return products with
-- -- 	quantity in stock equal to 49, 38, 72
-- SELECT *
-- FROM products
-- WHERE quantity_in_stock In (49, 38, 72)

-- SELECT *
-- FROM customers
-- WHERE points >= 1000 AND points <= 3000
-- WHERE points BETWEEN 1000 AND 3000

-- -- Return customers born between 1/1/1990 and 1/1/2000
-- SELECT *
-- FROM customers
-- WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01'

-- SELECT *
-- FROM customers
-- WHERE last_name LIKE 'b%'  -- any last name starts with b, % means any characters
-- WHERE last_name LIKE 'brush%'
-- WHERE last_name LIKE '%b%'  -- we have any number of characters before or after b
-- WHERE last_name LIKE '%y'  -- last name ends by y
-- WHERE last_name LIKE '_y'  -- the last name is exactly two characters long, 
-- -- the first character can be anything but the second character should be y
-- WHERE last_name LIKE '_____y'
-- WHERE last_name LIKE 'b____y'  -- last name starts with b, after b we have 4 characters followed by y
-- -- % any number of characters
-- -- _ single character

-- -- Get the customers whose
-- -- 	addresses contain TRAIL or AVENUE
-- SELECT *
-- FROM customers
-- WHERE (address LIKE '%TRAIL%' OR address LIKE '%AVENUE%')
-- -- 	phone numbers end with 9
-- WHERE phone LIKE '%9'

-- SELECT * 
-- FROM customers
-- WHERE last_name LIKE '%field%'
-- -- regexp short for regular expression, for searching strings
-- WHERE last_name REGEXP 'field' 
-- -- ^ the beginning of the string '^field'
-- -- $ the end of the string 'field$'
-- WHERE last_name REGEXP 'field$|mac|rose'  
-- -- | for searching multiple words, logical or
-- WHERE last_name REGEXP '[gim]e'  
-- -- [] match if have ge, ie, me in their last name. match any single characters listed in []
-- WHERE last_name REGEXP 'e[fmq]' 
-- WHERE last_name REGEXP '[a-h]e'
-- -- [a-h]: a to h. hypen to present a range.

-- -- Get the customers whose
-- SELECT *
-- FROM customers
-- --	first names are ELKA or AMBUR
-- WHERE first_name REGEXP 'ELKA|AMBUR'
-- -- 	last names end with EY or ON
-- WHERE last_name REGEXP 'EY$|ON$'
-- -- 	last names start with MY or contains SE
-- WHERE last_name REGEXP '^MY|SE'
-- -- 	last names contain B followed by R or U	
-- WHERE last_name REGEXP 'B[RU]'	-- or 'BR|BU'

-- SELECT *
-- FROM customers
-- -- select all customers who don't have a phone
-- WHERE phone IS NULL
-- WHERE phone IS NOT NULL -- customers who have a phone

-- -- GET the orders that are not shipped
-- SELECT *
-- FROM orders
-- WHERE shipped_date IS NULL -- WHERE shipped_id IS NULL

-- -- sort data
-- SELECT first_name, last_name, 10 AS points
-- FROM customers
-- -- PRIMARY KEY column: the value is unique. default sorted by this column 
-- ORDER BY first_name DESC -- DESC: descending
-- ORDER BY state DESC, first_name DESC -- first sorted by state, then sorted by first_name
-- ORDER BY points, first_name

-- SELECT order_id, product_id, quantity, unit_price, quantity * unit_price AS total_price
-- FROM order_items
-- WHERE order_id = 2
-- ORDER BY quantity * unit_price DESC   -- can be alias or math expression

-- -- limit the number of records returned from the query
-- SELECT *
-- FROM customers
-- -- LIMIT 3  -- only return first 3 results
-- LIMIT 6,3  -- skip the first 6 records, and then pick 3 records

-- -- GET the top three loyal customers
-- SELECT *
-- FROM customers
-- ORDER BY points DESC
-- LIMIT 3

-- -- order of clauses:
-- -- 	SELECT, FROM, WHERE, ORDER BY, LIMIT

-- SELECT order_id, first_name, last_name, orders.customer_id
-- FROM orders
-- -- -- combines the columns in these two tables
-- JOIN customers ON orders.customer_id = customers.customer_id
-- -- can not select customer_id column since we have it in both tables. 
-- -- we should prefix a table name

-- -- Using alias
-- SELECT order_id, first_name, last_name, o.customer_id
-- FROM orders o
-- -- combines the columns in these two tables
-- JOIN customers c
-- 	ON o.customer_id = c.customer_id

-- SELECT order_id, oi.product_id, quantity, oi.unit_price
-- FROM order_items oi
-- JOIN products p 
-- 	ON oi.product_id = p.product_id
-- -- when give it an alias, you have to use it everywhere

-- -- Joining Across Databases
-- SELECT *
-- FROM order_items oi
-- JOIN sql_inventory.products p  -- prefixing the products table with the name of the database
-- 	ON oi.product_id = p.product_id
-- -- we only have to prefix te tables that are not part of the current database.

-- -- Joining a table with itself: self join
-- USE sql_hr;
-- SELECT 
-- 	e.employee_id,
--     e.first_name,
--     m.first_name AS manager
-- FROM employees e
-- JOIN employees m
-- 	ON e.reports_to = m.employee_id
-- -- use prefixes and prefix each column with an alias
      
-- -- Joining multiple tables
-- USE SQL_STORE;
-- SELECT 
-- 	o.order_id,
--     o.order_date,
--     c.first_name,
--     c.last_name,
--     os.name AS status
-- FROM orders o
-- JOIN customers c
-- 	ON o.customer_id = c.customer_id
-- JOIN order_statuses os
-- 	ON o.status = os.order_status_id
-- ORDER BY o.order_id 

-- USE sql_invoicing;
-- SELECT 
-- 	p.date,
--     p.invoice_id,
--     p.amount,
--     c.name,
--     pm.name
-- FROM payments p
-- JOIN payment_methods pm
-- 	ON p.payment_method = pm.payment_method_id
-- JOIN clients c
-- 	ON p.client_id = c.client_id


-- -- Compound Join Conditions
-- -- use two columns to unique identify each order item
-- USE sql_store;
-- SELECT * 
-- FROM order_items oi
-- JOIN order_item_notes oin
-- 	ON oi.order_id = oin.order_id
--     AND oi.product_id = oin.product_id  -- compound join conditions


-- SELECT *
-- FROM orders o
-- JOIN customers c
-- 	ON o.customer_id = c.customer_id
-- -- Implicit Join Syntax    
-- SELECT *
-- FROM orders O, customers c
-- WHERE o.customer_id = c.customer_id
-- -- better use explicit JOIN condition


-- -- Outer joins
-- -- (INNER) JOIN, OUTER JOIN
-- SELECT 
-- 	c.customer_id,
--     c.first_name,
--     o.order_id
-- FROM customers c
-- JOIN orders o
-- 	ON c.customer_id = o.customer_id
-- ORDER BY c.customer_id
-- -- only return customers who have orders
-- -- see customers whether they have an order or not: using outer join
-- -- two types of outer join: LEFT JOIN, RIGHT JOIN

-- SELECT 
-- 	c.customer_id,
--     c.first_name,
--     o.order_id
-- FROM customers c
-- LEFT JOIN orders o
-- -- RIGHT JOIN orders o
-- 	ON c.customer_id = o.customer_id
-- ORDER BY c.customer_id
-- -- LEFT JOIN: all the records from the left table (customers) are returned
-- -- whether this condition is true or not.
-- -- RIGHT JOIN: all the records from the orders table are returned 
-- -- whether this condition is true or not.
-- -- if you wanna see all customers with right join, you need to swipe the table orders.
-- -- don't have to type outer: LEFT (OUTER) JOIN

-- SELECT 
-- 	p.product_id,
--     p.name,
--     oi.quantity
-- FROM products p
-- LEFT JOIN order_items oi
-- 	ON p.product_id = oi.product_id


-- -- Outer Join Between Multiple Tables 
-- SELECT 
-- 	c.customer_id,
--     c.first_name,
--     o.order_id,
--     sh.name
-- FROM customers c
-- LEFT JOIN orders o
-- 	ON c.customer_id = o.customer_id
-- LEFT JOIN shippers sh
-- 	ON o.shipper_id = sh.shipper_id
-- ORDER BY c.customer_id

-- SELECT 
-- 	o.order_date,
--     o.order_id,
--     c.first_name AS customer,
--     s.name AS shipper,
--     os.name AS status
-- FROM orders o
-- JOIN order_statuses os
-- 	ON o.status = os.order_status_id
-- JOIN customers c
-- 	ON o.customer_id = c.customer_id
-- LEFT JOIN shippers s
-- 	ON o.shipper_id = s.shipper_id
-- ORDER BY os.name, o.order_id

-- -- Self Outer Joins
-- USE sql_hr;
-- SELECT 
-- 	e.employee_id,
--     e.first_name,
--     m.first_name AS manager
-- FROM employees e
-- LEFT JOIN employees m
-- 	ON e.reports_to = m.employee_id
-- -- we don't have the manager himself: use LEFT JOIN

-- -- The USING Clause
-- USE sql_store;
-- SELECT 
-- 	o.order_id,
--     c.first_name,
--     sh.name AS shipper
-- From orders o
-- JOIN customers c
	-- ON o.customer_id = c.customer_id
-- -- if the column name is exactly the same across these two tables, 
-- -- we can replace the ON clause with a USING clause.
--     USING (customer_id)
-- LEFT JOIN shippers sh
-- 	USING (shipper_id)

-- SELECT *
-- FROM order_items oi
-- JOIN order_item_notes oin
-- 	ON oi.order_id = oin.order_id AND 
-- 		oi.product_id = oin.product_id
-- 	USING (order_id, product_id)
    
-- USE sql_invoicing;
-- SELECT 
-- 	p.date,
--     c.name AS client,
--     p.amount,
--     pm.name
-- FROM payments p
-- JOIN clients c
-- 	USING (client_id)
-- JOIN payment_methods pm
-- 	ON p.payment_method = pm.payment_method_id

-- -- Natural Joins (not recommend)
-- -- The database engine will look at these two tables and it will
-- -- join them based on the common columns.
-- USE sql_store;
-- SELECT 
-- 	o.order_id,
--     c.first_name
-- FROM orders o
-- NATURAL JOIN customers c -- don't expecitly specify the column names

-- -- Cross Joins
-- -- We use cross joins to combine or join every record from the first table, 
-- -- with every record in the second table.
-- SELECT 
-- 	c.first_name AS customer,
--     p.name AS product
-- FROM customers c  -- implicit syntax: FROM customers c, orders o (delete cross join...)
-- CROSS JOIN products p  -- explicit syntax
-- ORDER BY c.first_name
-- -- When to use CROSS JOIN: when you have a table of sizes like small, medium and large.
-- -- And a table of colors, like red, blue, green. 
-- -- And you want to combine all the size with all the colors.


-- -- Do a cross join between shippers and products
-- -- 	using the implicit syntax
-- SELECT 
-- 	s.name AS shipper,
--     p.name AS product
-- FROM shippers s, products p
-- -- 	and then using the eplicit syntax
-- FROM shippers s
-- CROSS JOIN products p
-- ORDER BY s.name


-- -- Unions (combine rows with multiple tables)
-- SELECT 
-- 	order_id,
--     order_date,
--     'Active' AS status
-- FROM orders
-- WHERE order_date >= '2019-01-01'
-- UNION  -- combine records for multiple queries.
-- SELECT 
-- 	order_id,
--     order_date,
--     'Archived' AS status
-- FROM orders
-- WHERE order_date < '2019-01-01'

-- -- Unions from different table
-- SELECT first_name
-- FROM customers
-- UNION
-- SELECT name
-- FROM shippers
-- -- !! The number of columns that the each query returns (SELECT ...) should be equal,
-- -- otherwise you're going to get an error.
-- -- What we have in the first query is used to determine the name of columns.

-- SELECT 
-- 	customer_id, 
-- 	first_name, 
--     points, 
--     'Bronze' AS type
-- FROM customers
-- WHERE points < 2000
-- UNION
-- SELECT 
-- 	customer_id, 
-- 	first_name, 
--     points, 
--     'SILVER' AS type
-- FROM customers
-- WHERE points BETWEEN 2000 AND 3000
-- UNION
-- SELECT 
-- 	customer_id, 
-- 	first_name, 
--     points, 
--     'GOLD' AS type
-- FROM customers
-- WHERE points > 3000
-- ORDER BY first_name


-- -- Column Attributes: INSERT, UPDATE, and DELETE data
 
 
 -- -- Inserting a Single Row
-- INSERT INTO customers  -- table name
 -- -- add VALUES to each columns
--  VALUES (
-- 	DEFAULT,  -- customer_id
--     'John',   -- first_name
--     'Smith',  -- last_name
--     '1990-01-01',  -- birth_date
--      NULL,-- phone
--      'address',
--      'city',
--      'CA',
--      DEFAULT)

-- -- another way, specify column s
--  INSERT INTO customers  (
-- 	first_name,
--     last_name,
--     birth_date,
--     address,
--     city,
--     state)
--  VALUES (
--     'John',   -- first_name
--     'Smith',  -- last_name
--     '1990-01-01',  -- birth_date
--      'address',
--      'city',
--      'CA')
     
     
-- -- Inserting Multiple Rows
-- INSERT INTO shippers(name)
-- VALUES ('Shipper1'),
-- 	   ('Shipper1'),
--        ('Shipper3')

-- -- Insert three rows in the products table
-- INSERT INTO products (name, quantity_in_stock, unit_price)
-- VALUES ('Name1', 30, 2),
-- 	   ('Name2', 60, 4),
--        ('Name3', 90, 6)


-- -- Inserting Hierarchical Rows
-- -- The orders table is the parent, and the order_items is child. 
-- -- One row in the orders tale can have 1 or more children inside the order items table.
-- -- The order ID should be the same in these two tables.
-- -- LAST_INSERT_ID(): return the id that MySQL generates when we insert a new row.
-- INSERT INTO orders (customer_id, order_date, status)
-- VALUES (1, '2019-01-02', 1);
-- INSERT INTO order_items
-- VALUES 
-- 	(LAST_INSERT_ID(), 1, 1, 2.95),
--     (LAST_INSERT_ID(), 2, 1, 3.95)


-- -- Creating a Copy of a Table
-- CREATE TABLE orders_archived AS 
-- SELECT * FROM orders  -- sub query
-- -- but MySQL will ignore PK, AI and some attributes.

-- -- only copy a subset of a table
-- INSERT INTO orders_archived()
-- SELECT *
-- FROM orders
-- WHERE order_date < '2019-01-01'

-- USE sql_invoicing;
-- CREATE TABLE invoices_archived AS
-- SELECT 
-- 	i.invoice_id,
--     i.number,
--     c.name,
-- 	i.payment_total,
--     i.invoice_date,
--     i.due_date,
--     i.payment_date
-- FROM invoices i
-- JOIN clients c ON i.client_id = c.client_id
-- WHERE i.payment_date IS NOT NULL


-- -- Updating a Single Row
-- UPDATE invoices
-- SET payment_total = 10, payment_date = '2019-03-01'  -- specify a new value
-- WHERE invoice_id = 1

-- UPDATE invoices
-- SET payment_total = DEFAULT, payment_date = NULL  -- specify a new value
-- WHERE invoice_id = 1

-- UPDATE invoices
-- SET 
-- 	payment_total = invoice_total * 0.5, 
-- 	payment_date = due_date  -- specify a new value
-- WHERE invoice_id = 3

-- -- Updating Multiple Rows
-- USE sql_invoicing;
-- UPDATE invoices
-- SET 
-- 	payment_total = invoice_total * 0.5, 
-- 	payment_date = due_date  -- specify a new value
-- WHERE client_id IN (3, 5)


-- -- Write a SQL statement to
-- -- 	give any customers born before 1990
-- -- 	50 extra points
-- USE sql_store;
-- UPDATE customers
-- SET
-- 	points = points + 50
-- WHERE birth_date < '1990-01-01'


-- -- Using Subqueries in Updates
-- USE sql_invoicing;
-- UPDATE invoices
-- SET 
-- 	payment_total = invoice_total * 0.5, 
-- 	payment_date = due_date  -- specify a new value
-- WHERE client_id = 
-- 	(SELECT client_id
-- 	FROM clients
-- 	WHERE name = 'Myworks')
-- -- update the clients from NY or CA
-- WHERE client_id IN   -- return multiple results can not use =
--     (SELECT client_id
-- 	FROM clients
-- 	WHERE state IN ('CA', 'NY'))

-- -- if don't use sub query is also fine
-- UPDATE invoices
-- SET 
-- 	payment_total = invoice_total * 0.5, 
-- 	payment_date = due_date  -- specify a new value
-- -- SELECT *  --  remove
-- -- FROM invoives  -- remove
-- 	WHERE payment_date IS NULL  -- get attach to the update statement


-- USE sql_store;
-- UPDATE orders o
-- SET 
-- 	comments = 'GOLD member'
-- WHERE customer_id IN (
-- 	SELECT customer_id
--     FROM customers 
--     WHERE points > 3000)
    
-- -- Deleting Rows
-- DELETE FROM invoices
-- WHERE invoice_id = 1

-- -- can also use sub query
DELETE FROM invoices
WHERE client_id = (
	SELECT *
	FROM clients
	WHERE name = 'Myworks')

-- -- Restoring the Databases











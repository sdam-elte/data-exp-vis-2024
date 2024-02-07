/*CREATE TABLE sales_by_store (
transaction_id INTEGER, 
transaction_date DATE, 
transaction_time time without time zone, 
store_id INTEGER, 
staff_id INTEGER, 
customer_id INTEGER, 
instore_yn varchar(1), 
orders INTEGER, 
line_item_id INTEGER, 
product_id INTEGER, 
quantity_sold INTEGER, 
unit_price DOUBLE PRECISION, 
promo_item_yn VARCHAR(1)
);

COPY sales_by_store FROM 'c:/Users/Public/Documents/data/sales_by_tore.csv' WITH CSV HEADER DELIMITER ',';

CREATE TABLE store (
	store_id INTEGER, 
	store_type VARCHAR (20), 
	store_square_feet INTEGER, 
	store_address  VARCHAR(150), 
	store_city VARCHAR(150), 
	store_state_province VARCHAR(150), 
	store_postal_code INTEGER, 
	store_longitude DOUBLE PRECISION, 
	store_latitude DOUBLE PRECISION, 
	manager INTEGER, 
	neighborhood VARCHAR(150)
);
	
COPY store FROM 'c:/Users/Public/Documents/data/stores.csv' WITH CSV HEADER DELIMITER ',';*/

SELECT distinct store_id FROM sales_by_store

CREATE INDEX idx_store ON sales_by_store 
USING  btree
(store_id);

SELECT sa.*, st.store_city FROM sales_by_store sa
INNER JOIN store st ON sa.store_id = st.store_id
WHERE sa.store_id = 5

-- ÖSSZES Megrendelés, eladás összesítése
SELECT SUM(orders) AS sum_orders, SUM(quantity_sold) AS sum_sold_qunatitiy, SUM(quantity_sold)::decimal / SUM(orders) AS avg_sold_qunatitiy FROM sales_by_store;

-- Kerekítés
SELECT SUM(orders) AS sum_orders, SUM(quantity_sold) AS sum_sold_qunatitiy, round(SUM(quantity_sold)::decimal / SUM(orders), 2) AS avg_sold_qunatitiy FROM sales_by_store;

-- Ugyanez store-onkénti bontásban
SELECT store_id, 
	   SUM(orders) AS sum_orders, 
	   SUM(quantity_sold) AS sum_sold_qunatitiy, 
	   round(SUM(quantity_sold)::decimal / SUM(orders), 2) AS avg_sold_quantity 
FROM sales_by_store
GROUP BY store_id;

-- Tegyük mellé még az évet is a tranzakció időpontjából store-onkénti bontásban
SELECT store_id,
	   EXTRACT(year FROM transaction_date) AS year,
	   SUM(orders) AS sum_orders, 
	   SUM(quantity_sold) AS sum_sold_qunatitiy, 
	   round(SUM(quantity_sold)::decimal / SUM(orders), 2) AS avg_sold_quantity
FROM sales_by_store
GROUP BY 1,2
ORDER BY 1,2;

-- Számoljuk ki ugyanebben a bontásban a bevételeket is.
SELECT store_id,
	   EXTRACT(year FROM transaction_date) AS year,
	   SUM(orders) AS sum_orders, 
	   SUM(quantity_sold) AS sum_sold_qunatitiy, 
	   round(SUM(quantity_sold)::decimal / SUM(orders), 2) AS avg_sold_quantity,
	   round(SUM(quantity_sold * unit_price)::decimal, 2) AS revenue
FROM sales_by_store
GROUP BY 1,2
ORDER BY 1,2;

-- Nézzük meg, hogy hány egyedi vásárlótól jöttek ezek a bevételek
SELECT store_id,
	   EXTRACT(year FROM transaction_date) AS year,
	   SUM(orders) AS sum_orders, 
	   SUM(quantity_sold) AS sum_sold_qunatitiy, 
	   COUNT( customer_id),
	   round(SUM(quantity_sold)::decimal / SUM(orders), 2) AS avg_sold_quantity,
	   round(SUM(quantity_sold * unit_price)::decimal, 2) AS revenue
FROM sales_by_store
GROUP BY 1,2
ORDER BY 1,2;

-- Ellenőrzés
SELECT COUNT(distinct customer_id) FROM sales_by_store
WHERE store_id = 3
AND extract(year FROM transaction_date) = 2019;

-- Nézzük meg, hogy hány egyedi vásárlótól jöttek ezek a bevételek
SELECT sa.store_id,
	   EXTRACT(year FROM transaction_date) AS year,
	   st.store_city,
	   SUM(orders) AS sum_orders, 
	   SUM(quantity_sold) AS sum_sold_qunatitiy, 
	   COUNT( customer_id),
	   round(SUM(quantity_sold)::decimal / SUM(orders), 2) AS avg_sold_quantity,
	   round(SUM(quantity_sold * unit_price)::decimal, 2) AS revenue
FROM sales_by_store sa
INNER JOIN store st ON st.store_id = sa.store_id
GROUP BY 1,2,3
ORDER BY 1,2;

-- Van-e átfedés a boltok vásárlői között?
(SELECT customer_id FROM sales_by_store
WHERE store_id = 5)
INTERSECT
(SELECT customer_id FROM sales_by_store
WHERE store_id = 8);


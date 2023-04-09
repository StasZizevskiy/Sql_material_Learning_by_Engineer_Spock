CREATE VIEW products_suppliers_categories AS
SELECT product_name, quantity_per_unit, unit_price, units_in_stock,
company_name, contact_name, phone, category_name, description
FROM products
JOIN suppliers USING (supplier_id) 
JOIN categories USING (category_id);

SELECT *
FROM products_suppliers_categories

SELECT *
FROM products_suppliers_categories
WHERE unit_price>20

DROP VIEW IF EXISTS products_suppliers_categories

CREATE VIEW heavy_orders AS
SELECT *
FROM orders
WHERE freight>50;

SELECT *
FROM heavy_orders
ORDER BY order_id desc

CREATE OR REPLACE VIEW heavy_orders as
SELECT *
FROM orders
WHERE FREIGHT>100
WITH LOCAL CHECK OPTION

ALTER VIEW products_suppliers_categories RENAME TO psc

SELECT MAX(order_id)
FROM orders

INSERT INTO heavy_orders
VALUES (11078, 'VINET', 5, '2019-12-15', '2019-12-14', '2019-12-15', 1, 120,
	   'HANARY CARNES', 'RUA DE PACO', 'BERN', NULL, 3012, 'SWITZERLAND')
	   
SELECT MIN(freight)
FROM orders;

DELETE FROM heavy_orders -- через представление нельзя удалить запись в основной таблице
WHERE freight<0.05

SELECT MIN(freight)
FROM heavy_orders

DELETE FROM heavy_orders
WHERE freight<100.25

DELETE FROM order_details -- было ограничение на удаление записи так как был внешний ключ к order_details
WHERE order_id = 10854

SELECT *
FROM orders
WHERE order_id = 11920

INSERT INTO heavy_orders
VALUES (11921, 'RICSU', 9, '1996-07-12', '1996-08-09', '1996-07-15', 3, 80, 
		'Richter Supermarkt', 'Starenweg 5', 'geneve', null, 1204, 'Switzerland')


	   
















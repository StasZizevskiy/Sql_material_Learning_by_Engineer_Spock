ALTER TABLE products
ADD CONSTRAINT CHK_unit_price CHECK (unit_price>0) 

SELECT MAX(product_id) FROM products

CREATE SEQUENCE IF NOT EXISTS products_product_id_seq
START WITH 78 OWNED BY products.product_id;

ALTER TABLE products
ALTER COLUMN product_id
SET DEFAULT nextval('products_product_id_seq')

INSERT INTO products (product_name, supplier_id, category_id, quantity_per_unit, unit_price,
					  units_in_stock, units_on_order, reorder_level, discontinued)
VALUES
('NAME', 1,2,3,4,5,6,7,8)
RETURNING product_id







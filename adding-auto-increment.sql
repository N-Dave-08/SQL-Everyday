-- adding auto increment
ALTER TABLE products
ALTER COLUMN product_id
ADD GENERATED ALWAYS AS IDENTITY

-- check current max id
SELECT MAX(product_id) FROM products;

-- check the sequence name
SELECT pg_get_serial_sequence('products', 'product_id');

-- 
SELECT setval('products_product_id_seq', 12)


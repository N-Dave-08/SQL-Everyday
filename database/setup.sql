-- Create users table
CREATE TABLE users (
    id INTEGER,
    name TEXT,
    age INTEGER,
    country TEXT
);

-- Insert users
INSERT INTO users VALUES
(1, 'Ana', 22, 'PH'),
(2, 'Ben', 30, 'US'),
(3, 'Cara', 19, 'PH'),
(4, 'Dan', 25, 'PH'),
(5, 'Eva', 35, 'UK');

-- Create orders table
CREATE TABLE orders (
    order_id INTEGER,
    user_id INTEGER,
    product TEXT,
    price INTEGER
);

-- Insert orders
INSERT INTO orders VALUES
(1, 1, 'Shampoo', 150),
(2, 2, 'Conditioner', 200),
(3, 4, 'Haircut', 100),
(4, 1, 'Soap', 50),
(5, 3, 'Comb', 30);

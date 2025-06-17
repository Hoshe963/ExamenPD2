USE ecommerce_lp2_prod;

-- 1. Creación de tablas (en orden para evitar problemas de FK)
-- Eliminar tablas si existen (en orden inverso por las FK)
DROP TABLE IF EXISTS ordersproducts;
DROP TABLE IF EXISTS stocks;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS categories;

-- Resto de tu script actual...

CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    status VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(255),
    cellphone VARCHAR(20),
    password VARCHAR(255) NOT NULL,
    date_created DATETIME,
    type_user ENUM('ADMIN','USER') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) UNIQUE,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    image VARCHAR(255),
    price DECIMAL(10,2) NOT NULL,
    date_created DATETIME,
    date_updated DATETIME,
    user_id INT,
    category_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date_created DATETIME,
    status VARCHAR(50),
    total DECIMAL(10,2), -- MODIFICADO
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS stocks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(255),
    entradas INT,
    salidas INT,
    balance INT,
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS ordersproducts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT NOT NULL,
    product_id INT,
    order_id INT,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (order_id) REFERENCES orders(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Insertar categorías básicas
INSERT INTO categories (name, status) VALUES
('Electrónicos', 'ACTIVE'),
('Ropa', 'ACTIVE'),
('Hogar', 'ACTIVE'),
('Deportes', 'ACTIVE');

-- 3. Crear usuario ADMIN
INSERT INTO users (
    username,
    first_name,
    last_name,
    email,
    password,
    date_created,
    type_user
) VALUES (
    'admin',
    'Administrador',
    'del Sistema',
    'admin@ecommerce.com',
    -- Password: Admin123 (debes encriptarlo en producción)
    '$2a$10$xLFtBIXGtYvAbRqM95JhYeuNd/h6q5r6mhknU9t.ChkmY8b0F.Q0K',
    NOW(),
    'ADMIN'
);
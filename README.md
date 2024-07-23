|-----------------------------------------------------Crear base de datos--- --------------------------------------------|
|  En consolo primero crear la base de datos interbank y dentro de ella ejecutar el codigo en la consolo con Ctrl+Enter  |
|------------------------------------------------------------------------------------------------------------------------|
CREATE DATABASE IF NOT EXISTS interbank;

-- Seleccionar la base de datos
USE interbank;

-- Crear la tabla 'clientes'
CREATE TABLE IF NOT EXISTS clientes (
    dni VARCHAR(8) PRIMARY KEY,
    correo VARCHAR(255) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    celular VARCHAR(9) NOT NULL,
    claveweb VARCHAR(255) NOT NULL,
    card_number VARCHAR(16) NOT NULL,
    saldo DECIMAL(10, 2) DEFAULT 0.00
);

-- Insertar un cliente de ejemplo (opcional) para verificacion
INSERT INTO clientes (dni, correo, nombre, celular, claveweb, card_number) 
VALUES ('12345678', 'ejemplo@correo.com', 'Juan Pérez', '987654321', 'clave123', '1234567890123456');

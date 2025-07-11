DROP DATABASE IF EXISTS HOTEL;
CREATE DATABASE HOTEL;
USE HOTEL;

CREATE TABLE ESTADOS (
	ID_ESTADO BIT PRIMARY KEY,
    ESTADO_NOMB VARCHAR(255)
);

CREATE TABLE HABITACION (
	ID_HABITACION INT PRIMARY KEY,
    CAPACIDAD INT NOT NULL,
    ID_ESTADO BIT,
    PRECIO FLOAT,
    CONSTRAINT FK_ID_ESTADO FOREIGN KEY (ID_ESTADO) REFERENCES ESTADOS(ID_ESTADO)
);

CREATE TABLE CLIENTE (
	ID_CLIENTE INT PRIMARY KEY AUTO_INCREMENT,
    NOMBRE VARCHAR(255),
    APELLIDO VARCHAR(255),
    TELEFONO INT UNIQUE
);

CREATE TABLE RESERVACION (
	ID_RESERVACION INT PRIMARY KEY AUTO_INCREMENT,
    ID_HABITACION INT,
    ID_CLIENTE INT,
    TOTAL FLOAT,
    FECHA_ING DATE,
    FECHA_SAL DATE,
    FECHA_RES DATE,
    CONSTRAINT FK_ID_CLIENTE FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE),
    CONSTRAINT FK_ID_HABITACION FOREIGN KEY (ID_HABITACION) REFERENCES HABITACION(ID_HABITACION)
)
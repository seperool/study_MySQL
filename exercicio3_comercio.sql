/*COMERCIO*/

CREATE DATABASE COMERCIO;

USE COMERCIO;

CREATE TABLE CLIENTE (
	IDCLIENTE INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30) NOT NULL,
	SEXO ENUM('M','F') NOT NULL,
	EMAIL VARCHAR(50) UNIQUE ,
	CPF VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE TELEFONE(
	IDTELEFONE INT PRIMARY KEY AUTO_INCREMENT,
	NUMERO VARCHAR(12),
	TIPO ENUM('CELULAR','RESIDENCIAL')
);

CREATE TABLE ENDERECO(
	IDENDERECO INT PRIMARY KEY AUTO_INCREMENT,
	RUA VARCHAR(100) NOT NULL,
	BAIRRO VARCHAR(100) NOT NULL,
	CIDADE VARCHAR(100) NOT NULL,
	ESTADO CHAR(2) NOT NULL
);
/*FORMAS NORMAIS*/

/*1º FORMA NORMAL*/

/*
1. Todo campo vetorizado se tornará outra tabela.
2. Todo campo multivalorado se tornará outra tabela.
3. Toda tabela necessita de pelo menos um campo que identifique todo registro como sendo único 
(é o que chamamos de "Chave Primaria" ou "Primary Key").*/

/*2º FORMA NORMAL*/

/*Uma relação está na 2º forma normal se, e somente se, estiver na 1º forma normal 
e cada atributo não-chave for dependente da chave primária inteira, isto é, 
cada atributo não-chave não poderá ser dependente de apenas parte da chave.*/

/*3º FORMA NORMAL*/

/*Uma relação R está na 3º forma normal se ela estiver na 2º forma normal 
e cada atributo não-chave de R não possuir dependência transitiva, para cada chave candidata de R. 
Todos os atributos dessa tabela devem ser independentes uns dos outros, 
ao mesmo tempo que devem ser dependentes exclusivamente da chave primária da tabela.*/

/*CONSULTORIO*/

CREATE DATABASE CONSULTORIO;

USE CONSULTORIO;

CREATE TABLE PACIENTE (
IDPACIENTE INT PRIMARY KEY AUTO_INCREMENT,
NOME VARCHAR(50),
SEXO CHAR(1),
EMAIL VARCHAR(30),
NASCIMENTO DATE
);

CREATE TABLE MEDICO(
IDMEDICO INT PRIMARY KEY AUTO_INCREMENT,
NOME VARCHAR(50),
SEXO CHAR(2),
ESPECIALIDADE VARCHAR(30),
FUNCIONARIO ENUM('S','N')
);

CREATE TABLE HOSPITAL(
IDHOSPITAL INT PRIMARY KEY AUTO_INCREMENT,
NOME VARCHAR(50),
BAIRRO VARCHAR(50),
CIDADE VARCHAR(50),
ESTADO CHAR(2)
);

CREATE TABLE CONSULTA(
IDCONSULTA INT PRIMARY KEY AUTO_INCREMENT,
ID_PACIENTE INT,
ID_MEDICO INT,
ID_HOSPITAL INT,
DATA DATETIME,
DIAGNOSTICO VARCHAR(500)
);

CREATE TABLE INTERNACAO(
IDINTERNACAO INT PRIMARY KEY AUTO_INCREMENT,
QUARTO INT,
ENTRADA DATETIME,
SAIDA DATETIME,
OBSERVAÇÃO VARCHAR(500),
ID_CONSULTA INT
);

/*CHAVE ESTRANGEIRA*/

ALTER TABLE CONSULTA
ADD CONSTRAINT FK_CONSULTA_PACIENTE
FOREIGN KEY (ID_PACIENTE)
REFERENCES PACIENTE (IDPACIENTE);

ALTER TABLE CONSULTA
ADD CONSTRAINT FK_CONSULTA_MEDICO
FOREIGN KEY (ID_MEDICO)
REFERENCES MEDICO (IDMEDICO);

ALTER TABLE CONSULTA
ADD CONSTRAINT FK_CONSULTA_HOSPITAL
FOREIGN KEY (ID_HOSPITAL)
REFERENCES HOSPITAL (IDHOSPITAL);

ALTER TABLE INTERNACAO
ADD CONSTRAINT FK_INTERNACAO_CONSULTA
FOREIGN KEY (ID_CONSULTA)
REFERENCES CONSULTA (IDCONSULTA);

-- CONSULTANDO TABELAS
SHOW TABLES;

+-----------------------+
| Tables_in_CONSULTORIO |
+-----------------------+
| CONSULTA              |
| HOSPITAL              |
| INTERNACAO            |
| MEDICO                |
| PACIENTE              |
+-----------------------+

-- CONSULTANDO CONSTRAINTS

SHOW DATABASES;

USE information_schema;

SHOW TABLES;

DESC TABLE_CONSTRAINTS;

+--------------------+-------------+------+-----+---------+-------+
| Field              | Type        | Null | Key | Default | Extra |
+--------------------+-------------+------+-----+---------+-------+
| CONSTRAINT_CATALOG | varchar(64) | NO   |     | NULL    |       |
| CONSTRAINT_SCHEMA  | varchar(64) | NO   |     | NULL    |       |
| CONSTRAINT_NAME    | varchar(64) | YES  |     | NULL    |       |
| TABLE_SCHEMA       | varchar(64) | NO   |     | NULL    |       |
| TABLE_NAME         | varchar(64) | NO   |     | NULL    |       |
| CONSTRAINT_TYPE    | varchar(11) | NO   |     |         |       |
| ENFORCED           | varchar(3)  | NO   |     |         |       |
+--------------------+-------------+------+-----+---------+-------+

SELECT CONSTRAINT_NAME FROM TABLE_CONSTRAINTS
WHERE CONSTRAINT_NAME LIKE "FK_CONSULTA%" 
OR CONSTRAINT_NAME LIKE "FK_INTERNACAO%";

+------------------------+
| CONSTRAINT_NAME        |
+------------------------+
| FK_CONSULTA_HOSPITAL   |
| FK_CONSULTA_MEDICO     |
| FK_CONSULTA_PACIENTE   |
| FK_INTERNACAO_CONSULTA |
+------------------------+

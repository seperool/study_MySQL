CREATE DATABASE PROJETO_OF;

USE PROJETO_OF;

/*TABELAS*/

CREATE TABLE CLIENTE(
IDCLIENTE INT UNIQUE AUTO_INCREMENT,
NOME VARCHAR(60) NOT NULL
);

CREATE TABLE TELEFONE(
IDTELEFONE INT AUTO_INCREMENT,
TELEFONE VARCHAR(11) NOT NULL,
ID_CLIENTE INT NOT NULL
);

CREATE TABLE CARRO (
IDCARRO INT UNIQUE AUTO_INCREMENT,
MARCA VARCHAR(30),
ID_CLIENTE INT UNIQUE NOT NULL
);

CREATE TABLE TINTA(
COR VARCHAR(10),
ID_CARRO INT NOT NULL
);

CREATE TABLE SERVICO(
IDSERVICO INT UNIQUE AUTO_INCREMENT,
ID_CLIENTE INT,
ID_CARRO INT,
SERVICO VARCHAR(300)
);

/*CHAVES*/

/*CHAVES PRIMARIAS*/

ALTER TABLE CLIENTE
ADD CONSTRAINT PK_CLIENTE
PRIMARY KEY (IDCLIENTE);

ALTER TABLE TELEFONE
ADD CONSTRAINT PK_TELEFONE
PRIMARY KEY (IDTELEFONE);

ALTER TABLE CARRO
ADD CONSTRAINT PK_CARRO
PRIMARY KEY (IDCARRO);

ALTER TABLE SERVICO
ADD CONSTRAINT PK_SERVICO
PRIMARY KEY (IDSERVOCO);

/*CHAVES ESTRANGEIRAS*/

ALTER TABLE TELEFONE
ADD CONSTRAINT FK_CLIENTE_TELEFONE
FOREIGN KEY (ID_CLIENTE)
REFERENCES CLIENTE (IDCLIENTE);

ALTER TABLE CARRO
ADD CONSTRAINT FK_CLIENTE_CARRO
FOREIGN KEY (ID_CLIENTE)
REFERENCES CLIENTE (IDCLIENTE);

ALTER TABLE TINTA
ADD CONSTRAINT FK_CARRO_TINTA
FOREIGN KEY (ID_CARRO)
REFERENCES CARRO (IDCARRO);

ALTER TABLE SERVICO
ADD CONSTRAINT FK_CARRO_SERVICO
FOREIGN KEY (ID_CARRO)
REFERENCES CARRO (IDCARRO);

ALTER TABLE SERVICO
ADD CONSTRAINT FK_CLIENTE_SERVICO
FOREIGN KEY (ID_CLIENTE)
REFERENCES CLIENTE (IDCLIENTE);

/*VERIFICANDO REGRAS E TABELAS*/

SHOW TABLES;

SHOW CREATE TABLE CLIENTE;
SHOW CREATE TABLE TELEFONE;
SHOW CREATE TABLE CARRO;
SHOW CREATE TABLE TINTA;
SHOW CREATE TABLE SERVICO;

/*INSERT*/

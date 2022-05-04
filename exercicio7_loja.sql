/*COMUNICAÇÃO ENTRE BANCOS DE DADO*/

/*CRIAÇÃO DO BANCO DE DADOS LOJA*/
CREATE DATABASE LOJA;

/*CONECTAR AO BANCO DE DADOS*/
USE LOJA;

/*VERIFICAR OS STATUS: BANCO DE DADOS CONECTADO*/
STATUS

/*CRIAÇÃO DE TABELAS*/
CREATE TABLE PRODUTO (
IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
NOME VARCHAR(30),
VALOR FLOAT(10,2)
);

/*CRIAÇÃO DE UM BANCO DE DADOS BACKUP*/
CREATE DATABASE BACKUP;

/*CONECTANDO AO BANCO DE DADOS BACKUP*/
USE BACKUP;

STATUS

/*CRIAÇÃO DE TABELA BKP*/
CREATE TABLE BKP_PRODUTO (
IDBKP INT PRIMARY KEY AUTO_INCREMENT,
IDPRODUTO INT,
NOME VARCHAR(30),
VALOR FLOAT(10,2)
);

/*COMUNICAÇÃO ENTRE BANCOS DE DADOS*/

USE LOJA;

STATUS

/*DENTRO DO DATABASE LOJA, 
VOU INSERIR REGISTRO NO DATABASE BACKUP, 
TABELA BKP_PRODUTO*/
INSERT INTO BACKUP.BKP_PRODUTO VALUES
(NULL,1000,"TESTE",0.0);

-- USAR DATABASE.TABELA NO "INSERT"

/*CONSULTAR SEM MUDAR DE DATABASE*/
SELECT * FROM BACKUP.BKP_PRODUTO;

+-------+-----------+-------+-------+
| IDBKP | IDPRODUTO | NOME  | VALOR |
+-------+-----------+-------+-------+
|     1 |      1000 | TESTE |  0.00 |
+-------+-----------+-------+-------+

/*CRIAR TRIGGER EM OUTRA DATABASE*/

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO
BEFORE INSERT ON PRODUTO
FOR EACH ROW
BEGIN
INSERT INTO BACKUP.BKP_PRODUTO VALUES 
(NULL, NEW.IDPRODUTO, NEW.NOME, NEW.VALOR);
END
$

DELIMITER ;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO_DEL
AFTER DELETE ON PRODUTO
FOR EACH ROW
BEGIN
INSERT INTO BACKUP.BKP_PRODUTO VALUES 
(NULL, OLD.IDPRODUTO, OLD.NOME, OLD.VALOR);
END
$

DELIMITER ;


/*TESTANDO OS TRIGGERS*/

INSERT INTO PRODUTO VALUES 
(NULL, "LIVRO MODELAGEM",50.00),
(NULL, "LIVRO BI",80.00),
(NULL, "LIVRO ORACLE",70.00),
(NULL, "LIVRO SQL SERVER",100.00);

SELECT * FROM PRODUTO;

+-----------+------------------+--------+
| IDPRODUTO | NOME             | VALOR  |
+-----------+------------------+--------+
|         1 | LIVRO MODELAGEM  |  50.00 |
|         2 | LIVRO BI         |  80.00 |
|         3 | LIVRO ORACLE     |  70.00 |
|         4 | LIVRO SQL SERVER | 100.00 |
+-----------+------------------+--------+

SELECT * FROM BACKUP.BKP_PRODUTO;

+-------+-----------+------------------+--------+
| IDBKP | IDPRODUTO | NOME             | VALOR  |
+-------+-----------+------------------+--------+
|     1 |      1000 | TESTE            |   0.00 |
|     2 |         0 | LIVRO MODELAGEM  |  50.00 |
|     3 |         0 | LIVRO BI         |  80.00 |
|     4 |         0 | LIVRO ORACLE     |  70.00 |
|     5 |         0 | LIVRO SQL SERVER | 100.00 |
+-------+-----------+------------------+--------+
-- O VALOR DO IDPRODUTO VEIO "0" POR CAUSA DO BEFORE
-- COMO O VALOR FOI PEGO ANTES DE ENTRAR DA TABELA,
-- NÃO DEU TEMPO DE ATIVAR O AUTO_INCREMENTE

/*--------------------*/

DELETE FROM PRODUTO
WHERE IDPRODUTO = 2;

SELECT * FROM PRODUTO;

+-----------+------------------+--------+
| IDPRODUTO | NOME             | VALOR  |
+-----------+------------------+--------+
|         1 | LIVRO MODELAGEM  |  50.00 |
|         3 | LIVRO ORACLE     |  70.00 |
|         4 | LIVRO SQL SERVER | 100.00 |
+-----------+------------------+--------+

SELECT * FROM BACKUP.BKP_PRODUTO;

+-------+-----------+------------------+--------+
| IDBKP | IDPRODUTO | NOME             | VALOR  |
+-------+-----------+------------------+--------+
|     1 |      1000 | TESTE            |   0.00 |
|     2 |         0 | LIVRO MODELAGEM  |  50.00 |
|     3 |         0 | LIVRO BI         |  80.00 |
|     4 |         0 | LIVRO ORACLE     |  70.00 |
|     5 |         0 | LIVRO SQL SERVER | 100.00 |
|     6 |         2 | LIVRO BI         |  80.00 |
+-------+-----------+------------------+--------+
-- AGORA O IDPRODUTO ENTROU PQ O ELE EXISTIA NA TABELA PRODUTO.

/*APAGANDO O TRIGGER INSERT
CONCERTANDO O TRIGGER INSERT PARA AFTER*/

DROP TRIGGER BACKUP_PRODUTO;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO
AFTER INSERT ON PRODUTO
FOR EACH ROW
BEGIN
INSERT INTO BACKUP.BKP_PRODUTO VALUES 
(NULL, NEW.IDPRODUTO, NEW.NOME, NEW.VALOR);
END
$

DELIMITER ;

/*TESTANDO NOVO TRIGGER INSERT*/

INSERT INTO PRODUTO VALUES
(NULL, "LIVRO C#",100.00);

SELECT * FROM PRODUTO;

+-----------+------------------+--------+
| IDPRODUTO | NOME             | VALOR  |
+-----------+------------------+--------+
|         1 | LIVRO MODELAGEM  |  50.00 |
|         3 | LIVRO ORACLE     |  70.00 |
|         4 | LIVRO SQL SERVER | 100.00 |
|         5 | LIVRO C#         | 100.00 |
+-----------+------------------+--------+

SELECT * FROM BACKUP.BKP_PRODUTO;

+-------+-----------+------------------+--------+
| IDBKP | IDPRODUTO | NOME             | VALOR  |
+-------+-----------+------------------+--------+
|     1 |      1000 | TESTE            |   0.00 |
|     2 |         0 | LIVRO MODELAGEM  |  50.00 |
|     3 |         0 | LIVRO BI         |  80.00 |
|     4 |         0 | LIVRO ORACLE     |  70.00 |
|     5 |         0 | LIVRO SQL SERVER | 100.00 |
|     6 |         2 | LIVRO BI         |  80.00 |
|     7 |         5 | LIVRO C#         | 100.00 |
+-------+-----------+------------------+--------+
-- AGORA O TRIGGER PEGOU O IDPRODUTO POR CONTA DO AFTER

/*ALTERANDO BKP_PRODUTO PARA GUARDAR O TIPO DE EVENTO*/

ALTER TABLE BACKUP.BKP_PRODUTO
ADD COLUMN EVENTO CHAR(3);

-- VERIFICANDO
SELECT * FROM BACKUP.BKP_PRODUTO;

-- APAGANDO TRIGGERS
DROP TRIGGER BACKUP_PRODUTO;
DROP TRIGGER BACKUP_PRODUTO_DEL;

-- REESCREVENDO TRIGGERS
DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO
AFTER INSERT ON PRODUTO
FOR EACH ROW
BEGIN
INSERT INTO BACKUP.BKP_PRODUTO VALUES 
(NULL, NEW.IDPRODUTO, NEW.NOME, NEW.VALOR, "INS");
END
$

DELIMITER ;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO_DEL
AFTER DELETE ON PRODUTO
FOR EACH ROW
BEGIN
INSERT INTO BACKUP.BKP_PRODUTO VALUES 
(NULL, OLD.IDPRODUTO, OLD.NOME, OLD.VALOR, "DEL");
END
$

DELIMITER ;

-- TESTANDO NOVO TRIGGER
DELETE FROM PRODUTO
WHERE IDPRODUTO = 4;

-- VERIFICANDO
SELECT * FROM PRODUTO;

+-----------+-----------------+--------+
| IDPRODUTO | NOME            | VALOR  |
+-----------+-----------------+--------+
|         1 | LIVRO MODELAGEM |  50.00 |
|         3 | LIVRO ORACLE    |  70.00 |
|         5 | LIVRO C#        | 100.00 |
+-----------+-----------------+--------+

SELECT * FROM BACKUP.BKP_PRODUTO;

+-------+-----------+------------------+--------+--------+
| IDBKP | IDPRODUTO | NOME             | VALOR  | EVENTO |
+-------+-----------+------------------+--------+--------+
|     1 |      1000 | TESTE            |   0.00 | NULL   |
|     2 |         0 | LIVRO MODELAGEM  |  50.00 | NULL   |
|     3 |         0 | LIVRO BI         |  80.00 | NULL   |
|     4 |         0 | LIVRO ORACLE     |  70.00 | NULL   |
|     5 |         0 | LIVRO SQL SERVER | 100.00 | NULL   |
|     6 |         2 | LIVRO BI         |  80.00 | NULL   |
|     7 |         5 | LIVRO C#         | 100.00 | NULL   |
|     8 |         4 | LIVRO SQL SERVER | 100.00 | DEL    |
+-------+-----------+------------------+--------+--------+

/*FAZENDO UPDATE NOS REGISTROS ANTERIORES*/

UPDATE BACKUP.BKP_PRODUTO SET EVENTO = "INS"
WHERE IDBKP IN (2,3,4,5,7);

UPDATE BACKUP.BKP_PRODUTO SET EVENTO = "DEL"
WHERE IDBKP = 6;

-- VERIFICANDO
SELECT * FROM BACKUP.BKP_PRODUTO;

+-------+-----------+------------------+--------+--------+
| IDBKP | IDPRODUTO | NOME             | VALOR  | EVENTO |
+-------+-----------+------------------+--------+--------+
|     1 |      1000 | TESTE            |   0.00 | NULL   |
|     2 |         0 | LIVRO MODELAGEM  |  50.00 | INS    |
|     3 |         0 | LIVRO BI         |  80.00 | INS    |
|     4 |         0 | LIVRO ORACLE     |  70.00 | INS    |
|     5 |         0 | LIVRO SQL SERVER | 100.00 | INS    |
|     6 |         2 | LIVRO BI         |  80.00 | DEL    |
|     7 |         5 | LIVRO C#         | 100.00 | INS    |
|     8 |         4 | LIVRO SQL SERVER | 100.00 | DEL    |
+-------+-----------+------------------+--------+--------+

/*TRIGGER BACKUP - UPDATE COM DATA E USUARIO, VALOR ANTIGO E NOVO*/

USE BACKUP;

CREATE TABLE BKP_PRODUTO_UPDATE(
IDBKP_UP INT PRIMARY KEY AUTO_INCREMENT,
IDPRODUTO INT,
NOME VARCHAR (30),
VALOR_ANTIGO FLOAT(10,2),
VALOR_NOVO FLOAT(10,2),
DATA DATETIME,
USUARIO VARCHAR(30),
TIPO CHAR(1)
);

USE LOJA;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO_UP
AFTER UPDATE ON PRODUTO
FOR EACH ROW
BEGIN
INSERT INTO BACKUP.BKP_PRODUTO_UPDATE VALUES
(NULL, NEW.IDPRODUTO,NEW.NOME,OLD.VALOR,NEW.VALOR,NOW(),CURRENT_USER(),"U");
END
$

DELIMITER ;

UPDATE PRODUTO SET VALOR = 110
WHERE IDPRODUTO = 5;

SELECT * FROM PRODUTO;

+-----------+-----------------+--------+
| IDPRODUTO | NOME            | VALOR  |
+-----------+-----------------+--------+
|         1 | LIVRO MODELAGEM |  50.00 |
|         3 | LIVRO ORACLE    |  70.00 |
|         5 | LIVRO C#        | 110.00 |
+-----------+-----------------+--------+

SELECT * FROM BACKUP.BKP_PRODUTO_UPDATE;

+----------+-----------+----------+--------------+------------+---------------------+----------------+------+
| IDBKP_UP | IDPRODUTO | NOME     | VALOR_ANTIGO | VALOR_NOVO | DATA                | USUARIO        | TIPO |
+----------+-----------+----------+--------------+------------+---------------------+----------------+------+
|        1 |         5 | LIVRO C# |       100.00 |     110.00 | 2022-05-02 00:37:00 | root@localhost | U    |
+----------+-----------+----------+--------------+------------+---------------------+----------------+------+

/*DELETANDO TRIGGERS 
E REESCREVENDO PARA SE ADEQUAR
BKP_PRODUTO_UPDATE*/

-- ALTERANDO NOME
ALTER TABLE BACKUP.BKP_PRODUTO_UPDATE
RENAME BACKUP.BKP_PRODUTO_LOJA;

-- DELETANDO TRIGGERS
DROP TRIGGER BACKUP_PRODUTO_UP;
DROP TRIGGER BACKUP_PRODUTO_DEL;
DROP TRIGGER BACKUP_PRODUTO;

-- REESCREVENDO TRIGGERS

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO_UP
AFTER UPDATE ON PRODUTO
FOR EACH ROW
BEGIN
INSERT INTO BACKUP.BKP_PRODUTO_LOJA VALUES
(NULL, NEW.IDPRODUTO,NEW.NOME,OLD.VALOR,NEW.VALOR,NOW(),CURRENT_USER(),"U");
END
$

DELIMITER ;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO_DEL
AFTER DELETE ON PRODUTO
FOR EACH ROW
BEGIN
INSERT INTO BACKUP.BKP_PRODUTO_LOJA VALUES 
(NULL, OLD.IDPRODUTO,OLD.NOME,OLD.VALOR,NULL,NOW(),CURRENT_USER(),"D");
END
$

DELIMITER ;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO_INS
AFTER INSERT ON PRODUTO
FOR EACH ROW
BEGIN
INSERT INTO BACKUP.BKP_PRODUTO_LOJA VALUES 
(NULL, NEW.IDPRODUTO,NEW.NOME,NULL,NEW.VALOR,NOW(),CURRENT_USER(),"I");
END
$

DELIMITER ;

-- INSERINDO REGISTROS
INSERT INTO PRODUTO VALUES
(NULL, "LIVRO R",100.00),
(NULL,"LIVRO SQL", 80.00),
(NULL, "LIVRO LINUX",150.00);

--ALTERANDO REGISTRO
UPDATE PRODUTO SET VALOR = 160.00
WHERE IDPRODUTO = 8; 

-- DELETANDO REGISTRO
DELETE FROM PRODUTO
WHERE IDPRODUTO = 7;

-- VERIFICANDO TRIGGERS
SELECT * FROM PRODUTO;

+-----------+-----------------+--------+
| IDPRODUTO | NOME            | VALOR  |
+-----------+-----------------+--------+
|         1 | LIVRO MODELAGEM |  50.00 |
|         3 | LIVRO ORACLE    |  70.00 |
|         5 | LIVRO C#        | 110.00 |
|         6 | LIVRO R         | 100.00 |
|         8 | LIVRO LINUX     | 160.00 |
+-----------+-----------------+--------+

SELECT * FROM BACKUP.BKP_PRODUTO_LOJA;

+----------+-----------+-------------+--------------+------------+---------------------+----------------+------+
| IDBKP_UP | IDPRODUTO | NOME        | VALOR_ANTIGO | VALOR_NOVO | DATA                | USUARIO        | TIPO |
+----------+-----------+-------------+--------------+------------+---------------------+----------------+------+
|        1 |         5 | LIVRO C#    |       100.00 |     110.00 | 2022-05-02 00:37:00 | root@localhost | U    |
|        2 |         6 | LIVRO R     |         NULL |     100.00 | 2022-05-03 00:44:22 | root@localhost | I    |
|        3 |         7 | LIVRO SQL   |         NULL |      80.00 | 2022-05-03 00:44:22 | root@localhost | I    |
|        4 |         8 | LIVRO LINUX |         NULL |     150.00 | 2022-05-03 00:44:22 | root@localhost | I    |
|        5 |         8 | LIVRO LINUX |       150.00 |     160.00 | 2022-05-03 00:44:42 | root@localhost | U    |
|        6 |         7 | LIVRO SQL   |        80.00 |       NULL | 2022-05-03 00:44:53 | root@localhost | D    |
+----------+-----------+-------------+--------------+------------+---------------------+----------------+------+

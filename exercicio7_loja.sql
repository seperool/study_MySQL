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
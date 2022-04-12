CREATE DATABASE PROJETO;

SHOW DATABASES;

USE PROJETO;

CREATE TABLE CURSOS (
IDCURSO INT PRIMARY KEY AUTO_INCREMENT,
NOME VARCHAR(30) NOT NULL,
HORAS INT(3) NOT NULL,
VALOR FLOAT(10,2) NOT NULL
);

INSERT INTO CURSOS VALUES (NULL, 'JAVA', 30, 500.00);
INSERT INTO CURSOS VALUES (NULL, 'FUNDAMENTOS DE BANCO DE DADOS', 40, 700.00);

SELECT * FROM CURSOS;

DELIMITER $

STATUS

CREATE PROCEDURE CAD_CURSOS(P_NOME VARCHAR(30), P_HORAS INT(3), P_VALOR FLOAT(10,2))
BEGIN
	INSERT INTO CURSOS VALUES (NULL, P_NOME,P_HORAS,P_VALOR);
END
$

DELIMITER ;

STATUS

CALL CAD_CURSOS ('BI SQL SERVER',35,3000.00);
CALL CAD_CURSOS ('POWER BI',20,1000.00);
CALL CAD_CURSOS ('TABLEAU',30,1200.00);

SELECT * FROM CURSOS;

/*CRIAR UMA PROCEDURE PARA CONSULTAR CURSOS*/

DELIMITER $

STATUS

CREATE PROCEDURE CON_CURSOS()
BEGIN
SELECT * FROM CURSOS;
END
$

DELIMITER ;

STATUS

CALL CON_CURSOS();

/*--------------------------------------------------------*/

/* FUNCOES DE AGREGACAO NUMERICAS */

CREATE TABLE VENDEDORES(
	IDVENDEDOR INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	SEXO CHAR(1),
	JANEIRO FLOAT(10,2),
	FEVEREIRO FLOAT(10,2),
	MARCO FLOAT(10,2)
);

+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| IDVENDEDOR | int         | NO   | PRI | NULL    | auto_increment |
| NOME       | varchar(30) | YES  |     | NULL    |                |
| SEXO       | char(1)     | YES  |     | NULL    |                |
| JANEIRO    | float(10,2) | YES  |     | NULL    |                |
| FEVEREIRO  | float(10,2) | YES  |     | NULL    |                |
| MARCO      | float(10,2) | YES  |     | NULL    |                |
+------------+-------------+------+-----+---------+----------------+

INSERT INTO VENDEDORES VALUES(NULL,'CARLOS','M',76234.78,88346.87,5756.90);
INSERT INTO VENDEDORES VALUES(NULL,'MARIA','F',5865.78,6768.87,4467.90);
INSERT INTO VENDEDORES VALUES(NULL,'ANTONIO','M',78769.78,6685.87,6664.90);
INSERT INTO VENDEDORES VALUES(NULL,'CLARA','F',5779.78,446886.87,8965.90);
INSERT INTO VENDEDORES VALUES(NULL,'ANDERSON','M',676545.78,77544.87,578665.90);
INSERT INTO VENDEDORES VALUES(NULL,'IVONE','F',57789.78,44774.87,68665.90);
INSERT INTO VENDEDORES VALUES(NULL,'JOAO','M',4785.78,66478.87,6887.90);
INSERT INTO VENDEDORES VALUES(NULL,'CELIA','F',89667.78,57654.87,5755.90);

+------------+----------+------+-----------+-----------+-----------+
| IDVENDEDOR | NOME     | SEXO | JANEIRO   | FEVEREIRO | MARCO     |
+------------+----------+------+-----------+-----------+-----------+
|          1 | CARLOS   | M    |  76234.78 |  88346.87 |   5756.90 |
|          2 | MARIA    | F    |   5865.78 |   6768.87 |   4467.90 |
|          3 | ANTONIO  | M    |  78769.78 |   6685.87 |   6664.90 |
|          4 | CLARA    | F    |   5779.78 | 446886.88 |   8965.90 |
|          5 | ANDERSON | M    | 676545.75 |  77544.87 | 578665.88 |
|          6 | IVONE    | F    |  57789.78 |  44774.87 |  68665.90 |
|          7 | JOAO     | M    |   4785.78 |  66478.87 |   6887.90 |
|          8 | CELIA    | F    |  89667.78 |  57654.87 |   5755.90 |
+------------+----------+------+-----------+-----------+-----------+


/* MAX - TRAZ O VALOR MAXIMO DE UMA COLUNA */

SELECT MAX(FEVEREIRO) AS MAIOR_FEV
FROM VENDEDORES;


/* MIN - TRAZ O VALOR MINIMO DE UMA COLUNA */

SELECT MIN(FEVEREIRO) AS MENOR_FEV
FROM VENDEDORES;

/* AVG - TRAZ O VALOR MEDIO DE UMA COLUNA */

SELECT AVG(FEVEREIRO) AS MEDIA_FEV
FROM VENDEDORES;

/* VARIAS FUNCOES */

SELECT 
MAX(JANEIRO) AS MAX_JAN,
MIN(JANEIRO) AS MIN_JAN,
AVG(JANEIRO) AS MEDIA_JAN
FROM VENDEDORES;
	 
/*TRUNCATE */
	 
SELECT 
MAX(JANEIRO) AS MAX_JAN,
MIN(JANEIRO) AS MIN_JAN,
TRUNCATE(AVG(JANEIRO),2) AS MEDIA_JAN
FROM VENDEDORES;

/* AGREGANDO COM SUM() */

SELECT SUM(JANEIRO) AS TOTAL_JAN
FROM VENDEDORES;

SELECT SUM(JANEIRO) AS TOTAL_JAN,
	   SUM(FEVEREIRO) AS TOTAL_FEV,
	   SUM(MARCO) AS TOTAL_MAR
FROM VENDEDORES;

/* VENDAS POR SEXO */

SELECT SEXO, SUM(MARCO) AS TOTAL_MARCO
FROM VENDEDORES
GROUP BY SEXO;

/*-------------------*/

/* A 31 - SUBQUERIES

VENDEDOR QUE VENDEU MENOS EM MARCO
E O SEU NOME */

-- QUAL MENOR VENDA MARCO?
SELECT 
MIN(MARCO) AS MENOR_VEND_MARCO
FROM VENDEDORES;

+------------------+
| MENOR_VEND_MARCO |
+------------------+
|          4467.90 |
+------------------+


-- NOME DO VENDEDOR DA MENOR VENDA.
SELECT
NOME,
MARCO
FROM VENDEDORES
WHERE MARCO = (SELECT 
MIN(MARCO) AS MENOR_VEND_MARCO
FROM VENDEDORES);

+-------+---------+
| NOME  | MARCO   |
+-------+---------+
| MARIA | 4467.90 |
+-------+---------+


/*NOME E O VALOR QUE VENDEU MAIS EM MARCO*/

-- QUAL MAIOR VENDA DE MARCO?
SELECT 
MAX(MARCO) AS MAIOR_VEND_MARCO
FROM VENDEDORES;

+------------------+
| MAIOR_VEND_MARCO |
+------------------+
|        578665.88 |
+------------------+

-- NOME DO VENDEDOR QUE MAIS VENDEU EM MARCO

SELECT
NOME,
MARCO
FROM VENDEDORES
WHERE MARCO = (SELECT 
MAX(MARCO) AS MENOR_VEND_MARCO
FROM VENDEDORES);

+----------+-----------+
| NOME     | MARCO     |
+----------+-----------+
| ANDERSON | 578665.88 |
+----------+-----------+


/*QUEM VENDEU MAIS QUE O VALOR MEDIO DE FEV*/

-- VALOR MEDIO DE FEVEREIRO

SELECT
AVG(FEVEREIRO) AS VALOR_MED_FEV
FROM VENDEDORES;

+---------------+
| VALOR_MED_FEV |
+---------------+
|  99392.744873 |
+---------------+


-- QUAIS VENDERAM MAIS QUE O VALOR MEDIO DE FEV

SELECT
NOME,
FEVEREIRO
FROM VENDEDORES
WHERE FEVEREIRO > (SELECT
AVG(FEVEREIRO) AS VALOR_MED_FEV
FROM VENDEDORES);

+-------+-----------+
| NOME  | FEVEREIRO |
+-------+-----------+
| CLARA | 446886.88 |
+-------+-----------+

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

/*------*/
CREATE TABLE ENDERECO(
	IDENDERECO INT PRIMARY KEY AUTO_INCREMENT,
	RUA VARCHAR(30) NOT NULL,
	BAIRRO VARCHAR(30) NOT NULL,
	CIDADE VARCHAR(30) NOT NULL,
	ESTADO CHAR(2) NOT NULL,
	ID_CLIENTE INT UNIQUE, -- 1 X 1 
	FOREIGN KEY (ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
);

CREATE TABLE TELEFONE(
	IDTELEFONE INT PRIMARY KEY AUTO_INCREMENT,
	TIPO ENUM('RES','COM','CEL') NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_CLIENTE INT,
	FOREIGN KEY (ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
);

/*RELAÇÕES

ENDERECO - OBRIGATORIO
CADASTRO DE SOMENTE UM.

TELEFONE - NÃO OBRIGATORIO
CADASTRO DE MAIS DE UM (OPCIONAL)*/

/*CHAVE ESTRANGEIRA É A CHAVE PRIMARIA DE UMA TABELA, 
QUE VAI ATE A OUTRA TABELA, 
PARA FAZER REFERENCIA ENTRE REGISTROS*/

/*REGRA DE ONDE FICA A CHAVE ESTRANGEIRA (FK):
1 X 1 (UM PRA UM) A CHAVE ESTRANGEIRA FICA NA TABELA MAIS FRACA.
1 X N (UM PRA MUITOS) A CHAVE ESTRANGEIRA FICA NA TABELA N.
*/

/*----------*/

DESC CLIENTE; /*VERIFICANDO A ESTRUTURA*/

INSERT INTO CLIENTE 
VALUES
(NULL,'JOAO','M','JOAO@GMAIL.COM','4565987985'),
(NULL,'CARLOS','M','CARLOS@GMAIL.COM','87985484'),
(NULL,'ANA','F','ANA@GMAIL.COM','879562131'),
(NULL,'CLARA','F',NULL,'798212445'),
(NULL,'JORGE','M','JORGE@GMAIL.COM','2136467854'),
(NULL,'CELIA','F','CELIA@GMAIL.COM','5461321678');

/*PARA O CAMPO COM AUTO_INCREMENT FUNCIONE, 
É PRECISO NO INSERT DEIXAR O CAMPO COM AUTO_INCREMENTE NULL*/

SELECT * FROM CLIENTE; /*VERIFICAR OS REGISTROS*/

+-----------+--------+------+------------------+------------+
| IDCLIENTE | NOME   | SEXO | EMAIL            | CPF        |
+-----------+--------+------+------------------+------------+
|         1 | JOAO   | M    | JOAO@GMAIL.COM   | 4565987985 |
|         2 | CARLOS | M    | CARLOS@GMAIL.COM | 87985484   |
|         3 | ANA    | F    | ANA@GMAIL.COM    | 879562131  |
|         4 | CLARA  | F    | NULL             | 798212445  |
|         5 | JORGE  | M    | JORGE@GMAIL.COM  | 2136467854 |
|         6 | CELIA  | F    | CELIA@GMAIL.COM  | 5461321678 |
+-----------+--------+------+------------------+------------+

/*RELACÃO 1 X 1 - CLIENTE X ENDERECO
LOGO SÃO 6 INSERT EM ENDERECO*/

DESC ENDERECO; /*VERIFICANDO A ESTRUTURA*/

INSERT INTO ENDERECO VALUES
(NULL,"RUA ANTONIO SA","CENTRO","BELO HORIZONTE",'MG',4),
(NULL,"RUA CAPITAO HERMES","CENTRO","RIO DE JANEIRO",'RJ',1),
(NULL,"RUA PRES VARGAS","JARDINS","SAO PAULO",'SP',3),
(NULL,"RUA ALFANDEGA","ESTACIO","RIO DE JANEIRO",'RJ',2),
(NULL,"RUA DO OUVIRDOR","FLAMENGO","RIO DE JANEIRO",'RJ',6),
(NULL,"RUA URUGUAIANA","CENTRO","VITORIA",'ES',5);

SELECT * FROM ENDERECO; /*VERIFICAR OS REGISTROS*/

+------------+--------------------+----------+----------------+--------+------------+
| IDENDERECO | RUA                | BAIRRO   | CIDADE         | ESTADO | ID_CLIENTE |
+------------+--------------------+----------+----------------+--------+------------+
|          1 | RUA ANTONIO SA     | CENTRO   | BELO HORIZONTE | MG     |          4 |
|          2 | RUA CAPITAO HERMES | CENTRO   | RIO DE JANEIRO | RJ     |          1 |
|          3 | RUA PRES VARGAS    | JARDINS  | SAO PAULO      | SP     |          3 |
|          4 | RUA ALFANDEGA      | ESTACIO  | RIO DE JANEIRO | RJ     |          2 |
|          5 | RUA DO OUVIRDOR    | FLAMENGO | RIO DE JANEIRO | RJ     |          6 |
|          6 | RUA URUGUAIANA     | CENTRO   | VITORIA        | ES     |          5 |
+------------+--------------------+----------+----------------+--------+------------+

/*RELACÃO 1 X N - CLIENTE X TELEFONE
LOGO PODEM SER N INSERT EM ENDERECO*/

DESC TELEFONE; /*VERIFICANDO A ESTRUTURA*/

INSERT INTO TELEFONE VALUES
(NULL,"CEL","78945612",5),
(NULL,"RES","45642321",5),
(NULL,"CEL","79521321",1),
(NULL,"COM","98654621",2),
(NULL,"RES","46546874",1),
(NULL,"CEL","13215464",3),
(NULL,"CEL","98452154",3),
(NULL,"COM","86546511",1),
(NULL,"RES","65465845",5),
(NULL,"CEL","65412354",2);

SELECT * FROM TELEFONE; /*VERIFICAR OS REGISTROS*/

+------------+------+----------+------------+
| IDTELEFONE | TIPO | NUMERO   | ID_CLIENTE |
+------------+------+----------+------------+
|          1 | CEL  | 78945612 |          5 |
|          2 | RES  | 45642321 |          5 |
|          3 | CEL  | 79521321 |          1 |
|          4 | COM  | 98654621 |          2 |
|          5 | RES  | 46546874 |          1 |
|          6 | CEL  | 13215464 |          3 |
|          7 | CEL  | 98452154 |          3 |
|          8 | COM  | 86546511 |          1 |
|          9 | RES  | 65465845 |          5 |
|         10 | CEL  | 65412354 |          2 |
+------------+------+----------+------------+

/*----------*/

/*JUNÇÃO -> JOIN*/

SELECT NOME, EMAIL, IDCLIENTE
FROM CLIENTE;

SELECT ID_CLIENTE, BAIRRO, CIDADE
FROM ENDERECO;

+--------+------------------+-----------+
| NOME   | EMAIL            | IDCLIENTE |
+--------+------------------+-----------+
| JOAO   | JOAO@GMAIL.COM   |         1 |
| CARLOS | CARLOS@GMAIL.COM |         2 |
| ANA    | ANA@GMAIL.COM    |         3 |
| CLARA  | NULL             |         4 |
| JORGE  | JORGE@GMAIL.COM  |         5 |
| CELIA  | CELIA@GMAIL.COM  |         6 |
+--------+------------------+-----------+

+------------+----------+----------------+
| ID_CLIENTE | BAIRRO   | CIDADE         |
+------------+----------+----------------+
|          4 | CENTRO   | BELO HORIZONTE |
|          1 | CENTRO   | RIO DE JANEIRO |
|          3 | JARDINS  | SAO PAULO      |
|          2 | ESTACIO  | RIO DE JANEIRO |
|          6 | FLAMENGO | RIO DE JANEIRO |
|          5 | CENTRO   | VITORIA        |
+------------+----------+----------------+

/*FORMA ERRADA DE JUNÇÃO*/
/*FUNCIONA POREM É UMA GAMBIARRA*/

SELECT NOME, SEXO, BAIRRO, CIDADE /*PROJEÇÃO*/
FROM CLIENTE, ENDERECO /*ORIGEM*/
WHERE ID_CLIENTE = IDCLIENTE; /*JUNÇÃO*/
/*NÃO TEM SELEÇÃO*/

+--------+------+----------+----------------+
| NOME   | SEXO | BAIRRO   | CIDADE         |
+--------+------+----------+----------------+
| JOAO   | M    | CENTRO   | RIO DE JANEIRO |
| CARLOS | M    | ESTACIO  | RIO DE JANEIRO |
| ANA    | F    | JARDINS  | SAO PAULO      |
| CLARA  | F    | CENTRO   | BELO HORIZONTE |
| JORGE  | M    | CENTRO   | VITORIA        |
| CELIA  | F    | FLAMENGO | RIO DE JANEIRO |
+--------+------+----------+----------------+

/*ADICIONANDO SELEÇÃO NA FORMA ERRADA - USO DE OPERADOR LOGICO*/

SELECT NOME, SEXO, BAIRRO, CIDADE /*PROJEÇÃO*/
FROM CLIENTE, ENDERECO /*ORIGEM*/
WHERE ID_CLIENTE = IDCLIENTE /*ID_CLIENTE = IDCLIENTE É SEMPRE VERDADE*/ 
AND SEXO = 'F'; /*JUNÇÃO*/
/*TORNA A PESQUISA INEFICIENTE, MAIS CUSTOSA COMPUTACIONALMENTE*/

+-------+------+----------+----------------+
| NOME  | SEXO | BAIRRO   | CIDADE         |
+-------+------+----------+----------------+
| ANA   | F    | JARDINS  | SAO PAULO      |
| CLARA | F    | CENTRO   | BELO HORIZONTE |
| CELIA | F    | FLAMENGO | RIO DE JANEIRO |
+-------+------+----------+----------------+

/*FORMA CERTA DE JUNÇÃO - JOIN*/

SELECT NOME, SEXO, BAIRRO, CIDADE /*PROJEÇÃO*/
FROM CLIENTE /*ORIGEM*/
	INNER JOIN ENDERECO /*JUNÇÃO*/
	ON ID_CLIENTE = IDCLIENTE
WHERE SEXO = 'F'; /*SELEÇÃO*/

+-------+------+----------+----------------+
| NOME  | SEXO | BAIRRO   | CIDADE         |
+-------+------+----------+----------------+
| ANA   | F    | JARDINS  | SAO PAULO      |
| CLARA | F    | CENTRO   | BELO HORIZONTE |
| CELIA | F    | FLAMENGO | RIO DE JANEIRO |
+-------+------+----------+----------------+

SELECT NOME, SEXO, EMAIL, TIPO, NUMERO /*PROJEÇÃO*/
FROM CLIENTE /*ORIGEM*/
INNER JOIN TELEFONE /*JUNÇÃO*/
ON ID_CLIENTE = IDCLIENTE;

+--------+------+------------------+------+----------+
| NOME   | SEXO | EMAIL            | TIPO | NUMERO   |
+--------+------+------------------+------+----------+
| JORGE  | M    | JORGE@GMAIL.COM  | CEL  | 78945612 |
| JORGE  | M    | JORGE@GMAIL.COM  | RES  | 45642321 |
| JOAO   | M    | JOAO@GMAIL.COM   | CEL  | 79521321 |
| CARLOS | M    | CARLOS@GMAIL.COM | COM  | 98654621 |
| JOAO   | M    | JOAO@GMAIL.COM   | RES  | 46546874 |
| ANA    | F    | ANA@GMAIL.COM    | CEL  | 13215464 |
| ANA    | F    | ANA@GMAIL.COM    | CEL  | 98452154 |
| JOAO   | M    | JOAO@GMAIL.COM   | COM  | 86546511 |
| JORGE  | M    | JORGE@GMAIL.COM  | RES  | 65465845 |
| CARLOS | M    | CARLOS@GMAIL.COM | CEL  | 65412354 |
+--------+------+------------------+------+----------+

/*NOME, SEXO, BAIRRO, CIDADE, TIPO, NUMERO*/

SELECT 
CLIENTE.NOME, 
CLIENTE.SEXO, 
ENDERECO.BAIRRO, 
ENDERECO.CIDADE, 
TELEFONE.TIPO, 
TELEFONE.NUMERO /*PROJEÇÃO*/
FROM CLIENTE /*ORIGEM*/
INNER JOIN ENDERECO /*JUNÇÃO*/
ON CLIENTE.IDCLIENTE = ENDERECO.ID_CLIENTE
INNER JOIN TELEFONE /*JUNÇÃO*/
ON TELEFONE.ID_CLIENTE = CLIENTE.IDCLIENTE;
/*USAR O tabela.coluna PARA IDENTIFICAR AS COLUNAS*/

+--------+------+---------+----------------+------+----------+
| NOME   | SEXO | BAIRRO  | CIDADE         | TIPO | NUMERO   |
+--------+------+---------+----------------+------+----------+
| JOAO   | M    | CENTRO  | RIO DE JANEIRO | COM  | 86546511 |
| JOAO   | M    | CENTRO  | RIO DE JANEIRO | RES  | 46546874 |
| JOAO   | M    | CENTRO  | RIO DE JANEIRO | CEL  | 79521321 |
| CARLOS | M    | ESTACIO | RIO DE JANEIRO | CEL  | 65412354 |
| CARLOS | M    | ESTACIO | RIO DE JANEIRO | COM  | 98654621 |
| ANA    | F    | JARDINS | SAO PAULO      | CEL  | 98452154 |
| ANA    | F    | JARDINS | SAO PAULO      | CEL  | 13215464 |
| JORGE  | M    | CENTRO  | VITORIA        | RES  | 65465845 |
| JORGE  | M    | CENTRO  | VITORIA        | RES  | 45642321 |
| JORGE  | M    | CENTRO  | VITORIA        | CEL  | 78945612 |
+--------+------+---------+----------------+------+----------+

/*JUNÇÃO - JOIN PONTEIRAMENTO (ALIAS PARA TABELAS)*/
SELECT 
C.NOME, 
C.SEXO, 
E.BAIRRO, 
E.CIDADE, 
T.TIPO, 
T.NUMERO /*PROJEÇÃO*/
FROM CLIENTE C /*ORIGEM*/
INNER JOIN ENDERECO E /*JUNÇÃO*/
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T /*JUNÇÃO*/
ON T.ID_CLIENTE = C.IDCLIENTE;
/*MELHORA O PROCESSAMENTO*/

+--------+------+---------+----------------+------+----------+
| NOME   | SEXO | BAIRRO  | CIDADE         | TIPO | NUMERO   |
+--------+------+---------+----------------+------+----------+
| JOAO   | M    | CENTRO  | RIO DE JANEIRO | COM  | 86546511 |
| JOAO   | M    | CENTRO  | RIO DE JANEIRO | RES  | 46546874 |
| JOAO   | M    | CENTRO  | RIO DE JANEIRO | CEL  | 79521321 |
| CARLOS | M    | ESTACIO | RIO DE JANEIRO | CEL  | 65412354 |
| CARLOS | M    | ESTACIO | RIO DE JANEIRO | COM  | 98654621 |
| ANA    | F    | JARDINS | SAO PAULO      | CEL  | 98452154 |
| ANA    | F    | JARDINS | SAO PAULO      | CEL  | 13215464 |
| JORGE  | M    | CENTRO  | VITORIA        | RES  | 65465845 |
| JORGE  | M    | CENTRO  | VITORIA        | RES  | 45642321 |
| JORGE  | M    | CENTRO  | VITORIA        | CEL  | 78945612 |
+--------+------+---------+----------------+------+----------+

/*DDL*/

CREATE TABLE PRODUTO(
IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
NOME_PRODUTO VARCHAR(30) NOT NULL,
PRECO INT,
FRETE FLOAT(10,2) NOT NULL
);

/*ALTER TABLE*/

/*ALTERAR NOME DE UMA COLUNA - CHANGE*/

ALTER TABLE PRODUTO
CHANGE PRECO VALOR_UNITARIO INT NOT NULL;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int         | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | int         | NO   |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+

/*ALTERAR O TIPO DE UMA COLUNA - MODIFY*/

ALTER TABLE PRODUTO
MODIFY VALOR_UNITARIO VARCHAR(50) NOT NULL;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int         | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | varchar(50) | NO   |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+

/*ADICIONANDO UM COLUNA*/

ALTER TABLE PRODUTO
ADD PESO FLOAT(10,2) NOT NULL;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int         | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | varchar(50) | NO   |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
| PESO           | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+

/*APAGANDO UMA COLUNA - DROP COLUMN*/

ALTER TABLE PRODUTO
DROP COLUMN PESO;

/*ADICIONAR A COLUNA NA POSIÇÃO ESPECIFICA*/

ALTER TABLE PRODUTO
ADD COLUMN PESO FLOAT(10,2) NOT NULL
FIRST;

ALTER TABLE PRODUTO
ADD COLUMN PESO FLOAT(10,2) NOT NULL
AFTER NOME_PRODUTO;
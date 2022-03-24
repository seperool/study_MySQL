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



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

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| PESO           | float(10,2) | NO   |     | NULL    |                |
| IDPRODUTO      | int         | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | varchar(50) | NO   |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+

/*EXERCICO DE DML*/

INSERT INTO CLIENTE VALUES(NULL,'FLAVIO','M','FLAVIO@IG.COM','4657765');
INSERT INTO CLIENTE VALUES(NULL,'ANDRE','M','ANDRE@GLOBO.COM','7687567');
INSERT INTO CLIENTE VALUES(NULL,'GIOVANA','F',NULL,'0876655');
INSERT INTO CLIENTE VALUES(NULL,'KARLA','M','KARLA@GMAIL.COM','545676778');
INSERT INTO CLIENTE VALUES(NULL,'DANIELE','M','DANIELE@GMAIL.COM','43536789');
INSERT INTO CLIENTE VALUES(NULL,'LORENA','M',NULL,'774557887');
INSERT INTO CLIENTE VALUES(NULL,'EDUARDO','M',NULL,'54376457');
INSERT INTO CLIENTE VALUES(NULL,'ANTONIO','F','ANTONIO@IG.COM','12436767');
INSERT INTO CLIENTE VALUES(NULL,'ANTONIO','M','ANTONIO@UOL.COM','3423565');
INSERT INTO CLIENTE VALUES(NULL,'ELAINE','M','ELAINE@GLOBO.COM','32567763');
INSERT INTO CLIENTE VALUES(NULL,'CARMEM','M','CARMEM@IG.COM','787832213');
INSERT INTO CLIENTE VALUES(NULL,'ADRIANA','F','ADRIANA@GMAIL.COM','88556942');
INSERT INTO CLIENTE VALUES(NULL,'JOICE','F','JOICE@GMAIL.COM','55412256');

/* CADASTRE UM ENDERECO PARA CADA CLIENTE */

INSERT INTO ENDERECO VALUES(NULL,'RUA GUEDES','CASCADURA','B. HORIZONTE','MG',8);
INSERT INTO ENDERECO VALUES(NULL,'RUA MAIA LACERDA','ESTACIO','RIO DE JANEIRO','RJ',9);
INSERT INTO ENDERECO VALUES(NULL,'RUA VISCONDESSA','CENTRO','RIO DE JANEIRO','RJ',10);
INSERT INTO ENDERECO VALUES(NULL,'RUA NELSON MANDELA','COPACABANA','RIO DE JANEIRO','RJ',11);
INSERT INTO ENDERECO VALUES(NULL,'RUA ARAUJO LIMA','CENTRO','VITORIA','ES',12);
INSERT INTO ENDERECO VALUES(NULL,'RUA CASTRO ALVES','LEBLON','RIO DE JANEIRO','RJ',13);
INSERT INTO ENDERECO VALUES(NULL,'AV CAPITAO ANTUNES','CENTRO','CURITIBA','PR',14);
INSERT INTO ENDERECO VALUES(NULL,'AV CARLOS BARROSO','JARDINS','SAO PAULO','SP',15);
INSERT INTO ENDERECO VALUES(NULL,'ALAMEDA SAMPAIO','BOM RETIRO','CURITIBA','PR',16);
INSERT INTO ENDERECO VALUES(NULL,'RUA DA LAPA','LAPA','SAO PAULO','SP',17);
INSERT INTO ENDERECO VALUES(NULL,'RUA GERONIMO','CENTRO','RIO DE JANEIRO','RJ',18);
INSERT INTO ENDERECO VALUES(NULL,'RUA GOMES FREIRE','CENTRO','RIO DE JANEIRO','RJ',19);
INSERT INTO ENDERECO VALUES(NULL,'RUA GOMES FREIRE','CENTRO','RIO DE JANEIRO','RJ',20);

/* CADASTRE TELEFONES PARA OS CLIENTES */


INSERT INTO TELEFONE VALUES(NULL,'RES','68976565',8);
INSERT INTO TELEFONE VALUES(NULL,'CEL','99656675',8);
INSERT INTO TELEFONE VALUES(NULL,'CEL','33567765',10);
INSERT INTO TELEFONE VALUES(NULL,'CEL','88668786',10);
INSERT INTO TELEFONE VALUES(NULL,'COM','55689654',10);
INSERT INTO TELEFONE VALUES(NULL,'COM','88687979',11);
INSERT INTO TELEFONE VALUES(NULL,'COM','88965676',12);
INSERT INTO TELEFONE VALUES(NULL,'CEL','89966809',14);
INSERT INTO TELEFONE VALUES(NULL,'COM','88679978',15);
INSERT INTO TELEFONE VALUES(NULL,'CEL','99655768',16);
INSERT INTO TELEFONE VALUES(NULL,'RES','89955665',17);
INSERT INTO TELEFONE VALUES(NULL,'RES','77455786',18);
INSERT INTO TELEFONE VALUES(NULL,'RES','89766554',18);
INSERT INTO TELEFONE VALUES(NULL,'RES','77755785',19);
INSERT INTO TELEFONE VALUES(NULL,'COM','44522578',19);
INSERT INTO TELEFONE VALUES(NULL,'CEL','44522578',20);

/*RELATORIO GERAL DE TODOS OS CLIENTES*/

SELECT
C.IDCLIENTE,
C.NOME,
C.SEXO,
C.EMAIL,
C.CPF,
E.RUA,
E.BAIRRO,
E.CIDADE,
E.ESTADO,
T.TIPO,
T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

+-----------+---------+------+-------------------+------------+--------------------+------------+----------------+--------+------+----------+
| IDCLIENTE | NOME    | SEXO | EMAIL             | CPF        | RUA                | BAIRRO     | CIDADE         | ESTADO | TIPO | NUMERO   |
+-----------+---------+------+-------------------+------------+--------------------+------------+----------------+--------+------+----------+
|         1 | JOAO    | M    | JOAO@GMAIL.COM    | 4565987985 | RUA CAPITAO HERMES | CENTRO     | RIO DE JANEIRO | RJ     | CEL  | 79521321 |
|         1 | JOAO    | M    | JOAO@GMAIL.COM    | 4565987985 | RUA CAPITAO HERMES | CENTRO     | RIO DE JANEIRO | RJ     | RES  | 46546874 |
|         1 | JOAO    | M    | JOAO@GMAIL.COM    | 4565987985 | RUA CAPITAO HERMES | CENTRO     | RIO DE JANEIRO | RJ     | COM  | 86546511 |
|         2 | CARLOS  | M    | CARLOS@GMAIL.COM  | 87985484   | RUA ALFANDEGA      | ESTACIO    | RIO DE JANEIRO | RJ     | COM  | 98654621 |
|         2 | CARLOS  | M    | CARLOS@GMAIL.COM  | 87985484   | RUA ALFANDEGA      | ESTACIO    | RIO DE JANEIRO | RJ     | CEL  | 65412354 |
|         3 | ANA     | F    | ANA@GMAIL.COM     | 879562131  | RUA PRES VARGAS    | JARDINS    | SAO PAULO      | SP     | CEL  | 13215464 |
|         3 | ANA     | F    | ANA@GMAIL.COM     | 879562131  | RUA PRES VARGAS    | JARDINS    | SAO PAULO      | SP     | CEL  | 98452154 |
|         5 | JORGE   | M    | JORGE@GMAIL.COM   | 2136467854 | RUA URUGUAIANA     | CENTRO     | VITORIA        | ES     | CEL  | 78945612 |
|         5 | JORGE   | M    | JORGE@GMAIL.COM   | 2136467854 | RUA URUGUAIANA     | CENTRO     | VITORIA        | ES     | RES  | 45642321 |
|         5 | JORGE   | M    | JORGE@GMAIL.COM   | 2136467854 | RUA URUGUAIANA     | CENTRO     | VITORIA        | ES     | RES  | 65465845 |
|         8 | FLAVIO  | M    | FLAVIO@IG.COM     | 4657765    | RUA GUEDES         | CASCADURA  | B. HORIZONTE   | MG     | RES  | 68976565 |
|         8 | FLAVIO  | M    | FLAVIO@IG.COM     | 4657765    | RUA GUEDES         | CASCADURA  | B. HORIZONTE   | MG     | CEL  | 99656675 |
|        10 | GIOVANA | F    | NULL              | 0876655    | RUA VISCONDESSA    | CENTRO     | RIO DE JANEIRO | RJ     | CEL  | 33567765 |
|        10 | GIOVANA | F    | NULL              | 0876655    | RUA VISCONDESSA    | CENTRO     | RIO DE JANEIRO | RJ     | CEL  | 88668786 |
|        10 | GIOVANA | F    | NULL              | 0876655    | RUA VISCONDESSA    | CENTRO     | RIO DE JANEIRO | RJ     | COM  | 55689654 |
|        11 | KARLA   | M    | KARLA@GMAIL.COM   | 545676778  | RUA NELSON MANDELA | COPACABANA | RIO DE JANEIRO | RJ     | COM  | 88687979 |
|        12 | DANIELE | M    | DANIELE@GMAIL.COM | 43536789   | RUA ARAUJO LIMA    | CENTRO     | VITORIA        | ES     | COM  | 88965676 |
|        14 | EDUARDO | M    | NULL              | 54376457   | AV CAPITAO ANTUNES | CENTRO     | CURITIBA       | PR     | CEL  | 89966809 |
|        15 | ANTONIO | F    | ANTONIO@IG.COM    | 12436767   | AV CARLOS BARROSO  | JARDINS    | SAO PAULO      | SP     | COM  | 88679978 |
|        16 | ANTONIO | M    | ANTONIO@UOL.COM   | 3423565    | ALAMEDA SAMPAIO    | BOM RETIRO | CURITIBA       | PR     | CEL  | 99655768 |
|        17 | ELAINE  | M    | ELAINE@GLOBO.COM  | 32567763   | RUA DA LAPA        | LAPA       | SAO PAULO      | SP     | RES  | 89955665 |
|        18 | CARMEM  | M    | CARMEM@IG.COM     | 787832213  | RUA GERONIMO       | CENTRO     | RIO DE JANEIRO | RJ     | RES  | 77455786 |
|        18 | CARMEM  | M    | CARMEM@IG.COM     | 787832213  | RUA GERONIMO       | CENTRO     | RIO DE JANEIRO | RJ     | RES  | 89766554 |
|        19 | ADRIANA | F    | ADRIANA@GMAIL.COM | 88556942   | RUA GOMES FREIRE   | CENTRO     | RIO DE JANEIRO | RJ     | RES  | 77755785 |
|        19 | ADRIANA | F    | ADRIANA@GMAIL.COM | 88556942   | RUA GOMES FREIRE   | CENTRO     | RIO DE JANEIRO | RJ     | COM  | 44522578 |
|        20 | JOICE   | F    | JOICE@GMAIL.COM   | 55412256   | RUA GOMES FREIRE   | CENTRO     | RIO DE JANEIRO | RJ     | CEL  | 44522578 |
+-----------+---------+------+-------------------+------------+--------------------+------------+----------------+--------+------+----------+


/*RELATORIO DE HOMENS*/

DESC CLIENTE;
DESC ENDERECO;
DESC TELEFONE;

SELECT
C.IDCLIENTE,
C.NOME,
C.SEXO,
C.EMAIL,
C.CPF,
E.RUA,
E.BAIRRO,
E.CIDADE,
E.ESTADO,
T.TIPO,
T.NUMERO
FROM CLIENTE C
LEFT JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
LEFT JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE C.SEXO = 'M';

-- CONSERTANDO REGISTROS ERRADOS
UPDATE CLIENTE SET SEXO = 'F'
WHERE IDCLIENTE IN (11, 12, 13, 17, 18);

/*RELATORIO DE MULHERES*/

SELECT
C.IDCLIENTE,
C.NOME,
C.SEXO,
C.EMAIL,
C.CPF,
E.RUA,
E.BAIRRO,
E.CIDADE,
E.ESTADO,
T.TIPO,
T.NUMERO
FROM CLIENTE C
LEFT JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
LEFT JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE C.SEXO = 'F';

-- CONSERTANDO REGISTROS ERRADOS
UPDATE CLIENTE SET SEXO = 'M'
WHERE IDCLIENTE = 15;

/*QUANTIDADE DE HOMENS E MULHERES*/

SELECT
COUNT(SEXO) AS QTD,
SEXO
FROM CLIENTE
GROUP BY SEXO;

/*ID'S E EMAIL DAS MULHERES
 QUE MOREM NO CENTRO
 DO RIO DE JANEIRO
 E QUE NÃO TENHAM CELULAR*/

-- ERRO 8
SELECT
COUNT(SEXO) AS QTD,
SEXO
FROM CLIENTE
GROUP BY SEXO;

-- ERRO 10
SELECT
COUNT(BAIRRO) AS QTD,
BAIRRO
FROM ENDERECO
GROUP BY BAIRRO;

-- ERRO 9
SELECT
COUNT(CIDADE) AS QTD,
CIDADE
FROM ENDERECO
GROUP BY CIDADE;

-- ERRO 15
SELECT
COUNT(TIPO) AS QTD,
TIPO
FROM TELEFONE
GROUP BY TIPO;

-- REPOSTA
SELECT
C.IDCLIENTE, 
C.EMAIL,
C.NOME,
C.SEXO,
E.BAIRRO,
E.CIDADE,
T.TIPO
FROM CLIENTE C

INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE

INNER JOIN TELEFONE T
ON T.ID_CLIENTE = C.IDCLIENTE

WHERE
NOT T.TIPO = 'CEL' AND
E.BAIRRO = 'CENTRO' AND
E.CIDADE = 'RIO DE JANEIRO' AND
C.SEXO = 'F';

+-----------+-------------------+---------+------+--------+----------------+------+
| IDCLIENTE | EMAIL             | NOME    | SEXO | BAIRRO | CIDADE         | TIPO |
+-----------+-------------------+---------+------+--------+----------------+------+
|        10 | NULL              | GIOVANA | F    | CENTRO | RIO DE JANEIRO | COM  |
|        18 | CARMEM@IG.COM     | CARMEM  | F    | CENTRO | RIO DE JANEIRO | RES  |
|        18 | CARMEM@IG.COM     | CARMEM  | F    | CENTRO | RIO DE JANEIRO | RES  |
|        19 | ADRIANA@GMAIL.COM | ADRIANA | F    | CENTRO | RIO DE JANEIRO | RES  |
|        19 | ADRIANA@GMAIL.COM | ADRIANA | F    | CENTRO | RIO DE JANEIRO | COM  |
+-----------+-------------------+---------+------+--------+----------------+------+


/* PARA UMA CAMPANHA DE MARKETING, O SETOR SOLICITOU UM
RELATÓRIO COM O NOME, EMAIL E TELEFONE CELULAR 
DOS CLIENTES QUE MORAM NO ESTADO DO RIO DE JANEIRO 
VOCÊ TERÁ QUE PASSAR A QUERY PARA GERAR O RELATORIO PARA
O PROGRAMADOR */

SELECT
C.IDCLIENTE, 
C.NOME,
C.EMAIL,
T.NUMERO AS CELULAR
FROM CLIENTE C

INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE

INNER JOIN TELEFONE T
ON T.ID_CLIENTE = C.IDCLIENTE

WHERE (T.TIPO = 'CEL' AND E.ESTADO = 'RJ');

+-----------+---------+------------------+----------+
| IDCLIENTE | NOME    | EMAIL            | CELULAR  |
+-----------+---------+------------------+----------+
|         1 | JOAO    | JOAO@GMAIL.COM   | 79521321 |
|         2 | CARLOS  | CARLOS@GMAIL.COM | 65412354 |
|        10 | GIOVANA | NULL             | 33567765 |
|        10 | GIOVANA | NULL             | 88668786 |
|        20 | JOICE   | JOICE@GMAIL.COM  | 44522578 |
+-----------+---------+------------------+----------+


/* PARA UMA CAMPANHA DE PRODUTOS DE BELEZA, O COMERCIAL SOLICITOU UM
RELATÓRIO COM O NOME, EMAIL E TELEFONE CELULAR 
 DAS MULHERES QUE MORAM NO ESTADO DE SÃO PAULO 
VOCÊ TERÁ QUE PASSAR A QUERY PARA GERAR O RELATORIO PARA
O PROGRAMADOR */

SELECT
C.IDCLIENTE, 
C.NOME,
C.EMAIL,
T.NUMERO AS CELULAR
FROM CLIENTE C

INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE

INNER JOIN TELEFONE T
ON T.ID_CLIENTE = C.IDCLIENTE

WHERE 
C.SEXO = 'F' AND
T.TIPO = 'CEL' AND 
E.ESTADO = 'SP';

+-----------+------+---------------+----------+
| IDCLIENTE | NOME | EMAIL         | CELULAR  |
+-----------+------+---------------+----------+
|         3 | ANA  | ANA@GMAIL.COM | 13215464 |
|         3 | ANA  | ANA@GMAIL.COM | 98452154 |
+-----------+------+---------------+----------+

/*-------*/

/*NOME, EMAIL, NUMERO E ESTADO*/

SELECT
C.NOME,
C.EMAIL,
T.NUMERO,
E.ESTADO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

+---------+-------------------+----------+--------+
| NOME    | EMAIL             | NUMERO   | ESTADO |
+---------+-------------------+----------+--------+
| JORGE   | JORGE@GMAIL.COM   | 78945612 | ES     |
| JORGE   | JORGE@GMAIL.COM   | 45642321 | ES     |
| JOAO    | JOAO@GMAIL.COM    | 79521321 | RJ     |
| CARLOS  | CARLOS@GMAIL.COM  | 98654621 | RJ     |
| JOAO    | JOAO@GMAIL.COM    | 46546874 | RJ     |
| ANA     | ANA@GMAIL.COM     | 13215464 | SP     |
| ANA     | ANA@GMAIL.COM     | 98452154 | SP     |
| JOAO    | JOAO@GMAIL.COM    | 86546511 | RJ     |
| JORGE   | JORGE@GMAIL.COM   | 65465845 | ES     |
| CARLOS  | CARLOS@GMAIL.COM  | 65412354 | RJ     |
| JOICE   | JOICE@GMAIL.COM   | 44522578 | RJ     |
| FLAVIO  | FLAVIO@IG.COM     | 68976565 | MG     |
| FLAVIO  | FLAVIO@IG.COM     | 99656675 | MG     |
| GIOVANA | NULL              | 33567765 | RJ     |
| GIOVANA | NULL              | 88668786 | RJ     |
| GIOVANA | NULL              | 55689654 | RJ     |
| KARLA   | KARLA@GMAIL.COM   | 88687979 | RJ     |
| DANIELE | DANIELE@GMAIL.COM | 88965676 | ES     |
| EDUARDO | NULL              | 89966809 | PR     |
| ANTONIO | ANTONIO@IG.COM    | 88679978 | SP     |
| ANTONIO | ANTONIO@UOL.COM   | 99655768 | PR     |
| ELAINE  | ELAINE@GLOBO.COM  | 89955665 | SP     |
| CARMEM  | CARMEM@IG.COM     | 77455786 | RJ     |
| CARMEM  | CARMEM@IG.COM     | 89766554 | RJ     |
| ADRIANA | ADRIANA@GMAIL.COM | 77755785 | RJ     |
| ADRIANA | ADRIANA@GMAIL.COM | 44522578 | RJ     |
+---------+-------------------+----------+--------+

/*TRATANDO NULL COM A FUNÇÃO IFNULL()*/
/*SEMELHANTE A FUNÇÃO COALESCE()*/

SELECT
C.NOME,
IFNULL(C.EMAIL,'NAO TEM EMAIL') AS EMAIL,
T.NUMERO,
E.ESTADO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

+---------+-------------------+----------+--------+
| NOME    | EMAIL             | NUMERO   | ESTADO |
+---------+-------------------+----------+--------+
| JOAO    | JOAO@GMAIL.COM    | 79521321 | RJ     |
| JOAO    | JOAO@GMAIL.COM    | 46546874 | RJ     |
| JOAO    | JOAO@GMAIL.COM    | 86546511 | RJ     |
| CARLOS  | CARLOS@GMAIL.COM  | 98654621 | RJ     |
| CARLOS  | CARLOS@GMAIL.COM  | 65412354 | RJ     |
| ANA     | ANA@GMAIL.COM     | 13215464 | SP     |
| ANA     | ANA@GMAIL.COM     | 98452154 | SP     |
| JORGE   | JORGE@GMAIL.COM   | 78945612 | ES     |
| JORGE   | JORGE@GMAIL.COM   | 45642321 | ES     |
| JORGE   | JORGE@GMAIL.COM   | 65465845 | ES     |
| FLAVIO  | FLAVIO@IG.COM     | 68976565 | MG     |
| FLAVIO  | FLAVIO@IG.COM     | 99656675 | MG     |
| GIOVANA | NAO TEM EMAIL     | 33567765 | RJ     |
| GIOVANA | NAO TEM EMAIL     | 88668786 | RJ     |
| GIOVANA | NAO TEM EMAIL     | 55689654 | RJ     |
| KARLA   | KARLA@GMAIL.COM   | 88687979 | RJ     |
| DANIELE | DANIELE@GMAIL.COM | 88965676 | ES     |
| EDUARDO | NAO TEM EMAIL     | 89966809 | PR     |
| ANTONIO | ANTONIO@IG.COM    | 88679978 | SP     |
| ANTONIO | ANTONIO@UOL.COM   | 99655768 | PR     |
| ELAINE  | ELAINE@GLOBO.COM  | 89955665 | SP     |
| CARMEM  | CARMEM@IG.COM     | 77455786 | RJ     |
| CARMEM  | CARMEM@IG.COM     | 89766554 | RJ     |
| ADRIANA | ADRIANA@GMAIL.COM | 77755785 | RJ     |
| ADRIANA | ADRIANA@GMAIL.COM | 44522578 | RJ     |
| JOICE   | JOICE@GMAIL.COM   | 44522578 | RJ     |
+---------+-------------------+----------+--------+

SELECT
C.NOME,
IFNULL(C.EMAIL,'*************') AS EMAIL,
T.NUMERO,
E.ESTADO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

/*VIEWS*/

CREATE VIEW RELATORIO AS
SELECT 
C.NOME,
C.SEXO, 
C.EMAIL, 
T.TIPO, 
T.NUMERO, 
E.BAIRRO, 
E.CIDADE, 
E.ESTADO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

SELECT * FROM RELATORIO;

+---------+------+-------------------+------+----------+------------+----------------+--------+
| NOME    | SEXO | EMAIL             | TIPO | NUMERO   | BAIRRO     | CIDADE         | ESTADO |
+---------+------+-------------------+------+----------+------------+----------------+--------+
| JOAO    | M    | JOAO@GMAIL.COM    | CEL  | 79521321 | CENTRO     | RIO DE JANEIRO | RJ     |
| JOAO    | M    | JOAO@GMAIL.COM    | RES  | 46546874 | CENTRO     | RIO DE JANEIRO | RJ     |
| JOAO    | M    | JOAO@GMAIL.COM    | COM  | 86546511 | CENTRO     | RIO DE JANEIRO | RJ     |
| CARLOS  | M    | CARLOS@GMAIL.COM  | COM  | 98654621 | ESTACIO    | RIO DE JANEIRO | RJ     |
| CARLOS  | M    | CARLOS@GMAIL.COM  | CEL  | 65412354 | ESTACIO    | RIO DE JANEIRO | RJ     |
| ANA     | F    | ANA@GMAIL.COM     | CEL  | 13215464 | JARDINS    | SAO PAULO      | SP     |
| ANA     | F    | ANA@GMAIL.COM     | CEL  | 98452154 | JARDINS    | SAO PAULO      | SP     |
| JORGE   | M    | JORGE@GMAIL.COM   | CEL  | 78945612 | CENTRO     | VITORIA        | ES     |
| JORGE   | M    | JORGE@GMAIL.COM   | RES  | 45642321 | CENTRO     | VITORIA        | ES     |
| JORGE   | M    | JORGE@GMAIL.COM   | RES  | 65465845 | CENTRO     | VITORIA        | ES     |
| FLAVIO  | M    | FLAVIO@IG.COM     | RES  | 68976565 | CASCADURA  | B. HORIZONTE   | MG     |
| FLAVIO  | M    | FLAVIO@IG.COM     | CEL  | 99656675 | CASCADURA  | B. HORIZONTE   | MG     |
| GIOVANA | F    | NULL              | CEL  | 33567765 | CENTRO     | RIO DE JANEIRO | RJ     |
| GIOVANA | F    | NULL              | CEL  | 88668786 | CENTRO     | RIO DE JANEIRO | RJ     |
| GIOVANA | F    | NULL              | COM  | 55689654 | CENTRO     | RIO DE JANEIRO | RJ     |
| KARLA   | F    | KARLA@GMAIL.COM   | COM  | 88687979 | COPACABANA | RIO DE JANEIRO | RJ     |
| DANIELE | F    | DANIELE@GMAIL.COM | COM  | 88965676 | CENTRO     | VITORIA        | ES     |
| EDUARDO | M    | NULL              | CEL  | 89966809 | CENTRO     | CURITIBA       | PR     |
| ANTONIO | M    | ANTONIO@IG.COM    | COM  | 88679978 | JARDINS    | SAO PAULO      | SP     |
| ANTONIO | M    | ANTONIO@UOL.COM   | CEL  | 99655768 | BOM RETIRO | CURITIBA       | PR     |
| ELAINE  | F    | ELAINE@GLOBO.COM  | RES  | 89955665 | LAPA       | SAO PAULO      | SP     |
| CARMEM  | F    | CARMEM@IG.COM     | RES  | 77455786 | CENTRO     | RIO DE JANEIRO | RJ     |
| CARMEM  | F    | CARMEM@IG.COM     | RES  | 89766554 | CENTRO     | RIO DE JANEIRO | RJ     |
| ADRIANA | F    | ADRIANA@GMAIL.COM | RES  | 77755785 | CENTRO     | RIO DE JANEIRO | RJ     |
| ADRIANA | F    | ADRIANA@GMAIL.COM | COM  | 44522578 | CENTRO     | RIO DE JANEIRO | RJ     |
| JOICE   | F    | JOICE@GMAIL.COM   | CEL  | 44522578 | CENTRO     | RIO DE JANEIRO | RJ     |
+---------+------+-------------------+------+----------+------------+----------------+--------+

SHOW DATABASES;
SHOW TABLES;
SHOW VIEWS; -- NÃO EXISTE
/*AS VIEWS FICAM DENTRO DE TABLES
POR CONTA DISTO, É NECESSARIO DIFERENCIAR O NOME DAS VIEWS*/

DROP VIEW RELATORIO;

/*INSERINDO UM PREFIXO*/

CREATE VIEW VW_RELATORIO AS
SELECT 
C.NOME,
C.SEXO, 
C.EMAIL, 
T.TIPO, 
T.NUMERO, 
E.BAIRRO, 
E.CIDADE, 
E.ESTADO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

/*CONSULTA NUMA VIEW*/

SELECT
NOME,
NUMERO,
ESTADO
FROM VW_RELATORIO;

/******/
/*CRIANDO TABELA JOGADORES E VIEW*/

CREATE TABLE JOGADORES(
	IDJOGADOR INT,
	NOME VARCHAR(30),
	ESTADO CHAR(2)
);

INSERT INTO JOGADORES VALUES(1,'GUERRERO','RS');
INSERT INTO JOGADORES VALUES(2,'GABIGOL','RJ');
INSERT INTO JOGADORES VALUES(3,'GANSO','RJ');
INSERT INTO JOGADORES VALUES(4,'NENÊ', 'RJ');
INSERT INTO JOGADORES VALUES(5,'LOVE','SP');

CREATE VIEW VW_JOGADORES AS
SELECT NOME, ESTADO
FROM JOGADORES;

SELECT * FROM VW_JOGADORES;

DELETE FROM VW_JOGADORES
WHERE NOME = 'GUERRERO';

INSERT INTO VW_JOGADORES VALUES('GUERRERO','RS');

/*ORDER BY*/

CREATE TABLE ALUNOS(
NUMERO INT,
NOME VARCHAR(30)
);

INSERT INTO ALUNOS VALUES(1,'JOAO');
INSERT INTO ALUNOS VALUES(1,'MARIA');
INSERT INTO ALUNOS VALUES(2,'ZOE');
INSERT INTO ALUNOS VALUES(2,'ANDRE');
INSERT INTO ALUNOS VALUES(3,'CLARA');
INSERT INTO ALUNOS VALUES(1,'CLARA');
INSERT INTO ALUNOS VALUES(4,'MAFRA');
INSERT INTO ALUNOS VALUES(5,'JANAINA');
INSERT INTO ALUNOS VALUES(1,'JANAINA');
INSERT INTO ALUNOS VALUES(3,'MARCELO');
INSERT INTO ALUNOS VALUES(4,'GIOVANI');
INSERT INTO ALUNOS VALUES(5,'ANTONIO');
INSERT INTO ALUNOS VALUES(6,'ANA');
INSERT INTO ALUNOS VALUES(6,'VIVIANE');

SELECT * FROM ALUNOS;

+--------+---------+
| NUMERO | NOME    |
+--------+---------+
|      1 | JOAO    |
|      1 | MARIA   |
|      2 | ZOE     |
|      2 | ANDRE   |
|      3 | CLARA   |
|      1 | CLARA   |
|      4 | MAFRA   |
|      5 | JANAINA |
|      1 | JANAINA |
|      3 | MARCELO |
|      4 | GIOVANI |
|      5 | ANTONIO |
|      6 | ANA     |
|      6 | VIVIANE |
+--------+---------+

/* ORDENANDO POR MAIS DE UMA COLUNA */

SELECT * 
FROM ALUNOS
ORDER BY 1, 2;

--OU

SELECT * 
FROM ALUNOS
ORDER BY NUMERO, NOME;

+--------+---------+
| NUMERO | NOME    |
+--------+---------+
|      1 | CLARA   |
|      1 | JANAINA |
|      1 | JOAO    |
|      1 | MARIA   |
|      2 | ANDRE   |
|      2 | ZOE     |
|      3 | CLARA   |
|      3 | MARCELO |
|      4 | GIOVANI |
|      4 | MAFRA   |
|      5 | ANTONIO |
|      5 | JANAINA |
|      6 | ANA     |
|      6 | VIVIANE |
+--------+---------+

/* ORDENANDO COM JOINS */


SELECT  
C.NOME, 
C.SEXO, 
IFNULL(C.EMAIL,'CLIENTE SEM EMAIL') AS "E-MAIL", 
T.TIPO, 
T.NUMERO, 
E.BAIRRO, 
E.CIDADE, 
E.ESTADO
FROM CLIENTE C 
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE 
INNER JOIN ENDERECO E 
ON C.IDCLIENTE = E.ID_CLIENTE
ORDER BY 1;

+---------+------+-------------------+------+----------+------------+----------------+--------+
| NOME    | SEXO | E-MAIL            | TIPO | NUMERO   | BAIRRO     | CIDADE         | ESTADO |
+---------+------+-------------------+------+----------+------------+----------------+--------+
| ADRIANA | F    | ADRIANA@GMAIL.COM | COM  | 44522578 | CENTRO     | RIO DE JANEIRO | RJ     |
| ADRIANA | F    | ADRIANA@GMAIL.COM | RES  | 77755785 | CENTRO     | RIO DE JANEIRO | RJ     |
| ANA     | F    | ANA@GMAIL.COM     | CEL  | 13215464 | JARDINS    | SAO PAULO      | SP     |
| ANA     | F    | ANA@GMAIL.COM     | CEL  | 98452154 | JARDINS    | SAO PAULO      | SP     |
| ANTONIO | M    | ANTONIO@UOL.COM   | CEL  | 99655768 | BOM RETIRO | CURITIBA       | PR     |
| ANTONIO | M    | ANTONIO@IG.COM    | COM  | 88679978 | JARDINS    | SAO PAULO      | SP     |
| CARLOS  | M    | CARLOS@GMAIL.COM  | COM  | 98654621 | ESTACIO    | RIO DE JANEIRO | RJ     |
| CARLOS  | M    | CARLOS@GMAIL.COM  | CEL  | 65412354 | ESTACIO    | RIO DE JANEIRO | RJ     |
| CARMEM  | F    | CARMEM@IG.COM     | RES  | 89766554 | CENTRO     | RIO DE JANEIRO | RJ     |
| CARMEM  | F    | CARMEM@IG.COM     | RES  | 77455786 | CENTRO     | RIO DE JANEIRO | RJ     |
| DANIELE | F    | DANIELE@GMAIL.COM | COM  | 88965676 | CENTRO     | VITORIA        | ES     |
| EDUARDO | M    | CLIENTE SEM EMAIL | CEL  | 89966809 | CENTRO     | CURITIBA       | PR     |
| ELAINE  | F    | ELAINE@GLOBO.COM  | RES  | 89955665 | LAPA       | SAO PAULO      | SP     |
| FLAVIO  | M    | FLAVIO@IG.COM     | RES  | 68976565 | CASCADURA  | B. HORIZONTE   | MG     |
| FLAVIO  | M    | FLAVIO@IG.COM     | CEL  | 99656675 | CASCADURA  | B. HORIZONTE   | MG     |
| GIOVANA | F    | CLIENTE SEM EMAIL | CEL  | 33567765 | CENTRO     | RIO DE JANEIRO | RJ     |
| GIOVANA | F    | CLIENTE SEM EMAIL | COM  | 55689654 | CENTRO     | RIO DE JANEIRO | RJ     |
| GIOVANA | F    | CLIENTE SEM EMAIL | CEL  | 88668786 | CENTRO     | RIO DE JANEIRO | RJ     |
| JOAO    | M    | JOAO@GMAIL.COM    | COM  | 86546511 | CENTRO     | RIO DE JANEIRO | RJ     |
| JOAO    | M    | JOAO@GMAIL.COM    | RES  | 46546874 | CENTRO     | RIO DE JANEIRO | RJ     |
| JOAO    | M    | JOAO@GMAIL.COM    | CEL  | 79521321 | CENTRO     | RIO DE JANEIRO | RJ     |
| JOICE   | F    | JOICE@GMAIL.COM   | CEL  | 44522578 | CENTRO     | RIO DE JANEIRO | RJ     |
| JOSE    | M    | JORGE@GMAIL.COM   | CEL  | 78945612 | CENTRO     | VITORIA        | ES     |
| JOSE    | M    | JORGE@GMAIL.COM   | RES  | 65465845 | CENTRO     | VITORIA        | ES     |
| JOSE    | M    | JORGE@GMAIL.COM   | RES  | 45642321 | CENTRO     | VITORIA        | ES     |
| KARLA   | F    | KARLA@GMAIL.COM   | COM  | 88687979 | COPACABANA | RIO DE JANEIRO | RJ     |
+---------+------+-------------------+------+----------+------------+----------------+--------+

/*-----------------------------------*/

/*ALTERANDO TABELAS*/

CREATE TABLE TABELA(
COLUNA1 VARCHAR(30),
COLUNA2 VARCHAR(30),
COLUNA3 VARCHAR(30)
);

/*ADICIONANDO UMA PRIMARY KEY*/
ALTER TABLE TABELA
ADD PRIMARY KEY (COLUNA1);

/*ADICIONANDO COLUNA NA ULTIMA POSIÇÃO*/
ALTER TABLE TABELA
ADD COLUNA VARCHAR(30);

/*ADICIONANDO COLUNA NUMA POSIÇÃO ESPECIFICA*/
ALTER TABLE TABELA
ADD COLUNA4 VARCHAR(30) NOT NULL UNIQUE
AFTER COLUNA3;

/*MODIFICANDO UM TIPO DE UM CAMPO*/
ALTER TABLE TABELA
MODIFY COLUNA2 DATE NOT NULL;

/*RENOMEANDO O NOME DA TABELA*/
ALTER TABLE TABELA
RENAME PESSOA;

/*CRIANDO UMA NOVA TABELA E ADICIONANDO UMA CHAVE ESTRANGEIRA*/
CREATE TABLE TIME(
IDTEMPO INT PRIMARY KEY AUTO_INCREMENT,
TIME VARCHAR(30),
ID_PESSOA VARCHAR(30)
);

ALTER TABLE TIME
ADD FOREIGN KEY (ID_PESSOA)
REFERENCES PESSOA(COLUNA1);

/*----------------------------------*/

/*ORGANIZACAO DE CHAVES - CONSTRAINT (REGRA) */

CREATE TABLE JOGADOR(
	IDJOGADOR INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30)
);

CREATE TABLE TIMES(
	IDTIME INT PRIMARY KEY AUTO_INCREMENT,
	NOMETIME VARCHAR(30),
	ID_JOGADOR INT,
	FOREIGN KEY(ID_JOGADOR)
	REFERENCES JOGADOR(IDJOGADOR)
);

INSERT INTO JOGADOR VALUES(NULL,'GUERRERO');
INSERT INTO TIMES VALUES(NULL,'FLAMENGO',1);

SHOW CREATE TABLE JOGADOR;
SHOW CREATE TABLE TIMES;

/*-------------------------------------------*/

/* A35 - ORGANIZANDO CHAVES*/

SHOW TABLES;

DROP TABLE ENDERECO;
DROP TABLE TELEFONE;
DROP TABLE CLIENTE;

CREATE TABLE CLIENTE(
	IDCLIENTE INT,
	NOME VARCHAR(30) NOT NULL
);

CREATE TABLE TELEFONE(
	IDTELEFONE INT,
	TIPO CHAR(3) NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_CLIENTE INT
);

ALTER TABLE CLIENTE ADD CONSTRAINT PK_CLIENTE
PRIMARY KEY(IDCLIENTE);

ALTER TABLE TELEFONE ADD CONSTRAINT FK_CLIENTE_TELEFONE
FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(IDCLIENTE);

SHOW CREATE TABLE TELEFONE;

/*------------------------------------*/

/* DICIONARIO DE DADOS */

SHOW DATABASES;

USE INFORMATION_SCHEMA;

STATUS

SHOW TABLES;

DESC TABLE_CONSTRAINTS;

SELECT CONSTRAINT_SCHEMA AS "BANCO",
TABLE_NAME AS "TABELA",
CONSTRAINT_NAME AS "NOME REGRA",
CONSTRAINT_TYPE AS "TIPO"
FROM TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'COMERCIO';

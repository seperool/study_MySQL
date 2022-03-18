/*MODELAGEM BASICA

ENTIDADES = TABELA
CAMPOS  = ATRIBUTOS*/

CLIENTE

NOME - CARACTER (30)
CPF - NUMERICO (11)
EMAIL - CARACTER (30)
TELEFONE - CARACTER (30)
ENDERECO - CARACTER (100)
SEXO - CARACTER (1)

/*PROCESSOS DE MODELANGEM */

/* FASE 01 E FASE 02  - AD ADM DE DADOS
MODELAGEM CONCEITUAL - RASCUNHO
MODELAGEM LOGICA - QUALQUER PROGRAMA DE MODELAGEM*/

/*FASE 03 - DBA / AD
MODELAGEM FISICA*/

/*INICIANDO A MODELAGEM FISICA*/

/*CRIANDO O BANCO DE DADOS*/

CREATE DATABASE PROJETO; /*CRIAÇÃO DO BANCO DE DADOS PROJETO*/

/*CONECTANDO-SE AO BANCO DE DADOS*/

USE PROJETO;

/*VERIFICANDO ONDE ESTOU CONECTADO*/
STATUS;

/*CRIANDO A TABELA CLIENTES*/

CREATE TABLE CLIENTE(
	NOME VARCHAR(30),
	CPF INT (11),
	EMAIL VARCHAR (30),
	TELEFONE VARCHAR (30),
	ENDERECO VARCHAR (100),
	SEXO CHAR(1)

);

/*VERIFICANDO AS TABELAS DO BANCO*/

SHOW TABLES;

/*VERIFICANDO OS BANCO DE DADOS NO SISTEMA*/

SHOW DATABASES;

/*DESCOBRINDO COMO É A ESTRUTURA DE UMA TABELA*/

DESC CLIENTE; 

/*INSERINDO DADOS NA TABELA - INSERT INTO NOME_DA_TABELA*/

/*FORMATO 01 - OMITINDO COLUNAS(CAMPOS)*/

INSERT INTO CLIENTE VALUES ('JOAO',988638273,'JOAO@GMAIL.COM','22923110','MAIA LACERDA - ESTACIO - RIO DE JANEIRO - RJ','M');
INSERT INTO CLIENTE VALUES ('CELIA',541521456,'CELIA@GMAIL.COM','25078869','RIACHUELO - CENTRO - RIO DE JANEIRO - RJ','F');
INSERT INTO CLIENTE VALUES ('JORGE',885755896,NULL,'58748895','OSCAR CURY - BOM RETIRO - PATOS DE MINAS - MG','M');

/*FORMATO 02 - COLOCANDO AS COLUNAS*/

INSERT INTO CLIENTE (NOME,SEXO,ENDERECO, TELEFONE, CPF) VALUES ('LILIAN', 'F','SENADOR SOARES - TIJUCA - RIO DE JANEIRO - RJ','947785696',887774856);

/*FORMATO 03 - INSERT COMPACTO - SOMENTE MYSQL*/

INSERT INTO CLIENTE VALUES ('ANA',85548962,'ANA@GLOBO.COM','548556985','PRES ANTONIO CARLOS - CENTRO - SAO PAULO - SP','F'),
('CARLA',7745828,'CARLA@TERATI.COM','66587458','SAMUEL SILVA - CENTRO - BELO HORIZONTE - MG','F');

/*COMANDO SELECT*/

/*seleção, projeção e junção*/

/*projeção/construção*/

SELECT NOW() AS DATA_HORA, 'SERGIO PEDRO' AS NOME_CLIENTE;

SELECT 'SERGIO PEDRO';

/*seleção*/

SELECT NOME AS CLIENTE, SEXO, EMAIL FROM CLIENTE;

SELECT NOME, SEXO, EMAIL, ENDERECO, NOW() AS HORA FROM CLIENTE;

SELECT * FROM CLIENTE; /*DIMINUI A EFICIENCIA DA PESQUISA*/

/*FILTRANDO DADOS COM WHERE E LIKE*/

/*FILTRANDO*/

SELECT NOME, SEXO FROM CLIENTE
WHERE SEXO = 'M';

SELECT NOME, ENDERECO FROM CLIENTE
WHERE SEXO = 'F';

/*UTILIZANDO LIKE E CARACTER CORINGA*/

/*'%' -> QUALQUER COISA*/
/*'_' -> UM CARACTER DESCONHECIDO */

SELECT NOME, SEXO FROM CLIENTE
WHERE ENDERECO LIKE '%RJ'; /*COMEÇA COM QUALQUER COISA*/

SELECT NOME, SEXO FROM CLIENTE
WHERE ENDERECO LIKE 'OSCAR%'; /*TERMINA COM QUALQUER COISA*/

SELECT NOME, SEXO FROM CLIENTE
WHERE ENDERECO LIKE '%CENTRO%';/*COMEÇA E TERMINA COM QUALQUER COISA*/

/*OPERADORES LOGICOS*/

/*OR - OU*/

SELECT NOME, SEXO, ENDERECO FROM CLIENTE
WHERE
SEXO = 'M' OR ENDERECO LIKE '%RJ';

SELECT NOME, SEXO, ENDERECO FROM CLIENTE
WHERE
SEXO = 'F' OR ENDERECO LIKE '%ESTACIO';


/*AND - E*/

SELECT NOME, SEXO, ENDERECO FROM CLIENTE
WHERE
SEXO = 'M' AND ENDERECO LIKE '%RJ';

SELECT NOME, SEXO, ENDERECO FROM CLIENTE
WHERE
SEXO = 'F' AND ENDERECO LIKE '%ESTACIO';
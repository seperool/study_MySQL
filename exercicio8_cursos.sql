/*AUTORELACIONAMENTO*/

CREATE DATABASE AULA44;

USE AULA44;

CREATE TABLE CURSOS(
IDCURSO INT PRIMARY KEY AUTO_INCREMENT,
NOME VARCHAR(30),
HORAS INT,
VALOR FLOAT(10,2),
ID_PREREQ INT
);

ALTER TABLE CURSOS
ADD CONSTRAINT FK_PREREQ
FOREIGN KEY (ID_PREREQ)
REFERENCES CURSOS (IDCURSO);

/*INSERINDO REGISTROS*/

INSERT INTO CURSOS VALUES
(NULL, "BD RELACIONAL", 20, 400.00,NULL),
(NULL, "BUSINESS INTELLIGENCE", 40, 800.00,1),
(NULL, "RELATORIOS AVANÇADOS", 20, 600.00,2),
(NULL, "LOGICA DE PROGRAMAÇÃO", 20, 400.00,NULL),
(NULL, "RUBY", 30, 500.00,4);

-- VERIFICANDO REGISTROS
SELECT
IDCURSO,
NOME,
HORAS,
VALOR,
IFNULL(ID_PREREQ,"SEM PRE_REQ") AS REQUISITO 
FROM CURSOS;

+---------+-------------------------+-------+--------+-------------+
| IDCURSO | NOME                    | HORAS | VALOR  | REQUISITO   |
+---------+-------------------------+-------+--------+-------------+
|       1 | BD RELACIONAL           |    20 | 400.00 | SEM PRE_REQ |
|       2 | BUSINESS INTELLIGENCE   |    40 | 800.00 | 1           |
|       3 | RELATORIOS AVANÇADOS    |    20 | 600.00 | 2           |
|       4 | LOGICA DE PROGRAMAÇÃO   |    20 | 400.00 | SEM PRE_REQ |
|       5 | RUBY                    |    30 | 500.00 | 4           |
+---------+-------------------------+-------+--------+-------------+

/*RETORNAR O NOME DO PRÉ-REQUISITO DO CURSO AO INVES DO NUMERO*/

SELECT
C.IDCURSO,
C.NOME,
C.HORAS,
C.VALOR,
IFNULL(P.NOME, "SEM PRE_REQ") AS REQUISITO
FROM CURSOS C
LEFT JOIN CURSOS P
ON P.IDCURSO = C.ID_PREREQ;

+---------+-------------------------+-------+--------+-------------------------+
| IDCURSO | NOME                    | HORAS | VALOR  | REQUISITO               |
+---------+-------------------------+-------+--------+-------------------------+
|       1 | BD RELACIONAL           |    20 | 400.00 | SEM PRE_REQ             |
|       2 | BUSINESS INTELLIGENCE   |    40 | 800.00 | BD RELACIONAL           |
|       3 | RELATORIOS AVANÇADOS    |    20 | 600.00 | BUSINESS INTELLIGENCE   |
|       4 | LOGICA DE PROGRAMAÇÃO   |    20 | 400.00 | SEM PRE_REQ             |
|       5 | RUBY                    |    30 | 500.00 | LOGICA DE PROGRAMAÇÃO   |
+---------+-------------------------+-------+--------+-------------------------+

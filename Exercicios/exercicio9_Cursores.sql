/*CURSORES - 
VETORES E MATRIZ 
PARA TRABALHAR COM MANIPULAÇÃO DE REGISTROS*/

CREATE DATABASE CURSORES;

USE CURSORES;

CREATE TABLE VENDEDORES (
IDVENDEDOR INT PRIMARY KEY AUTO_INCREMENT,
NOME VARCHAR(50),
JAN INT,
FEV INT,
MAR INT
);

INSERT INTO VENDEDORES 
VALUES
(NULL,"MAFRA",12548,78542,21547),
(NULL,"CLARA",48784,54654,95621),
(NULL,"JOAO",42658,56314,74125),
(NULL,"LILIAN",36521,41256,32651),
(NULL,"ANTONIO",45612,32165,65214),
(NULL,"GLORIA",78423,96521,75412);

-- CONFERINDO
SELECT * FROM VENDEDORES;

+------------+---------+-------+-------+-------+
| IDVENDEDOR | NOME    | JAN   | FEV   | MAR   |
+------------+---------+-------+-------+-------+
|          1 | MAFRA   | 12548 | 78542 | 21547 |
|          2 | CLARA   | 48784 | 54654 | 95621 |
|          3 | JOAO    | 42658 | 56314 | 74125 |
|          4 | LILIAN  | 36521 | 41256 | 32651 |
|          5 | ANTONIO | 45612 | 32165 | 65214 |
|          6 | GLORIA  | 78423 | 96521 | 75412 |
+------------+---------+-------+-------+-------+

-- PROJEÇÃO (NOME, SOMA, MEDIA)
SELECT 
NOME, 
(JAN+FEV+MAR) AS TOTAL,
(JAN+FEV+MAR)/3 AS MEDIA
FROM VENDEDORES;

+---------+--------+------------+
| NOME    | TOTAL  | MEDIA      |
+---------+--------+------------+
| MAFRA   | 112637 | 37545.6667 |
| CLARA   | 199059 | 66353.0000 |
| JOAO    | 173097 | 57699.0000 |
| LILIAN  | 110428 | 36809.3333 |
| ANTONIO | 142991 | 47663.6667 |
| GLORIA  | 250356 | 83452.0000 |
+---------+--------+------------+

/*ALTERNATIVA USANDO CURSOR*/

-- TABELA PARA GUARDAR O RESULTADO DA PROCEDURE COM CURSOR

CREATE TABLE VEND_TOTAL(
IDVEND_TOTAL INT PRIMARY KEY AUTO_INCREMENT,
IDVENDEDOR INT,
NOME VARCHAR(50),
JAN INT,
FEV INT,
MAR INT,
TOTAL INT,
MEDIA INT
);

-- MONTANDO PROCEDURE (FUNÇÃO) COM CURSOR (VETOR DE REGISTROS)

DELIMITER $

CREATE PROCEDURE INSEREDADOS()
BEGIN
DECLARE FIM INT DEFAULT 0;
DECLARE IDV, VAR1, VAR2, VAR3, VTOTAL, VMEDIA INT;
DECLARE VNOME VARCHAR(50);

DECLARE REG CURSOR FOR (
SELECT 
IDVENDEDOR,
NOME, 
JAN, 
FEV, 
MAR 
FROM VENDEDORES
);

DECLARE CONTINUE HANDLER FOR NOT FOUND SET FIM = 1;

OPEN REG;

REPEAT

FETCH REG INTO IDV, VNOME, VAR1, VAR2, VAR3;

IF NOT FIM THEN
SET VTOTAL = VAR1 + VAR2 + VAR3;
SET VMEDIA = VTOTAL/3;
INSERT INTO VEND_TOTAL VALUES 
(NULL, IDV, VNOME, VAR1, VAR2, VAR3, VTOTAL, VMEDIA);
END IF;

UNTIL FIM END REPEAT;

CLOSE REG;

END
$

DELIMITER ;

-- VERIFICANDO TABELAS

SELECT * FROM VENDEDORES;

+------------+---------+-------+-------+-------+
| IDVENDEDOR | NOME    | JAN   | FEV   | MAR   |
+------------+---------+-------+-------+-------+
|          1 | MAFRA   | 12548 | 78542 | 21547 |
|          2 | CLARA   | 48784 | 54654 | 95621 |
|          3 | JOAO    | 42658 | 56314 | 74125 |
|          4 | LILIAN  | 36521 | 41256 | 32651 |
|          5 | ANTONIO | 45612 | 32165 | 65214 |
|          6 | GLORIA  | 78423 | 96521 | 75412 |
+------------+---------+-------+-------+-------+

SELECT * FROM VEND_TOTAL;
--Empty set (0,00 sec)

-- CHAMANDO A FUNÇÃO
CALL INSEREDADOS();

-- VERIFICANDO A TABELA COM OS RESULTADOS DA PROCEDURE (FUNÇÃO) COM CURSOR

SELECT * FROM VEND_TOTAL;

+--------------+------------+---------+-------+-------+-------+--------+-------+
| IDVEND_TOTAL | IDVENDEDOR | NOME    | JAN   | FEV   | MAR   | TOTAL  | MEDIA |
+--------------+------------+---------+-------+-------+-------+--------+-------+
|            1 |          1 | MAFRA   | 12548 | 78542 | 21547 | 112637 | 37546 |
|            2 |          2 | CLARA   | 48784 | 54654 | 95621 | 199059 | 66353 |
|            3 |          3 | JOAO    | 42658 | 56314 | 74125 | 173097 | 57699 |
|            4 |          4 | LILIAN  | 36521 | 41256 | 32651 | 110428 | 36809 |
|            5 |          5 | ANTONIO | 45612 | 32165 | 65214 | 142991 | 47664 |
|            6 |          6 | GLORIA  | 78423 | 96521 | 75412 | 250356 | 83452 |
+--------------+------------+---------+-------+-------+-------+--------+-------+

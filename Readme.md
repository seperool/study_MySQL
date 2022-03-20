# Objetivo

Estudo dirigido de MySQL.

# Referência

Vídeo aulas “O curso completo de Banco de Dados e SQL, sem mistérios” -
Udemy.

# Módulo 2 - Teoria

## Modelagem

1.  Analise de requisitos  

-   Modelo das necessidades do Cliente, o que é do interesse do cliente
    e o que ele precisa no banco de dados.  
-   Processos a serem controlados pelo sistema.  
-   É uma fase de muita conversa e reunião com o cliente para investigar
    as regras do negocio.  

1.  processos de modelagem  

-   Fases 01 e 02 do projeto de banco de dados são feitos pelo
    administrador de dados:  

    1.  Modelo conceitual  

    -   Rascunho dos requisitos do projeto.  
    -   Desenho conceitual.  
    -   Modelo **entidades-relacionamentos**, define os relacionamentos
        entre os agentes.  

    1.  Modelo lógico  

    -   Coloca os requisitos num programa de diagramas.  
    -   Cria **entidades**, posteriormente serão tabelas.  
    -   Cria **atributos**, posteriormente serão campos, colunas nas
        tabelas.  

-   Fase 03 do projeto de banco de dados é feita tanto pelo
    administrador de bancos de dados(DBA) quanto administrador de
    dados(AD):  

    1.  Modelo físico  

    -   Criando banco de dados.  
        **CREATE DATABASE** *nome_do_banco_de_dados*;  

    -   Conectando-se a um dos banco de dados do sistema.  
        **USE** *nome_do_banco_de_dados*;  

    -   Criando tabela.  
        **CREATE** **TABLE** *nome_da_tabela*(  
        *coluna1* *tipo*(*tamanho*),  
        *coluna2* *tipo*(*tamanho*),  
        …  
        );  

    -   Verificando os banco de dados no sistema.  
        **SHOW DATABASES**;  

    -   Verificando as tabelas do banco de dados.  
        **SHOW TABLES**;  

    -   *Descrevendo* como é a estrutura de uma tabela, verificando
        quais são as colunas.  
        **DESC** *nome_da_tabela*;  

    -   Verificar em qual **DATABASE** esta conectado no momento.  
        **STATUS**;  

    -   Deletando um banco de dados.  
        **DROP** **DATABASE** *nome_do_banco_de_dados*;  

## Tipagem de campos

A tipagem correta diminui o tempo de resposta, otimiza os processos.  

1.  Tipo caracteres  

-   **CHAR**  
    -   Usado quando o numero de caracteres não varia, separa na memoria
        um espaço determinado para ser preenchido.  
-   **VARCHAR**  
    -   Usado quando o numero de caracteres varia, dependendo da entrada
        adapta o espaço separado na memoria para caber os caracters.  

1.  Tipo **ENUM**  

-   Conjunto de dados enumerados, ou seja, um conjunto fixo de dados.  
-   Limita dados em uma coluna, lista de opções.  
-   tipo caracterisco do **MySQL**.  

1.  Tipo numerico  

-   **INT**  
    -   Para numeros inteiros.  
    -   Numero maximo de 11 digitos, para numeros maiores que isso usar
        **VARCHAR**.  
-   **FLOAT**  
    -   Ponto flutuante, ou seja, numeros reais.  
    -   Ao entrar com o valor (em **INSERT**, **UPDATE**, …), usar “.”
        ao inves de “,” para separar as casas decimais.  
    -   Para numeros com casas decimais.  
        **FLOAT**(*total*, *virgula*)  

1.  Para fotos e documentos  

-   **BLOB**  

1.  Tipo textos  

-   **TEXT**  

# Módulo 3 - Comandos

## Inserir registros na tabela - **INSERT**

-   Existem diversas formas de inserir dados na tabela, entre eles
    temos:  
    -   Omitindo colunas/campos.  
        -   Determina apenas a tabela, que puxa todos os campos para
            serem preenchidos, na ordem que aparece na tabela.  
        -   Sintaxe:  
            **INSERT INTO** *nome_da_tabela*  
            **VALUES** (*valor_na_coluna_1*, *valor_na_coluna_2*,…);  
    -   Colocando as colunas. 
        -   Especifica a ordem das entradas e os campos a serem
            preenchidos.  
        -   Sintaxe:  
            **INSERT INTO** *nome_da_tabela*(*coluna_3*, *coluna_1*,
            *coluna_2*,…)  
            **VALUES** (*valor_na_coluna_3*, *valor_na_coluna_1*,…);  
    -   INSERT COMPACTO, somente **MySQL**.  
        -   Insere diversos registros de uma vez, na ordem que aparecem
            na tabela.  
        -   Sintaxe:  
            **INSERT INTO** *nome_da_tabela*  
            **VALUES** (*valor_na_coluna_1\_registro1*,
            *valor_na_coluna_2\_registro1*,…),  
            (*valor_na_coluna_1\_registro2*,
            *valor_na_coluna_2\_registro2*,…),  
            …;  

## Consultando campos na tabela - **SELECT**

-   O comando **SELECT** serve para projeção, seleção e junção.  

-   O comando **SELECT** seleciona os campos/colunas a serem
    mostrados.  

-   Projeta/constroi o que deve ser mostrado, não apenas os dados da
    tabela.

    -   Exemplo de codigo:  
        **SELECT** ‘*SERGIO PEDRO*’ **AS** *MEU_NOME*;  
    -   Sintaxe:  
        **SELECT** ‘*algo a mostrar*’ **AS** *alias_da_coluna*;  

-   Seleciona o que deve ser mostrado da tabela.  

    -   Exemplo de codigo:  
        **SELECT** *NOME*, *SEXO*, *EMAIL*, *ENDERECO* **FROM**
        *CLIENTE*;  
    -   Sintaxe:  
        **SELECT** *coluna_1*, *coluna_6*, *coluna_3*, *coluna_5*
        **FROM** *tabela*;  
    -   Seleciona todas as colunas da tabela:  
        **SELECT** \* **FROM** *tabela*;  
        Obs.: ’\*’, Diminui a eficiencia da pesquisa na tabela.  

## Consultando registros na tabela - **WHERE**

-   O comando **WHERE** serve para filtrar os registros/linhas da
    tabela, antes de mostrar.  

    -   Sintaxe:  
        **SELECT** *coluna_1*, *coluna_2* **FROM** *tabela*  
        **WHERE** *coluna_1* **=** *criterio*;  

-   O comando **WHERE** não precisa ter haver com a seleção
    **SELECT**.  

    -   Sintaxe:  
        **SELECT** *coluna_1*, *coluna_3* **FROM** *tabela*  
        **WHERE** *coluna_2* **=** *criterio*;  

-   Para trabalhar com *strings*, é util usar o comando **LIKE** e os
    *caracteres coringas*.  

    -   Caracteres coringas:  
        -   ‘%’  
            Qualquer coisa.  
        -   ’\_’  
            Um único caracter.  
    -   Sintaxe:  
        **SELECT** *coluna_1*, *coluna_3* **FROM** *tabela*  
        **WHERE** *coluna_2* **LIKE** ‘*string_procurada*’;  
        Obs.: Os caracteres coringas podem entrar em qualquer lugar da
        string para complementar o texto a procurar.  

-   Filtrando valores **NULL**.  

    -   Para filtrar valores **NULL**, basta utilizar o **IS NULL**, ao
        inves de ‘= **NULL**’.  
        -   Sintaxe:  
            **SELECT** *coluna1*, *coluna2*, … **FROM** *tabela*  
            **WHERE** *colunaX* **IS NULL**;  
    -   Para filtrar valores não **NULL**, basta utilizar **IS NOT
        NULL**, ao inves de uma expressão.
        -   Sintaxe:  
            **SELECT** *coluna1*, *coluna2*, … **FROM** *tabela*  
            **WHERE** *colunaX* **IS NOT NULL**;  

# Módulo 5 - Operadores Lógicos, **GROUP BY** e **ORDER BY**

## Operadores Lógicos e Performance de operadores lógicos

-   Operadores lógicos:  
    -   **OR**/OU  
        -   Apenas uma condição precisa ser verdadeira para dar
            verdadeiro.  
        -   Sintaxe:  
            **SELECT** \* **FROM** *tabela*  
            **WHERE** (*condição_1* **OR** *condição_2*);  
    -   **AND**/E  
        -   Todas as condições precisam ser verdadeiras para dar
            verdadeiro.  
        -   Sintaxe:  
            **SELECT** \* **FROM** *tabela*  
            **WHERE** (*condição_1* **AND** *condição_2*);  
    -   **NOT**/negação  
        -   Nega e inverte e inverte o valor de uma expressão.  
        -   Sintaxe:  
            **SELECT** \* **FROM** *tabela*  
            **WHERE** (*condição_1* **AND** **NOT** *condição_2*);  
            Obs.: Inverte o resultado da *condição_2*.  
-   *Tabela verdade*  

<!-- -->

    ##   A NOT_A B NOT_B A_OR_B A_AND_B
    ## 1 V     F V     F      V       V
    ## 2 V     F F     V      V       F
    ## 3 F     V V     F      V       F
    ## 4 F     V F     V      F       F

-   Performance de operadores lógicos.  
    -   Para melhorar a performance das consultas, com operadores
        lógicos, dois casos podem ser avaliados:  
        -   No caso **OR**:  
            -   Colocar a condição que oferece maior incidencia de
                verdadeiro na frente.  
            -   Se a primeira condição é verdadeira, a segunda não é
                avaliada, melhorando assim a performance da consulta.  
        -   No caso **AND**:  
            -   Colocar a condição que oference menor inicidencia de
                verdadeiro na frente.  
            -   Se a primeira condição for falsa, a segunda nem é
                avaliada, pois o resultado é falso. Melhorando assim a
                performance da consulta.  

## Agregador e funções de agregação - **GROUP BY**

-   **COUNT**(\*)  
    -   Conta o numero de registros.  
    -   Sintaxe:  
        **SELECT** **COUNT** (\*) **FROM** *tabela*;  
-   **GROUP BY**  
    -   Agrupa dados em torno de determinado campo.  

    -   Usar em conjunto com funções de agrupamento, como:  

        -   **COUNT** (\*)  
            Conta todos os registros.  

        -   **COUNT** (*coluna_x*)  
            Conta os registros da coluna x.  

        -   **AVG** (*coluna_x*)  
            Calcula a media dos valores da coluna x.  

        -   **MAX** (*coluna_x*)  
            Encontra o valor maximo da coluna x.  

        -   **MIN** (*coluna_x*)  
            Encontra o valor minimo da coluna x.  

        -   **SUM** (*coluna_x*)  
            Calcula a soma dos valores na coluna x.  

    -   Sintaxe:  
        **SELECT** *coluna_x*, **COUNT**(\*) **FROM** *tabela*  
        **GROUP BY** *coluna_x*;  

    -   É possivel agrupar mais de uma coluna de uma vez.  

        -   A ordem em que as colunas aparecem na instrução **GROUP
            BY**, determinam a ordem de prioridade no agrupamento.  
        -   Sintaxe:  
            **SELECT** *coluna1*, *coluna2*,.. **FROM** *tabela*  
            **GROUP BY** *coluna1*, *coluna2*;  
            Obs.: Prioridade primeiro agrupar a *coluna1*, depois
            agrupar em função da *coluna1* a *coluna2*.  

## Ordenando registros - **ORDER BY**

-   **ORDER BY**  
    -   Organiza os dados segundo uma ordem.  

    -   Por default é ordem crescente, **ASC**.  

    -   Para ordem decrescente só adicionar ao final **DESC**.  

    -   Utilizado normalmente ao final de **WHERE** ou **GROUP BY**.  

    -   Ao inves de colocar o nome da coluna, pode indicar a numeração
        da coluna na ordem em que aparece na instrução **SELECT**.  

    -   Sintaxe:  
        **SELECT** *coluna1*, *coluna2*, … **FROM** *tabela*  
        **GROUP BY** *coluna1*  
        **ORDER BY** *coluna2*; (ou **ORDER BY** *2*;)  

    -   Também é possivel colocar em ordem, mais de uma coluna de uma
        vez.  

        -   Sintaxe:  
            **SELECT** *coluna1*, *coluna2*, … **FROM** *tabela*  
            **GROUP BY** *coluna1*  
            **ORDER BY** *coluna2* **ASC**, *coluna1* **DESC**; (ou
            **ORDER BY** *2* **ASC**, *1* **DESC**;)  

# Módulo 7 - Mais comandos **UPDATE** e **DELETE**

## Atualizando registros na tabela - **UPDATE**

-   Atualizar todos os dados de uma coluna/campo de uma tabela, de uma
    vez.  
    -   Para atualizar todos os dados, de uma determinada coluna/campo,
        de uma tabela, para um dado determinado, basta usar **UPDATE**
        sem filtros.  
    -   Muito cuidado ao utilizar esse comando assim, pois pode gerar
        muitos problemas.  
    -   Sintaxe:  
        **UPDATE** *tabela* **SET** *coluna_a\_atualizar* **=**
        *valor_atualizado*;  
-   Para atualizar um determinado registro.  
    -   Para atualizar um determinado dado de uma coluna/campo, utilizar
        o **UPDATE** em conjunto com a instrução **WHERE**.  
    -   Sintaxe:  
        **UPDATE** *tabela* **SET** *coluna_a\_atualizar* **=**
        *valor_atualizado*  
        **WHERE** *condição* **=** *valor*;  
-   Existe como voltar atrás de um **UPDATE**, desfazer um **UPDATE**.  
    -   **COMMIT**  
    -   **ROLLBACK**  

## Deletando registros - **DELETE**

-   Deletar todos os registros de uma tabela.  
    -   Sintaxe:  
        **DELETE** **FROM** *tabela*;  
-   Deletar apenas determinados registros de uma tabela, usar **DELETE**
    em conjunto com filtro **WHERER**.  
    -   Sintaxe:  
        **DELETE** **FROM** *tabela*  
        **WHERE** *criterio_do_que_se_quer_deletar* **=** *valor*;  
-   Dicas:  
    -   Antes de deletar qualquer registro, deve-se conferir atraves de
        uma consulta, se os dados que aparecem são os que querem ser
        deletados.  
        **SELECT** \* **FROM** *tabela*  
        **WHERE** *mesmo_criterio_do_delete* **=** *valor*;  
    -   Contar os registros antes, durante a consulta e depois do
        **DELETE**. Para ter certeza sobre o que foi deletado.  
        **SELECT** **COUNT**(\*) **FROM** *tabela*  
        **WHERE** *mesmo_criterio_do_delete* **=** *valor*;  
        Obs.: Exemplo de consulta de quantos registros devem ser
        deletados.  

# Detalhes

-   ***Comentarios*** no **MySQL**, diferente do **SQL** onde
    comentarios são ’/\*\*/‘, no MySQL é’\#‘. Ou’- -’ para comentario de
    linha.  
-   O que são e o que fazem os administradores:  
    -   Administrador de dados(AD):  
        O Administrador de Dados (AD) tem o objetivo de gerenciar o
        Modelo de Dados Corporativo, contribuindo para assegurar a
        qualidade das informações, a integração dos sistemas, a retenção
        e a disseminação do conhecimento dos negócios.  
        Cabe a ele, guiado por certos princípios e através de atividades
        de planejamento, organização e controle dos dados corporativos,
        gerenciar os dados como recursos de uso comum da organização,
        promovendo-lhes os valores de autenticidade, autoridade,
        precisão, acessibilidade, seguridade e inteligibilidade.  
        Tem como função o planejamento central, a documentação e o
        gerenciamento dos dados a partir da perspectiva de seus
        significados e valores para a organização como um todo.  

    -   Administrador de banco de dados (DBA):  
        O DBA (database administrator), sigla em inglês para
        Administrador de Banco de Dados, é um profissional da área de
        tecnologia responsável pela criação, instalação, monitoramento,
        reparos e análise de estruturas de um banco de dados.  
        O banco de dados fica sob análise periódica do DBA, que trabalha
        para que não haja sobrecargas do sistema e que as informações
        inseridas tenham destino correto nos servidores. Outras funções
        também importantes são analisar o espaço em disco, buscar
        melhorias para os sistemas e realizar backups.  
-   Acesso ao **MySQL** pelo terminal é necessario usar o comando:  
    mysql -u root -p  
    -   Depois colocar a senha.  
-   Ao final dos comandos do **SQL** e do **MySQL**, usar o
    ‘;’(delimitador), ele informa que o comando acabou e deve ser
    executado.

# Andamento dos Estudos

## Assunto em andamento:

Atualmente estou estudando Seção 8.  

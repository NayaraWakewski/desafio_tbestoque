----UMA DAS SOLUÇÕES FOI CRIAR UM BANCO DE DADOS DIMENSIONAL, PARA AGILIDADE NAS CONSULTAS----

----dim_produto----

----Criação----
CREATE TABLE dw.dim_produto AS
SELECT DISTINCT
    produto_id,
     nome_produto,
     categoria_produto
FROM public.tbestoque
WHERE 1 = 1;

---- Consulta-----
SELECT *
FROM dw.dim_produto;


----dim_fornecedor----

----Criação----
CREATE TABLE dw.dim_fornecedor AS
SELECT DISTINCT
    fornecedor_id,
    nome_fornecedor,
    endereco_fornecedor,
    telefone_fornecedor
FROM public.tbestoque
WHERE 1 = 1;

---- Consulta-----
SELECT *
FROM dw.dim_fornecedor;


----dim_loja----

----Criação----
CREATE TABLE dw.dim_loja AS
SELECT DISTINCT
    loja_id,
    nome_loja,
    endereco_loja,
    cidade_loja
FROM public.tbestoque
WHERE 1 = 1;

---- Consulta-----
SELECT *
FROM dw.dim_loja;



-------Criação da dim_data------


---------função para alterar os nomes em inglês para português------

CREATE OR REPLACE FUNCTION mes_nome_pt(data date)
  RETURNS TEXT AS $$
DECLARE
  meses TEXT[] := ARRAY['Janeiro', 'Fevereiro', 'Marco', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'];
BEGIN
  RETURN meses[EXTRACT(MONTH FROM data)];
END;
$$ LANGUAGE plpgsql;

---------depois criar a tabela data---------
 
CREATE TABLE dw.dim_data AS
SELECT DISTINCT 
       to_date(data_estoque::text, 'YYYY')                          AS Data
     , EXTRACT(DAY FROM CURRENT_DATE)                               AS Dia
     , EXTRACT(WEEK FROM CURRENT_DATE)                              AS Semana
     , EXTRACT(MONTH FROM to_date(data_estoque::text, 'YYYY'))      AS Mês
     , to_char(to_date(data_estoque::text, 'YYYY'), 'Month')        AS MêsNome
     , CEILING(date_part('month', to_date(data_estoque::text, 'YYYY')) / 2.0)::integer AS bimestre
     , CEILING(date_part('month', to_date(data_estoque::text, 'YYYY')) / 3.0)::integer AS trimestre
     , CEILING(date_part('month', to_date(data_estoque::text, 'YYYY')) / 6.0)::integer AS semestre
     , EXTRACT(YEAR FROM to_date(data_estoque::text, 'YYYY'))       AS Ano
  FROM public.tbestoque
 WHERE 1 = 1
 ORDER BY 1;

----consulta----
 SELECT * FROM dw.dim_data 


----fato_estoque----

----Criação----
CREATE TABLE dw.fato_estoque AS
SELECT DISTINCT
    produto_id,
    preco_produto,
    fornecedor_id,
    loja_id,
    quantidade_estoque,
    data_estoque
FROM public.tbestoque
WHERE 1 = 1;

---- Consulta-----
SELECT *
FROM dw.fato_estoque;

-----CONSULTANDO A TABELA-------
SELECT * FROM tbestoque

----CONSULTANDO A TABELA DE FORMA GERAL-----

SELECT * FROM information_schema.columns WHERE table_name = 'tbestoque' ORDER BY column_name ASC;

----CONSULTANDO NULOS-----


DO
$$
DECLARE
    coluna record;
    consulta_sql text;
    resultado integer;
BEGIN
    FOR coluna IN (
        SELECT column_name
        FROM information_schema.columns
        WHERE table_name = 'tbestoque'
    )
    LOOP
        consulta_sql := 'SELECT COUNT(*) AS ' || coluna.column_name || '_nulos FROM tbestoque WHERE ' || coluna.column_name || ' IS NULL';
        EXECUTE consulta_sql INTO resultado;
        RAISE NOTICE 'Coluna %: % nulos', coluna.column_name, resultado;
    END LOOP;
END;
$$

---RESULTADO A TABELA NÃO TEM VALORES NULOS-----


--NOTICE:  Coluna produto_id: 0 nulos
--NOTICE:  Coluna preco_produto: 0 nulos
--NOTICE:  Coluna fornecedor_id: 0 nulos
--NOTICE:  Coluna loja_id: 0 nulos
--NOTICE:  Coluna quantidade_estoque: 0 nulos
--NOTICE:  Coluna data_estoque: 0 nulos
--NOTICE:  Coluna endereco_fornecedor: 0 nulos
--NOTICE:  Coluna telefone_fornecedor: 0 nulos
--NOTICE:  Coluna cidade_loja: 0 nulos
--NOTICE:  Coluna nome_produto: 0 nulos
--NOTICE:  Coluna categoria_produto: 0 nulos
--NOTICE:  Coluna nome_loja: 0 nulos
--NOTICE:  Coluna endereco_loja: 0 nulos
--NOTICE:  Coluna nome_fornecedor: 0 nulos
--DO

--Query returned successfully in 69 msec.
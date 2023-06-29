------INSIGHTS ESTRATÉGICOS

----TOTAL DE PRODUTOS EM ESTOQUE POR CATEGORIA----

SELECT dp.nome_produto, dp.categoria_produto, SUM(fe.quantidade_estoque) AS total_estoque
FROM dw.fato_estoque fe
JOIN dw.dim_produto dp ON dp.produto_id = fe.produto_id
GROUP BY dp.nome_produto, dp.categoria_produto;

---- NESSE INSIGHT PODE AVALIAR QUAIS CATEGORIAS DE PRODUTO POSSUEM MAIS ESTOQUE E QUAIS ESTÃO COM BAIXA---
----PARA MELHOR AVALIAÇÃO DE QUAIS PRODUTOS MAIS VENDEM OU MENOS VENDEM, SERIA NECESSÁRIO ACESSO AS INFORMAÇÕES DE VENDA---
----NO CASO A CATEGORIA 1 TEM QUANTIDADE 0 DE ESTOQUE----


-----LISTA DE PRODUTOS COM ESTOQUE BAIXO----

SELECT dp.nome_produto, fe.quantidade_estoque
FROM dw.fato_estoque fe
JOIN dw.dim_produto dp ON dp.produto_id = fe.produto_id
WHERE fe.quantidade_estoque < 1;

----QUAIS PRODUTOS ESTÃO COM ESTOQUE ZERADO E SE FAZ NECESSÁRIO COMPRAR PARA REPOSIÇÃO---
----AQUI PRECISA ANALISAR AS VENDAS PARA VERIFICAR O MOTIVO DE NÃO TER ESTOQUE, SE FORAM PRODUTOS DESCONTINUADOS NAS VENDAS,---
----OU SE SÃO PRODUTOS QUE VENDEM MUITO-----


----- TOTAL DE PRODUTO EM ESTOQUE POR CIDADE----

SELECT dl.cidade_loja, SUM(fe.quantidade_estoque) AS total_estoque
FROM dw.fato_estoque fe
JOIN dw.dim_loja dl ON dl.loja_id = fe.loja_id
GROUP BY dl.cidade_loja;

----AQUI VERIFICAR A QUANTIDADE DE PRODUTOS ESTOCADOS POR LOJA E CIDADE, PARA ANALISAR QUAIS LOJAS MAIS POSSUEM PRODUTOS PARADOS---
---OU NECESSITAM DE REPOSIÇÃO.


----TOP 5 FORNECEDORES----

SELECT df.nome_fornecedor, SUM(fe.preco_produto * fe.quantidade_estoque) AS valor_total_estoque
FROM dw.fato_estoque fe
JOIN dw.dim_fornecedor df ON df.fornecedor_id = fe.fornecedor_id
GROUP BY df.nome_fornecedor
ORDER BY valor_total_estoque DESC
LIMIT 5;

---ESSA CONSULTA IRÁ RETORNAR OS 5 FORNECEDORES QUE POSSUEM O MAIOR VALOR TOTAL DE ESTOQUE.


-----VARIAÇÃO DO ESTOQUE POR DATA----


SELECT data_estoque, SUM(quantidade_estoque) AS total_estoque
FROM public.fato_estoque
GROUP BY data_estoque;

---PERMITI AVALIAR A VARIAÇÃO DO ESTOQUE POR DATA----

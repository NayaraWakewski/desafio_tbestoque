![texto alt](https://digitalcollege.com.br/wp-content/webp-express/webp-images/uploads/2022/05/logo-digital.png.webp)


# ODISSEIA EMPRESA Z

Este é um repositório com a solução para a lentidão do banco de dados da Empresa Z e apresentar insigths estratégicos para o negócio.


## 🚀 Começando

Neste projeto, realizamos a análise de dados; O objetivo é extrair insights relevantes a partir desses dados.

> **Foi dividida a análise em 4 etapas:**

1. **Restauração do Banco de Dados**: Nesta etapa, restauramos o banco de dados, disponibilizado, no programa PostgreSQL.

2. **Análise Exploratória SQL**: Nesta etapa, realizamos uma análise exploratória dos dados para obter uma compreensão inicial do conjunto de dados. Utilizamos consultas dinamicas e e funções em SQL para identificar padrões e valores nulos.

4. **Trasformação SQL**: Após a análise exploratória, fizemos a modelagem dimensional, com base na tabela do banco relacional e após isso criamos o banco de dados dimensional, juntamente com as tabelas dimensões e fato.

4. **Medidas SQL**: Após a criação do banco dimensional, começamos a criar as medidas, afim de trazer insights valiosos para o negócio. 

5. **Visualização dos Dados**: A visualização de dados desempenha um papel importante na comunicação dos resultados da análise. Utilizamos gráficos e visualizações interativas para apresentar os insights obtidos de forma clara e compreensível, utilizando a ferramenta PowerBI.

Ao seguir essas etapas, buscamos obter uma compreensão aprofundada dos dados de estoque da EMPRESA Z, afim de encontrar soluções eficientes e insights estratégicos.


### 🛠️ Instalação/Ferramentas

> **Para elaboração do Projeto utilizamos as seguintes ferramentas:**

- **Visual Studio Code** - utilizado para organizar as etapas do projeto, testar as query em Sql e fazer o projeto em Python.
- **Postgres Sql** - Banco de Dados utilizado para restauração e manipulação.
- **PowerBi** - Ferramenta utilizada para visualização das análises.
- **Github** - Plataforma de hospedagem de código, que utilizamos para subir o projeto.


## ⚙️ Exemplo de querys SQL do Projeto:

- **Analise do Banco - Consulta Dinâmica Nulos**

```sql
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

```

- **Transformação e Tratamento**

```sql
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

```

- **Medidas**

```sql
----TOTAL DE PRODUTOS EM ESTOQUE POR CATEGORIA----

SELECT dp.nome_produto, dp.categoria_produto, SUM(fe.quantidade_estoque) AS total_estoque
FROM dw.fato_estoque fe
JOIN dw.dim_produto dp ON dp.produto_id = fe.produto_id
GROUP BY dp.nome_produto, dp.categoria_produto;
```

## :bar_chart: Dataviz

Para visualizar o dashboard do projeto, acessar o link abaixo:

https://app.powerbi.com/view?r=eyJrIjoiODA2ZTFkNzctMDk5ZS00MmRkLWFkNmMtZGRhNGMzNTQ4ZWFmIiwidCI6ImJkMWMxZTAzLTU2MDMtNDUzNy04ODY5LWQ5ZGQyYzRiMjc2MiJ9



## 🎁 Expressões de gratidão

* Compartilhe com outras pessoas esse projeto 📢;
* Quer saber mais sobre o projeto? Entre em contato para tomarmos um :coffee:;

---
⌨️ com ❤️ por [Nayara Vakevskii](https://github.com/NayaraWakewski) 😊

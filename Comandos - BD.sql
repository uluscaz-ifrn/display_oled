create table Clima (
	cidade varchar(80),
	temp_lo int,
	temp_hi int,
	prcp real,
	data date
);

insert into Clima (cidade, temp_lo, temp_hi, prcp, data)
	values ('Caíco', 30, 45, 0, CURRENT_TIMESTAMP);

select * from Clima;

-- CREATE TABLE Produto(
-- 	produto_num int,
-- 	nome text,
--  preco numeric default 1.99 -- Valor definido, caso o usuário não informe um valor
--  preco numeric check(preco > 0) -- Verifica se o preço que o usuário informou é maior que 0
-- 	preco numeric CONSTRAINT preco_positivo check (preco > 0) -- Define um nome (preco_positivo) para ficar identificado no campo
-- );

create table Produto(
	-- produto_num integer not null unique,
	produto_num integer PRIMARY KEY,
	nome text not null unique,
	preco numeric not null CONSTRAINT preco_positivo check (preco>0),
	preco_desconto numeric CONSTRAINT preco_desconto_positivo check (preco_desconto>0),
	CONSTRAINT desconto_valido check (preco>preco_desconto)
);

SELECT * FROM produto;

insert into public.produto (produto_num, nome, preco, preco_desconto)
	values (1, 'Laser', 10, 9);

-- Adiciona uma coluna na tabela:
-- alter table nome_da_tabela add column nome_da_coluna;

-- Remove uma coluna da tabela:
-- alter table nome_da_tabela drop COLUMN nome_da_coluna;

-- Adiciona uma restrição em uma tabela:
-- alter table nome_da_tabela add check (condicao);
-- alter table nome_da_tabela add constraint nome_da_restricao UNIQUE (nome_do_campo);
-- alter table nome_da_tabela add foreign key(nome_da_coluna) references nome_da_tabela_de_referencia(nome_da_coluna_de_referencia)

-- Restrição com NOT NULL:
-- alter table nome_da_tabela alter column nome_da_coluna SET NOT NULL;

-- Remover restrição:
-- alter table nome_da_tabela drop constraint nome_da_coluna;

-- Remover restrição (com NOT NULL):
-- alter table nome_da_tabela alter column nome_da_coluna drop NOT NULL;

-- Definir um valor padrão na coluna:
-- alter table nome_da_tabela alter column nome_da_coluna set default valor_padrao;

-- Remover valor padrão:
-- alter table nome_da_tabela alter column nome_da_coluna drop default;

-- Modificar tipo de dado de uma coluna:
-- alter table nome_da_tabela alter column nome_da_coluna type tipo_dado;

-- Inserir dados em uma tabela:
-- insert into nome_da_tabela(conjunto_de_campos) values(valores_dos_campos);

-- Consultar dados de uma tabela:
-- select lista_projecao from nome_tabela[filtro][ordenacao]

-- Filtrar dados de um select:
-- 1) WHERE
-- 2) GROUP BY
-- 3) HAVING
-- 4) ORDER BY

-- Indiferença de string:
-- ilike

-- BETWEEN - Buscar valores entre:
-- select * from nome_tabela where nome_campo between valor_inicial and valor_final;

-- Funções de agregações:
-- AVG(): Retorna a média
-- COUNT(): Retorna o número de linhas
-- MAX(): Retorna o maior valor
-- MIN(): Retorna o menor valor
-- SUM(): Retorna a soma dos valores
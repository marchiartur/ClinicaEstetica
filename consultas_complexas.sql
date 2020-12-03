-- 1: listar todos os produtos comprados por clientes no mês de novembro de 2020
select * 
from produtos p 
where p.id in(
	select lv.id_produto
	from lotes_venda lv
	where lv.id_pedido_venda in(
		select pv.id
		from pedidos_vendas pv
		where pv.data_pedido >= '2020-11-01' and pv.data_pedido <= '2020-11-30'
	)
);

-- 2: listar os clientes que possuem horários no mês de novembro de 2020 que iniciam antes das 14 horas
select * 
from clientes c 
where c.id in(
	select h.id
    from horarios h
    where (datediff(h.data_inicio, '2020-11-01') > -1 and datediff(h.data_inicio, '2020-11-01') < 30) and timediff('14:00:00', h.data_inicio) > 0
);

-- 3: listar os funcionarios do sexo feminino que possuem salario menor que 1000 
select * 
from funcionarios f
where f.salario < 1000 and f.id in(
	select p.id
    from pessoas p
    group by p.sexo = 'F'
);

-- 4: listar os funcionarios que realizaram vendas com desconto
select * 
from funcionarios f 
where f.id in(
	select pv.id_funcionario
	from pedidos_vendas pv
    where pv.desconto > 0 and pv.id_funcionario = f.id
);
select * from categorias_servicos;

-- 5: liste os funcionarios que tem a especialização = 'Maquiagem' e possuem um salário maior que 1000
select * 
from funcionarios f 
where f.id in(
	select cs.id
    from categorias_servicos cs
    where cs.nome = 'Maquiagem' and salario > 1000
);

-- 6: o funcionario mais experiente em alguma categoria
select *
from funcionarios f, categorias_servicos cs
order by cs.iniciou_em
limit 1;

-- 7: mostre a quantidade de clientes que fizeram pedidos de produtos
select count(*)
from clientes c
where c.id in (
	select pv.id_cliente
    from pedidos_vendas pv
);

-- 8: liste os fornecedores que realizaram venda para a clinica = 'Estética Bem Estar'
select *
from fornecedores f
where f.cnpj in(
	select pc.cnpj_fornecedor
    from pedidos_compras pc
    where pc.id_clinica in (
		select cs.id 
        from clinicas_esteticas cs
        where cs.nome = 'Estética Bem Estar'
    )
);

-- 9: selecionar os produtos que terminam com a letra o que estão no mesmo estoque e que possuem o mesmo preço de custo
select * 
from produtos p
where p.nome like "%o" 
group by p.preco_de_custo;

-- 10: selecionar os fornecedores que fizeram uma venda
select *
from fornecedores f
where f.cnpj in(
	select pc.cnpj_fornecedor
    from pedidos_compras pc 
    where f.cnpj = pc.cnpj_fornecedor
);

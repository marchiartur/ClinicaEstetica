use clinica_estetica;

drop table if exists lotes_compra;
drop table if exists lotes_venda;
drop table if exists pedidos_vendas;
drop table if exists pedidos_compras;
drop table if exists produtos;
drop table if exists estoques;
drop table if exists fornecedores;
drop table if exists categorias_servicos;
drop table if exists horarios;
drop table if exists agendas;
drop table if exists funcionarios;
drop table if exists clientes;
drop table if exists pessoas;
drop table if exists clinicas_esteticas;

create table if not exists clinicas_esteticas (
	id int primary key,
	nome varchar(255) not null,
    telefone varchar(20) not null
);

create table if not exists pessoas (
	id int primary key,
    nome varchar(255) not null,
    telefone varchar(20) not null,
    id_clinica_estetica int not null,
    foreign key(id_clinica_estetica) references clinicas_esteticas(id) on delete cascade
);

create table if not exists clientes(
	id int primary key,
    status_cliente int not null,
    sexo int not null,
    id_pessoa_cliente int not null,
	foreign key(id_pessoa_cliente) references pessoas(id) on delete cascade
);

create table if not exists funcionarios(
	id int primary key,
    endereco varchar(255),
    salario float,
	id_pessoa_funcionario int not null,
	foreign key(id_pessoa_funcionario) references pessoas(id) on delete cascade
);

create table if not exists categorias_servicos(
	id int primary key,
    nome varchar(255) not null,
    iniciou_em date not null,
    id_funcionario_especializado int not null,
	foreign key(id_funcionario_especializado) references funcionarios(id) on delete cascade
);

create table if not exists agendas(
	id int primary key,
    id_funcionario int not null,
    foreign key(id_funcionario) references funcionarios(id) on delete cascade
);

create table if not exists horarios(
	id int primary key,
    data_inicio datetime not null,
    data_fim datetime not null,
    id_cliente int not null,
    id_agenda int not null,
    foreign key(id_cliente) references clientes(id) on delete cascade,
    foreign key(id_agenda) references agendas(id)
);

create table if not exists estoques(
    id int primary key,
    id_clinica_estetica int,
    foreign key (id_clinica_estetica) references clinicas_esteticas(id) on delete cascade
);

create table if not exists produtos(
	id int primary key,
    nome varchar(255) not null,
    preco_de_custo float not null,
    preco_de_venda float not null,
    quantidade int not null,
    id_estoque int,
    foreign key (id_estoque) references estoques(id)
);

create table if not exists fornecedores(
    cnpj varchar(18) primary key,
    nome_fantasia varchar(255) not null,
    telefone varchar(20) not null
);

create table if not exists pedidos_compras(
	id int primary key,
    data_pedido date not null,
    preco_final float not null,
    cnpj_fornecedor varchar(18),
    foreign key (cnpj_fornecedor) references fornecedores(cnpj)
);

create table if not exists pedidos_vendas(
	id int primary key,
    data_pedido date not null,
    preco_final float not null,
    desconto float not null,
	id_cliente int,
    id_funcionario int,
    foreign key (id_cliente) references clientes(id),
    foreign key (id_funcionario) references funcionarios(id)
);

create table if not exists lotes_venda(
	id int primary key,
    quantidade int not null,
    id_produto int,
    id_pedido_venda int,
    foreign key(id_produto) references produtos(id),
    foreign key(id_pedido_venda) references pedidos_vendas(id)
);

create table if not exists lotes_compra(
	id int primary key,
    quantidade int not null,
    id_produto int,
    id_pedido_compra int,
    foreign key(id_produto) references produtos(id),
    foreign key(id_pedido_compra) references pedidos_compras(id)
);


select * from pedidos_compras;


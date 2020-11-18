use clinica_estetica;

drop table if exists pedidos_vendas;
drop table if exists pedidos_compras;
drop table if exists lotes;
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
    id_estoque int,
    foreign key (id_estoque) references estoques(id)
);

create table if not exists fornecedores(
    cnpj varchar(18) primary key,
    nome_fantasia varchar(255) not null,
    telefone varchar(20) not null
);

create table if not exists lotes(
	id int primary key,
    id_produto int,
    foreign key(id_produto) references produtos(id)
);

create table if not exists pedidos_compras(
	id int primary key,
    data_pedido date not null,
    preco_final float not null,
    cnpj_fornecedor varchar(18),
    id_lote int,
    foreign key (cnpj_fornecedor) references fornecedores(cnpj),
    foreign key (id_lote) references lotes(id)
);

create table if not exists pedidos_vendas(
	id int primary key,
    data_pedido date not null,
    preco_final float not null,
    desconto float not null,
	id_cliente int,
    id_funcionario int,
    id_lote int,
    foreign key (id_cliente) references clientes(id),
    foreign key (id_funcionario) references funcionarios(id),
    foreign key (id_lote) references lotes(id)
);

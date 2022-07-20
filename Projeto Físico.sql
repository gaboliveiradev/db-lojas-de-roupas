CREATE DATABASE EtecStore_DB;
USE EtecStore_DB;

CREATE TABLE Endereco (
    id int auto_increment,
    nome_endereco varchar(100) NOT NULL,
    cep char(8) NOT NULL,
    bairro varchar(50) NOT NULL,
    cidade varchar(32) NOT NULL,
    numero varchar(10) NOT NULL,
    primary key (id)
);

CREATE TABLE Cliente (
    id int auto_increment,
    nome varchar(150) NOT NULL,
    rg varchar(10) NOT NULL, -- 8 digitos, mas como cada estado pode emitir seu RG e não existe um padrão muito certo. 
    cpf char(11) NOT NULL,
    data_nasc varchar(10) NOT NULL, -- 20/10/2021 => 10 // 20102021 => 8
    genero varchar(9) NOT NULL,
    id_endereco int NOT NULL,
    primary key (id),
    foreign key (id_endereco) references Endereco(id)
);

CREATE TABLE Funcionario (
    id int auto_increment,
    nome varchar(150) NOT NULL,
    genero varchar(9) NOT NULL,	-- Feminino // Masculino // Outro
    telefone varchar(9) NOT NULL, -- 981062041 // 36623528
    cpf char(11) NOT NULL,
	cargo varchar(40) NOT NULL,
    id_endereco int NOT NULL,
    primary key (id),
    foreign key (id_endereco) references Endereco(id)
);

CREATE TABLE Fornecedor (
    id int auto_increment,
    nome varchar(150) NOT NULL,
    cnpj char(14) NOT NULL, -- Um CNPJ tem 14 digitos
    email varchar(150) NOT NULL,
    telefone varchar(9) NOT NULL,
    id_endereco int NOT NULL,
    primary key (id),
    foreign key (id_endereco) references Endereco(id)
);

CREATE TABLE Compra (
    id int auto_increment,
    nome varchar(40) NOT NULL,
    valor double NOT NULL,
    quantidade int NOT NULL,
    data_compra TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_fornecedor int NOT NULL,
    primary key (id),
    foreign key (id_fornecedor) references Fornecedor(id)
);

CREATE TABLE Produto (
    id int auto_increment,
    nome varchar(100) NOT NULL,
    valor double NOT NULL,
    marca varchar(50) NOT NULL,
    quantidade int NOT NULL,
    id_fornecedor int NOT NULL,
	id_categoria int NOT NULL,
    primary key (id),
    foreign key (id_fornecedor) references Fornecedor(id)
	foreign key (id_categoria) references Categoria(id)
);

CREATE TABLE Venda (
    id int auto_increment,
    quantidade_produto int NOT NULL,
    data_venda TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valor_total double NOT NULL,
    id_cliente int NOT NULL,
    id_produto int NOT NULL,
    id_funcionario int NOT NULL,
    primary key (id),
    foreign key (id_cliente) references Cliente(id),
    foreign key (id_produto) references Produto(id),
    foreign key (id_funcionario) references Funcionario(id)
);

CREATE TABLE Venda_Produto_Assoc (
    id_venda int NOT NULL,
    id_produto int NOT NULL,
    primary key (id_venda, id_produto),
    foreign key (id_venda) references Venda(id),
    foreign key (id_produto) references Produto(id)
);

CREATE TABLE Compra_Fornecedor_Assoc (
    id_compra int NOT NULL,
    id_fornecedor int NOT NULL,
    primary key (id_compra, id_fornecedor),
    foreign key (id_compra) references Compra(id),
    foreign key (id_fornecedor) references Fornecedor(id)
);

CREATE TABLE Produto_Fornecedor_Assoc (
    id_produto int NOT NULL,
    id_fornecedor int NOT NULL,
    primary key (id_produto, id_fornecedor),
    foreign key (id_produto) references Produto(id),
    foreign key (id_fornecedor) references Fornecedor(id)
);
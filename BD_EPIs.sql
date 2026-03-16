CREATE DATABASE IF NOT EXISTS Sistema_EPI;
USE Sistema_EPI;

CREATE TABLE setor (
    id_Setor int auto_increment PRIMARY KEY,
    nome_setor VARCHAR(80),
    RESPONSAVEL varchar(80),
    localizacao varchar(100)
);

CREATE TABLE fornecedor (
    id_fornecedor int auto_increment primary key,
    nome_fornecedor VARCHAR(80),
    Custo_EPI_X int,
    cnpj CHAR(14) unique
);

CREATE TABLE EPI (
    id_EPI int auto_increment primary key,
    nome_EPI VARCHAR(80),
    custo_EPI REAL,
    setor_uso varchar(80),
    data_validade Date,
    codigo_CA int,
    foreign key (id_setor) references setor (id_setor)
);

CREATE TABLE almoxarifado(
    id_almoxarifado int auto_increment primary key,
    nome varchar(80),
    cpf VARCHAR(11) unique, 
    Setor_professor varchar(80),
    EPIs_ultilizados varchar(80)
);

CREATE TABLE professor(
    id_professor int auto_increment primary key,
    nome varchar(80),
    cpf VARCHAR(11) unique, 
    EPIs_ultilizados varchar(80),
    foreign key (id_setor) references setor (id_setor)
);

CREATE TABLE funcionario(
    id_funcionario int auto_increment primary key,
    nome varchar(80),
    cpf VARCHAR(11) unique,
    EPIs_necessarios varchar(80),
	foreign key (id_setor) references setor (id_setor)
);

CREATE TABLE aluno(
    id_aluno int auto_increment primary key,
    nome varchar(80),
    cpf CHAR(11) unique not null,  
    EPIs_liberados varchar(80),
    foreign key (id_setor) references setor (id_setor)
);

CREATE TABLE entrega_EPI(
    id_entrega int auto_increment primary key,
    data_de_retirada datetime,
    setor_retirada varchar(80),
    id_EPI int,
    id_professor int,
    id_aluno int,
    autorização boolean default false,
    foreign key (id_EPI) references EPI (id_EPI),
    foreign key (id_professor) references professor (id_professor),
    foreign key (id_aluno) references aluno (id_aluno)
);

CREATE TABLE insepecao_EPI(
    id_inspecao int auto_increment primary key,
    data_inspecao date,
    resultado bool,
     foreign key (id_EPI) references EPI (id_EPI),
    foreign key (id_professor) references professor (id_professor),
    foreign key (id_aluno) references aluno (id_aluno),
     foreign key (id_EPI) references EPI (id_EPI),
    foreign key (id_professor) references professor (id_professor),
    foreign key (id_funcionario) references funcionario (id_funcionario)
);

Alter table funcionarios ADD email Varchar(30);

create index dt_entrega on entrega_EPI (data_de_retirada);

DESC setor;
DESC fornecedor;
DESC EPI;
DESC almoxarifado;
DESC professor;
DESC funcionario;
DESC aluno;
DESC entrega_EPI;
DESC inspecao_EPI;

INSERT INTO funcionarios ( nome, cpf, id_setor)
VALUES 
('Henrique de Paula', '11122233344', 1),
('Joao da Silva', '22233344455', 2),
('Jeguelson Pereira', '33344455566', 3),
('Napoleao Bonaparte', '44455566677', 4),
('Agricola Beterraba Areia' '55566677788', 5);

INSERT INTO EPI (nome_EPI, custo_EPI, data_validade, codigo_CA)
VALUES
('Oculos de protecao', '29.9', '2026-03-20', '20'),
('Bota bico de ferro', '129.9', '2027-08-12', '21') ,
('Luva anti-corte', '49,9', '2026-09-19', '22'),
('capacete de protecao','89.9', '2027-02-29', '23'),
('protetor auricular', '14.9', '2026-12-20', '24'),
('respirador tinta', '69,9', '2027-01-19', '25');
 







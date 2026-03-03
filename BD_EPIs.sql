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
    Custo_EPI int,
    Setor_uso varchar(80),
    data_validade Date,
    Codigo_CA int
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
    Setor_professor varchar(80),
    EPIs_ultilizados varchar(80)
);

CREATE TABLE funcionario(
    id_funcionario int auto_increment primary key,
    nome varchar(80),
    cpf VARCHAR(11) unique, 
    Setor_funcionario varchar(80),
    EPIs_ultilizados varchar(80)
);

CREATE TABLE aluno(
    id_aluno int auto_increment primary key,
    nome varchar(80),
    cpf CHAR(11) unique not null,  
    Setor_aluno Varchar(80),
    EPIs_liberados varchar(80)
);

CREATE TABLE Retirada_EPI(
    id_retirada int auto_increment primary key,
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
insert into aluno ( nome_aluno, cpf, setor_aluno, EPIs_liberados, telefone, idade) values ('henrique','12345674911', 'ADS', 'oculos de proteção', '1999999999', '18' ),
('Alex','25445568932', 'ADS', 'Chinelo', '1999999988', '17' ), ('jueguelson','25445899932', 'ADS', 'mascara', '1999999888', '19' );
select * from aluno where idade >= 18;
alter table aluno add idade int;
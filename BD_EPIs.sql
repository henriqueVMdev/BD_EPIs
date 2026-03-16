CREATE DATABASE IF NOT EXISTS Sistema_EPI;
USE Sistema_EPI;

CREATE TABLE setor (
    id_setor int auto_increment PRIMARY KEY,
    nome_setor VARCHAR(80),
    bloco varchar(10)
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
    estoque_EPI INT(4),
    custo_EPI REAL,
    setor_uso varchar(80),
    data_validade Date,
    codigo_CA int,
    id_setor INT,
    foreign key (id_setor) references setor (id_setor) ON DELETE RESTRICT
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
    id_setor INT,
    foreign key (id_setor) references setor (id_setor) ON DELETE RESTRICT
);

CREATE TABLE funcionario(
    id_funcionario int auto_increment primary key,
    nome varchar(80),
    cpf VARCHAR(11) unique,
    EPIs_necessarios varchar(80),
    id_setor INT,
	foreign key (id_setor) references setor (id_setor) ON DELETE RESTRICT
);

CREATE TABLE aluno(
    id_aluno int auto_increment primary key,
    nome varchar(80),
    cpf CHAR(11) unique not null,  
    EPIs_liberados varchar(80),
    id_setor INT,
    foreign key (id_setor) references setor (id_setor) ON DELETE RESTRICT
);

CREATE TABLE entrega_EPI(
    id_entrega int auto_increment primary key,
    data_entrega datetime,
    setor_entrega varchar(80),
    autorização boolean default false,
    id_EPI INT,
    id_professor INT,
    id_aluno INT,
    id_funcionario INT,
    foreign key (id_EPI) references EPI (id_EPI),
    foreign key (id_professor) references professor (id_professor) ON DELETE RESTRICT,
    foreign key (id_aluno) references aluno (id_aluno) ON DELETE RESTRICT,
    foreign key (id_funcionario) references funcionario (id_funcionario) ON DELETE RESTRICT
);

CREATE TABLE devolucao_EPI(
    id_devolucao int auto_increment primary key ,
    data_devolucao date,
    setor_devolucao varchar(80),
    autorização boolean default false,
    id_EPI INT,
    id_professor INT,
    id_aluno INT,
    foreign key (id_EPI) references EPI (id_EPI) ON DELETE RESTRICT,
    foreign key (id_professor) references professor (id_professor) ON DELETE RESTRICT,
    foreign key (id_aluno) references aluno (id_aluno) ON DELETE RESTRICT
);


CREATE TABLE inspecao_EPI(
    id_inspecao int auto_increment primary key,
    data_inspecao date,
    resultado bool,
    id_EPI INT,
    id_professor INT,
    id_aluno INT,
	foreign key (id_EPI) references EPI (id_EPI) ON DELETE RESTRICT,
    foreign key (id_professor) references professor (id_professor) ON DELETE RESTRICT,
    foreign key (id_aluno) references aluno (id_aluno) ON DELETE RESTRICT
);

Alter table funcionario ADD email Varchar(30);

create index data_entrega on entrega_EPI (data_entrega);

INSERT INTO setor (nome_setor, bloco)
VALUES ('solda','bloco a'), 
('torno','bloco d'), 
('pintor industrial', 'bloco j'), 
('maquinas pesadas', 'bloco j'), 
('eletrica', 'bloco b');

DESC setor;
DESC fornecedor;
DESC EPI;
DESC almoxarifado;
DESC professor;
DESC funcionario;
DESC aluno;
DESC entrega_EPI;
DESC inspecao_EPI;

INSERT INTO funcionario ( nome, cpf, id_setor)
VALUES 
('Henrique de Paula', '11122233344', 1),
('Joao da Silva', '22233344455', 2),
('Jeguelson Pereira', '33344455566', 3),
('Napoleao Bonaparte', '44455566677', 4),
('Agricola Beterraba Areia', '55566677788', 5);

INSERT INTO EPI (nome_EPI, custo_EPI, data_validade, codigo_CA, estoque_EPI)
VALUES
('Oculos de protecao', '29.9', '2026-03-20', '20','20'),
('Bota bico de ferro', '129.9', '2027-08-12', '21','20') ,
('Luva anti-corte', '49.9', '2026-09-19', '22','20'),
('capacete de protecao','89.9', '2027-02-25', '23','20'),
('protetor auricular', '14.9', '2026-12-20', '24','20'),
('respirador tinta', '69.9', '2027-01-19', '25','20');

UPDATE devolucao_EPI 
SET data_devolucao = '2026-03-16' 
where id_devolucao in (1, 2, 3); 

UPDATE EPI SET estoque_EPI = estoque_EPI - 1 WHERE id_EPI = 1;

SELECT funcionario.nome, entrega_EPI.data_entrega
FROM funcionario
LEFT JOIN entrega_EPI ON funcionario.id_funcionario = entrega_EPI.id_funcionario;

SELECT funcionario.nome
FROM funcionario
LEFT JOIN entrega_EPI ON funcionario.id_funcionario = entrega_EPI.id_funcionario
WHERE entrega_EPI.id_entrega IS NULL;

SELECT nome_EPI, data_validade
from EPI
WHERE data_validade<'2026-06-15';

SELECT entrega_EPI.setor_entrega, COUNT(*) AS total_entregas
FROM entrega_EPI 
GROUP BY entrega_EPI.setor_entrega;

SELECT entrega_EPI.autorização 
from entrega_EPI
where autorização = FALSE;

SELECT f.nome, COUNT(*) AS total_epis
FROM funcionario f
JOIN entrega_EPI ent ON f.id_funcionario = ent.id_funcionario
GROUP BY f.id_funcionario
HAVING total_epis > 2;

insert into entrega_EPI(data_entrega, setor_entrega, id_EPI,id_funcionario)
values 
('2026-03-16', 'solda', 2, 1);

insert into entrega_EPI(data_entrega, setor_entrega, id_EPI,id_funcionario)
values 
('2026-03-16', 'solda', 2, 90);

DELETE FROM EPI WHERE id_EPI = 2;

DELETE FROM funcionario WHERE id_funcionario = 5;

ROLLBACK;
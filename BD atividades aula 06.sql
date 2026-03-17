CREATE DATABASE IF NOT EXISTS sistem;
USE sistem;

CREATE TABLE fabricante(
id_fabricante  INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100),
cnpj VARCHAR(18)
);

CREATE TABLE EPI(
id_EPI INT AUTO_INCREMENT PRIMARY KEY,
nome_EPI VARCHAR(100),
CA VARCHAR(18),
data_validade DATE,
estoque int
);

CREATE TABLE funcionario(
id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
nome_funcionario VARCHAR(100)
);

CREATE TABLE entrega_EPI(
id_entrega INT AUTO_INCREMENT PRIMARY KEY,
data_entrega date,
id_EPI int,
id_funcionario int,
foreign key (id_EPI) references EPI (id_EPI),
foreign key (id_funcionario) references funcionario (id_funcionario)
); 

ALTER TABLE fabricante ADD  CA VARCHAR(18);

INSERT INTO EPI (nome_EPI, CA, data_validade, estoque)
values
('bota bico de ferro', '19', '2026-09-08', '10'),
('luva anti-corte', '20', '2026-09-09', '5'),
('Oculos de protecao','200', '2026-11-11', '20');

INSERT INTO funcionario (nome_funcionario)
VALUES('JEGUELSON'), ('RONALDO'), ('BETERRABA FARINHA DA SILVA'), ('ASSADO DA SILVA');

UPDATE EPI set estoque = estoque + 50 where id_EPI = 1;

DELETE FROM funcionario WHERE id_funcionario = 1; 

UPDATE EPI set estoque = estoque - 3 where id_EPI = 2;

select *  FROM EPI;

SELECT nome_EPI FROM EPI WHERE estoque < 5;

INSERT INTO entrega_EPI(data_entrega, id_epi, id_funcionario)
VALUES ('2026-03-16', 2, 2);

SELECT nome_funcionario, nome_EPI, data_entrega FROM entrega_EPI
JOIN funcionario on entrega_EPI.id_funcionario = funcionario.id_funcionario
JOIN EPi on entrega_EPI.id_EPI = EPI.id_EPI;







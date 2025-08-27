create database db_carro;
use db_carro;
create table tb_carro (
id_carro int (10) not null,
marca varchar (100) not null,
modelo varchar (100) not null,
ano int (5),
valor decimal (10,2),
cor varchar (100),
numero_vendas int(10),
primary key(id_carro)
);
create table tb_proprietario (
id_proprietario int (10) not null,
nome varchar (255),
id_carro int not null,
primary key (id_proprietario),
foreign key(id_carro) references tb_carro(id_carro)
);
create table tb_historico(
id_historico int(10) not null,
data_modificada date,
id_carro int (10) not null,
valor_anterior decimal(10,2),
valor_novo decimal (10,2),
primary key(id_historico),
foreign key (id_carro) references tb_carro(id_carro)
);

select marca, modelo, ano from tb_carro;

alter table tb_proprietario add idade int (3);
select * from tb_carro;
select * from tb_proprietario;
select * from tb_historico;
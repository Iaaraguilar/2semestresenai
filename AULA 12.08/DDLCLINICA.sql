CREATE DATABASE db_clinica;
use db_clinica;

create table tb_veterinarios(
id_veterinario int,
nome varchar (120) not null,
especialidade varchar (200) not null,
telefone varchar (15) not null,
primary key(id_veterinario)
);

create table clientes(
id_cliente int,
nome varchar (120) not null,
endereco varchar (255),
telefone varchar(12),
primary key(id_cliente)
);
create table pets(
id_pet int,
nome varchar (120) not null,
tipo varchar(120),
raca varchar (120),
data_nascimento date,
id_cliente int,
primary key(id_pet),
foreign key(id_cliente) references clientes(id_cliente) 
);
create table atendimentos(
id_atendimentos int,
id_pet int,
id_veterinario int,
data_atendimento date,
descricao varchar (255),
primary key(id_atendimentos),
foreign key(id_pet) references pets(id_pet),
foreign key(id_veterinario) references tb_veterinarios(id_veterinario)
);


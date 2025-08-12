USE db_clinica;
select * from tb_veterinarios;

insert into tb_veterinarios(id_veterinario, nome,especialidade,telefone) values(
'1',
'lucas',
'cardiologia',
'11 999-9999'
);
insert into tb_veterinarios(id_veterinario, nome,especialidade,telefone) values(
'2',
'maria',
'dermatologia',
'11 8888-888'
);
insert into tb_veterinarios(id_veterinario, nome,especialidade,telefone) values(
'3',
'kaua',
'odontologia',
'11 777-777'
);

/*clientes*/
select * from clientes;
insert into clientes(id_cliente, nome,endereco,telefone) values(
'1',
'diego',
'rua marta 123',
'11 1234-564'
);
insert into clientes(id_cliente, nome,endereco,telefone) values(
'2',
'natalia',
'Av costa 15',
'11 8965-996'
);
insert into clientes(id_cliente, nome,endereco,telefone) values(
'3',
'debora',
'rua pera 250 ',
'11 7896-4569'
);

/*pets*/
select * from pets;
insert into pets(id_pet, nome,tipo,raca,data_nascimento,id_cliente) values(
'1',
'pudim',
'felino ',
'gengibre',
'2017-08-12',
'3'
);
insert into pets(id_pet, nome,tipo,raca,data_nascimento,id_cliente) values(
'2',
'faisca',
'ave',
'periquito',
'2007-04-22',
'1'
);
insert into pets(id_pet, nome,tipo,raca,data_nascimento,id_cliente) values(
'3',
'princesa',
'canino',
'pitbull',
'2022-05-26',
'2'
);
/*atendimentos*/
select * from atendimentos;
insert into atendimentos(id_atendimentos,id_pet, id_veterinario, data_atendimento, descricao) values(
'1',
'2',
'1',
'2010-01-20',
'asa esquerda machucada'
);
insert into atendimentos(id_atendimentos,id_pet, id_veterinario, data_atendimento, descricao) values(
'2',
'1',
'3',
'2020-06-19',
'obesidade'
);
insert into atendimentos(id_atendimentos,id_pet, id_veterinario, data_atendimento, descricao) values(
'3',
'3',
'3',
'2023-09-10',
'pata quebrada'
);






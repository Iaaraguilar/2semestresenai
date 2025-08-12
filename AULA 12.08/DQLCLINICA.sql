use db_clinica;
select * from tb_veterinarios;

update tb_veterinarios set nome = 'gabriela' where id_veterinario = '2';

update atendimentos set descricao = 'asa direita machucada' where id_atendimentos = '1';

update clientes set nome = 'anderson' where id_cliente = '2';

update pets set nome = 'felix' where id_pet = '2';

update tb_veterinarios set especialidade = 'oncologia' where id_veterinario = '2';

/*EXERCICIO 5. Realize as seguintes consultas:*/
/*pet*/
select * from pets order by data_nascimento asc limit 1;
select * from pets order by data_nascimento desc limit 1;

select count(id_pet) as 'pets cadastrados' from pets;
select *from pets order by nome asc;
select *from pets order by nome desc;

/*nome vets*/
select *from tb_veterinarios order by nome asc;
select *from tb_veterinarios order by nome desc;

/*atendimento*/
select * from atendimentos order by data_atendimento asc limit 1;
select * from atendimentos order by data_atendimento desc limit 1;
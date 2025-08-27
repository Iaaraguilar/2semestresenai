use db_clinica;
delimiter $$
/*1*/
create function pet(p_id_cliente int)
returns int 
DETERMINISTIC
reads sql data
begin
	declare numeropets int default 0;
    select count(*)
    into numeropets
    from pets 
    where id_cliente = p_id_cliente;
    return numeropets;
end $$
select pet (3) as 'numero de pets';
drop  function pet;

/*2*/
DELIMITER $$

CREATE FUNCTION ultima_consulta(p_id_pet INT)
RETURNS DATE
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE data_ultima DATE;

    SELECT MAX(data_atendimento)
    INTO data_ultima
    FROM atendimentos
    WHERE id_pet = p_id_pet;

    RETURN data_ultima;
END$$
DELIMITER ;
drop FUNCTION ultima_consulta;
select ultima_consulta(1) as 'ultimo atendimento';

/*3*/
delimiter **
create function totalatendimento(p_id_veterinario int)
returns int
DETERMINISTIC
READS SQL DATA
BEGIN
declare total int;
select count(*)
into total
from atendimentos 
where id_veterinario = p_id_veterinario;
return total;
end **

select totalatendimento(3) as 'Total Atendimento';


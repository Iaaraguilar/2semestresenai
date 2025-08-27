/*1*/use db_clinica;
delimiter $$

create procedure nomevet (
in p_id_veterinario int,
in p_nome varchar (120),
in p_especialidade varchar(200),
in p_telefone varchar(12)
)
begin
	insert into tb_veterinarios(id_veterinario, nome, especialidade, telefone) values( p_id_veterinario, p_nome,p_especialidade, p_telefone);
end $$ 
call nomevet('7','laura','nutricao','11900567');
select * from tb_veterinarios;
drop procedure nomevet;

/*2*/
DELIMITER $$

CREATE PROCEDURE atualizaCliente (
    IN p_id_cliente INT,
    IN p_nome VARCHAR(120),
    IN p_endereco VARCHAR(200),
    IN p_telefone VARCHAR(20)
)
BEGIN
    UPDATE clientes
    SET nome = p_nome,
        endereco = p_endereco,
        telefone = p_telefone
    WHERE id_cliente = p_id_cliente;
END $$
CALL atualizaCliente(1, 'Maria Oliveira', 'Rua das Flores, 123', '11987654321');
drop procedure atualizaCliente;
select * from clientes;
DELIMITER ;

/*3*/ DELIMITER $$

CREATE PROCEDURE novoatendimento (
    IN p_id_pet INT,
    IN p_id_veterinario INT,
    IN p_descricao VARCHAR(255)
)
BEGIN

    IF NOT EXISTS (SELECT 1 FROM pets WHERE id_pet = p_id_pet) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Pet não encontrado!';
    END IF;

    -- Verificar se o veterinário existe
    IF NOT EXISTS (SELECT 1 FROM tb_veterinarios WHERE id_veterinario = p_id_veterinario) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Veterinário não encontrado!';
    END IF;

    INSERT INTO atendimentos (id_pet, id_veterinario, data_atendimento, descricao)
    VALUES (p_id_pet, p_id_veterinario, NOW(), p_descricao);
END $$

DELIMITER ;
drop PROCEDURE novoatendimento;
CALL novoatendimento(3, 2, 'Consulta de rotina e vacinação.');
select * from atendimentos;

ALTER TABLE atendimentos MODIFY id_atendimentos INT NOT NULL AUTO_INCREMENT;






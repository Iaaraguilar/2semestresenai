use db_biblioteca;

delimiter $$


create procedure inserirautor (
in p_id_autor varchar(100),
in p_nome varchar(120),
in p_data_nascimento date
)
begin 
	insert into tb_autores(id_autor, nome, data_nascimento) values (p_id_autor, p_nome, p_data_nascimento);
end $$
delimiter ;
call  inserirautor('9','malala', '1997-07-19');
select * from tb_autores;


delimiter //
/*2*/ create procedure atualizardata(
in p_id_emprestimos int,
in p_data_devolucao date
)
begin
	update tb_emprestimos set data_devolucao = p_data_devolucao where id_emprestimos = p_id_emprestimos ;
end //

call atualizardata ('1', '2026-06-15');
select * from tb_emprestimos;
drop procedure atualizardata;




 /*3*/  
DELIMITER $$
CREATE PROCEDURE LivrosEmprestadosPorMembro(IN p_id_membros INT)
BEGIN
    SELECT l.titulo, e.data_emprestimo
    FROM tb_emprestimos e
    INNER JOIN tb_livro l ON e.id_livro = l.id_livro
    WHERE e.id_membros = p_id_membros;
END $$
DELIMITER ;
CALL LivrosEmprestadosPorMembro(1);
drop procedure LivrosEmprestadosPorMembro;
select * from tb_emprestimos;

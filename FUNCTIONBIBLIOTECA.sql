use db_biblioteca;
/*1*/

DROP FUNCTION i;
DELIMITER $$

CREATE FUNCTION i(p_id_autor INT)
RETURNS INT 
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE idade INT;
    DECLARE v_data_nascimento DATE;

    SELECT data_nascimento 
    INTO v_data_nascimento
    FROM tb_autores
    WHERE id_autor = p_id_autor;

    SET idade = TIMESTAMPDIFF(YEAR, v_data_nascimento, CURDATE());

    RETURN idade;
END$$
DELIMITER ;
SELECT i(1);
/*2*/

delimiter **
create function totallivro(p_id_autor int)
returns int
DETERMINISTIC
READS SQL DATA
BEGIN
declare total int;
select count(*)
into total
from tb_livro
where id_autor = p_id_autor;
return total;
end **

select totallivro(3) as 'Total Livros';


/*3*/
DELIMITER $$

CREATE FUNCTION total_emprestimos_periodo(
    p_data_emprestimo DATE,
    p_data_devolucao DATE
)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total INT;

    SELECT COUNT(*) INTO total
    FROM tb_emprestimos
    WHERE data_emprestimo BETWEEN p_data_emprestimo AND  p_data_devolucao;

    RETURN total;
END $$

DELIMITER ;
SELECT total_emprestimos_periodo('2025-01-01', CURDATE());

/*4*/
DELIMITER $$

CREATE FUNCTION media_dias_emprestimo()
RETURNS DECIMAL(5,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE media DECIMAL(5,2);

    SELECT AVG(DATEDIFF(data_devolucao, data_emprestimo))
    INTO media
    FROM tb_emprestimos
    WHERE data_devolucao IS NOT NULL;

    RETURN media;
END$$
select media_dias_emprestimo();
DELIMITER ;


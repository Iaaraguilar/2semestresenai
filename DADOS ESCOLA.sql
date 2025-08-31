/*/ DADOS ACADÊMICA/*/

CREATE DATABASE db_escola;
USE db_escola;

CREATE TABLE tb_cursos (
    id_curso INT AUTO_INCREMENT,
    nome VARCHAR(100),
    duracao_anos INT NOT NULL,
    PRIMARY KEY (id_curso)
);

CREATE TABLE tb_professores (
    id_professores INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    departamento VARCHAR(100) NOT NULL,
    ano_admissao DATE,
    PRIMARY KEY (id_professores)
);

CREATE TABLE disciplinas (
    id_disciplinas INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    curso_id INT,
    professor_id INT,
    PRIMARY KEY (id_disciplinas),
    FOREIGN KEY (curso_id) REFERENCES tb_cursos(id_curso),
    FOREIGN KEY (professor_id) REFERENCES tb_professores(id_professores)
);

CREATE TABLE estudantes (
    id_estudantes INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    email VARCHAR(100) UNIQUE NOT NULL,
    curso_id INT,
    data_matricula DATE NOT NULL,
    PRIMARY KEY (id_estudantes),
    FOREIGN KEY (curso_id) REFERENCES tb_cursos(id_curso)
);

CREATE TABLE matriculas (
    id_matriculas INT AUTO_INCREMENT UNIQUE,
    estudante_id INT,
    disciplina_id INT,
    data_matricula DATE,
    PRIMARY KEY (id_matriculas),
    FOREIGN KEY (estudante_id) REFERENCES estudantes(id_estudantes),
    FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id_disciplinas)
);

CREATE TABLE notas (
    id_notas INT AUTO_INCREMENT UNIQUE,
    matricula_id INT,
    nota DECIMAL(5,2),
    data_lancamento DATE,
    PRIMARY KEY (id_notas),
    FOREIGN KEY (matricula_id) REFERENCES matriculas(id_matriculas)
);
CREATE DATABASE db_escola;
USE db_escola;

CREATE TABLE tb_cursos (
    id_curso INT AUTO_INCREMENT,
    nome VARCHAR(100),
    duracao_anos INT NOT NULL,
    PRIMARY KEY (id_curso)
);

CREATE TABLE tb_professores (
    id_professores INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    departamento VARCHAR(100) NOT NULL,
    ano_admissao DATE,
    PRIMARY KEY (id_professores)
);

CREATE TABLE disciplinas (
    id_disciplinas INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    curso_id INT,
    professor_id INT,
    PRIMARY KEY (id_disciplinas),
    FOREIGN KEY (curso_id) REFERENCES tb_cursos(id_curso),
    FOREIGN KEY (professor_id) REFERENCES tb_professores(id_professores)
);

CREATE TABLE estudantes (
    id_estudantes INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    email VARCHAR(100) UNIQUE NOT NULL,
    curso_id INT,
    data_matricula DATE NOT NULL,
    PRIMARY KEY (id_estudantes),
    FOREIGN KEY (curso_id) REFERENCES tb_cursos(id_curso)
);

CREATE TABLE matriculas (
    id_matriculas INT AUTO_INCREMENT UNIQUE,
    estudante_id INT,
    disciplina_id INT,
    data_matricula DATE,
    PRIMARY KEY (id_matriculas),
    FOREIGN KEY (estudante_id) REFERENCES estudantes(id_estudantes),
    FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id_disciplinas)
);

CREATE TABLE notas (
    id_notas INT AUTO_INCREMENT UNIQUE,
    matricula_id INT,
    nota DECIMAL(5,2),
    data_lancamento DATE,
    PRIMARY KEY (id_notas),
    FOREIGN KEY (matricula_id) REFERENCES matriculas(id_matriculas)
);


/*DML*/ 
INSERT INTO tb_professores (nome, departamento, ano_admissao) VALUES 
('Paulo', 'História', '2019-06-22'),
('Maria', 'Ciência de Dados', '2017-04-09'),
('Lucas', 'Ciência da Computação', '2018-02-18'),
('Fernando', 'Cybersegurança', '2024-03-14'),
('Laura', 'ADS', '2023-12-20');
alter table tb_cursos drop column curso;
select * from tb_cursos;
insert into tb_cursos (nome, duracao_anos) values
('historia', 5),
('ciencia de dados', 2),
('ciencia da computacao', 5),
('cyberseguranca', 2),
('ADS',5);
delete from tb_cursos where id > 5;
select * from disciplinas;
insert into disciplinas (nome, curso_id, professor_id) values
('Brasil', 1, 1),
('banco de dados', 2, 2),
('IA', 3, 3),
('linux', 4, 4),
('HTML', 5, 5);
select * from estudantes;
INSERT INTO estudantes (nome, data_nascimento, email, curso_id, data_matricula) VALUES
('kaio miguel pereira', '2001-02-22', 'kaio.pereira@gmail.com', 1, '2022-01-23'),
('bruna marquezine', '1995-08-04', 'bruninha.marque@gmail.com', 2, '2024-03-12'),
('jonas costa', '2005-04-10', 'jonascosta@gmail.com', 3, '2020-06-19'),
('caroline junior', '1999-09-13', 'caarolineju3@gmail.com', 4, '2025-04-04'),
('vitoria souza', '2007-06-01', 'vitoriasouzza@gmail.com', 5, '2024-02-10');
select * from matriculas;
INSERT INTO matriculas (estudante_id, disciplina_id, data_matricula) VALUES
(1, 1, '2022-02-15'),
(2, 2, '2024-03-10'),
(3, 3, '2020-07-01'),
(4, 4, '2025-04-20'),
(5, 5, '2024-02-12'),
(1, 3, '2023-08-25'),
(2, 1, '2024-01-30'),
(3, 4, '2021-05-18'),
(4, 2, '2025-04-22'),
(5, 1, '2024-03-05');

select * from notas;
INSERT INTO notas (matricula_id, nota, data_lancamento) VALUES
(1, 8.50, '2022-07-01'),
(2, 9.20, '2024-03-20'),
(3, 7.80, '2020-12-10'),
(4, 6.50, '2025-05-05'),
(5, 9.00, '2024-06-15');
/*DQL*/
-- Alunos matriculados no curso de "ciencia de dados" em 2024
SELECT 
    e.nome AS estudante,
    c.nome AS curso,
    m.data_matricula
FROM estudantes e
JOIN matriculas m ON e.id_estudantes = m.estudante_id
JOIN disciplinas d ON m.disciplina_id = d.id_disciplinas
JOIN tb_cursos c ON d.curso_id = c.id_curso
WHERE c.nome = 'ciencia de dados'
  AND YEAR(m.data_matricula) = 2024;

-- Professores de Ciência da Computação com mais de 5 anos de experiência
SELECT 
    nome,
    departamento,
    ano_admissao,
    TIMESTAMPDIFF(YEAR, ano_admissao, CURDATE()) AS anos_experiencia
FROM tb_professores
WHERE departamento = 'ciencia da computacao'
  AND TIMESTAMPDIFF(YEAR, ano_admissao, CURDATE()) > 5;

-- Notas dos alunos por disciplina
SELECT 
    e.nome AS estudante,
    d.nome AS disciplina,
    n.nota
FROM notas n
JOIN matriculas m ON n.matricula_id = m.id_matriculas
JOIN estudantes e ON m.estudante_id = e.id_estudantes
JOIN disciplinas d ON m.disciplina_id = d.id_disciplinas
ORDER BY 
    n.nota DESC,
    e.nome ASC;

-- Média das notas dos alunos do curso de ADS
SELECT AVG(n.nota) AS media_notas
FROM estudantes e
JOIN tb_cursos c ON e.curso_id = c.id_curso
JOIN matriculas m ON e.id_estudantes = m.estudante_id
JOIN notas n ON m.id_matriculas = n.matricula_id
WHERE c.nome = 'ADS';

-- Total de estudantes por curso com mais de 50 alunos (ajuste de join corrigido)
SELECT c.nome AS curso, COUNT(m.estudante_id) AS total_estudantes
FROM tb_cursos c
JOIN disciplinas d ON c.id_curso = d.curso_id
JOIN matriculas m ON d.id_disciplinas = m.disciplina_id
GROUP BY c.id_curso, c.nome
HAVING COUNT(m.estudante_id) > 50;
-- Alunos matriculados no curso de "ciencia de dados" em 2024
SELECT 
    e.nome AS estudante,
    c.nome AS curso,
    m.data_matricula
FROM estudantes e
JOIN matriculas m ON e.id_estudantes = m.estudante_id
JOIN disciplinas d ON m.disciplina_id = d.id_disciplinas
JOIN tb_cursos c ON d.curso_id = c.id_curso
WHERE c.nome = 'ciencia de dados'
  AND YEAR(m.data_matricula) = 2024;


SELECT 
    nome,
    departamento,
    ano_admissao,
    TIMESTAMPDIFF(YEAR, ano_admissao, CURDATE()) AS anos_experiencia
FROM tb_professores
WHERE departamento = 'ciencia da computacao'
  AND TIMESTAMPDIFF(YEAR, ano_admissao, CURDATE()) > 5;

SELECT 
    e.nome AS estudante,
    d.nome AS disciplina,
    n.nota
FROM notas n
JOIN matriculas m ON n.matricula_id = m.id_matriculas
JOIN estudantes e ON m.estudante_id = e.id_estudantes
JOIN disciplinas d ON m.disciplina_id = d.id_disciplinas
ORDER BY 
    n.nota DESC,
    e.nome ASC;


SELECT AVG(n.nota) AS media_notas
FROM estudantes e
JOIN tb_cursos c ON e.curso_id = c.id_curso
JOIN matriculas m ON e.id_estudantes = m.estudante_id
JOIN notas n ON m.id_matriculas = n.matricula_id
WHERE c.nome = 'ADS';


SELECT c.nome AS curso, COUNT(m.estudante_id) AS total_estudantes
FROM tb_cursos c
JOIN disciplinas d ON c.id_curso = d.curso_id
JOIN matriculas m ON d.id_disciplinas = m.disciplina_id
GROUP BY c.id_curso, c.nome
HAVING COUNT(m.estudante_id) > 50;

/*subquery*/

SELECT nome 
FROM tb_cursos 
WHERE id_curso IN (
    SELECT curso_id 
    FROM disciplinas 
    GROUP BY curso_id 
    HAVING COUNT(DISTINCT id_disciplinas) > 5
);

SELECT e.nome
FROM estudantes e
JOIN disciplinas d
ON d.curso_id = e.curso_id
GROUP BY e.id_estudantes
HAVING COUNT(d.id_disciplinas) > (
	SELECT AVG(d.id_disciplinas)
    FROM disciplinas d
    JOIN estudantes e
    ON  d.curso_id = e.curso_id
);

SELECT DISTINCT p.nome
FROM tb_professores p
JOIN disciplinas d ON p.id_professores = d.professor_id
JOIN matriculas m ON d.id_disciplinas = m.disciplina_id
JOIN notas n ON n.matricula_id = m.id_matriculas
GROUP BY p.id_professores, p.nome
HAVING AVG(n.nota) > (
    SELECT AVG(n2.nota)
    FROM notas n2
);
SELECT DISTINCT p.nome
FROM tb_professores p
JOIN disciplinas d ON p.id_professores = d.professor_id
JOIN matriculas m ON d.id_disciplinas = m.disciplina_id
JOIN notas n ON n.matricula_id = m.id_matriculas
GROUP BY p.id_professores, p.nome
HAVING AVG(n.nota) > (
    SELECT AVG(n2.nota)
    FROM notas n2
);
SELECT DISTINCT e.nome
FROM estudantes e
JOIN matriculas m ON e.id_estudantes = m.estudante_id
JOIN notas n ON m.id_matriculas = n.matricula_id
WHERE n.nota < (
    SELECT AVG(nota) FROM notas
);
SELECT DISTINCT p.nome
FROM tb_professores p
WHERE NOT EXISTS (
    SELECT 1
    FROM disciplinas d
    JOIN matriculas m ON d.id_disciplinas = m.disciplina_id
    JOIN notas n ON m.id_matriculas = n.matricula_id
    WHERE d.professor_id = p.id_professores
      AND n.nota < 7
);

/*FUNCTION*/
DELIMITER $$

CREATE FUNCTION idade_estudante(data_nascimento DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE());
END$$

DELIMITER ;
SELECT idade_estudante('2000-05-15') AS idade;


DELIMITER $$
CREATE FUNCTION total_estudantes_disciplina(id_disciplina INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    
    SELECT COUNT(*) INTO total
    FROM matriculas
    WHERE disciplina_id = id_disciplina;
    
    RETURN total;
END$$
DELIMITER ;
SELECT total_estudantes_disciplina(1);
--
DELIMITER $$

CREATE FUNCTION nota_maxima()
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE maior DECIMAL(5,2);
    
    SELECT MAX(nota) INTO maior
    FROM notas;
    
    RETURN maior;
END$$

DELIMITER ;
SELECT nota_maxima();
-- 
DELIMITER $$

CREATE FUNCTION disciplina_do_curso(id_curso INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE nome_disciplina VARCHAR(100);
    
    SELECT nome INTO nome_disciplina
    FROM disciplinas
    WHERE curso_id = id_curso
    LIMIT 1;
    
    RETURN nome_disciplina;
END$$

DELIMITER ;
SELECT nota_maxima();
--
DELIMITER $$

CREATE FUNCTION disciplina_do_curso(id_curso INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE nome_disciplina VARCHAR(100);
    
    SELECT nome INTO nome_disciplina
    FROM disciplinas
    WHERE curso_id = id_curso
    LIMIT 1;
    
    RETURN nome_disciplina;
END$$

DELIMITER ;
SELECT disciplina_do_curso(2);
--

DELIMITER $$

CREATE FUNCTION media_notas_curso(id_curso INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE media DECIMAL(5,2);

    SELECT AVG(n.nota) INTO media
    FROM notas n
    JOIN matriculas m ON n.matricula_id = m.id_matriculas
    JOIN disciplinas d ON m.disciplina_id = d.id_disciplinas
    WHERE d.curso_id = id_curso;

    RETURN media;
END$$

DELIMITER ;
SELECT media_notas_curso(5);

/*TRIGGER*/
DELETE FROM disciplinas WHERE id_disciplinas = 1;
DELETE FROM disciplinas WHERE id_disciplinas = 99;
DELETE FROM disciplinas WHERE id_disciplinas = 1;

/*PROCEDURE*/
DELIMITER $$

CREATE PROCEDURE insere_professor (
    IN p_nome VARCHAR(100),
    IN p_departamento VARCHAR(100),
    IN p_ano_admissao DATE,
    OUT novo_id INT
)
BEGIN
    INSERT INTO tb_professores (nome, departamento, ano_admissao)
    VALUES (p_nome, p_departamento, p_ano_admissao);

    SET novo_id = LAST_INSERT_ID();
END$$

DELIMITER ;
CALL insere_professor('Ana Lima', 'Matemática', '2022-03-10', @id);
SELECT @id;

DELIMITER $$

CREATE PROCEDURE atualiza_disciplina (
    IN p_id INT,
    IN p_novo_nome VARCHAR(100)
)
BEGIN
    UPDATE disciplinas
    SET nome = p_novo_nome
    WHERE id_disciplinas = p_id;
END$$

DELIMITER ;
CALL atualiza_disciplina(3, 'Inteligência Artificial Avançada');

DELIMITER $$

CREATE PROCEDURE remove_estudante (
    IN p_id INT
)
BEGIN
    DELETE FROM estudantes
    WHERE id_estudantes = p_id;
END$$

DELIMITER ;
CALL remove_estudante(4);

DELIMITER $$

CREATE PROCEDURE consulta_professor (
    IN p_id INT
)
BEGIN
    SELECT nome, departamento
    FROM tb_professores
    WHERE id_professores = p_id;
END$$

DELIMITER ;

CALL consulta_professor(2);


DELIMITER $$

CREATE PROCEDURE atualiza_nota (
    IN p_matricula_id INT,
    IN p_nova_nota DECIMAL(5,2)
)
BEGIN
    UPDATE notas
    SET nota = p_nova_nota
    WHERE matricula_id = p_matricula_id;
END$$

DELIMITER ;
CALL atualiza_nota(1, 9.75);


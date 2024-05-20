SET SERVEROUTPUT ON;

-- Excluir Tabelas
DROP TABLE tb_sugestao_ia CASCADE CONSTRAINTS;
DROP TABLE tb_avaliacoes CASCADE CONSTRAINTS;
DROP TABLE tb_produto CASCADE CONSTRAINTS;
DROP TABLE tb_ia CASCADE CONSTRAINTS;
DROP TABLE tb_autentica CASCADE CONSTRAINTS;
DROP TABLE tb_cliente CASCADE CONSTRAINTS;
DROP TABLE tb_endereco CASCADE CONSTRAINTS;

-- Criando Tabelas
CREATE TABLE tb_avaliacoes (
    id_avaliacoes    INTEGER NOT NULL,
    id_cliente       INTEGER NOT NULL,
    id_produto       INTEGER NOT NULL,
    id_ia            INTEGER NOT NULL,
    comentario       VARCHAR2(500),
    nota_avaliacao   INTEGER,
    data_avaliacao   TIMESTAMP WITH TIME ZONE,
    status_avaliacao VARCHAR2(100)
);

ALTER TABLE tb_avaliacoes ADD CONSTRAINT tb_avaliacoes_pk PRIMARY KEY (id_avaliacoes);

CREATE TABLE tb_autentica (
    id_cliente    INTEGER NOT NULL,
    email_cliente VARCHAR2(100),
    senha_cliente VARCHAR2(50)
);

CREATE TABLE tb_cliente (
    id_cliente              INTEGER NOT NULL,
    nome_cliente            VARCHAR2(100),
    cpf_cliente             INTEGER,
    data_nascimento_cliente TIMESTAMP WITH TIME ZONE,
    genero_cliente          VARCHAR2(50)
);

ALTER TABLE tb_cliente ADD CONSTRAINT tb_cliente_pk PRIMARY KEY (id_cliente);

CREATE TABLE tb_ia (
    id_ia             INTEGER NOT NULL,
    nome_ia           VARCHAR2(100),
    algoritmo_ia      VARCHAR2(500),
    dados_treinamento VARCHAR2(500),
    desempenho_ia     VARCHAR2(255)
);

ALTER TABLE tb_ia ADD CONSTRAINT tb_ia_pk PRIMARY KEY (id_ia);

CREATE TABLE tb_produto (
    id_produto        INTEGER NOT NULL,
    id_cliente        INTEGER NOT NULL,
    id_ia             INTEGER NOT NULL,
    nome_produto      VARCHAR2(100),
    preco_produto     INTEGER,
    tipo_produto      VARCHAR2(100),
    descricao_produto VARCHAR2(100)
);

ALTER TABLE tb_produto ADD CONSTRAINT tb_produto_pk PRIMARY KEY (id_produto);

CREATE TABLE tb_sugestao_ia (
    id_sugestao         INTEGER NOT NULL,
    id_ia               INTEGER NOT NULL,
    imagem_sugestao     BLOB,
    descricao_sugestao  VARCHAR2(500),
    data_sugestao       TIMESTAMP WITH TIME ZONE,
    relevancia_sugestao INTEGER
);

ALTER TABLE tb_sugestao_ia ADD CONSTRAINT tb_sugestao_ia_pk PRIMARY KEY (id_sugestao);

CREATE TABLE tb_endereco (
    id_cliente INTEGER NOT NULL,
    endereco   VARCHAR2(100),
    numero     INTEGER
);

-- Inserindo chaves estrangeiras
ALTER TABLE tb_sugestao_ia
    ADD CONSTRAINT tb_sugestao_ia_tb_ia_fk FOREIGN KEY (id_ia)
        REFERENCES tb_ia (id_ia);

ALTER TABLE tb_produto
    ADD CONSTRAINT tb_produto_tb_ia_fk FOREIGN KEY (id_ia)
        REFERENCES tb_ia (id_ia);

ALTER TABLE tb_produto
    ADD CONSTRAINT tb_produto_tb_cliente_fk FOREIGN KEY (id_cliente)
        REFERENCES tb_cliente (id_cliente);

ALTER TABLE tb_autentica
    ADD CONSTRAINT tb_autentica_tb_cliente_fk FOREIGN KEY (id_cliente)
        REFERENCES tb_cliente (id_cliente);

ALTER TABLE tb_avaliacoes
    ADD CONSTRAINT tb_avaliacoes_tb_produto_fk FOREIGN KEY (id_produto)
        REFERENCES tb_produto (id_produto);

ALTER TABLE tb_avaliacoes
    ADD CONSTRAINT tb_avaliacoes_tb_ia_fk FOREIGN KEY (id_ia)
        REFERENCES tb_ia (id_ia);

ALTER TABLE tb_avaliacoes
    ADD CONSTRAINT tb_avaliacoes_tb_cliente_fk FOREIGN KEY (id_cliente)
        REFERENCES tb_cliente (id_cliente);

-- Inserindo valores nas tabelas
-- Inserindo valores na tb_cliente
INSERT INTO tb_cliente (id_cliente, nome_cliente, cpf_cliente, data_nascimento_cliente, genero_cliente)
VALUES (1, 'Ana Silva', 12345678901, TO_DATE('1990-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Feminino');

INSERT INTO tb_cliente (id_cliente, nome_cliente, cpf_cliente, data_nascimento_cliente, genero_cliente)
VALUES (2, 'Carlos Souza', 23456789012, TO_DATE('1985-05-15 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Masculino');

INSERT INTO tb_cliente (id_cliente, nome_cliente, cpf_cliente, data_nascimento_cliente, genero_cliente)
VALUES (3, 'Mariana Santos', 34567890123, TO_DATE('1988-10-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Feminino');

INSERT INTO tb_cliente (id_cliente, nome_cliente, cpf_cliente, data_nascimento_cliente, genero_cliente)
VALUES (4, 'Rafael Oliveira', 45678901234, TO_DATE('1995-03-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Masculino');

INSERT INTO tb_cliente (id_cliente, nome_cliente, cpf_cliente, data_nascimento_cliente, genero_cliente)
VALUES (5, 'Juliana Martins', 56789012345, TO_DATE('1980-12-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Feminino');

-- Inserindo valores na tb_autentica
INSERT INTO tb_autentica (id_cliente, email_cliente, senha_cliente)
VALUES (1, 'anasilva@example.com', 'senha123');

INSERT INTO tb_autentica (id_cliente, email_cliente, senha_cliente)
VALUES (2, 'carlossouza@example.com', 'senha456');

INSERT INTO tb_autentica (id_cliente, email_cliente, senha_cliente)
VALUES (3, 'marianasantos@example.com', 'senha789');

INSERT INTO tb_autentica (id_cliente, email_cliente, senha_cliente)
VALUES (4, 'rafaeloliveira@example.com', 'senhaabc');

INSERT INTO tb_autentica (id_cliente, email_cliente, senha_cliente)
VALUES (5, 'julianamartins@example.com', 'senhaxyz');

-- Inserindo valores na tb_endereco
INSERT INTO tb_endereco (id_cliente, endereco, numero)
VALUES (1, 'Rua A, 123', 123);

INSERT INTO tb_endereco (id_cliente, endereco, numero)
VALUES (2, 'Rua B, 456', 456);

INSERT INTO tb_endereco (id_cliente, endereco, numero)
VALUES (3, 'Rua C, 789', 789);

INSERT INTO tb_endereco (id_cliente, endereco, numero)
VALUES (4, 'Rua D, 1011', 1011);

INSERT INTO tb_endereco (id_cliente, endereco, numero)
VALUES (5, 'Rua E, 1213', 1213);

-- Inserindo valores na tb_ia
INSERT INTO tb_ia (id_ia, nome_ia, algoritmo_ia, dados_treinamento, desempenho_ia)
VALUES (1, 'IA de Recomendação', 'Redes Neurais', 'dados_recomendacao.csv', '85% de precisão');

INSERT INTO tb_ia (id_ia, nome_ia, algoritmo_ia, dados_treinamento, desempenho_ia)
VALUES (2, 'IA de Análise de Sentimentos', 'Árvores de Decisão', 'dados_sentimentos.csv', '78% de precisão');

INSERT INTO tb_ia (id_ia, nome_ia, algoritmo_ia, dados_treinamento, desempenho_ia)
VALUES (3, 'IA de Reconhecimento de Imagens', 'Máquinas de Vetores de Suporte', 'dados_imagens.csv', '91% de precisão');

INSERT INTO tb_ia (id_ia, nome_ia, algoritmo_ia, dados_treinamento, desempenho_ia)
VALUES (4, 'IA de Previsão de Vendas', 'Regressão Linear', 'dados_vendas.csv', '67% de precisão');

INSERT INTO tb_ia (id_ia, nome_ia, algoritmo_ia, dados_treinamento, desempenho_ia)
VALUES (5, 'IA de Classificação de Textos', 'Redes Bayesianas', 'dados_textos.csv', '82% de precisão');

-- Inserindo valores na tb_produto
INSERT INTO tb_produto (id_produto, id_cliente, id_ia, nome_produto, preco_produto, tipo_produto, descricao_produto)
VALUES (1, 1, 1, 'Notebook Dell', 2500, 'Eletrônico', 'Notebook com processador Intel Core i7 e 8GB de RAM.');

INSERT INTO tb_produto (id_produto, id_cliente, id_ia, nome_produto, preco_produto, tipo_produto, descricao_produto)
VALUES (2, 2, 2, 'Camisa Polo', 80, 'Vestuário', 'Camisa Polo de algodão, várias cores disponíveis.');

INSERT INTO tb_produto (id_produto, id_cliente, id_ia, nome_produto, preco_produto, tipo_produto, descricao_produto)
VALUES (3, 3, 3, 'Chocolate Amargo', 10, 'Alimentício', 'Barra de chocolate amargo, 70% de cacau.');

INSERT INTO tb_produto (id_produto, id_cliente, id_ia, nome_produto, preco_produto, tipo_produto, descricao_produto)
VALUES (4, 4, 4, 'Vaso Decorativo', 150, 'Decoração', 'Vaso de cerâmica decorado com padrão floral.');

INSERT INTO tb_produto (id_produto, id_cliente, id_ia, nome_produto, preco_produto, tipo_produto, descricao_produto)
VALUES (5, 5, 5, 'Tênis de Corrida', 300, 'Esportivo', 'Tênis de corrida com amortecimento e tecnologia respirável.');

-- Inserindo valores na tb_avaliacoes
INSERT INTO tb_avaliacoes (id_avaliacoes, id_cliente, id_produto, id_ia, comentario, nota_avaliacao, data_avaliacao, status_avaliacao)
VALUES (1, 1, 1, 1, 'Ótimo produto, estou muito satisfeito!', 5, TO_DATE('2024-04-11 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Aprovado');

INSERT INTO tb_avaliacoes (id_avaliacoes, id_cliente, id_produto, id_ia, comentario, nota_avaliacao, data_avaliacao, status_avaliacao)
VALUES (2, 2, 2, 2, 'A qualidade da camisa é excelente!', 4, TO_DATE('2024-04-11 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Aprovado');

INSERT INTO tb_avaliacoes (id_avaliacoes, id_cliente, id_produto, id_ia, comentario, nota_avaliacao, data_avaliacao, status_avaliacao)
VALUES (3, 3, 3, 3, 'Adorei a variedade de cores disponíveis!', 5, TO_DATE('2024-04-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Aprovado');

INSERT INTO tb_avaliacoes (id_avaliacoes, id_cliente, id_produto, id_ia, comentario, nota_avaliacao, data_avaliacao, status_avaliacao)
VALUES (4, 4, 4, 4, 'O vaso combinou perfeitamente com a decoração da minha casa.', 4, TO_DATE('2024-04-11 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Aprovado');

INSERT INTO tb_avaliacoes (id_avaliacoes, id_cliente, id_produto, id_ia, comentario, nota_avaliacao, data_avaliacao, status_avaliacao)
VALUES (5, 5, 5, 5, 'O tênis é muito confortável para correr!', 5, TO_DATE('2024-04-11 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Aprovado');

-- Inserindo valores na tb_sugestao_ia
INSERT INTO tb_sugestao_ia (id_sugestao, id_ia, descricao_sugestao, data_sugestao, relevancia_sugestao)
VALUES (1, 1, 'Sugestão de Produto: Mochila para Notebook', TO_DATE('2024-04-11 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4);

INSERT INTO tb_sugestao_ia (id_sugestao, id_ia, descricao_sugestao, data_sugestao, relevancia_sugestao)
VALUES (2, 2, 'Sugestão de Produto: Calça Jeans Masculina', TO_DATE('2024-04-11 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3);

INSERT INTO tb_sugestao_ia (id_sugestao, id_ia, descricao_sugestao, data_sugestao, relevancia_sugestao)
VALUES (3, 3, 'Sugestão de Produto: Kit de Pintura', TO_DATE('2024-04-12 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5);

INSERT INTO tb_sugestao_ia (id_sugestao, id_ia, descricao_sugestao, data_sugestao, relevancia_sugestao)
VALUES (4, 4, 'Sugestão de Produto: Monitor Ultrawide', TO_DATE('2024-04-12 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4);

INSERT INTO tb_sugestao_ia (id_sugestao, id_ia, descricao_sugestao, data_sugestao, relevancia_sugestao)
VALUES (5, 5, 'Sugestão de Produto: Livro de Ficção Científica', TO_DATE('2024-04-12 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3);


--Criando duas funções para validar entrada de dados

CREATE OR REPLACE FUNCTION valida_cpf(cpf_cliente IN INTEGER) RETURN BOOLEAN IS
    v_cpf VARCHAR2(11);
BEGIN
    -- Converte o CPF para string
    v_cpf := TO_CHAR(cpf_cliente);

    -- Verifica se o CPF possui 11 dígitos
    IF LENGTH(v_cpf) != 11 THEN
        RETURN FALSE;
    END IF;

    -- Verifica se todos os dígitos são iguais
    IF REGEXP_LIKE(v_cpf, '^(\d)\1{10}$') THEN
        RETURN FALSE;
    END IF;

    -- Calcula o primeiro dígito verificador
    DECLARE
        v_soma1 INTEGER := 0;
        v_digito1 INTEGER;
    BEGIN
        FOR i IN 1..9 LOOP
            v_soma1 := v_soma1 + TO_NUMBER(SUBSTR(v_cpf, i, 1)) * (11 - i);
        END LOOP;

        v_digito1 := 11 - MOD(v_soma1, 11);
        IF v_digito1 = 10 OR v_digito1 = 11 THEN
            v_digito1 := 0;
        END IF;

        IF v_digito1 != TO_NUMBER(SUBSTR(v_cpf, 10, 1)) THEN
            RETURN FALSE;
        END IF;
    END;

    -- Calcula o segundo dígito verificador
    DECLARE
        v_soma2 INTEGER := 0;
        v_digito2 INTEGER;
    BEGIN
        FOR i IN 1..10 LOOP
            v_soma2 := v_soma2 + TO_NUMBER(SUBSTR(v_cpf, i, 1)) * (12 - i);
        END LOOP;

        v_digito2 := 11 - MOD(v_soma2, 11);
        IF v_digito2 = 10 OR v_digito2 = 11 THEN
            v_digito2 := 0;
        END IF;

        IF v_digito2 != TO_NUMBER(SUBSTR(v_cpf, 11, 1)) THEN
            RETURN FALSE;
        END IF;
    END;

    -- Se chegou até aqui, o CPF é válido
    RETURN TRUE;
END;
/

CREATE OR REPLACE FUNCTION valida_email(email_cliente IN VARCHAR2) RETURN BOOLEAN IS
BEGIN
    -- Verifica se o e-mail tem o formato correto
    IF REGEXP_LIKE(email_cliente, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$') THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
/

--Criar duas funções para validar entrada de dados
--Testar CPF
DECLARE 
    cpfs_teste SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(12345678901, 98765432109, 11111111111, 22222222222, 33333333333);
    resultado BOOLEAN;
BEGIN
    FOR i IN 1..cpfs_teste.COUNT LOOP
        resultado := valida_cpf(cpfs_teste(i));

        IF resultado THEN 
            DBMS_OUTPUT.put_line(cpfs_teste(i) || ' - CPF válido');
        ELSE
            DBMS_OUTPUT.put_line(cpfs_teste(i) || ' - CPF inválido');
        END IF;
    END LOOP;
END;
/


--Testar emails
DECLARE 
    emails_teste VARCHAR2(200);
    resultado BOOLEAN;
BEGIN
    emails_teste := 'matheus123@gmail.com, teste.email@teste.com, email_invalido@invalido, teste@.com, email@@teste.com';
    
    -- Separando os e-mails por vírgula e testando cada um
    FOR email IN (SELECT TRIM(REGEXP_SUBSTR(emails_teste, '[^,]+', 1, LEVEL)) AS email_teste FROM DUAL CONNECT BY LEVEL <= REGEXP_COUNT(emails_teste, ',') + 1) LOOP
        resultado := valida_email(email.email_teste);

        IF resultado THEN 
            DBMS_OUTPUT.put_line(email.email_teste || ' - E-mail válido');
        ELSE
            DBMS_OUTPUT.put_line(email.email_teste || ' - E-mail inválido');
        END IF;
    END LOOP;
END;
/

-- Criando procedures de INSERT para as tabelas criadas

--tb_avaliacoes

CREATE OR REPLACE PROCEDURE inserir_avaliacao (
    p_id_cliente IN INTEGER,
    p_id_produto IN INTEGER,
    p_id_ia IN INTEGER,
    p_comentario IN VARCHAR2,
    p_nota_avaliacao IN INTEGER,
    p_data_avaliacao IN TIMESTAMP,
    p_status_avaliacao IN VARCHAR2
) AS
BEGIN
    INSERT INTO tb_avaliacoes (
        id_avaliacoes,
        id_cliente,
        id_produto,
        id_ia,
        comentario,
        nota_avaliacao,
        data_avaliacao,
        status_avaliacao
    ) 
    SELECT 
        NVL(MAX(id_avaliacoes), 0) + 1,
        p_id_cliente,
        p_id_produto,
        p_id_ia,
        p_comentario,
        p_nota_avaliacao,
        p_data_avaliacao,
        p_status_avaliacao
    FROM tb_avaliacoes;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Avaliação inserida com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir avaliação: ' || SQLERRM);
END;
/

BEGIN
    inserir_avaliacao(3, 3, 3, 'Adorei!', 5, TO_TIMESTAMP('2024-05-14 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Aprovado');
END;
/

-- Procedure que verifica se o e-mail fornecido já está sendo usado por outro cliente da tb_autentica.

CREATE OR REPLACE PROCEDURE inserir_autenticacao (
    p_id_cliente IN INTEGER,
    p_email_cliente IN VARCHAR2,
    p_senha_cliente IN VARCHAR2
) AS
    v_email_existente INTEGER;
BEGIN
    -- Verifica se o e-mail já está sendo usado por outro cliente
    SELECT COUNT(*) INTO v_email_existente FROM tb_autentica WHERE email_cliente = p_email_cliente;
    
    IF v_email_existente > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Este e-mail já está sendo usado por outro cliente.');
        RETURN;
    END IF;

    INSERT INTO tb_autentica (
        id_cliente,
        email_cliente,
        senha_cliente
    ) VALUES (
        p_id_cliente,
        p_email_cliente,
        p_senha_cliente
    );
    
    DBMS_OUTPUT.PUT_LINE('Autenticação inserida com sucesso.');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Já existe uma autenticação para este cliente.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir autenticação: ' || SQLERRM);
END;
/

BEGIN
    inserir_autenticacao(3, 'marianasantos@example.com', 'nova_senha');
END;
/

-- Procedure para inserir dados na tabela tb_cliente

CREATE OR REPLACE PROCEDURE inserir_cliente (
    p_nome_cliente IN VARCHAR2,
    p_cpf_cliente IN INTEGER,
    p_data_nascimento_cliente IN TIMESTAMP,
    p_genero_cliente IN VARCHAR2
) AS
BEGIN
    INSERT INTO tb_cliente (
        id_cliente,
        nome_cliente,
        cpf_cliente,
        data_nascimento_cliente,
        genero_cliente
    ) VALUES (
        (SELECT NVL(MAX(id_cliente), 0) + 1 FROM tb_cliente),
        p_nome_cliente,
        p_cpf_cliente,
        p_data_nascimento_cliente,
        p_genero_cliente
    );
    
    DBMS_OUTPUT.PUT_LINE('Cliente inserido com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir cliente: ' || SQLERRM);
END;
/

BEGIN
    inserir_cliente('Fernanda Oliveira', 12345678901, TO_TIMESTAMP('1990-05-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Feminino');
END;
/

-- Procedure para inserir dados na tabela tb_ia

CREATE OR REPLACE PROCEDURE inserir_ia (
    p_nome_ia IN VARCHAR2,
    p_algoritmo_ia IN VARCHAR2,
    p_dados_treinamento IN VARCHAR2,
    p_desempenho_ia IN VARCHAR2
) AS
BEGIN
    INSERT INTO tb_ia (
        id_ia,
        nome_ia,
        algoritmo_ia,
        dados_treinamento,
        desempenho_ia
    ) VALUES (
        (SELECT NVL(MAX(id_ia), 0) + 1 FROM tb_ia),
        p_nome_ia,
        p_algoritmo_ia,
        p_dados_treinamento,
        p_desempenho_ia
    );
    
    DBMS_OUTPUT.PUT_LINE('IA inserida com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir IA: ' || SQLERRM);
END;
/

BEGIN
    inserir_ia('IA de Tradução', 'Redes Neurais', 'dados_traducao.csv', '85% de precisão');
END;
/

-- Procedure para inserir dados na tabela tb_produto

CREATE OR REPLACE PROCEDURE inserir_produto (
    p_id_cliente IN INTEGER,
    p_id_ia IN INTEGER,
    p_nome_produto IN VARCHAR2,
    p_preco_produto IN INTEGER,
    p_tipo_produto IN VARCHAR2,
    p_descricao_produto IN VARCHAR2
) AS
BEGIN
    INSERT INTO tb_produto (
        id_produto,
        id_cliente,
        id_ia,
        nome_produto,
        preco_produto,
        tipo_produto,
        descricao_produto
    ) VALUES (
        (SELECT NVL(MAX(id_produto), 0) + 1 FROM tb_produto),
        p_id_cliente,
        p_id_ia,
        p_nome_produto,
        p_preco_produto,
        p_tipo_produto,
        p_descricao_produto
    );
    
    DBMS_OUTPUT.PUT_LINE('Produto inserido com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir produto: ' || SQLERRM);
END;
/

BEGIN
    inserir_produto(1, 1, 'Mouse sem Fio', 50, 'Eletrônicos', 'Mouse óptico sem fio, fácil de usar.');
END;
/

-- Procedure para inserir dados na tabela tb_sugestao_ia

CREATE OR REPLACE PROCEDURE inserir_sugestao_ia (
    p_id_ia IN INTEGER,
    p_imagem_sugestao IN BLOB,
    p_descricao_sugestao IN VARCHAR2,
    p_data_sugestao IN TIMESTAMP,
    p_relevancia_sugestao IN INTEGER
) AS
BEGIN
    INSERT INTO tb_sugestao_ia (
        id_sugestao,
        id_ia,
        imagem_sugestao,
        descricao_sugestao,
        data_sugestao,
        relevancia_sugestao
    ) VALUES (
        (SELECT NVL(MAX(id_sugestao), 0) + 1 FROM tb_sugestao_ia),
        p_id_ia,
        p_imagem_sugestao,
        p_descricao_sugestao,
        p_data_sugestao,
        p_relevancia_sugestao
    );
    
    DBMS_OUTPUT.PUT_LINE('Sugestão inserida com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir sugestão: ' || SQLERRM);
END;
/

BEGIN
    inserir_sugestao_ia(2, EMPTY_BLOB(), 'Sugestão de Produto: Mouse Ergonômico', SYSTIMESTAMP, 4);
END;
/

-- Procedure para inserir dados na tabela tb_endereco

CREATE OR REPLACE PROCEDURE inserir_endereco (
    p_id_cliente IN INTEGER,
    p_endereco IN VARCHAR2,
    p_numero IN INTEGER
) AS
BEGIN
    INSERT INTO tb_endereco (
        id_cliente,
        endereco,
        numero
    ) VALUES (
        p_id_cliente,
        p_endereco,
        p_numero
    );
    
    DBMS_OUTPUT.PUT_LINE('Endereço inserido com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir endereço: ' || SQLERRM);
END;
/

BEGIN
    inserir_endereco(1, 'Rua X', 123);
END;
/

-- Criando procedures de UPDATE para as tabelas criadas

-- Procedure de atualização para a tabela tb_avaliacoes

CREATE OR REPLACE PROCEDURE atualizar_avaliacao (
    p_id_avaliacao IN INTEGER,
    p_comentario IN VARCHAR2,
    p_nota_avaliacao IN INTEGER,
    p_status_avaliacao IN VARCHAR2
) AS
BEGIN
    UPDATE tb_avaliacoes
    SET comentario = p_comentario,
        nota_avaliacao = p_nota_avaliacao,
        status_avaliacao = p_status_avaliacao
    WHERE id_avaliacoes = p_id_avaliacao;

    DBMS_OUTPUT.PUT_LINE('Avaliação atualizada com sucesso.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Avaliação não encontrada.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar avaliação: ' || SQLERRM);
END;
/

BEGIN
    atualizar_avaliacao(1, 'Comentário atualizado', 4, 'Reprovado');
END;
/

-- Procedure de atualização para a tabela tb_autentica

CREATE OR REPLACE PROCEDURE atualizar_autenticacao (
    p_id_cliente IN INTEGER,
    p_email_cliente IN VARCHAR2,
    p_senha_cliente IN VARCHAR2
) AS
BEGIN
    UPDATE tb_autentica
    SET senha_cliente = p_senha_cliente
    WHERE id_cliente = p_id_cliente AND email_cliente = p_email_cliente;

    DBMS_OUTPUT.PUT_LINE('Autenticação atualizada com sucesso.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Autenticação não encontrada.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar autenticação: ' || SQLERRM);
END;
/

BEGIN
    atualizar_autenticacao(1, 'anasilva@example.com', 'nova_senha123');
END;
/

-- Procedure de atualização para a tabela tb_cliente

CREATE OR REPLACE PROCEDURE atualizar_cliente (
    p_id_cliente IN INTEGER,
    p_nome_cliente IN VARCHAR2,
    p_cpf_cliente IN INTEGER,
    p_data_nascimento_cliente IN TIMESTAMP,
    p_genero_cliente IN VARCHAR2
) AS
BEGIN
    UPDATE tb_cliente
    SET nome_cliente = p_nome_cliente,
        cpf_cliente = p_cpf_cliente,
        data_nascimento_cliente = p_data_nascimento_cliente,
        genero_cliente = p_genero_cliente
    WHERE id_cliente = p_id_cliente;

    DBMS_OUTPUT.PUT_LINE('Cliente atualizado com sucesso.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Cliente não encontrado.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar cliente: ' || SQLERRM);
END;
/

BEGIN
    atualizar_cliente(1, 'Ana Silva Santos', 98765432109, TO_TIMESTAMP('1985-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Feminino');
END;
/

-- Procedure de atualização para a tabela tb_ia

CREATE OR REPLACE PROCEDURE atualizar_ia (
    p_id_ia IN INTEGER,
    p_nome_ia IN VARCHAR2,
    p_algoritmo_ia IN VARCHAR2,
    p_dados_treinamento IN VARCHAR2,
    p_desempenho_ia IN VARCHAR2
) AS
BEGIN
    UPDATE tb_ia
    SET nome_ia = p_nome_ia,
        algoritmo_ia = p_algoritmo_ia,
        dados_treinamento = p_dados_treinamento,
        desempenho_ia = p_desempenho_ia
    WHERE id_ia = p_id_ia;

    DBMS_OUTPUT.PUT_LINE('IA atualizada com sucesso.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('IA não encontrada.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar IA: ' || SQLERRM);
END;
/

BEGIN
    atualizar_ia(1, 'IA de Recomendação de Produtos', 'Redes Neurais', 'novos_dados.csv', '90% de precisão');
END;
/

-- Procedure de atualização para a tabela tb_produto

CREATE OR REPLACE PROCEDURE atualizar_produto (
    p_id_produto IN INTEGER,
    p_id_cliente IN INTEGER,
    p_id_ia IN INTEGER,
    p_nome_produto IN VARCHAR2,
    p_preco_produto IN INTEGER,
    p_tipo_produto IN VARCHAR2,
    p_descricao_produto IN VARCHAR2
) AS
BEGIN
    UPDATE tb_produto
    SET id_cliente = p_id_cliente,
        id_ia = p_id_ia,
        nome_produto = p_nome_produto,
        preco_produto = p_preco_produto,
        tipo_produto = p_tipo_produto,
        descricao_produto = p_descricao_produto
    WHERE id_produto = p_id_produto;

    DBMS_OUTPUT.PUT_LINE('Produto atualizado com sucesso.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Produto não encontrado.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar produto: ' || SQLERRM);
END;
/

BEGIN
    atualizar_produto(1, 1, 1, 'Notebook Dell Inspiron', 2700, 'Eletrônico', 'Notebook com processador Intel Core i7 e 16GB de RAM.');
END;
/

-- Procedure de atualização para a tabela tb_sugestao_ia

CREATE OR REPLACE PROCEDURE atualizar_sugestao_ia (
    p_id_sugestao IN INTEGER,
    p_id_ia IN INTEGER,
    p_imagem_sugestao IN BLOB,
    p_descricao_sugestao IN VARCHAR2,
    p_data_sugestao IN TIMESTAMP,
    p_relevancia_sugestao IN INTEGER
) AS
BEGIN
    UPDATE tb_sugestao_ia
    SET id_ia = p_id_ia,
        imagem_sugestao = p_imagem_sugestao,
        descricao_sugestao = p_descricao_sugestao,
        data_sugestao = p_data_sugestao,
        relevancia_sugestao = p_relevancia_sugestao
    WHERE id_sugestao = p_id_sugestao;

    DBMS_OUTPUT.PUT_LINE('Sugestão atualizada com sucesso.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Sugestão não encontrada.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar sugestão: ' || SQLERRM);
END;
/

BEGIN
    atualizar_sugestao_ia(1, 1, EMPTY_BLOB(), 'Nova sugestão de produto: Mochila para Notebook', SYSTIMESTAMP, 5);
END;
/


-- Procedure de atualização para a tabela tb_endereco

CREATE OR REPLACE PROCEDURE atualizar_endereco (
    p_id_cliente IN INTEGER,
    p_endereco IN VARCHAR2,
    p_numero IN INTEGER
) AS
BEGIN
    UPDATE tb_endereco
    SET endereco = p_endereco,
        numero = p_numero
    WHERE id_cliente = p_id_cliente;

    DBMS_OUTPUT.PUT_LINE('Endereço atualizado com sucesso.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Endereço não encontrado.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar endereço: ' || SQLERRM);
END;
/

BEGIN
    atualizar_endereco(1, 'Rua Y', 456);
END;
/

-- Procedure de DELETE para a tabela tb_avaliacoes

CREATE OR REPLACE PROCEDURE deletar_avaliacao (
    p_id_avaliacoes IN INTEGER
) AS
BEGIN
    DELETE FROM tb_avaliacoes
    WHERE id_avaliacoes = p_id_avaliacoes;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhuma avaliação encontrada com o ID fornecido.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Avaliação deletada com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar avaliação: ' || SQLERRM);
END deletar_avaliacao;
/

BEGIN
    deletar_avaliacao(1); -- Ou o ID da avaliação que deseja deletar
END;
/

-- Procedure de DELETE para a tabela tb_autentica

CREATE OR REPLACE PROCEDURE deletar_autenticacao (
    p_id_cliente IN INTEGER
) AS
BEGIN
    DELETE FROM tb_autentica
    WHERE id_cliente = p_id_cliente;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhuma autenticação encontrada para o cliente com o ID fornecido.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Autenticação deletada com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar autenticação: ' || SQLERRM);
END deletar_autenticacao;
/

BEGIN
    deletar_autenticacao(1); -- Ou o ID do cliente que deseja deletar a autenticação
END;
/

-- Procedure de DELETE para a tabela tb_cliente

CREATE OR REPLACE PROCEDURE deletar_cliente (
    p_id_cliente IN INTEGER
) AS
BEGIN
    -- Deletar registros dependentes em tb_produto
    DELETE FROM tb_produto
    WHERE id_cliente = p_id_cliente;

    -- Deletar o cliente
    DELETE FROM tb_cliente
    WHERE id_cliente = p_id_cliente;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum cliente encontrado com o ID fornecido.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Cliente deletado com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar cliente: ' || SQLERRM);
END deletar_cliente;
/

BEGIN
    deletar_cliente(1); -- Ou o ID do cliente que deseja deletar
END;
/

--Procedure de DELETE para a tabela tb_ia

CREATE OR REPLACE PROCEDURE deletar_ia (
    p_id_ia IN INTEGER
) AS
BEGIN
    -- Deletar registros dependentes em tb_sugestao_ia
    DELETE FROM tb_sugestao_ia
    WHERE id_ia = p_id_ia;

    -- Deletar a IA
    DELETE FROM tb_ia
    WHERE id_ia = p_id_ia;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhuma IA encontrada com o ID fornecido.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('IA deletada com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar IA: ' || SQLERRM);
END deletar_ia;
/

BEGIN
    deletar_ia(1); -- Ou o ID da IA que deseja deletar
END;
/

--Procedure de DELETE para a tabela tb_produto

CREATE OR REPLACE PROCEDURE deletar_produto (
    p_id_produto IN INTEGER
) AS
BEGIN
    -- Deletar registros dependentes em tb_avaliacoes
    DELETE FROM tb_avaliacoes
    WHERE id_produto = p_id_produto;

    -- Deletar o produto
    DELETE FROM tb_produto
    WHERE id_produto = p_id_produto;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum produto encontrado com o ID fornecido.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Produto deletado com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar produto: ' || SQLERRM);
END deletar_produto;
/

BEGIN
    deletar_produto(1); -- Ou o ID do produto que deseja deletar
END;
/

--Procedure de DELETE para a tabela tb_sugestao_ia 

CREATE OR REPLACE PROCEDURE deletar_sugestao_ia (
    p_id_sugestao IN INTEGER
) AS
BEGIN
    -- Deletar sugestão de IA
    DELETE FROM tb_sugestao_ia
    WHERE id_sugestao = p_id_sugestao;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhuma sugestão de IA encontrada com o ID fornecido.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Sugestão de IA deletada com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar sugestão de IA: ' || SQLERRM);
END deletar_sugestao_ia;
/

BEGIN
    deletar_sugestao_ia(1); -- Ou o ID da sugestão de IA que deseja deletar
END;
/

--Procedure de DELETE para a tabela tb_endereco

CREATE OR REPLACE PROCEDURE deletar_endereco (
    p_id_cliente IN INTEGER
) AS
BEGIN
    -- Deletar endereço do cliente
    DELETE FROM tb_endereco
    WHERE id_cliente = p_id_cliente;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum endereço encontrado para o cliente com o ID fornecido.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Endereço do cliente deletado com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar endereço do cliente: ' || SQLERRM);
END deletar_endereco;
/

BEGIN
    deletar_endereco(1); -- Ou o ID do cliente cujo endereço deseja deletar
END;
/

-- Procedure que faz uso de joins com as tabelas tb_avaliacoes, tb_cliente e tb_produto
CREATE OR REPLACE PROCEDURE listar_avaliacoes IS
    CURSOR c_avaliacoes IS
        SELECT av.id_avaliacoes,
               cl.nome_cliente,
               pr.nome_produto,
               av.comentario,
               av.nota_avaliacao,
               av.data_avaliacao
          FROM tb_avaliacoes av
               JOIN tb_cliente cl ON av.id_cliente = cl.id_cliente
               JOIN tb_produto pr ON av.id_produto = pr.id_produto;
    avaliacao_rec c_avaliacoes%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Avaliações:');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    OPEN c_avaliacoes;
    LOOP
        FETCH c_avaliacoes INTO avaliacao_rec;
        EXIT WHEN c_avaliacoes%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID Avaliação: ' || avaliacao_rec.id_avaliacoes);
        DBMS_OUTPUT.PUT_LINE('Cliente: ' || avaliacao_rec.nome_cliente);
        DBMS_OUTPUT.PUT_LINE('Produto: ' || avaliacao_rec.nome_produto);
        DBMS_OUTPUT.PUT_LINE('Comentário: ' || avaliacao_rec.comentario);
        DBMS_OUTPUT.PUT_LINE('Nota: ' || avaliacao_rec.nota_avaliacao);
        DBMS_OUTPUT.PUT_LINE('Data: ' || TO_CHAR(avaliacao_rec.data_avaliacao, 'YYYY-MM-DD HH24:MI:SS'));
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    END LOOP;
    CLOSE c_avaliacoes;
END;
/

BEGIN
    listar_avaliacoes;
END;
/

-- Procedure que imprima um relatório com pelo menos um regra de negócio

CREATE OR REPLACE PROCEDURE relatorio_vendas IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Relatório de Vendas:');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    FOR cliente_rec IN (
        SELECT c.id_cliente,
               c.nome_cliente,
               SUM(p.preco_produto) AS total_gasto
          FROM tb_cliente c
               JOIN tb_avaliacoes a ON c.id_cliente = a.id_cliente
               JOIN tb_produto p ON a.id_produto = p.id_produto
         GROUP BY c.id_cliente, c.nome_cliente
        HAVING SUM(p.preco_produto) > 300 -- Regra de negócio: Mostrar apenas clientes que gastaram mais de 300
         ORDER BY total_gasto DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('ID Cliente: ' || cliente_rec.id_cliente);
        DBMS_OUTPUT.PUT_LINE('Nome Cliente: ' || cliente_rec.nome_cliente);
        DBMS_OUTPUT.PUT_LINE('Total Gasto: ' || cliente_rec.total_gasto);
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    END LOOP;
END;
/

BEGIN
    relatorio_vendas;
END;
/


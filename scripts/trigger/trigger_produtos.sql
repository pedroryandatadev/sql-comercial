DELIMITER $$

-- Trigger para INSERT
CREATE TRIGGER trg_auditoria_produtos
AFTER INSERT ON Produtos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_produtos (
        operacao, usuario, id_produto,
        nome_novo, descricao_novo, preco_novo, estoque_novo,
        categoria_novo, data_adicionado_novo
    )
    VALUES (
        'INSERT', USER(), NEW.id_produto,
        NEW.nome, NEW.descricao, NEW.preco, NEW.estoque,
        NEW.categoria, NEW.data_adicionado
    );
END$$

-- Trigger para UPDATE
CREATE TRIGGER trg_auditoria_produtos_update
AFTER UPDATE ON Produtos
FOR EACH ROW
BEGIN
    IF OLD.nome <> NEW.nome OR OLD.descricao <> NEW.descricao
        OR OLD.preco <> NEW.preco OR OLD.estoque <> NEW.estoque
        OR OLD.categoria <> NEW.categoria OR OLD.data_adicionado <> NEW.data_adicionado THEN

        INSERT INTO auditoria_produtos (
            operacao, usuario, id_produto,
            nome_anterior, nome_novo,
            descricao_anterior, descricao_novo,
            preco_anterior, preco_novo,
            estoque_anterior, estoque_novo,
            categoria_anterior, categoria_novo,
            data_adicionado_anterior, data_adicionado_novo
        )
        VALUES (
            'UPDATE', USER(), NEW.id_produto,
            OLD.nome, NEW.nome,
            OLD.descricao, NEW.descricao,
            OLD.preco, NEW.preco,
            OLD.estoque, NEW.estoque,
            OLD.categoria, NEW.categoria,
            OLD.data_adicionado, NEW.data_adicionado
        );
    END IF;
END$$

-- Trigger para DELETE
CREATE TRIGGER trg_auditoria_produtos_delete
AFTER DELETE ON Produtos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_produtos (
        operacao, usuario, id_produto,
        nome_anterior, descricao_anterior, preco_anterior,
        estoque_anterior, categoria_anterior, data_adicionado_anterior
    )
    VALUES (
        'DELETE', USER(), OLD.id_produto,
        OLD.nome, OLD.descricao, OLD.preco,
        OLD.estoque, OLD.categoria, OLD.data_adicionado
    );
END$$

DELIMITER ;

DELIMITER $$

-- Trigger para INSERT
CREATE TRIGGER trg_clientes_insert
AFTER INSERT ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_clientes (
        operacao, usuario, id_cliente,
        nome_novo, email_novo, telefone_novo, endereco_novo, data_cadastro_novo
    )
    VALUES (
        'INSERT', USER(), NEW.id_cliente,
        NEW.nome, NEW.email, NEW.telefone, NEW.endereco, NEW.data_cadastro
    );
END$$

-- Trigger para UPDATE
CREATE TRIGGER trg_clientes_update
AFTER UPDATE ON Clientes
FOR EACH ROW
BEGIN
    IF OLD.nome <> NEW.nome
        OR OLD.email <> NEW.email
        OR OLD.telefone <> NEW.telefone
        OR OLD.endereco <> NEW.endereco
        OR OLD.data_cadastro <> NEW.data_cadastro THEN

        INSERT INTO auditoria_clientes (
            operacao, usuario, id_cliente,
            nome_anterior, nome_novo,
            email_anterior, email_novo,
            telefone_anterior, telefone_novo,
            endereco_anterior, endereco_novo,
            data_cadastro_anterior, data_cadastro_novo
        )
        VALUES (
            'UPDATE', USER(), NEW.id_cliente,
            OLD.nome, NEW.nome,
            OLD.email, NEW.email,
            OLD.telefone, NEW.telefone,
            OLD.endereco, NEW.endereco,
            OLD.data_cadastro, NEW.data_cadastro
        );
    END IF;
END$$

-- Trigger para DELETE
CREATE TRIGGER trg_clientes_delete
AFTER DELETE ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_clientes (
        operacao, usuario, id_cliente,
        nome_anterior, email_anterior, telefone_anterior, endereco_anterior, data_cadastro_anterior
    )
    VALUES (
        'DELETE', USER(), OLD.id_cliente,
        OLD.nome, OLD.email, OLD.telefone, OLD.endereco, OLD.data_cadastro
    );
END$$

DELIMITER ;
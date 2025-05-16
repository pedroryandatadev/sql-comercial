-- Trigger para atualizar o estoque após a inserção de um item no pedido
-- Ele diminuirá a quantidade do produto de acordo com a quantidade do item inserido na tabela ItensPedido
DELIMITER $$

CREATE TRIGGER trg_baixa_estoque
AFTER INSERT ON ItensPedido
FOR EACH ROW
BEGIN
    UPDATE Produtos
    SET estoque = estoque - NEW.quantidade
    WHERE id_produto = NEW.id_produto;
END$$

DELIMITER ;

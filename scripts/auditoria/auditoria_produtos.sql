-- Tabela de auditoria
-- Esta tabela armazena dados anteiores e novos de produtos de acordo com o tipo de operação realizada (INSERT, UPDATE ou DELETE).
CREATE TABLE auditoria_produtos (
    id_auditoria INT PRIMARY KEY AUTO_INCREMENT,
    operacao VARCHAR(10),
    usuario VARCHAR(100),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_produto INT,
    nome_anterior VARCHAR(100),
    nome_novo VARCHAR(100),
    descricao_anterior TEXT,
    descricao_novo TEXT,
    preco_anterior DECIMAL(10,2),
    preco_novo DECIMAL(10,2),
    estoque_anterior INT,
    estoque_novo INT,
    categoria_anterior VARCHAR(50),
    categoria_novo VARCHAR(50),
    data_adicionado_anterior TIMESTAMP,
    data_adicionado_novo TIMESTAMP
);
-- Auditoria de Clientes
-- Esta tabela armazena dados anteiores e novos de clientes de acordo com o tipo de operação realizada (INSERT, UPDATE ou DELETE).
CREATE TABLE auditoria_clientes (
    id_auditoria INT PRIMARY KEY AUTO_INCREMENT,
    operacao VARCHAR(10),
    usuario VARCHAR(100),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_cliente INT,
    nome_anterior VARCHAR(100),
    nome_novo VARCHAR(100),
    email_anterior VARCHAR(100),
    email_novo VARCHAR(100),
    telefone_anterior VARCHAR(20),
    telefone_novo VARCHAR(20),
    endereco_anterior TEXT,
    endereco_novo TEXT,
    data_cadastro_anterior TIMESTAMP,
    data_cadastro_novo TIMESTAMP
);
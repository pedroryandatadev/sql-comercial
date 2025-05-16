-- Relatório de Vendas
-- E exibido ID do pedido, a data do pedido, o nome do cliente, o nome do produto, a quantidade vendida, preço unitário e o total da venda.
SELECT 
    p.id_pedido AS venda_id,
    p.data_pedido AS data,
    c.nome AS cliente,
    pr.nome AS produto,
    ip.quantidade AS quantidade,
    ip.preco_unitario AS preco_unitario,
    ip.subtotal AS total_venda
FROM 
    pedidos p
INNER JOIN 
    clientes c ON p.id_cliente = c.id_cliente
INNER JOIN 
    itenspedido ip ON p.id_pedido = ip.id_pedido
INNER JOIN 
    produtos pr ON ip.id_produto = pr.id_produto
ORDER BY 
    p.data_pedido DESC;


-- Relatório de Pagamentos
-- E exibido a quantidade de pagamentos por método de pagamento especifico, mostrando qual forma de pagamento e mais usado.
SELECT metodo_pagamento, COUNT(*) AS total 
FROM pagamentos GROUP BY metodo_pagamento;


-- Relatório de Produtos Vendidos
-- E exibido o nome do produto e a quantidade vendida, mostrando quais produtos foram mais vendidos.
SELECT 
    p.nome AS Produto,
    SUM(ip.quantidade) AS Quantidade
FROM 
    produtos p
INNER JOIN
    itenspedido ip ON p.id_produto = ip.id_produto
GROUP BY 
    p.nome;
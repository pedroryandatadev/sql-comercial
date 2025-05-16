import pandas as pd
from sqlalchemy import create_engine
import os
from dotenv import load_dotenv

load_dotenv()

# Conexão com o MySQL
engine = create_engine(f'mysql+pymysql://{os.getenv("BD_USER")}:{os.getenv("BD_PASSWORD")}@{os.getenv("BD_HOST")}/{os.getenv("BD_NAME")}')

# Mapeamento de arquivos para tabelas
arquivos_tabelas = {
    'clientes.csv': 'clientes',
    'produtos.csv': 'produtos',
    'pedidos.csv': 'pedidos',
    'itens_pedido.csv': 'itenspedido',
    'pagamentos.csv': 'pagamentos'
}

caminho_arquivos = 'data/'

for arquivo, tabela in arquivos_tabelas.items():
    caminho_final = os.path.join(caminho_arquivos, arquivo)
    
    try:
        if not os.path.exists(caminho_final):
            print(f"Arquivo não encontrado: {caminho_final}")
            continue
            
        print(f'Importando {arquivo} para {tabela}...')
        
        # Ler CSV com tratamento de encoding
        # Tenta ler o arquivo com utf-8, se falhar tenta com latin1
        # Para prevenir erros de encoding e garantir que o arquivo seja lido corretamente
        try:
            df = pd.read_csv(caminho_final, sep=';', encoding='utf-8')
        except UnicodeDecodeError:
            df = pd.read_csv(caminho_final, sep=';', encoding='latin1')
        
        # Tratamento especial para cada tabela
        # Pedidos, Produtos e Pagamentos tem datas em formato diferente do MySQL
        if tabela == 'pedidos':
            df['data_pedido'] = pd.to_datetime(df['data_pedido'], format='%d/%m/%Y').dt.strftime('%Y-%m-%d')

        if tabela == 'produtos':
            df['data_adicionado'] = pd.to_datetime(df['data_adicionado'], format='%d/%m/%Y').dt.strftime('%Y-%m-%d')
        
        if tabela == 'pagamentos':
            df['data_pagamento'] = pd.to_datetime(df['data_pagamento'], format='%d/%m/%Y').dt.strftime('%Y-%m-%d')
        
        # Inserir no banco
        df.to_sql(tabela, con=engine, if_exists='append', index=False)
        
        print(f"Sucesso: {arquivo} -> {tabela}")
        
    except Exception as e:
        print(f"Erro ao processar {arquivo}: {str(e)}")

print('Importação concluída!')
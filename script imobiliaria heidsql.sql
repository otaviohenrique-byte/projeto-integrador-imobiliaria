CREATE imobiliaria
GO

USE imobiliaria;
GO

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE, -- Adicionado UNIQUE para boas práticas
    telefone VARCHAR(30),
	 adm TINYINT(1) NOT NULL DEFAULT 0,
    -- Como o usuário agora "possui" imóveis, campos de "contato/interesse" diretos aqui 
    -- geralmente saem daqui, mas mantive o tipo_interesse caso seja o perfil do usuário.
    tipo_interesse VARCHAR(50) CHECK (tipo_interesse IN ('Comprar', 'Alugar', 'Informação')), 
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 1. Tabela de usuários (criada primeiro, pois imóveis vai depender dela)
CREATE TABLE administrador (
    idadm INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE, -- Adicionado UNIQUE para boas práticas
    telefone VARCHAR(30),
    adm TINYINT(1) NOT NULL DEFAULT 1,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabela de imóveis (Alterada: agora recebe a FK de usuarios)
CREATE TABLE imoveis (
    id INT AUTO_INCREMENT PRIMARY KEY,
    administrador_id INT NOT NULL, -- O usuário/corretor que cadastrou/possui o imóvel
    referencia VARCHAR(100) NOT NULL UNIQUE,
    tipo_negocio VARCHAR(50) NOT NULL CHECK (tipo_negocio IN ('Aluguel', 'Venda')), 
    tipo_imovel VARCHAR(50) NOT NULL CHECK (tipo_imovel IN ('Casa', 'Apartamento', 'Terreno')), 
    titulo VARCHAR(255) NOT NULL,
    descricao LONGTEXT,
    preco DECIMAL(15,2),
    bairro VARCHAR(150),
    cidade VARCHAR(150),
    estado VARCHAR(100),
    quartos INT DEFAULT 0,
    banheiros INT DEFAULT 0,
    vagas INT DEFAULT 0,
    area_m2 DECIMAL(10,2),
    destaque TINYINT(1) NOT NULL DEFAULT 0, 
    ativo TINYINT(1) NOT NULL DEFAULT 1,     
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    -- Configuração do relacionamento: Um usuário tem muitos imóveis
    CONSTRAINT fk_imoveis_usuario
        FOREIGN KEY (administrador_id)
        REFERENCES administrador(idadm)
        ON DELETE CASCADE -- Se deletar o usuário, os imóveis dele são deletados (ajuste se preferir SET NULL)
);

-- 3. Tabela de fotos dos imóveis (Mantida: Um imóvel tem muitas fotos)
CREATE TABLE fotos_imovel (
    id INT AUTO_INCREMENT PRIMARY KEY,
    imovel_id INT NOT NULL,
    url_imagem VARCHAR(500) NOT NULL,
    alt_texto VARCHAR(255),
    ordem INT DEFAULT 1,
    capa TINYINT(1) NOT NULL DEFAULT 0, 
    CONSTRAINT fk_fotos_imovel
        FOREIGN KEY (imovel_id)
        REFERENCES imoveis(id)
        ON DELETE CASCADE
);
GO

-- Índices auxiliares para pesquisas
CREATE INDEX idx_imoveis_cidade ON imoveis(cidade);
CREATE INDEX idx_imoveis_estado ON imoveis(estado);
CREATE INDEX idx_imoveis_bairro ON imoveis(bairro);
CREATE INDEX idx_imoveis_tipo_negocio ON imoveis(tipo_negocio);
CREATE INDEX idx_imoveis_tipo_imovel ON imoveis(tipo_imovel);
CREATE INDEX idx_imoveis_destaque ON imoveis(destaque);
CREATE INDEX idx_imoveis_ativo ON imoveis(ativo);
CREATE INDEX idx_fotos_imovel_imovel_id ON fotos_imovel(imovel_id);
GO
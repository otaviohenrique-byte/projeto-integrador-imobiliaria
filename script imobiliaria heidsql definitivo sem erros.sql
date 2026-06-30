CREATE DATABASE imobiliaria;
GO

USE imobiliaria;
GO

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    telefone VARCHAR(30),
    adm TINYINT(1) NOT NULL DEFAULT 0,
    tipo_interesse VARCHAR(50) CHECK (tipo_interesse IN ('Comprar', 'Alugar', 'Informação')),
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE imoveis (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    referencia VARCHAR(100) NOT NULL UNIQUE,
    tipo_negocio VARCHAR(50) NOT NULL CHECK (tipo_negocio IN ('Aluguel', 'Venda')),
    tipo_imovel VARCHAR(50) NOT NULL CHECK (tipo_imovel IN ('Casa', 'Apartamento', 'Terreno')),
    titulo VARCHAR(255) NOT NULL,
    descricao LONGTEXT,
    preco DECIMAL(15,2),
    endereco VARCHAR(255),
    bairro VARCHAR(150),
    cidade VARCHAR(150),
    estado VARCHAR(100),
    link_mapa VARCHAR(500),
    quartos INT DEFAULT 0,
    banheiros INT DEFAULT 0,
    vagas INT DEFAULT 0,
    area_m2 DECIMAL(10,2),
    destaque TINYINT(1) NOT NULL DEFAULT 0,
    ativo TINYINT(1) NOT NULL DEFAULT 1,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_imoveis_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
        ON DELETE CASCADE
);

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
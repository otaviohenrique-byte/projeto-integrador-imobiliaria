CREATE imobiliaria
GO

USE imobiliaria;
GO

Table "usuarios" {
  "id" INT [pk, increment]
  "nome" VARCHAR(150) [not null]
  "email" VARCHAR(255) [unique, not null]
  "senha" VARCHAR(255) [not null]
  "telefone" VARCHAR(30)
  "adm" TINYINT(1) [not null, default: 0]
  "tipo_interesse" VARCHAR(50) [check: `tipo_interesse IN ('Comprar', 'Alugar', 'Informação')`]
  "criado_em" DATETIME [default: `CURRENT_TIMESTAMP`]
}

Table "imoveis" {
  "id" INT [pk, increment]
  "usuario_id" INT [not null]
  "referencia" VARCHAR(100) [unique, not null]
  "tipo_negocio" VARCHAR(50) [not null, check: `tipo_negocio IN ('Aluguel', 'Venda')`]
  "tipo_imovel" VARCHAR(50) [not null, check: `tipo_imovel IN ('Casa', 'Apartamento', 'Terreno', 'Comercial')`]
  "titulo" VARCHAR(255) [not null]
  "descricao" LONGTEXT
  "preco" DECIMAL(15,2)
  "endereco" VARCHAR(255)
  "bairro" VARCHAR(150)
  "cidade" VARCHAR(150)
  "estado" VARCHAR(100)
  "link_mapa" VARCHAR(500)
  "quartos" INT [default: 0]
  "banheiros" INT [default: 0]
  "vagas" INT [default: 0]
  "area_m2" DECIMAL(10,2)
  "destaque" TINYINT(1) [not null, default: 0]
  "ativo" TINYINT(1) [not null, default: 1]
  "criado_em" DATETIME [default: `CURRENT_TIMESTAMP`]

  Indexes {
    cidade [name: "idx_imoveis_cidade"]
    estado [name: "idx_imoveis_estado"]
    bairro [name: "idx_imoveis_bairro"]
    tipo_negocio [name: "idx_imoveis_tipo_negocio"]
    tipo_imovel [name: "idx_imoveis_tipo_imovel"]
    destaque [name: "idx_imoveis_destaque"]
    ativo [name: "idx_imoveis_ativo"]
  }
}

Table "fotos_imovel" {
  "id" INT [pk, increment]
  "imovel_id" INT [not null]
  "url_imagem" VARCHAR(500) [not null]
  "alt_texto" VARCHAR(255)
  "ordem" INT [default: 1]
  "capa" TINYINT(1) [not null, default: 0]

  Indexes {
    imovel_id [name: "idx_fotos_imovel_imovel_id"]
  }
}

Ref "fk_imoveis_usuario":"usuarios"."id" < "imoveis"."usuario_id" [delete: cascade]

Ref "fk_fotos_imovel":"imoveis"."id" < "fotos_imovel"."imovel_id" [delete: cascade]

CREATE TABLE FATO_Venda(
	id_venda int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	id_cliente INT  NOT NULL,
	id_funcionario INT  NOT NULL,
	id_pagamento INT  NOT NULL,
	id_tempo INT  NOT NULL,
	id_loja INT  NOT NULL,
	id_produto INT  NOT NULL,
	id_data_comemorativa INT  NOT NULL,
	quantidade INT NOT NULL,
	valor DECIMAL(10,2) NOT NULL
)


CREATE TABLE FATO_Producao(
    id_producao int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	id_tempo INT  NOT NULL,
	id_produto INT  NOT NULL
)


CREATE TABLE FATO_Promocao(
	id_fato_promocao int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	id_loja INT  NOT NULL,
	id_data_comemorativa DATETIME NOT NULL,
	id_promocao INT NOT NULL,
	id_produto INT  NOT NULL,
	quantidade INT NOT NULL
)


CREATE TABLE FATO_Saida(
	id_producao int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	id_produto INT  NOT NULL,
	id_loja INT  NOT NULL,
	id_tempo INT  NOT NULL,
	quantidade INT NOT NULL
)


CREATE TABLE FATO_Venda_Agregado(
	id_venda int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	id_tempo INT  NOT NULL,
	id_loja INT  NOT NULL,
	quantidade INT NOT NULL,
	valor DECIMAL(10,2) NOT NULL
)

CREATE TABLE FATO_Promocao_Agregado(
	id_fato_promocao int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	id_loja INT  NOT NULL,
	id_data_comemorativa DATETIME NOT NULL,
	id_produto INT  NOT NULL,
	quantidade INT NOT NULL
)



CREATE TABLE FATO_Saida_Agregado(
	id_producao int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	id_produto INT  NOT NULL,
	id_tempo INT  NOT NULL,
	quantidade INT NOT NULL
)







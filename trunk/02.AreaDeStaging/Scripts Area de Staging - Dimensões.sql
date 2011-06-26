CREATE TABLE TB_Aux_Produto(
data_carga DATETIME NOT NULL,
codigo INT  NOT NULL,
codigo_barra INT NULL,
descricao VARCHAR(25)NULL,
linha VARCHAR(20)NULL,
valor NUMERIC(10,2)NULL
)

CREATE TABLE TB_Aux_Cliente(
	data_carga DATETIME NOT NULL,
	cod_cliente INT  NOT NULL,
	cpf VARCHAR(11) NOT NULL,
	nome VARCHAR(30) NOT NULL, 
	data_nascimento DATE NOT NULL,
	endereco VARCHAR(45) NOT NULL, 
	bairro VARCHAR(20) NOT NULL,
	cidade VARCHAR(20) NOT NULL
)


CREATE TABLE TB_Aux_Funcionario(
	data_carga DATETIME NOT NULL,
	cod_funcionario INT  NOT NULL,
	cpf VARCHAR(11) NOT NULL,
	nome VARCHAR(30) NOT NULL, 
	data_nascimento DATE NOT NULL, 
	data_admissao DATE NOT NULL,
	endereco TEXT NOT NULL, 
	bairro VARCHAR(20) NOT NULL,
	cidade VARCHAR(20) NOT NULL
)


CREATE TABLE TB_Aux_Loja(
	data_carga DATETIME NOT NULL,
	cod_loja INT  NOT NULL,
	nome VARCHAR(20)NOT NULL,
	regiao VARCHAR(20)NOT NULL,
	estado VARCHAR(20)NOT NULL,
	cidade VARCHAR(20)NOT NULL
)

CREATE TABLE TB_Aux_Promocao(
	data_carga DATETIME NOT NULL,
	cod_promocao INT  NOT NULL,
	descricao VARCHAR(30)NOT NULL,
	data_inicial DATETIME NOT NULL, 
	data_final DATETIME NOT NULL,
	desconto NUMERIC(10,2) NOT NULL
)


CREATE TABLE TB_Aux_Data_Comemorativa(
	data_carga DATETIME NOT NULL,
	cod_data_comemorativa INT  NOT NULL,
	descricao VARCHAR(25)NOT NULL,
	data_comemorativa DATETIME NOT NULL
)

CREATE TABLE TB_Aux_Pagamento(
	data_carga DATETIME NOT NULL,
	cod_pagamento INT  NOT NULL,
	forma_pagamento VARCHAR(10) NOT NULL
)





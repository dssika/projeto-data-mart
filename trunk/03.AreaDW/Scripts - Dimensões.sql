CREATE TABLE DIM_Tempo(
	Id_Tempo int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Nivel varchar(8) NOT NULL,
	Data datetime NULL,
	Dia smallint NULL,
	DiaSemana varchar(25) NULL,
	FimSemana char(3) NULL,
	Quinzena smallint NULL,
	Mes smallint NULL,
	NomeMes varchar(20) NULL,
	FimMes char(3) NULL,
	Trimestre smallint NULL,
	NomeTrimestre varchar(20)  NULL,
	Semestre smallint NULL,
	NomeSemestre varchar(20) NULL,
	Ano smallint NOT NULL,
	Estacao varchar(9) NULL
)

CREATE TABLE DIM_Produto(
	id_produto INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	codigo INT  NOT NULL,
	codigo_barra INT NOT NULL,
	descricao VARCHAR(25)NOT NULL,
	linha VARCHAR(20)NOT NULL,
	valor NUMERIC(10,2)NOT NULL,
	dt_inicio DATETIME NOT NULL,
	dt_fim DATETIME NULL,
	fl_corrente VARCHAR(3) NOT NULL CHECK (fl_corrente IN ('SIM','NAO'))
)

CREATE TABLE DIM_Promocao(
	id_promocao INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	cod_promocao INT  NOT NULL,
	descricao VARCHAR(25)NOT NULL,
	data_inicial DATETIME NOT NULL, 
	data_final DATETIME NULL
)

CREATE TABLE DIM_Loja(
	id_loja INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	cod_loja INT  NOT NULL,
	nome VARCHAR(20)NOT NULL,
	cidade VARCHAR(20)NOT NULL,
	estado VARCHAR(20)NOT NULL,
	regiao VARCHAR(20)NOT NULL
)

CREATE TABLE DIM_Data_Comemorativa(
	id_data_comemorativa INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	cod_data_comemorativa INT  NOT NULL,
	descricao VARCHAR(25)NOT NULL,
	data_comemorativa DATETIME NOT NULL
)

CREATE TABLE DIM_Funcionario(
	id_funcionario INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	cod_funcionario INT  NOT NULL,
	cpf VARCHAR(11) NOT NULL,
	nome VARCHAR(15) NOT NULL, 
	data_nascimento DATE NOT NULL, 
	data_admissao DATE NOT NULL,
	endereco VARCHAR(45) NOT NULL, 
	bairro VARCHAR(45) NOT NULL,
	cidade VARCHAR(45) NOT NULL
)

CREATE TABLE DIM_Pagamento(
	id_pagamento INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	cod_pagamento INT  NOT NULL,
	forma_pagamento VARCHAR(10) NOT NULL
)


CREATE TABLE DIM_Cliente(
	id_cliente INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	cod_cliente INT  NOT NULL,
	cpf VARCHAR(11) NOT NULL,
	nome VARCHAR(15) NOT NULL, 
	data_admissao DATE NOT NULL,
	endereco VARCHAR(45) NOT NULL, 
	bairro VARCHAR(45) NOT NULL,
	cidade VARCHAR(45) NOT NULL
)


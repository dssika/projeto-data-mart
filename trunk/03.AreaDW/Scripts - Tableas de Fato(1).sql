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
	
	CONSTRAINT fk_FATO_Venda_DIM_Cliente FOREIGN KEY(id_cliente) REFERENCES DIM_Cliente (id_cliente),
	CONSTRAINT fk_FATO_Venda_DIM_Funcionario FOREIGN KEY(id_funcionario) REFERENCES DIM_Funcionario (id_funcionario),
	CONSTRAINT fk_FATO_Venda_DIM_Pagamento FOREIGN KEY(id_pagamento) REFERENCES DIM_Pagamento (id_pagamento),
	CONSTRAINT fk_FATO_Venda_DIM_Tempo FOREIGN KEY(id_tempo) REFERENCES DIM_Tempo (id_tempo),
	CONSTRAINT fk_FATO_Venda_DIM_Loja FOREIGN KEY(id_loja) REFERENCES DIM_Loja (id_loja),
	CONSTRAINT fk_FATO_Venda_DIM_Produto FOREIGN KEY(id_produto) REFERENCES DIM_Produto (id_produto),
	CONSTRAINT fk_FATO_Venda_DIM_Data_Comemorativa FOREIGN KEY(id_cliente) REFERENCES DIM_Cliente (id_cliente),
	
)


CREATE TABLE FATO_Producao(
    id_producao int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	id_tempo INT  NOT NULL,
	id_produto INT  NOT NULL
		
	CONSTRAINT fk_FATO_Producao_DIM_Tempo FOREIGN KEY(Id_Tempo) REFERENCES DIM_Tempo (Id_Tempo),
	CONSTRAINT fk_FATO_Producao_DIM_Produto FOREIGN KEY(Id_Produto) REFERENCES DIM_Produto(Id_Produto)
)


CREATE TABLE FATO_Promocao(
	id_fato_promocao int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	id_loja INT  NOT NULL,
	id_data_comemorativa INT NOT NULL,
	id_promocao INT NOT NULL,
	id_produto INT  NOT NULL,
	quantidade INT NOT NULL
	
	CONSTRAINT fk_FATO_Promocao_DIM_Loja FOREIGN KEY(id_loja) REFERENCES DIM_Loja (id_loja),
	CONSTRAINT fk_FATO_Promocao_DIM_Data_Comemorativa FOREIGN KEY(id_data_comemorativa) REFERENCES DIM_Data_Comemorativa(id_data_comemorativa),
	CONSTRAINT fk_FATO_Promocao_DIM_promocao FOREIGN KEY(id_promocao) REFERENCES DIM_Promocao (id_promocao),
	CONSTRAINT fk_FATO_Promocao_DIM_produto FOREIGN KEY(id_produto) REFERENCES DIM_Produto (id_produto)
)


CREATE TABLE FATO_Saida(
	id_saida int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	id_produto INT  NOT NULL,
	id_loja INT  NOT NULL,
	id_tempo INT  NOT NULL,
	quantidade INT NOT NULL
	
	CONSTRAINT fk_FATO_Saida_DIM_Produto FOREIGN KEY(id_produto) REFERENCES DIM_Produto (id_produto),
	CONSTRAINT fk_FATO_Saida_DIM_Loja FOREIGN KEY(id_loja) REFERENCES DIM_Loja (id_loja),
	CONSTRAINT fk_FATO_Saida_DIM_Tempo FOREIGN KEY(id_tempo) REFERENCES DIM_Tempo (id_tempo)	
)


CREATE TABLE FATO_Venda_Agregado(
	id_venda int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	id_tempo INT  NOT NULL,
	id_loja INT  NOT NULL,
	quantidade INT NOT NULL,
	valor DECIMAL(10,2) NOT NULL
	
	CONSTRAINT fk_FATO_Venda_Agregado_DIM_Tempo FOREIGN KEY(id_tempo) REFERENCES DIM_Tempo (id_tempo),
	CONSTRAINT fk_FATO_Venda_Agregado_DIM_Loja FOREIGN KEY(id_loja) REFERENCES DIM_Loja (id_loja),
	
)

CREATE TABLE FATO_Promocao_Agregado(
	id_fato_promocao int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	id_loja INT  NOT NULL,
	id_data_comemorativa DATETIME NOT NULL,
	quantidade INT NOT NULL
	
	CONSTRAINT fk_FATO_Promocao_Agregado_DIM_Loja FOREIGN KEY(id_loja) REFERENCES DIM_Loja (id_loja),
	CONSTRAINT fk_FATO_Promocao_Agregado_DIM_Data_Comemorativa FOREIGN KEY(id_data_comemorativa) REFERENCES DIM_Data_Comemorativa(id_data_comemorativa),
)




CREATE TABLE FATO_Saida_Agregado(
	id_producao int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	id_produto INT  NOT NULL,
	id_tempo INT  NOT NULL,
	quantidade INT NOT NULL
	
	CONSTRAINT fk_FATO_Saida_Agregado_DIM_Produto FOREIGN KEY(id_produto) REFERENCES DIM_Produto (id_produto),
	CONSTRAINT fk_FATO_Saida_Agregado_DIM_Tempo FOREIGN KEY(id_tempo) REFERENCES DIM_Tempo (id_tempo)
	
)







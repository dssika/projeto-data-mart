CREATE TABLE TB_Aux_Fato_Venda(
	data_carga DATETIME NOT NULL,
	cod_venda INT NOT NULL,	
	cod_cliente INT  NOT NULL,
	cod_funcionario INT  NOT NULL,
	cod_pagamento INT  NOT NULL,
	cod_loja INT  NOT NULL,
	cod_produto INT  NOT NULL,
	cod_data_comemorativa INT  NOT NULL,
	data_venda DATETIME NOT NULL,
	valor DECIMAL(10,2) NOT NULL
)

CREATE TABLE TB_Violacao_Fato_Venda(
	data_erro DATETIME NOT NULL,
	descricao VARCHAR(max),
	data_carga DATETIME NOT NULL,
	cod_cliente INT  NOT NULL,
	cod_funcionario INT  NOT NULL,
	cod_pagamento INT  NOT NULL,
	cod_loja INT  NOT NULL,
	cod_produto INT  NOT NULL,
	cod_data_comemorativa INT  NOT NULL,
	data_venda DATETIME NOT NULL,
	valor DECIMAL(10,2) NOT NULL
)


CREATE TABLE TB_AUX_CLIENTE (
  id_AUX_CLIENTE INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  DATA_CARGA DATETIME NOT NULL ,
  COD_CLIENTE INT NOT NULL ,
  CPF VARCHAR(11) NULL ,
  NOME VARCHAR(30) NULL ,
  DATA_NASCIMENTO DATETIME NULL ,
  ENDERECO VARCHAR(45) NULL ,
  BAIRRO VARCHAR(20) NULL ,
  CIDADE VARCHAR(20) NULL )



CREATE  TABLE TB_AUX_DATA_COMEMORATIVA (
  id_AUX_DATA_COMEMORATIVA INT IDENTITY(1,1) NOT NULL ,
  COD_DATA_COMEMORATIVA INT NULL ,
  DESCRICAO VARCHAR(25) NULL ,
  DATA_COMEMORATIVA DATETIME NULL ,
  PRIMARY KEY (id_AUX_DATA_COMEMORATIVA) )



CREATE  TABLE TB_AUX_PAGAMENTO (
  id_AUX_PAGAMENTO INT IDENTITY(1,1) NOT NULL ,
  COD_PAGAMENTO INT NULL ,
  FORMA_PAGAMENTO VARCHAR(10) NULL ,
  PRIMARY KEY (id_AUX_PAGAMENTO) )



CREATE  TABLE TB_AUX_FUNCIONARIO (
  id_AUX_FUNCIONARIO INT IDENTITY(1,1) NOT NULL ,
  COD_FUNCIONARIO INT NULL ,
  CPF VARCHAR(11) NULL ,
  NOME VARCHAR(30) NULL ,
  DATA_NASCIMENTO DATETIME NULL ,
  DATA_ADMISSAO DATETIME NULL ,
  ENDERECO VARCHAR(45) NULL ,
  BAIRRO VARCHAR(20) NULL ,
  CIDADE VARCHAR(20) NULL ,
  PRIMARY KEY (id_AUX_FUNCIONARIO) )



CREATE  TABLE TB_AUX_LOJA (
  id_AUX_LOJA INT IDENTITY(1,1) NOT NULL ,
  COD_LOJA INT NULL ,
  NOME VARCHAR(20) NULL ,
  CIDADE VARCHAR(20) NULL ,
  ESTADO VARCHAR(20) NULL ,
  REGIAO VARCHAR(20) NULL ,
  PRIMARY KEY (id_AUX_LOJA) )


CREATE  TABLE TB_AUX_PRODUCAO (
  id_AUX_PRODUCAO INT IDENTITY(1,1) NOT NULL ,
  LOTE INT NULL ,
  DESCRICAO VARCHAR(20) NULL ,
  DATA_FABRICACAO VARCHAR(20) NULL ,
  QUANTIDADE INT NULL ,
  PRIMARY KEY (id_AUX_PRODUCAO) )


CREATE  TABLE TB_AUX_PRODUTO (
  id_AUX_PRODUTO INT IDENTITY(1,1) NOT NULL ,
  COD INT NULL ,
  COD_BARRA INT NULL ,
  DESCRICAO VARCHAR(25) NULL ,
  LINHA VARCHAR(20) NULL ,
  VALOR DECIMAL(10,2)  NULL ,
  PRIMARY KEY (id_AUX_PRODUTO) )



CREATE  TABLE TB_AUX_PROMOCOES (
  idTB_AUX_PROMOCOES INT IDENTITY(1,1) NOT NULL ,
  COD_PROMOCAO INT NULL ,
  DESCRICAO VARCHAR(30) NULL ,
  DATA_INICIAL DATETIME NULL ,
  DATA_FINAL DATETIME NULL ,
  PRIMARY KEY (idTB_AUX_PROMOCOES) )


CREATE  TABLE TB_AUX_VENDA (
  id_AUX_VENDA INT IDENTITY(1,1) NOT NULL ,
  COD_VENDA INT NULL ,
  id_AUX_CLIENTE INT NOT NULL ,
  id_AUX_FUNCIONARIO INT NOT NULL ,
  id_AUX_PAGAMENTO INT NOT NULL ,
  id_AUX_LOJA INT NOT NULL ,
  id_AUX_PRODUTO INT NOT NULL ,
  id_AUX_DATA_COMEMORATIVA INT NOT NULL ,
  VALOR_TOTAL DECIMAL(10,2)  NULL ,
  DATA_VENDA DATETIME NULL ,
  PRIMARY KEY (id_AUX_VENDA) ,
  
  FOREIGN KEY(id_AUX_CLIENTE)
    REFERENCES TB_AUX_CLIENTE(id_AUX_CLIENTE),
  FOREIGN KEY (id_AUX_FUNCIONARIO )
    REFERENCES TB_AUX_FUNCIONARIO (id_AUX_FUNCIONARIO ),
     FOREIGN KEY (id_AUX_PAGAMENTO )
    REFERENCES TB_AUX_PAGAMENTO (id_AUX_PAGAMENTO),
    FOREIGN KEY (id_AUX_LOJA )
    REFERENCES TB_AUX_LOJA (id_AUX_LOJA ),
    FOREIGN KEY (id_AUX_PRODUTO )
    REFERENCES TB_AUX_PRODUTO (id_AUX_PRODUTO ),    
    FOREIGN KEY (id_AUX_DATA_COMEMORATIVA )
    REFERENCES TB_AUX_DATA_COMEMORATIVA (id_AUX_DATA_COMEMORATIVA ));
 
GO

 /*
  INDEX fk_TB_AUX_VENDA_TB_AUX_CLIENTE (id_AUX_CLIENTE ASC) ,
  INDEX fk_TB_AUX_VENDA_TB_AUX_FUNCIONARIO1 (id_AUX_FUNCIONARIO ASC) ,
  INDEX fk_TB_AUX_VENDA_TB_AUX_PAGAMENTO1 (id_AUX_PAGAMENTO ASC) ,
  INDEX fk_TB_AUX_VENDA_TB_AUX_LOJA1 (id_AUX_LOJA ASC) ,
  INDEX fk_TB_AUX_VENDA_TB_AUX_PRODUTO1 (id_AUX_PRODUTO ASC) ,
  INDEX fk_TB_AUX_VENDA_TB_AUX_DATA_COMEMORATIVA1 (id_AUX_DATA_COMEMORATIVA ASC) ,
  */
CREATE TABLE TB_Loja (
  codigo INT  NOT NULL   IDENTITY ,
  nome VARCHAR(20)  NOT NULL  ,
  regiao VARCHAR(20)   NOT NULL ,
  estado VARCHAR(20)  NOT NULL  ,
  cidade VARCHAR(20)   NOT NULL   ,
PRIMARY KEY(codigo));
GO



CREATE TABLE TB_Funcionario (
  codigo INT  NOT NULL   IDENTITY ,
  cpf VARCHAR(11) NOT NULL ,
  nome VARCHAR(30)  NOT NULL  ,
  data_nascimento DATETIME  NOT NULL  ,
  data_admissao DATETIME  NOT NULL  ,
  endereco TEXT  NOT NULL  ,
  bairro VARCHAR(20)  NOT NULL  ,
  cidade VARCHAR(20)   NOT NULL   ,
PRIMARY KEY(codigo));
GO




CREATE TABLE TB_FormaPagamento (
  codigo INT  NOT NULL   IDENTITY ,
  forma_pagamento VARCHAR(10)  NOT NULL,
PRIMARY KEY(codigo));
GO




CREATE TABLE TB_Promocoes (
  codigo INT  NOT NULL   IDENTITY ,
  descricao VARCHAR(30)  NOT NULL  ,
  data_inicio DATETIME   NOT NULL ,
  data_fim DATETIME      NOT NULL,
  desconto NUMERIC(10,2) NOT NULL,
PRIMARY KEY(codigo));
GO




CREATE TABLE TB_Produto (
  codigo INT  NOT NULL   IDENTITY,
  codigo_barra INT  NOT NULL,
  descricao VARCHAR(25)  NOT NULL,
  linha VARCHAR(20)  NOT NULL,
  valor NUMERIC(10,2)  NOT NULL,
PRIMARY KEY(codigo));
GO




CREATE TABLE TB_Producao (
  lote INT  NOT NULL   IDENTITY ,
  descricao VARCHAR(20) NOT NULL ,
  data_fabricacao DATETIME NOT NULL ,
PRIMARY KEY(lote));
GO




CREATE TABLE TB_Cliente (
  codigo INT  NOT NULL   IDENTITY ,
  cpf VARCHAR(11) NOT NULL,
  nome VARCHAR(30) NOT NULL,
  data_nascimento DATETIME NOT NULL,
  endereco TEXT NOT NULL,
  bairro VARCHAR(20)NOT NULL,
  cidade VARCHAR(20)NOT NULL,
PRIMARY KEY(codigo));
GO




CREATE TABLE TB_DataComemorativa (
  codigo INT  NOT NULL   IDENTITY ,
  descricao VARCHAR(25)  NOT NULL  ,
  data_comemorativa DATETIME  NOT NULL    ,
PRIMARY KEY(codigo));
GO




CREATE TABLE Producao_Produto (
  TB_Producao_lote INT  NOT NULL  ,
  TB_Produto_codigo INT  NOT NULL  ,
  quantidade INT NOT NULL,
PRIMARY KEY(TB_Producao_lote, TB_Produto_codigo)    ,
  FOREIGN KEY(TB_Producao_lote)
    REFERENCES TB_Producao(lote),
  FOREIGN KEY(TB_Produto_codigo)
    REFERENCES TB_Produto(codigo));
GO


CREATE INDEX TB_Producao_has_TB_Produto_FKIndex1 ON Producao_Produto (TB_Producao_lote);
GO
CREATE INDEX TB_Producao_has_TB_Produto_FKIndex2 ON Producao_Produto (TB_Produto_codigo);
GO


CREATE INDEX IFK_Rel_01 ON Producao_Produto (TB_Producao_lote);
GO
CREATE INDEX IFK_Rel_02 ON Producao_Produto (TB_Produto_codigo);
GO


CREATE TABLE Producao_Loja (
  TB_Producao_lote INT  NOT NULL  ,
  TB_Loja_codigo INT  NOT NULL    ,
PRIMARY KEY(TB_Producao_lote, TB_Loja_codigo)    ,
  FOREIGN KEY(TB_Producao_lote)
    REFERENCES TB_Producao(lote),
  FOREIGN KEY(TB_Loja_codigo)
    REFERENCES TB_Loja(codigo));
GO


CREATE INDEX TB_Producao_has_TB_Loja_FKIndex1 ON Producao_Loja (TB_Producao_lote);
GO
CREATE INDEX TB_Producao_has_TB_Loja_FKIndex2 ON Producao_Loja (TB_Loja_codigo);
GO


CREATE INDEX IFK_Rel_12 ON Producao_Loja (TB_Producao_lote);
GO
CREATE INDEX IFK_Rel_13 ON Producao_Loja (TB_Loja_codigo);
GO


CREATE TABLE Promocoes_Produto (
  TB_Promocoes_codigo INT  NOT NULL  ,
  TB_Produto_codigo INT  NOT NULL    ,
PRIMARY KEY(TB_Promocoes_codigo, TB_Produto_codigo)    ,
  FOREIGN KEY(TB_Promocoes_codigo)
    REFERENCES TB_Promocoes(codigo),
  FOREIGN KEY(TB_Produto_codigo)
    REFERENCES TB_Produto(codigo));
GO


CREATE INDEX TB_Promocoes_has_TB_Produto_FKIndex1 ON Promocoes_Produto (TB_Promocoes_codigo);
GO
CREATE INDEX TB_Promocoes_has_TB_Produto_FKIndex2 ON Promocoes_Produto (TB_Produto_codigo);
GO


CREATE INDEX IFK_Rel_03 ON Promocoes_Produto (TB_Promocoes_codigo);
GO
CREATE INDEX IFK_Rel_04 ON Promocoes_Produto (TB_Produto_codigo);
GO


CREATE TABLE TB_Venda (
  codigo INT  NOT NULL   IDENTITY ,
  TB_FormaPagamento_codigo INT  NOT NULL  ,
  TB_Funcionario_codigo INT  NOT NULL  ,
  TB_Loja_codigo INT  NOT NULL  ,
  TB_DataComemorativa_codigo INT NOT NULL ,
  TB_Cliente_codigo INT NOT NULL ,
  data_venda DATETIME NOT NULL ,
  valor_Total NUMERIC(10,2) NOT NULL ,
PRIMARY KEY(codigo)          ,
  FOREIGN KEY(TB_Loja_codigo)
    REFERENCES TB_Loja(codigo),
  FOREIGN KEY(TB_Funcionario_codigo)
    REFERENCES TB_Funcionario(codigo),
  FOREIGN KEY(TB_FormaPagamento_codigo)
    REFERENCES TB_FormaPagamento(codigo),
  FOREIGN KEY(TB_Cliente_codigo)
    REFERENCES TB_Cliente(codigo),
  FOREIGN KEY(TB_DataComemorativa_codigo)
    REFERENCES TB_DataComemorativa(codigo));
GO


CREATE INDEX TB_Venda_FKIndex1 ON TB_Venda (TB_Loja_codigo);
GO
CREATE INDEX TB_Venda_FKIndex2 ON TB_Venda (TB_Funcionario_codigo);
GO
CREATE INDEX TB_Venda_FKIndex3 ON TB_Venda (TB_FormaPagamento_codigo);
GO
CREATE INDEX TB_Venda_FKIndex4 ON TB_Venda (TB_Cliente_codigo);
GO
CREATE INDEX TB_Venda_FKIndex5 ON TB_Venda (TB_DataComemorativa_codigo);
GO


CREATE INDEX IFK_Rel_05 ON TB_Venda (TB_Loja_codigo);
GO
CREATE INDEX IFK_Rel_06 ON TB_Venda (TB_Funcionario_codigo);
GO
CREATE INDEX IFK_Rel_07 ON TB_Venda (TB_FormaPagamento_codigo);
GO
CREATE INDEX IFK_Rel_08 ON TB_Venda (TB_Cliente_codigo);
GO
CREATE INDEX IFK_Rel_11 ON TB_Venda (TB_DataComemorativa_codigo);
GO


CREATE TABLE Produto_Venda (
  TB_Produto_codigo INT  NOT NULL  ,
  TB_Venda_codigo INT  NOT NULL    ,
PRIMARY KEY(TB_Produto_codigo, TB_Venda_codigo)    ,
  FOREIGN KEY(TB_Produto_codigo)
    REFERENCES TB_Produto(codigo),
  FOREIGN KEY(TB_Venda_codigo)
    REFERENCES TB_Venda(codigo));
GO


CREATE INDEX TB_Produto_has_TB_Venda_FKIndex1 ON Produto_Venda (TB_Produto_codigo);
GO
CREATE INDEX TB_Produto_has_TB_Venda_FKIndex2 ON Produto_Venda (TB_Venda_codigo);
GO


CREATE INDEX IFK_Rel_09 ON Produto_Venda (TB_Produto_codigo);
GO
CREATE INDEX IFK_Rel_10 ON Produto_Venda (TB_Venda_codigo);
GO




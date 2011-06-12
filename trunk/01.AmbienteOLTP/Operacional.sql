CREATE TABLE TB_loja (
  codigo INTEGER  NOT NULL   IDENTITY ,
  nome VARCHAR(20)  NOT NULL  ,
  cidade VARCHAR(20)      ,
PRIMARY KEY(codigo));
GO




CREATE TABLE TB_Funcionario (
  codigo INTEGER  NOT NULL   IDENTITY ,
  cpf INTEGER    ,
  nome VARCHAR(30)    ,
  data_nascimento DATE    ,
  data_admissao DATE    ,
  endereco TEXT    ,
  bairro VARCHAR(20)    ,
  cidade VARCHAR(20)      ,
PRIMARY KEY(codigo));
GO




CREATE TABLE TB_Producao (
  lote INTEGER  NOT NULL   IDENTITY ,
  descricao VARCHAR(20)    ,
  data_fabricacao DATE      ,
PRIMARY KEY(lote));
GO




CREATE TABLE TB_Promocoes (
  codigo INTEGER  NOT NULL   IDENTITY ,
  descricao VARCHAR(30)    ,
  data_inicio DATE    ,
  data_fim DATE    ,
  desconto DOUBLE(10,2)      ,
PRIMARY KEY(codigo));
GO




CREATE TABLE TB_Produto (
  codigo INTEGER  NOT NULL   IDENTITY ,
  codigo_barra INTEGER    ,
  descricao VARCHAR(25)    ,
  valor DOUBLE(10,2)      ,
PRIMARY KEY(codigo));
GO




CREATE TABLE TB_Cliente (
  codigo INTEGER  NOT NULL   IDENTITY ,
  cpf INTEGER    ,
  nome VARCHAR(30)    ,
  data_nascimento DATE    ,
  endereco TEXT    ,
  bairro VARCHAR(20)    ,
  cidade VARCHAR(20)      ,
PRIMARY KEY(codigo));
GO




CREATE TABLE TB_FormaPagamento (
  codigo INTEGER  NOT NULL   IDENTITY ,
  forma_pagamento VARCHAR(10)      ,
PRIMARY KEY(codigo));
GO




CREATE TABLE Producao_Produto (
  TB_Producao_lote INTEGER  NOT NULL  ,
  TB_Produto_codigo INTEGER  NOT NULL  ,
  quantidade INTEGER      ,
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


CREATE TABLE Promocoes_Produto (
  TB_Promocoes_codigo INTEGER  NOT NULL  ,
  TB_Produto_codigo INTEGER  NOT NULL    ,
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
  codigo INTEGER  NOT NULL   IDENTITY ,
  TB_Cliente_codigo INTEGER    ,
  TB_FormaPagamento_codigo INTEGER  NOT NULL  ,
  TB_Funcionario_codigo INTEGER  NOT NULL  ,
  TB_loja_codigo INTEGER  NOT NULL  ,
  data_venda DATE    ,
  valor_Total DOUBLE(10,2)      ,
PRIMARY KEY(codigo)        ,
  FOREIGN KEY(TB_loja_codigo)
    REFERENCES TB_loja(codigo),
  FOREIGN KEY(TB_Funcionario_codigo)
    REFERENCES TB_Funcionario(codigo),
  FOREIGN KEY(TB_FormaPagamento_codigo)
    REFERENCES TB_FormaPagamento(codigo),
  FOREIGN KEY(TB_Cliente_codigo)
    REFERENCES TB_Cliente(codigo));
GO


CREATE INDEX TB_Venda_FKIndex1 ON TB_Venda (TB_loja_codigo);
GO
CREATE INDEX TB_Venda_FKIndex2 ON TB_Venda (TB_Funcionario_codigo);
GO
CREATE INDEX TB_Venda_FKIndex3 ON TB_Venda (TB_FormaPagamento_codigo);
GO
CREATE INDEX TB_Venda_FKIndex4 ON TB_Venda (TB_Cliente_codigo);
GO


CREATE INDEX IFK_Rel_05 ON TB_Venda (TB_loja_codigo);
GO
CREATE INDEX IFK_Rel_06 ON TB_Venda (TB_Funcionario_codigo);
GO
CREATE INDEX IFK_Rel_07 ON TB_Venda (TB_FormaPagamento_codigo);
GO
CREATE INDEX IFK_Rel_08 ON TB_Venda (TB_Cliente_codigo);
GO


CREATE TABLE Produto_Venda (
  TB_Produto_codigo INTEGER  NOT NULL  ,
  TB_Venda_codigo INTEGER  NOT NULL    ,
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




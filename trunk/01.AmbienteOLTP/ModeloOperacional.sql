CREATE TABLE TB_Producao (
  lote INTEGER  NOT NULL   IDENTITY ,
  descricao VARCHAR(15)  NOT NULL  ,
  data_fabricacao DATE  NOT NULL    ,
PRIMARY KEY(lote));
GO




CREATE TABLE TB_Loja (
  codigo INTEGER  NOT NULL   IDENTITY ,
  nome VARCHAR(20)  NOT NULL  ,
  cidade VARCHAR(20)  NOT NULL    ,
PRIMARY KEY(codigo));
GO




CREATE TABLE TB_Promocoes (
  codigo INTEGER  NOT NULL   IDENTITY ,
  descricao VARCHAR(20)  NOT NULL  ,
  desconto DOUBLE(10,2)  NOT NULL    ,
PRIMARY KEY(codigo));
GO




CREATE TABLE TB_Produto (
  codigo INTEGER  NOT NULL   IDENTITY ,
  descricao VARCHAR(20)  NOT NULL  ,
  valor DOUBLE(10,2)  NOT NULL    ,
PRIMARY KEY(codigo));
GO




CREATE TABLE TB_Funcionario (
  cpf INTEGER  NOT NULL   IDENTITY ,
  nome VARCHAR(30)    ,
  cargo VARCHAR(20)      ,
PRIMARY KEY(cpf));
GO




CREATE TABLE TB_Cliente (
  codigo INTEGER  NOT NULL   IDENTITY ,
  nome VARCHAR(30)    ,
  idade INTEGER    ,
  sexo SET('M','F')      ,
PRIMARY KEY(codigo));
GO




CREATE TABLE TB_FormaPagamento (
  codigo INTEGER  NOT NULL   IDENTITY ,
  descricao VARCHAR(10)  NOT NULL    ,
PRIMARY KEY(codigo));
GO




CREATE TABLE TB_Produto_has_TB_Producao (
  TB_Produto_codigo INTEGER  NOT NULL  ,
  TB_Producao_lote INTEGER  NOT NULL  ,
  quantidade INTEGER      ,
PRIMARY KEY(TB_Produto_codigo, TB_Producao_lote)    ,
  FOREIGN KEY(TB_Produto_codigo)
    REFERENCES TB_Produto(codigo),
  FOREIGN KEY(TB_Producao_lote)
    REFERENCES TB_Producao(lote));
GO


CREATE INDEX TB_Produto_has_TB_Producao_FKIndex1 ON TB_Produto_has_TB_Producao (TB_Produto_codigo);
GO
CREATE INDEX TB_Produto_has_TB_Producao_FKIndex2 ON TB_Produto_has_TB_Producao (TB_Producao_lote);
GO


CREATE INDEX IFK_Rel_09 ON TB_Produto_has_TB_Producao (TB_Produto_codigo);
GO
CREATE INDEX IFK_Rel_10 ON TB_Produto_has_TB_Producao (TB_Producao_lote);
GO


CREATE TABLE Promocoes_Produto (
  TB_Promocoes_codigo INTEGER  NOT NULL  ,
  TB_Produto_codigo INTEGER  NOT NULL  ,
  desconto DOUBLE(10,2)  NOT NULL    ,
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


CREATE INDEX IFK_Rel_01 ON Promocoes_Produto (TB_Promocoes_codigo);
GO
CREATE INDEX IFK_Rel_02 ON Promocoes_Produto (TB_Produto_codigo);
GO


CREATE TABLE TB_Venda (
  codigo INTEGER  NOT NULL   IDENTITY ,
  TB_Cliente_codigo INTEGER  NOT NULL  ,
  TB_FormaPagamento_codigo INTEGER  NOT NULL  ,
  TB_Funcionario_cpf INTEGER  NOT NULL  ,
  TB_Loja_codigo INTEGER  NOT NULL  ,
  dataVenda DATETIME    ,
  valorTotal DOUBLE(10,2)      ,
PRIMARY KEY(codigo)        ,
  FOREIGN KEY(TB_Loja_codigo)
    REFERENCES TB_Loja(codigo),
  FOREIGN KEY(TB_Funcionario_cpf)
    REFERENCES TB_Funcionario(cpf),
  FOREIGN KEY(TB_FormaPagamento_codigo)
    REFERENCES TB_FormaPagamento(codigo),
  FOREIGN KEY(TB_Cliente_codigo)
    REFERENCES TB_Cliente(codigo));
GO


CREATE INDEX TB_Venda_FKIndex1 ON TB_Venda (TB_Loja_codigo);
GO
CREATE INDEX TB_Venda_FKIndex2 ON TB_Venda (TB_Funcionario_cpf);
GO
CREATE INDEX TB_Venda_FKIndex3 ON TB_Venda (TB_FormaPagamento_codigo);
GO
CREATE INDEX TB_Venda_FKIndex4 ON TB_Venda (TB_Cliente_codigo);
GO


CREATE INDEX IFK_Rel_06 ON TB_Venda (TB_Loja_codigo);
GO
CREATE INDEX IFK_Rel_07 ON TB_Venda (TB_Funcionario_cpf);
GO
CREATE INDEX IFK_Rel_07 ON TB_Venda (TB_FormaPagamento_codigo);
GO
CREATE INDEX IFK_Rel_08 ON TB_Venda (TB_Cliente_codigo);
GO


CREATE TABLE Produto_Venda (
  TB_Produto_codigo INTEGER  NOT NULL  ,
  TB_Venda_codigo INTEGER  NOT NULL  ,
  quantidade INTEGER    ,
  subTotal DOUBLE(10,2)      ,
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


CREATE INDEX IFK_Rel_03 ON Produto_Venda (TB_Produto_codigo);
GO
CREATE INDEX IFK_Rel_04 ON Produto_Venda (TB_Venda_codigo);
GO




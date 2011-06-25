CREATE PROCEDURE SP_CARGA_STAGING_FUNCIONARIO(@DATA DATETIME)
AS
	delete from TB_AUX_FUNCIONARIO
DECLARE
	@CODIGO INT,
	@CPF VARCHAR(11),
	@NOME VARCHAR(30),
	@DATA_NASCIMENTO DATETIME    ,
	@DATA_ADMISSAO DATETIME  ,
	@ENDERECO VARCHAR(45)    ,
	@BAIRRO VARCHAR(20)    ,
	@CIDADE VARCHAR(20)	
DECLARE C_FUNCIONARIO CURSOR FOR SELECT CODIGO, CPF, NOME, DATA_NASCIMENTO,
									 DATA_ADMISSAO,ENDERECO, BAIRRO, CIDADE
				FROM TB_FUNCIONARIO			
OPEN C_FUNCIONARIO
FETCH C_FUNCIONARIO INTO @CODIGO, @CPF, @NOME, @DATA_NASCIMENTO,@DATA_ADMISSAO, @ENDERECO,
									@BAIRRO, @CIDADE
WHILE (@@FETCH_STATUS = 0)
BEGIN
	INSERT INTO TB_AUX_FUNCIONARIO (DATA_CARGA, COD_FUNCIONARIO, CPF, NOME, DATA_NASCIMENTO,
									 ENDERECO, BAIRRO, CIDADE) 
				VALUES(@DATA,@CODIGO, @CPF, @NOME, @DATA_NASCIMENTO, @ENDERECO,
									@BAIRRO, @CIDADE)
	

	
FETCH C_FUNCIONARIO INTO	@CODIGO, @CPF, @NOME, @DATA_NASCIMENTO, @DATA_ADMISSAO, @ENDERECO,
									@BAIRRO, @CIDADE
	END
	CLOSE C_FUNCIONARIO
	DEALLOCATE C_FUNCIONARIO
	
	
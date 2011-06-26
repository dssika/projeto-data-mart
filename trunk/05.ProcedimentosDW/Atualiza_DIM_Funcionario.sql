
exec Atualiza_Dimensao_Funcionario '20110625'
select * from DIM_Funcionario

CREATE PROCEDURE Atualiza_Dimensao_Funcionario (@data DATETIME)
AS
	DECLARE @cod_funcionario INT, @cpf VARCHAR(11),@nome VARCHAR(30), @data_nascimento DATE,
	@data_admissao DATETIME, @endereco VARCHAR(MAX), @bairro VARCHAR(20), @cidade VARCHAR(20),@existeFuncionario INT
	
 DECLARE C_Atualiza_Dim_Funcionario CURSOR FOR
	SELECT cod_funcionario , cpf, nome , data_nascimento, data_admissao, endereco, bairro, cidade FROM TB_Aux_Funcionario
	WHERE data_carga = @data
	OPEN C_Atualiza_Dim_Funcionario
		FETCH C_Atualiza_Dim_Funcionario INTO @cod_funcionario , @cpf, @nome , @data_nascimento,@data_admissao, @endereco, @bairro, @cidade
		WHILE (@@FETCH_STATUS =0)
			BEGIN
				EXEC Verifica_DIM_Funcionario @cod_funcionario, @existeFuncionario OUTPUT
				-- Se Cliente já existe na DIM_Cliente, ele será atualizado, senão, será inserido
				IF (@existeFuncionario=1)
					BEGIN
						UPDATE DIM_Funcionario set cpf=@cpf where cod_funcionario= @cod_funcionario
						UPDATE DIM_Funcionario set nome=@nome where cod_funcionario= @cod_funcionario
						UPDATE DIM_Funcionario set data_nascimento=@data_nascimento where cod_funcionario= @cod_funcionario
						UPDATE DIM_Funcionario set data_admissao=@data_admissao where cod_funcionario= @cod_funcionario
						UPDATE DIM_Funcionario set endereco=@endereco where cod_funcionario= @cod_funcionario
						UPDATE DIM_Funcionario set bairro=@bairro where cod_funcionario= @cod_funcionario
						UPDATE DIM_Funcionario set cidade=@cidade where cod_funcionario= @cod_funcionario
						
						FETCH C_Atualiza_Dim_Funcionario INTO @cod_funcionario, @cpf, @nome , @data_nascimento, @data_admissao, @endereco, @bairro, @cidade
					END
				ELSE
					BEGIN
						INSERT INTO DIM_Funcionario(cod_funcionario , cpf, nome , data_nascimento, data_admissao,endereco, bairro, cidade)
						VALUES(@cod_funcionario , @cpf, @nome , @data_nascimento, @data_admissao, @endereco, @bairro, @cidade)
					
						FETCH C_Atualiza_Dim_Funcionario INTO @cod_funcionario , @cpf, @nome , @data_nascimento, @data_admissao, @endereco, @bairro, @cidade
					END
				
			END
	CLOSE C_Atualiza_Dim_Funcionario 
	DEALLOCATE C_Atualiza_Dim_Funcionario 			
			
			


CREATE PROCEDURE Verifica_DIM_Funcionario(@codigo_funcionario INT, @existeFuncionario INT OUTPUT)
AS

set @existeFuncionario = (SELECT COUNT(cod_funcionario)
					  FROM DIM_Funcionario
					  WHERE cod_funcionario = @codigo_funcionario)
	
	
DECLARE @RESULTADO INT
EXEC Verifica_DIM_Funcionario 1, @RESULTADO OUTPUT
PRINT @RESULTADO	
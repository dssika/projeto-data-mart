EXEC cargaStagingFuncionario '20110625'
select * from TB_Aux_Funcionario


-- carregar da TB_Funcionario para a Staging (TB_Aux_Funcionario)

CREATE PROCEDURE cargaStagingFuncionario (@data_carga DATETIME)
AS
	DECLARE @cod_funcionario INT, @cpf VARCHAR(11), @nome VARCHAR(30),@data_nascimento DATETIME, 
			@data_admissao DATETIME, @endereco VARCHAR(max), @bairro VARCHAR(20), @cidade VARCHAR(20)
			
			delete from TB_Aux_Funcionario where data_carga = @data_carga
			
	DECLARE CARGA_S CURSOR FOR
	SELECT codigo , cpf, nome , data_nascimento,data_admissao, endereco, bairro, cidade FROM TB_Funcionario
	OPEN CARGA_S 
		FETCH CARGA_S INTO @cod_funcionario , @cpf, @nome , @data_nascimento, @data_admissao, @endereco, @bairro, @cidade
		WHILE (@@FETCH_STATUS =0)
			BEGIN
				INSERT INTO TB_Aux_Funcionario(data_carga, cod_funcionario , cpf, nome ,data_nascimento, data_admissao, endereco, bairro, cidade)
				VALUES(@data_carga, @cod_funcionario  , @cpf, @nome , @data_nascimento,@data_admissao,@endereco,@bairro, @cidade)			
				FETCH CARGA_S INTO @cod_funcionario , @cpf, @nome , @data_nascimento, @data_admissao, @endereco,@bairro, @cidade
			END		
	CLOSE CARGA_S
	DEALLOCATE CARGA_S
	
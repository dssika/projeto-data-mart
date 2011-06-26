EXEC cargaStagingCliente '20110624'
select * from TB_Aux_Cliente

-- carregar da TB_Cliente para a Staging (TB_Aux_Cliente)

ALTER PROCEDURE cargaStagingCliente (@data_carga DATETIME)
AS
	DECLARE @cod_cliente INT, @cpf VARCHAR(11), @nome VARCHAR(30),@data_nascimento DATETIME,
			@endereco VARCHAR(max), @bairro VARCHAR(20), @cidade VARCHAR(20)
			
			delete from TB_Aux_Cliente where data_carga = @data_carga
			
	DECLARE CARGA_S CURSOR FOR
	SELECT codigo , cpf, nome , data_nascimento,endereco, bairro, cidade FROM TB_Cliente
	OPEN CARGA_S 
		FETCH CARGA_S INTO @cod_cliente , @cpf, @nome , @data_nascimento,@endereco, @bairro, @cidade
		WHILE (@@FETCH_STATUS =0)
			BEGIN
				INSERT INTO TB_Aux_Cliente(data_carga, cod_cliente , cpf, nome ,data_nascimento,endereco, bairro, cidade)
				VALUES(@data_carga,@cod_cliente  , @cpf, @nome , @data_nascimento,@endereco,@bairro, @cidade)			
				FETCH CARGA_S INTO @cod_cliente  , @cpf, @nome , @data_nascimento,@endereco,@bairro, @cidade
			END		
	CLOSE CARGA_S
	DEALLOCATE CARGA_S
	

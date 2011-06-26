EXEC cargaStagingDataComemorativa '20110625'
select * from TB_Aux_Data_Comemorativa

-- carregar da TB_Data_Comemorativa para a Staging (TB_Aux_Data_Comemorativa)

CREATE PROCEDURE cargaStagingDataComemorativa (@data_carga DATETIME)
AS
	DECLARE @cod_data_comemorativa INT, @descricao VARCHAR(25), @data_comemorativa DATETIME
			
			delete from TB_Aux_Data_Comemorativa where data_carga = @data_carga
			
	DECLARE CARGA_S CURSOR FOR
	SELECT codigo , descricao, data_comemorativa FROM TB_DataComemorativa
	OPEN CARGA_S 
		FETCH CARGA_S INTO @cod_data_comemorativa, @descricao, @data_comemorativa
		WHILE (@@FETCH_STATUS =0)
			BEGIN
				INSERT INTO TB_Aux_Data_Comemorativa(data_carga,cod_data_comemorativa , descricao, data_comemorativa)
				VALUES(@data_carga,@cod_data_comemorativa, @descricao, @data_comemorativa)			
				FETCH CARGA_S INTO @cod_data_comemorativa, @descricao, @data_comemorativa
			END		
	CLOSE CARGA_S
	DEALLOCATE CARGA_S
	
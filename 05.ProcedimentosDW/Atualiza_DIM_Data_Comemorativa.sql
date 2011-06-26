exec Atualiza_Dimensao_Data_Comemorativa'20110625'
select * from DIM_Data_Comemorativa

CREATE PROCEDURE Atualiza_Dimensao_Data_Comemorativa (@data DATETIME)
AS
	DECLARE @cod_data_comemorativa INT, @descricao VARCHAR(25),@data_comemorativa DATETIME,
	@existeDataC INT
	
 DECLARE C_Atualiza_Dim_Dt_Com CURSOR FOR
	SELECT cod_data_comemorativa , descricao , data_comemorativa FROM TB_Aux_Data_Comemorativa
	WHERE data_carga = @data
	OPEN C_Atualiza_Dim_Dt_Com
		FETCH C_Atualiza_Dim_Dt_Com INTO @cod_data_comemorativa, @descricao, @data_comemorativa
		WHILE (@@FETCH_STATUS =0)
			BEGIN
				EXEC Verifica_DIM_DataComemorativa @cod_data_comemorativa, @existeDataC OUTPUT
				-- Se a data comemorativa já existe na DIM_data_comemorativa, ele será atualizado, senão, será inserido
				IF (@existeDataC=1)
					BEGIN
						UPDATE DIM_Data_Comemorativa set descricao=@descricao where cod_data_comemorativa= @cod_data_comemorativa
						UPDATE DIM_Data_Comemorativa set data_comemorativa=@data_comemorativa where cod_data_comemorativa= @cod_data_comemorativa

						FETCH C_Atualiza_Dim_Dt_Com INTO @cod_data_comemorativa, @descricao, @data_comemorativa
					END
				ELSE
					BEGIN
						INSERT INTO DIM_Data_Comemorativa (cod_data_comemorativa ,descricao,data_comemorativa)
						VALUES(@cod_data_comemorativa , @descricao , @data_comemorativa)
					
						FETCH C_Atualiza_Dim_Dt_Com INTO @cod_data_comemorativa, @descricao, @data_comemorativa
					END
				
			END
	CLOSE C_Atualiza_Dim_Dt_Com
	DEALLOCATE C_Atualiza_Dim_Dt_Com 			
			
			


CREATE PROCEDURE Verifica_DIM_DataComemorativa(@codigo_data_comemorativa INT, @existeDataC INT OUTPUT)
AS

set @existeDataC = (SELECT COUNT(cod_data_comemorativa)
					  FROM DIM_Data_Comemorativa
					  WHERE cod_data_comemorativa = @codigo_data_comemorativa)
	
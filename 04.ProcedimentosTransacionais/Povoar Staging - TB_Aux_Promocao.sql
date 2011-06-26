EXEC cargaStagingPromocao'20110624'
select * from TB_Aux_Promocao

-- carregar da TB_Promocao para a Staging (TB_Aux_Promocao)

CREATE PROCEDURE cargaStagingPromocao (@data_carga DATETIME)
AS
	DECLARE @cod_promocao INT, @descricao VARCHAR(30), @data_inicial DATETIME,
			@data_fim DATETIME, @desconto NUMERIC(10,2)
			
			delete from TB_Aux_Cliente where data_carga = @data_carga
			
	DECLARE CARGA_S CURSOR FOR
	SELECT codigo, descricao, data_inicio, data_fim, desconto FROM TB_Promocoes
	OPEN CARGA_S 
		FETCH CARGA_S INTO @cod_promocao ,@descricao, @data_inicial,@data_fim, @desconto
		WHILE (@@FETCH_STATUS =0)
			BEGIN
				INSERT INTO TB_Aux_Promocao(data_carga, cod_promocao , descricao ,data_inicial,data_final, desconto)
				VALUES(@data_carga,@cod_promocao  , @descricao, @data_inicial,@data_fim, @desconto)			
				FETCH CARGA_S INTO @cod_promocao ,@descricao, @data_inicial,@data_fim, @desconto
			END		
	CLOSE CARGA_S
	DEALLOCATE CARGA_S
	
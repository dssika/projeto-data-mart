exec Atualiza_Dimensao_Promocao '20110625'

select * from DIM_Promocao


ALTER PROCEDURE Atualiza_Dimensao_Promocao (@data DATETIME)
AS
	DECLARE @cod_promocao INT, @descricao VARCHAR(30),@data_inicial DATETIME, @data_final DATETIME, 
	@desconto NUMERIC (10,2),@existePromocao INT
	
 DECLARE C_Atualiza_Dim_Promocao CURSOR FOR
	SELECT cod_promocao , descricao, data_inicial, data_final, desconto FROM TB_Aux_Promocao
	WHERE data_carga = @data
	OPEN C_Atualiza_Dim_Promocao
		FETCH C_Atualiza_Dim_Promocao INTO @cod_promocao , @descricao, @data_inicial, @data_final, @desconto
		WHILE (@@FETCH_STATUS =0)
			BEGIN
				EXEC Verifica_DIM_Promocao @cod_promocao, @existePromocao OUTPUT
				-- Se a Promocao já existe na DIM_Promocao, ele será atualizado, senão, será inserido
				IF (@existePromocao=1)
					BEGIN
						UPDATE DIM_Promocao set descricao=@descricao where cod_promocao= @cod_promocao
						UPDATE DIM_Promocao set data_inicial=@data_inicial where cod_promocao= @cod_promocao
						UPDATE DIM_Promocao set data_final=@data_final where cod_promocao= @cod_promocao
						UPDATE DIM_Promocao set desconto=@desconto where cod_promocao= @cod_promocao
						
						FETCH C_Atualiza_Dim_Promocao INTO @cod_promocao , @descricao, @data_inicial, @data_final, @desconto
					END
				ELSE
					BEGIN
						INSERT INTO DIM_Promocao(cod_promocao ,descricao ,data_inicial,data_final, desconto)
						VALUES(@cod_promocao , @descricao , @data_inicial,@data_final, @desconto)
					
						FETCH C_Atualiza_Dim_Promocao INTO @cod_promocao , @descricao, @data_inicial, @data_final, @desconto
					END
				
			END
	CLOSE C_Atualiza_Dim_Promocao
	DEALLOCATE C_Atualiza_Dim_Promocao			
			
			


CREATE PROCEDURE Verifica_DIM_Promocao(@codigo_promocao INT, @existePromocao INT OUTPUT)
AS

set @existePromocao= (SELECT COUNT(cod_promocao)
					  FROM DIM_Promocao
					  WHERE cod_promocao = @codigo_promocao)
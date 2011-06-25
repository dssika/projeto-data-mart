
exec Atualiza_Dimensao_Loja'20110626'
select * from DIM_Loja

CREATE PROCEDURE Atualiza_Dimensao_Loja (@data DATETIME)
AS
	DECLARE @cod_loja INT, @nome VARCHAR(30),@regiao VARCHAR(20), @estado VARCHAR(20), @cidade VARCHAR(20),
	@existeLoja INT
	
 DECLARE C_Atualiza_Dim_Loja CURSOR FOR
	SELECT cod_loja , nome , regiao, estado, cidade FROM TB_Aux_Loja
	WHERE data_carga = @data
	OPEN C_Atualiza_Dim_Loja
		FETCH C_Atualiza_Dim_Loja INTO @cod_loja,@nome , @regiao, @estado, @cidade
		WHILE (@@FETCH_STATUS =0)
			BEGIN
				EXEC Verifica_DIM_Loja @cod_loja, @existeLoja OUTPUT
				-- Se a Loja já existe na DIM_Loja, ele será atualizado, senão, será inserido
				IF (@existeLoja=1)
					BEGIN
						UPDATE DIM_Loja set nome=@nome where cod_loja= @cod_loja
						UPDATE DIM_Loja set regiao=@regiao where cod_loja= @cod_loja
						UPDATE DIM_Loja set estado=@estado where cod_loja= @cod_loja
						UPDATE DIM_Loja set cidade=@cidade where cod_loja= @cod_loja
						
						FETCH C_Atualiza_Dim_Loja INTO @cod_loja ,@nome , @regiao, @estado, @cidade
					END
				ELSE
					BEGIN
						INSERT INTO DIM_Loja(cod_loja ,nome ,regiao,estado, cidade)
						VALUES(@cod_loja , @nome , @regiao,@estado, @cidade)
					
						FETCH C_Atualiza_Dim_Loja INTO @cod_loja ,@nome , @regiao, @estado, @cidade
					END
				
			END
	CLOSE C_Atualiza_Dim_Loja
	DEALLOCATE C_Atualiza_Loja 			
			
			


CREATE PROCEDURE Verifica_DIM_Loja(@codigo_loja INT, @existeLoja INT OUTPUT)
AS

set @existeLoja = (SELECT COUNT(cod_loja)
					  FROM DIM_Loja
					  WHERE cod_loja = @codigo_loja)
	
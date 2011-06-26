EXEC Atualiza_Dimensao_Produto '20110621'
select * from DIM_Produto


CREATE PROCEDURE Atualiza_Dimensao_Produto (@data DATETIME)
AS
	DECLARE @data_carga DATETIME,@codigo INT, @codigo_barra INT, @descricao VARCHAR(25),@linha VARCHAR(20),
			@valor NUMERIC(10,2),@dt_inicio DATETIME,@dt_fim DATETIME,@fl_corrente VARCHAR(3), @existe_data INT,
			@existe_reg INT,@id_novo_reg INT, @atualizou VARCHAR(3)
			
	EXEC VERIFICA_STAGING @data, @existe_data OUTPUT 
	IF(@EXISTE_DATA>0) -- SE EXISTE A DATA INFORMADA NO STAGING
	BEGIN
		DECLARE C_Produto CURSOR FOR
			SELECT data_carga, codigo , codigo_barra, descricao ,linha ,valor
			FROM TB_Aux_Produto WHERE data_carga = @data
		OPEN C_Produto
	
			FETCH C_Produto INTO @data_carga,@codigo , @codigo_barra, @descricao ,@linha ,@valor 
			WHILE (@@FETCH_STATUS =0)
			BEGIN

				EXEC VERIFICA_DIMENSAO @codigo, @existe_reg OUTPUT
				IF(@existe_reg>0) -- SE JÁ EXISTE UM REGISTRO COM ESSA MATRICULA NA DIMENSAO
					BEGIN
					-- verificar se houve alguma atualização nos campos
					EXEC EXISTE_ATUALIZACAO @codigo, @data, @atualizou OUTPUT 

						IF(@atualizou='SIM')
							BEGIN	
								IF((@codigo  IS NULL) OR (@codigo_barra IS NULL) OR (@descricao IS NULL) OR (@linha IS NULL) OR (@valor IS NULL))
								BEGIN
									 PRINT 'DADOS NULOS NAO PODEM SER INSERIDOS NA DIM_PRODUTO' 
									 
								END
								ELSE
								BEGIN
								EXEC COPIA_REG @codigo, @data, @id_novo_reg OUTPUT
									UPDATE DIM_Produto set codigo_barra= @codigo_barra where id_produto=@id_novo_reg
									UPDATE DIM_Produto set descricao= @descricao where id_produto=@id_novo_reg
									UPDATE DIM_Produto set linha= @linha where id_produto=@id_novo_reg
									UPDATE DIM_Produto set valor= @valor where id_produto=@id_novo_reg
			
								END
							END
					END
				ELSE -- SE AINDA NÃO EXISTE NENHUM REGISTRO COM ESSA MATRICULA GRAVADA NA DIMENSAO
					BEGIN
						INSERT INTO DIM_Produto(codigo , codigo_barra, descricao ,linha ,valor, dt_inicio,dt_fim,fl_corrente)
						VALUES(@codigo , @codigo_barra, @descricao ,@linha ,@valor,@data, NULL, 'SIM')	
					END
				FETCH C_Produto INTO @data_carga,@codigo , @codigo_barra, @descricao ,@linha ,@valor 
			END			
	END	
			
	CLOSE C_Produto
	DEALLOCATE C_Produto
	
	
-------------------------------------------------------------
-- VERIFICA SE EXISTE ALGUM CAMPO COM A DATA INFORMADA PARA TRANSFERENCIA DA STAGING PARA A DIMENSAO
CREATE PROCEDURE VERIFICA_STAGING (@data DATETIME, @resultado INT OUTPUT)
AS
	set @resultado = (SELECT COUNT(codigo)
					  FROM TB_Aux_Produto
					  WHERE data_carga = @data)
					  
---- TESTANDO PROCEDIMENTO -> VERIFICA_STAGING
DECLARE @RESULTADO INT
EXEC VERIFICA_STAGING '20110619', @RESULTADO OUTPUT
PRINT @RESULTADO


--------------------------------------------------------------
-- VERIFICA SE JÁ EXISTE NA DIMENSAO ALGUM REGISTRO IGUAL AO INFORMADO 
CREATE PROCEDURE VERIFICA_DIMENSAO(@codigo INT, @resultado INT OUTPUT)
AS
	set @resultado  = (SELECT COUNT(codigo)
					  FROM DIM_Produto
					  WHERE codigo = @codigo)
--TESTANDO

DECLARE @RESULTADO INT
EXEC VERIFICA_DIMENSAO 1, @RESULTADO OUTPUT
PRINT @RESULTADO

-----------------------------------------------------------------

-- Verifica se houve alguma atualização dos registros 
CREATE PROCEDURE EXISTE_ATUALIZACAO(@cod INT, @data DATETIME, @atualizou VARCHAR(3) OUTPUT)
AS
	
	DECLARE   @codigo_barra INT, @descricao VARCHAR(25),@linha VARCHAR(20), @valor NUMERIC(10,2),  
			  @codigo_barra_aux INT, @descricao_aux VARCHAR(25),@linha_aux VARCHAR(20),@valor_aux NUMERIC(10,2)
			 
			 
	DECLARE C_EXISTE_ATUALIZACAO CURSOR FOR			
	SELECT codigo_barra ,descricao ,linha, valor
	FROM DIM_Produto
	WHERE codigo=@cod AND fl_corrente='SIM'
	OPEN C_EXISTE_ATUALIZACAO
	FETCH C_EXISTE_ATUALIZACAO INTO @codigo_barra ,@descricao ,@linha, @valor
	
	
	SET @codigo_barra_aux = (SELECT codigo_barra FROM TB_Aux_Produto WHERE codigo=@cod AND data_carga=@data )
	SET @descricao_aux= (SELECT descricao FROM TB_Aux_Produto WHERE codigo=@cod AND data_carga=@data )
	SET @linha_aux= (SELECT linha FROM TB_Aux_Produto WHERE codigo=@cod AND data_carga=@data )
	SET @valor_aux= (SELECT valor FROM TB_Aux_Produto WHERE codigo=@cod AND data_carga=@data)
	
	--IF((@CARGO_AUX<>@CARGO)OR (@FUNCAO_AUX<>@FUNCAO) OR (@SALARIO_AUX<>@SALARIO) OR (@SETOR_AUX<>@SETOR) OR (@DEPARTAMENTO_AUX<>@DEPARTAMENTO))
	IF((@codigo_barra_aux!=@codigo_barra)OR ((@descricao_aux!=@descricao)) OR (@linha_aux!=@linha) OR (@valor_aux!=@valor))
		SET @atualizou='SIM'
	ELSE
		SET @atualizou='NAO'
	CLOSE C_EXISTE_ATUALIZACAO
	DEALLOCATE C_EXISTE_ATUALIZACAO
	
	
	--------------------------------------------------------------
-- FAZ UMA COPIA DO REGISTRO NA DIM_FUNCIONARIO E ATUALIZAR A DT_FIM E FL_CORRENTE,
-- RETORNANDO O VALOR DO ID_FUNCIONARIO DO REGISTRO A SER FEITA A ALTERAÇÃO > FL_CORRENTE=NAO E DT_FIM= 
CREATE PROCEDURE COPIA_REG (@cod INT, @data DATETIME, @novo_registro INT OUTPUT)
AS
	
	DECLARE  @data_carga DATETIME,@codigo INT, @codigo_barra INT, @descricao VARCHAR(25),@linha VARCHAR(20),
			 @valor NUMERIC(10,2),@dt_inicio DATETIME,@dt_fim DATETIME,@fl_corrente VARCHAR(3)
			 
	DECLARE C_COPIA_REG CURSOR FOR			
	SELECT codigo , codigo_barra, descricao ,linha ,valor,dt_inicio, dt_fim, fl_corrente 
	FROM DIM_Produto
	WHERE codigo=@cod AND fl_corrente='SIM'
	OPEN C_COPIA_REG
		FETCH C_COPIA_REG INTO @codigo,@codigo_barra,@descricao,@linha,@valor,@dt_inicio,@dt_fim,@fl_corrente	 
		UPDATE DIM_Produto set dt_fim= @data, fl_corrente='NAO' where codigo=@cod AND fl_corrente='SIM'
		INSERT INTO DIM_Produto (codigo , codigo_barra, descricao ,linha ,valor,dt_inicio, fl_corrente)
		VALUES(@codigo,@codigo_barra,@descricao,@linha,@valor,@dt_inicio,'SIM')
		
		
		SET @novo_registro= (SELECT id_produto FROM DIM_Produto WHERE codigo=@codigo AND fl_corrente='SIM')
	CLOSE C_COPIA_REG
	DEALLOCATE C_COPIA_REG
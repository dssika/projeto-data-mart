exec Povoar_Fato_Venda '20110624'


ALTER PROCEDURE Povoar_Fato_Venda(@data DATETIME)
AS

	DECLARE @cod_venda INT, @cod_cliente INT, @cod_funcionario INT,@cod_pagamento INT,@cod_loja INT,
			@cod_produto INT, @cod_data_comemorativa INT,@data_venda DATETIME, @valor INT,@id_venda INT, 
			@id_cliente INT, @id_funcionario INT,@id_pagamento INT,@id_tempo INT, @id_loja INT,
			@id_produto INT,@id_data_comemorativa INT, @existeErro VARCHAR(3)        
		
	DECLARE C_Atualiza_Fato_Venda CURSOR FOR
	
	SELECT cod_venda,cod_cliente,cod_funcionario,cod_pagamento,cod_loja,
		   cod_produto,cod_data_comemorativa,data_venda,valor  
	FROM TB_Aux_Fato_Venda
	WHERE data_carga = @data
	
	OPEN C_Atualiza_Fato_Venda 
		FETCH C_Atualiza_Fato_Venda INTO @cod_venda,@cod_cliente, @cod_funcionario,@cod_pagamento,@cod_loja,
										 @cod_produto, @cod_data_comemorativa,@data_venda, @valor
		WHILE (@@FETCH_STATUS =0)
			BEGIN
				SET @existeErro = 'NAO'
				
				-- Obter� o id_cliente atrav�s da DIM_cliente, se n� encontrar ser� registrado o erro na tabela de viola��o
				SELECT @id_cliente = id_cliente from DIM_Cliente WHERE  cod_cliente=@cod_cliente
				 
				IF (@id_cliente IS NULL) 
					BEGIN
						INSERT INTO TB_Violacao_Fato_Venda  
						VALUES (GETDATE(),'Id_Cliente n�o encontrado',@data,@cod_cliente, @cod_funcionario,
								@cod_pagamento,@cod_loja,@cod_produto, @cod_data_comemorativa,@data_venda, @valor)
										 										 
						SET @existeErro = 'SIM'		
					END
					
				-- Obter� o id_funcionario atrav�s da DIM_Funcionario, se n� encontrar ser� registrado o erro na tabela de viola��o	
				SELECT @id_funcionario = id_funcionario from DIM_Funcionario WHERE  cod_funcionario=@cod_funcionario
				 
				IF (@id_funcionario IS NULL) 
					BEGIN
						INSERT INTO TB_Violacao_Fato_Venda  
						VALUES (GETDATE(),'Id_funcionario n�o encontrado',@data,@cod_cliente, @cod_funcionario,
								@cod_pagamento,@cod_loja,@cod_produto, @cod_data_comemorativa,@data_venda, @valor)
										 										 
						SET @existeErro = 'SIM'		
					END
					
				-- Obter� o id_pagamento atrav�s da DIM_Pagamento, 
				-- se n�o encontrar ser� registrado o erro na tabela de viola��o	
				SELECT @id_pagamento = id_pagamento from DIM_Pagamento WHERE  cod_pagamento=@cod_pagamento
				 
				IF (@id_pagamento IS NULL) 
					BEGIN
						INSERT INTO TB_Violacao_Fato_Venda  
						VALUES (GETDATE(),'Id_pagamento n�o encontrado',@data,@cod_cliente, @cod_funcionario,
								@cod_pagamento,@cod_loja,@cod_produto, @cod_data_comemorativa,@data_venda, @valor)
										 										 
						SET @existeErro = 'SIM'		
					END
				
				-- Obter� o id_tempo atrav�s da DIM_Tempo, 
				-- se n�o encontrar ser� registrado o erro na tabela de viola��o	
				SELECT @id_tempo = id_tempo from DIM_Tempo WHERE  Data=@data_venda
				IF (@id_tempo IS NULL) 
					BEGIN
						INSERT INTO TB_Violacao_Fato_Venda  
						VALUES (GETDATE(),'Id_tempo n�o encontrado',@data,@cod_cliente, @cod_funcionario,
								@cod_pagamento,@cod_loja,@cod_produto, @cod_data_comemorativa,@data_venda, @valor)
										 										 
						SET @existeErro = 'SIM'		
					END
					
				-- Obter� o id_loja atrav�s da DIM_loja, 
				-- se n�o encontrar ser� registrado o erro na tabela de viola��o	
				SELECT @id_loja = id_loja from DIM_Loja WHERE  cod_loja=@cod_loja
				 
				IF (@id_loja IS NULL) 
					BEGIN
						INSERT INTO TB_Violacao_Fato_Venda  
						VALUES (GETDATE(),'Id_loja n�o encontrado',@data,@cod_cliente, @cod_funcionario,
								@cod_pagamento,@cod_loja,@cod_produto, @cod_data_comemorativa,@data_venda, @valor)
										 										 
						SET @existeErro = 'SIM'		
					END
				
				
				-- Obter� o id_produto  atrav�s da DIM_produto , 
				-- se n�o encontrar ser� registrado o erro na tabela de viola��o	
				SELECT @id_produto = id_produto from DIM_Produto WHERE  codigo=@cod_produto
				 
				IF (@id_produto IS NULL) 
					BEGIN
						INSERT INTO TB_Violacao_Fato_Venda  
						VALUES (GETDATE(),'Id_produto n�o encontrado',@data,@cod_cliente, @cod_funcionario,
								@cod_pagamento,@cod_loja,@cod_produto, @cod_data_comemorativa,@data_venda, @valor)
										 										 
						SET @existeErro = 'SIM'		
					END	
				
				-- Obter� o id_data_comemorativa  atrav�s da DIM_data_comemorativa , 
				-- se n�o encontrar ser� registrado o erro na tabela de viola��o	
				SELECT @id_data_comemorativa = id_data_comemorativa from DIM_Data_Comemorativa WHERE  cod_data_comemorativa=@cod_data_comemorativa
				 
				IF (@id_data_comemorativa IS NULL) 
					BEGIN
						INSERT INTO TB_Violacao_Fato_Venda  
						VALUES (GETDATE(),'Id_data_comemorativa n�o encontrado',@data,@cod_cliente, @cod_funcionario,
								@cod_pagamento,@cod_loja,@cod_produto, @cod_data_comemorativa,@data_venda, @valor)
										 										 
						SET @existeErro = 'SIM'		
					END	
					
					
				IF(@existeErro='NAO')
					BEGIN
						INSERT INTO FATO_Venda
						VALUES (@id_cliente,@id_funcionario,@id_pagamento,@id_tempo,@id_loja,@id_produto,@id_data_comemorativa,@cod_venda,1,@valor)
					END
				
				
				FETCH C_Atualiza_Fato_Venda INTO @cod_venda,@cod_cliente, @cod_funcionario,@cod_pagamento,@cod_loja,
										 @cod_produto, @cod_data_comemorativa,@data_venda, @valor
			
			END
	
	CLOSE C_Atualiza_Fato_Venda 
	DEALLOCATE C_Atualiza_Fato_Venda 
	

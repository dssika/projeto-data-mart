
exec Atualiza_DimensaoPagamento '20110625'
select * from DIM_Pagamento

CREATE PROCEDURE Atualiza_DimensaoPagamento (@data DATETIME)
AS
	DECLARE @cod_pagamento INT, @forma_pagamento VARCHAR(10),@existeFormaPagamento INT
	
 DECLARE C_Atualiza_Dim_Pagamento CURSOR FOR
	SELECT cod_pagamento, forma_pagamento FROM TB_Aux_Pagamento
	WHERE data_carga = @data
	OPEN C_Atualiza_Dim_Pagamento 
		FETCH C_Atualiza_Dim_Pagamento INTO @cod_pagamento, @forma_pagamento
		WHILE (@@FETCH_STATUS =0)
			BEGIN
				EXEC Verifica_DIM_Pagamento @cod_pagamento, @existeFormaPagamento OUTPUT
				-- Se Forma de Pagamento já existe na DIM_Pagamento, ele será atualizado, senão, será inserido
				IF (@existeFormaPagamento>0)
					BEGIN
						UPDATE DIM_Pagamento set forma_pagamento=@forma_pagamento where cod_pagamento= @cod_pagamento
						
						FETCH C_Atualiza_Dim_Pagamento INTO @cod_pagamento, @forma_pagamento
					END
				ELSE
					BEGIN
						INSERT INTO DIM_Pagamento(cod_pagamento,forma_pagamento)
						VALUES(@cod_pagamento , @forma_pagamento)
						FETCH C_Atualiza_Dim_Pagamento INTO @cod_pagamento, @forma_pagamento
					END
				
			END
	CLOSE C_Atualiza_Dim_Pagamento
	DEALLOCATE C_Atualiza_Dim_Pagamento 			
			
			


CREATE PROCEDURE Verifica_DIM_Pagamento(@codigo_pagamento INT, @existeFormaPagamento INT OUTPUT)
AS

set @existeFormaPagamento = (SELECT COUNT(cod_pagamento)
					  FROM DIM_Pagamento
					  WHERE cod_pagamento  = @codigo_pagamento )
	
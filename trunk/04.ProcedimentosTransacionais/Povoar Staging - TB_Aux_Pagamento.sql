EXEC cargaStagingPagamento'20110625'
select * from TB_Aux_Pagamento

-- carregar da TB_Pagamento para a Staging (TB_Aux_Pagamento)

ALTER PROCEDURE cargaStagingPagamento (@data_carga DATETIME)
AS
	DECLARE @cod_pagamento INT, @forma_pagamento VARCHAR(10)
			
			delete from TB_Aux_Pagamento where data_carga = @data_carga
			
	DECLARE CARGA_S CURSOR FOR
	SELECT codigo , forma_pagamento FROM TB_FormaPagamento
	OPEN CARGA_S 
		FETCH CARGA_S INTO @cod_pagamento , @forma_pagamento
		WHILE (@@FETCH_STATUS =0)
			BEGIN
				INSERT INTO TB_Aux_Pagamento(data_carga, cod_pagamento, forma_pagamento)
				VALUES(@data_carga,@cod_pagamento  , @forma_pagamento)			
				FETCH CARGA_S INTO @cod_pagamento , @forma_pagamento
			END		
	CLOSE CARGA_S
	DEALLOCATE CARGA_S

	

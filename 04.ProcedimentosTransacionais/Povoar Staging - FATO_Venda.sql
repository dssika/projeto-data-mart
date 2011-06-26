exec Povoar_Staging_Fato_Venda '20110624'
select * from TB_Aux_Fato_Venda


-- carregar da TB_Venda para a Staging (TB_Aux_Venda)

ALTER PROCEDURE Povoar_Staging_Fato_Venda(@data_carga DATETIME)
AS 
	DECLARE @cod_venda INT ,@cod_cliente INT,@cod_funcionario INT,@cod_pagamento INT,
			@cod_loja INT, @cod_produto INT,@cod_data_comemorativa INT,	
			@data_venda DATETIME, @valor DECIMAL(10,2)
			
			delete from TB_Aux_Fato_Venda where data_carga = @data_carga
			
	DECLARE CARGA_S CURSOR FOR
	
	SELECT V.codigo,PV.TB_Produto_codigo, V.TB_FormaPagamento_codigo, V.TB_Funcionario_codigo, V.TB_Loja_codigo,
		   V.TB_DataComemorativa_codigo, V.TB_Cliente_codigo, V.data_venda, V.valor_Total
		   FROM TB_Venda V INNER JOIN Produto_Venda PV
		   ON(PV.TB_Venda_codigo=V.codigo) 
	 
	OPEN CARGA_S 
		FETCH CARGA_S INTO @cod_venda ,@cod_produto,@cod_pagamento,@cod_funcionario,@cod_loja,@cod_data_comemorativa,@cod_cliente, @data_venda, @valor 
		WHILE (@@FETCH_STATUS =0)
			BEGIN
				INSERT INTO TB_Aux_Fato_Venda(data_carga,cod_venda,cod_cliente,cod_funcionario,cod_pagamento,cod_loja,cod_produto,cod_data_comemorativa,data_venda,valor)
				VALUES(@data_carga,@cod_venda,@cod_cliente,@cod_funcionario,@cod_pagamento,@cod_loja,@cod_produto,@cod_data_comemorativa,@data_venda,@valor)			
				FETCH CARGA_S INTO @cod_venda ,@cod_produto,@cod_pagamento,@cod_funcionario,@cod_loja,@cod_data_comemorativa,@cod_cliente, @data_venda, @valor 
			END		
	CLOSE CARGA_S
	DEALLOCATE CARGA_S
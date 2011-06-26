EXEC cargaStagingProduto '20110621'
select * from TB_Aux_Produto

-- carregar da TB_Produto para a Staging (TB_Aux_Produto)

CREATE PROCEDURE cargaStagingProduto(@data_carga DATETIME)
AS
	DECLARE @codigo INT, @codigo_barra INT, @descricao VARCHAR(25),@linha VARCHAR(20),@valor NUMERIC(10,2)
			delete from dbo.TB_Aux_Produto where data_carga = @data_carga
	DECLARE CARGA_S CURSOR FOR
	SELECT codigo , codigo_barra, descricao , linha ,valor FROM TB_Produto
	OPEN CARGA_S 
		FETCH CARGA_S INTO @codigo, @codigo_barra, @descricao ,@linha ,@valor
		WHILE (@@FETCH_STATUS =0)
			BEGIN
				INSERT INTO TB_Aux_Produto(data_carga,codigo,codigo_barra,descricao,linha,valor)
				VALUES(@data_carga,@codigo,@codigo_barra,@descricao,@linha,@valor)			
				FETCH CARGA_S INTO @codigo, @codigo_barra, @descricao ,@linha ,@valor
			END		
	CLOSE CARGA_S
	DEALLOCATE CARGA_S
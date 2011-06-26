EXEC cargaStagingLoja'20110626'
select * from TB_Aux_Loja


-- carregar da TB_Funcionario para a Staging (TB_Aux_Funcionario)

CREATE PROCEDURE cargaStagingLoja (@data_carga DATETIME)
AS
	DECLARE @cod_loja INT, @nome VARCHAR(20), @regiao VARCHAR(20), @estado VARCHAR(20), @cidade VARCHAR(20)
			
			delete from TB_Aux_Loja where data_carga = @data_carga
			
	DECLARE CARGA_S CURSOR FOR
	SELECT codigo , nome ,regiao,estado, cidade FROM TB_Loja
	OPEN CARGA_S 
		FETCH CARGA_S INTO @cod_loja , @nome , @regiao, @estado, @cidade
		WHILE (@@FETCH_STATUS =0)
			BEGIN
				INSERT INTO TB_Aux_Loja(data_carga, cod_loja , nome ,regiao,estado, cidade)
				VALUES(@data_carga, @cod_loja, @nome , @regiao,@estado, @cidade)			
				FETCH CARGA_S INTO @cod_loja , @nome , @regiao, @estado, @cidade
			END		
	CLOSE CARGA_S
	DEALLOCATE CARGA_S
	
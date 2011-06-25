
CREATE PROCEDURE SP_CARGA_STAGING_DATA_COMEMORATIVA(@DATA DATETIME)
AS
	delete from TB_AUX_DATA_COMEMORATIVA
DECLARE
	  @COD_DATA_COMEMORATIVA  INT ,
	  @DESCRICAO VARCHAR(25)  ,
	  @DATA_COMEMORATIVA DATETIME 
	  
DECLARE C_DATA_COMEMORATIVA CURSOR FOR SELECT CODIGO, DESCRICAO, DATA_COMEMORATIVA				
				FROM TB_DATACOMEMORATIVA	
							
OPEN C_DATA_COMEMORATIVA
FETCH C_DATA_COMEMORATIVA INTO @COD_DATA_COMEMORATIVA, @DESCRICAO, @DATA_COMEMORATIVA

				

WHILE (@@FETCH_STATUS = 0)
BEGIN
	INSERT INTO TB_AUX_DATA_COMEMORATIVA (DATA_CARGA,  COD_DATA_COMEMORATIVA, DESCRICAO, DATA_COMEMORATIVA)
				VALUES(@DATA,@COD_DATA_COMEMORATIVA,@DESCRICAO,@DATA_COMEMORATIVA)
	
FETCH C_DATA_COMEMORATIVA INTO	@COD_DATA_COMEMORATIVA, @DESCRICAO, @DATA_COMEMORATIVA

	END
	CLOSE C_DATA_COMEMORATIVA
	DEALLOCATE C_DATA_COMEMORATIVA
	

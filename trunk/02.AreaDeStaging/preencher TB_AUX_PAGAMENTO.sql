  CREATE PROCEDURE SP_CARGA_STAGING_FORMA_PAGAMENTO(@DATA DATETIME)
  AS
  DELETE FROM TB_AUX_PAGAMENTO
  DECLARE
  @CODIGO INT,
  @FORMA_PAGAMENTO VARCHAR(10)
  
  DECLARE C_PAGAMENTO CURSOR FOR SELECT CODIGO, FORMA_PAGAMENTO
				FROM TB_FORMAPAGAMENTO
  
  OPEN C_PAGAMENTO
  FETCH C_PAGAMENTO INTO @CODIGO, @FORMA_PAGAMENTO
  
  WHILE(@@FETCH_STATUS = 0)
  BEGIN
  INSERT INTO TB_AUX_PAGAMENTO (DATA_CARGA, COD_PAGAMENTO, FORMA_PAGAMENTO)
  VALUES (@DATA,@CODIGO,@FORMA_PAGAMENTO)
  
  FETCH C_PAGAMENTO INTO @CODIGO, @FORMA_PAGAMENTO
  END
  CLOSE C_PAGAMENTO
  DEALLOCATE C_PAGAMENTO
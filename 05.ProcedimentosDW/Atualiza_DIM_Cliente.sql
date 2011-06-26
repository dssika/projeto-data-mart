
exec Atualiza_Dimensao_Cliente '20110625'
select * from DIM_Cliente

ALTER PROCEDURE Atualiza_Dimensao_Cliente (@data DATETIME)
AS
	DECLARE @cod_cliente INT, @cpf VARCHAR(11),@nome VARCHAR(30), @data_nascimento DATE,
	@endereco VARCHAR(45), @bairro VARCHAR(20), @cidade VARCHAR(20),@existeCliente INT
	
 DECLARE C_Atualiza_Dim_Cliente CURSOR FOR
	SELECT cod_cliente , cpf, nome , data_nascimento,endereco, bairro, cidade FROM TB_Aux_Cliente
	WHERE data_carga = @data
	OPEN C_Atualiza_Dim_Cliente 
		FETCH C_Atualiza_Dim_Cliente INTO @cod_cliente , @cpf, @nome , @data_nascimento,@endereco, @bairro, @cidade
		WHILE (@@FETCH_STATUS =0)
			BEGIN
				EXEC Verifica_DIM_Cliente @cod_cliente, @existeCliente OUTPUT
				-- Se Cliente já existe na DIM_Cliente, ele será atualizado, senão, será inserido
				IF (@existeCliente>0)
					BEGIN
						UPDATE DIM_Cliente set cpf=@cpf where cod_cliente= @cod_cliente
						UPDATE DIM_Cliente set nome=@nome where cod_cliente= @cod_cliente
						UPDATE DIM_Cliente set data_nascimento=@data_nascimento where cod_cliente= @cod_cliente
						UPDATE DIM_Cliente set endereco=@endereco where cod_cliente= @cod_cliente
						UPDATE DIM_Cliente set bairro=@bairro where cod_cliente= @cod_cliente
						UPDATE DIM_Cliente set cidade=@cidade where cod_cliente= @cod_cliente
						
						FETCH C_Atualiza_Dim_Cliente INTO @cod_cliente , @cpf, @nome , @data_nascimento,@endereco, @bairro, @cidade
					END
				ELSE
					BEGIN
						INSERT INTO DIM_Cliente(cod_cliente , cpf, nome , data_nascimento,endereco, bairro, cidade)
						VALUES(@cod_cliente , @cpf, @nome , @data_nascimento,@endereco, @bairro, @cidade)
					
						FETCH C_Atualiza_Dim_Cliente INTO @cod_cliente , @cpf, @nome , @data_nascimento,@endereco, @bairro, @cidade
					END
				
			END
	CLOSE C_Atualiza_Dim_Cliente 
	DEALLOCATE C_Atualiza_Dim_Cliente 			
			
			


CREATE PROCEDURE Verifica_DIM_Cliente(@codigo_cliente INT, @existeCliente INT OUTPUT)
AS

set @existeCliente = (SELECT COUNT(cod_cliente)
					  FROM DIM_Cliente
					  WHERE cod_cliente = @codigo_cliente)
	
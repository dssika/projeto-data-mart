---------------- DIMENSÃO TEMPO -----------------------
EXEC  Atualiza_Dimensao_Tempo '20000101', '20111231'

 select * from DIM_Tempo

drop procedure inserirNiveis
delete from DIM_Tempo

CREATE PROCEDURE Atualiza_Dimensao_Tempo(@data_inicial DATETIME, @data_final DATETIME)  
AS
BEGIN
	
	WHILE (@data_inicial <= @data_final)
		BEGIN
			EXEC insere_Niveis @data_inicial
			SET @data_inicial = @data_inicial + 1
		END	
END;

--Inserir Níveis

ALTER PROCEDURE insere_Niveis (@dataDoDia datetime)
AS
	SET LANGUAGE BRAZILIAN
	DECLARE @data DATE, @dia SMALLINT, @diaSemanaNome VARCHAR(25),
			@fimSemana CHAR(3),	@quinzena SMALLINT, @mes SMALLINT, @nomeMes VARCHAR(20),
			@fimMes char(3), @trimestre SMALLINT, @nomeTrimestre VARCHAR(20),
			@semestre SMALLINT, @nomeSemestre VARCHAR(20), @ano SMALLINT,
			@estacao VARCHAR(9) , @diaSemanaNumero SMALLINT, @ultimoDiaMes SMALLINT
			 
	SELECT  @data			= CONVERT(VARCHAR(10),@dataDoDia,103)	,
			@dia			= DAY(@dataDoDia),
			@diaSemanaNome	= DATENAME (DW, @data),
			@diaSemanaNumero= DATEPART(DW,@DATA ),
			@mes			= MONTH(@data),
			@nomeMes		= DATENAME(mm, @data),
			@ano			= YEAR(@data),
			@trimestre		= datename(QQ,@data)			

				
	-- Verifica se é Fim de Semana.		
	IF(@diaSemanaNumero >=2 AND @diaSemanaNumero <7)
		BEGIN
			SET @fimSemana = 'NAO'			
		END			
	ELSE
		BEGIN
			SET @fimSemana = 'SIM'
		END
			
	-- quinzena da data
		IF (@dia >=1 AND @dia <16)
			BEGIN
				SET @quinzena = 1
			END
		ELSE
			BEGIN
				SET @quinzena = 2
			END
		
	
	-- nome do trimestre
		IF (@trimestre =1)
				SET @nomeTrimestre = ('1º Trimestre de ' + str(@ano))
		IF (@trimestre =2)
				SET @nomeTrimestre = ('2º Trimestre de ' + str(@ano))
		IF (@trimestre =3)
				SET @nomeTrimestre = ('3º Trimestre de ' + str(@ano))
		IF (@trimestre =4)
				SET @nomeTrimestre = ('4º Trimestre de ' + str(@ano))

	-- semestre e nome do semestre
		IF(@mes >=1 AND @mes<=6)
		BEGIN
			SET @semestre = 1
			SET @nomeSemestre = '1º Semestre de ' + str(@ano)
		END
			ELSE
				BEGIN
					SET @semestre = 2
					SET @nomeSemestre = '2º Semestre de ' + str(@ano) 
				END	

	-- último dia do mês
		SET @ultimoDiaMes =  day(DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,@data)+1,0)))
		IF (@ultimoDiaMes = @dia)
			SET @fimMes = 'SIM'
		ELSE
			SET @fimMes = 'NAO'	
		
		
	-- estação do ano
		IF @mes >=3 and @mes<=5
			set @estacao ='Outono'
		Else
			IF @mes >5 and @mes<=7
				set @estacao='Inverno'
			Else
				IF @mes >7 and @mes<=10
					set @estacao='Primavera'
				Else
					set @estacao='Verão'
			
	
	-- Inserir os dados na DIM_Tempo por nível - DIA
	declare @nivelDia  int
	set @nivelDia = (select  count(Id_Tempo)
					from DIM_Tempo
					where Data = @dataDoDia and Nivel = 'DIA'
					having count(Id_Tempo)>0)
					
					
					
	if(@nivelDia is null )
		begin
			INSERT INTO DIM_Tempo(Nivel, Data, Dia, DiaSemana, FimSemana,
									Quinzena,Mes, NomeMes, FimMes, Trimestre,
									NomeTrimestre, Semestre, NomeSemestre,
									Ano, Estacao)
			VALUES ('DIA', @data, @dia, @diaSemanaNome, @fimSemana,
					@quinzena,@mes, @nomeMes,@fimMes, @trimestre, 
					@nomeTrimestre, @semestre,@nomeSemestre, @ano, 
					@estacao)
		end
			
	-- Inserir os dados na DIM_Tempo por nível - MÊS
	declare @nivelMes  int
	set @nivelMes = (select  count(Id_Tempo)
					from DIM_Tempo
					where Mes = @mes and Nivel = 'MES'
					having count(Id_Tempo)>0)
					
	if(@nivelMes is null )
		begin
			INSERT INTO DIM_Tempo(Nivel, Data, Dia, DiaSemana, FimSemana, 
							Quinzena, Mes, NomeMes, FimMes, Trimestre,
							NomeTrimestre, Semestre, NomeSemestre,
							Ano, Estacao)
			VALUES ('MES', null, null, null,null, null,
			@mes, @nomeMes, @fimMes, @trimestre, 
			@nomeTrimestre, @semestre, @nomeSemestre,
			@ano, @estacao)
		end 	
	
			
			
	-- Inserir os dados na DIM_Tempo por nível - ANO
	declare @nivelAno  int
	set @nivelAno = (select count(Id_Tempo)
					from DIM_Tempo
					where Ano = @ano and Nivel = 'ANO'
					having count(Id_Tempo)>0)
	if(@nivelAno is null)
		begin
			INSERT INTO DIM_Tempo(Nivel, Data, Dia, DiaSemana, FimSemana, 
									Quinzena,Mes, NomeMes, FimMes, Trimestre,
									NomeTrimestre, Semestre, NomeSemestre,
									Ano, Estacao)
			VALUES ('ANO', null, null, null, null, null, 
					null, null, null, null, null, null,
					null, @ano,null)
		end
SELECT * FROM ['Video Games Sales$']
ORDER BY [North America] DESC


SELECT * FROM ['Video Games Sales$']
WHERE [Game Title] LIKE  '%Ã©%'

SELECT * FROM ['Video Games Sales$']
ORDER BY [ANO] DESC

SELECT * FROM ['Video Games Sales$']
ORDER BY [Review] DESC

SELECT * FROM ['Video Games Sales$']
WHERE [Publisher] LIKE  '%NULL%'



SELECT [Game Title],
[North America]+[Europe]+[Japan]+[Rest of World] AS [SOMA TOTAL]
FROM ['Video Games Sales$']


BEGIN TRANSACTION;

	--RETIRANDO OS OUTLIERS DE QUANTIDADE DE PRODUTOS VENDIDOS DE NORTH AMERICA
	UPDATE ['Video Games Sales$']
	SET [North America] = CONVERT(float,[North America]/10000000000000)
	WHERE [North America] > 10000

	--RETIRANDO OS OUTLIERS DE QUANTIDADE DE PRODUTOS VENDIDOS DA EUROPA
	UPDATE ['Video Games Sales$']
	SET [Europe] = CONVERT(float,[Europe]/10000000000000)
	WHERE [Europe] > 10000

	--RETIRANDO OS OUTLIERS DE QUANTIDADE DE PRODUTOS VENDIDOS DA JAPAN
	UPDATE ['Video Games Sales$']
	SET [Japan] = CONVERT(float,[Japan]/10000000000000)
	WHERE [Japan] > 10000

	--RETIRANDO OS OUTLIERS DE QUANTIDADE DE PRODUTOS VENDIDOS DA JAPAN
	UPDATE ['Video Games Sales$']
	SET [Rest of World] = CONVERT(float,[Rest of World]/10000000000000)
	WHERE [Rest of World] > 10000

	--RETIRANDO OS OUTLIERS DE QUANTIDADE DE PRODUTOS VENDIDOS DE NORTH AMERICA
	UPDATE ['Video Games Sales$']
	SET [Global] = CONVERT(float,[Global]/10000000000000)
	WHERE [Global] > 10000



	-- RETIRANDO OS ERROS ORTOGRÁFICOS NOS TÍTULOS DOS GAMES
	UPDATE ['Video Games Sales$']
	SET [Game Title] = REPLACE([Game Title],'Ã©','é')
	WHERE [Game Title] LIKE  '%Ã©%';



	-- CONVERTENDO O ANO DE FLOAT PARA INT  E YEAR OF RELEASE PARA INT
	-- ASSIM É POSSÍVEL PEGAR O ANO DE LANÇAMENTO DA COLUNA [YEAR OF RELEASE PARA] E COLOCAR NA COLUNA DE [ANO]
	UPDATE ['Video Games Sales$']
	SET [Ano] = CONVERT (INT,[Ano]),
		[Year of Release ] = CONVERT(INT,[Year of Release ])

	-- PEGANDO SOMENTE O VALOR DO ANO DE LANÇAMENTO E COLOCANDO NA COLUNA [ANO]
	UPDATE ['Video Games Sales$']
	SET [ANO] = YEAR([Year of Release ])



	-- REVIEW ARRUMAR OS OUTLIERS
	UPDATE ['Video Games Sales$']
	SET [Review] = [Review]/1000000000000
	WHERE [Review] >10000000000

	-- PESQUISANDO OS NOMES DO DOIS TÍTULOS QUE ESTAO VAZIO E ALTERANDO
	UPDATE ['Video Games Sales$']
	SET Publisher = 'Electronic Arts'
	WHERE [Game Title] = 'Triple Play 99'

	UPDATE ['Video Games Sales$']
	SET Publisher = 'THQ'
	WHERE [Game Title] = 'wwe Smackdown vs. Raw 2006'




	-- OBSERVANDO AS MODIFICAÇÕES FEITAS DENTRO DO TRANSACTION
	SELECT * FROM ['Video Games Sales$']
	ORDER BY [Global] DESC

COMMIT;


SELECT * FROM ['Video Games Sales$']
WHERE [Game Title] = 'myst'

ALTER TABLE ['Video Games Sales$']
DROP COLUMN [Total Sale]
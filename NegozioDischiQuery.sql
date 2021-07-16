--Q1
SELECT DISTINCT a.Titolo
FROM Album a
INNER JOIN Band b
ON b.Id = a.BandId
WHERE b.Nome = 'Franco Battiato'

--Q2
SELECT *
FROM Album a
WHERE a.AnnoUscita = 1983 AND a.CasaDiscografica = 'EMI'

--Q3
SELECT br.Titolo
FROM Brano br
INNER JOIN BraniAlbum ba
ON ba.BranoId = br.Id
	INNER JOIN Album a
	ON a.Id = ba.AlbumId
		INNER JOIN Band b
		ON b.Id = a.BandId
WHERE a.AnnoUscita < 1990 AND b.Nome = 'U2'

--Q4
SELECT a.Titolo, a.AnnoUscita, a.CasaDiscografica, a.Genere, a.SupportoDistribuzione
FROM Album a
INNER JOIN BraniAlbum ba
ON ba.AlbumId = a.Id
	INNER JOIN Brano br
	ON ba.BranoId = br.Id
WHERE br.Titolo = 'Imagine'

--Q5
SELECT COUNT(DISTINCT br.Titolo) AS [Numero Canzoni]
FROM Brano br
INNER JOIN BraniAlbum ba
ON br.Id = ba.BranoId
	INNER JOIN Album a
	ON a.id = ba.AlbumId
		INNER JOIN Band b
		ON b.Id = a.BandId
WHERE b.Nome = 'Pooh'
GROUP BY b.Nome


--Q6
SELECT a.Titolo AS [Titolo Album], SUM(br.Durata) AS [Secondi Totali]
FROM Album a
INNER JOIN BraniAlbum ba
ON ba.AlbumId = a.Id
	INNER JOIN Brano br
	ON ba.BranoId = br.Id
GROUP BY a.Titolo, a.SupportoDistribuzione


--FUNZIONE
SELECT *
FROM dbo.ufnNumeroAlbumGeneri()

SELECT *
FROM dbo.ufnNumeroAlbumPerGenere('Rock')
--anche se non richiesta ho fatto anche una funzione per selezionare il genere

--STORED PROCEDURE SU QUERY 2
DECLARE @ValoreRitorno int

EXEC @ValoreRitorno = [dbo].[sp.CercaAlbumPerEditoreEPerAnno]
	@editore = N'Emi'
	, @anno = 1983
	SELECT [Valore di Ritorno] = @ValoreRitorno
	GO


---- VISTA
--CREATE VIEW VistaGeneraleNegozio AS
--SELECT a.Titolo AS [Titolo Album]
--	, a.AnnoUscita AS [Anno Pubblicazione]
--	, a.CasaDiscografica AS [Etichetta]
--	, a.Genere 
--	, a.SupportoDistribuzione AS [Supporto]
--	, b.Nome AS [Band]
--	, b.NumeroComponenti AS [Componenti]
--	, br.Titolo AS [Titolo Brano]
--	, br.Durata AS [Durata (sec)]
--FROM Band b
--INNER JOIN Album a
--ON b.Id = a.BandId
--	INNER JOIN BraniAlbum ba
--	ON ba.AlbumId = a.Id
--		INNER JOIN Brano br
--		ON br.Id = ba.BranoId
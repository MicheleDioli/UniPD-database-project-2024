--query 1: stampa il nome e il badge di tutti i capi reparto che hanno eseguito un operazione su 
--pazienti che sono stati ricoverati dopo una data scelta dall'utente e stampa anche il nome del paziente 


--query 2: stampa i nomi e cognomi di tutti i pazienti ricoverati in un reparto scelto da utente a cui sono stati prescritti farmaci
--e che hanno un allergia 


--query 3: stampa nome e grado di parentela degli accompagnatori (e cf del paziente accompagnato) di pazienti che hanno un 
--gruppo sanguigno scelto da utente e che sono in una camra con + di 3 posti letto


--query 4: stampa il nome,cognome e reparto e id operazione di medici che abbiano svolto operazioni che hanno avuto esito negativo in sale 
--operatorie con un livello di attrezzatura alto


--query 6: stampa l'id del ricovero il numero di camera, il nome del reparto e il badge del medico che ha scitto la cartella clinica di
--ogni paziente che sia stato ricoverato precedentemente a una data inserita da utente e stampare (in booleano tipo si o no)
--se ha mai subito un'operazione


--query nuove

--1 : calcolare la media di ricoverati nell'ospedale per camera e poi scelto un reparto da utente calcolare il numero di 
--    ricoverati per camera in quel reparto in modo da avere un confronto
WITH media AS(
SELECT Camere.id_camera, COUNT(*) AS pa
    FROM Ricoveri, Camere
    WHERE Ricoveri.id_camera = Camere.id_camera
	GROUP BY Camere.id_camera
),
media2 AS(
SELECT Camere.id_camera, COUNT(*) AS pb
	FROM Ricoveri, Camere
	WHERE Ricoveri.id_camera = Camere.id_camera AND Camere.nome_reparto = 'Pediatria'
	GROUP BY Camere.id_camera
)


SELECT AVG(pa) AS media_stanze, AVG(pb) AS media_reparto
FROM media, media2

--2 : stampa il numero di chirurgi che hanno lavorato nelle sale operatorie raggruppandoli per il livello di attrezzatura della sala
SELECT so.livello_attrezzatura, COUNT(lo.badge) AS n_chirurgi
FROM Operazioni AS o, Lista_operazioni AS lo, Sale_operatorie AS so
WHERE lo.id_operazione = o.id_operazione AND o.sala = so.id_sala
GROUP BY so.livello_attrezzatura
--questa che e molto easy la metteri come prima ne do una della stessa difficolta come alternativa
--2.2 : 

--3 : stampare i nome nome, cognome e badge del capo reparto (scelto da utente) e nome del reparto, del reparto con piu ricoverati 
SELECT pm.nome, pm.cognome, pm.badge, rp.nome_reparto
FROM Personale_medico AS pm, Reparto AS rp, Ricoveri AS ri, Camere AS ca
WHERE pm.capo_reparto = 101 AND pm.reparto = rp.nome_reparto
AND ri.id_camera = ca.id_camera AND ca.reparto = rp.nome_reparto AND stato_ricovero 
IN 
(
    SELECT stato_ricovero
	FROM Ricoveri, Camere
	GROUP BY stato_ricovero
	HAVING COUNT(*) = SELECT MAX(CONT) FROM (
			SELECT stato_ricovero, COUNT(*) AS CONT FROM Ricoveri
			GROUP BY stato_ricovero) AS CONTA


-- la media dell'eta dei chirurgi e nome del paziente operato delle operazioni con piu di n chirurgi scelti da utente

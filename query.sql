--query 1: stampa il nome e il badge di tutti i capi reparto che hanno eseguito un operazione su 
--pazienti che sono stati ricoverati dopo una data scelta dall'utente e stampa anche il nome del paziente 
WITH Ricoveri_dopo AS(
    SELECT 
        p.c_f,
        p.nome
    FROM Pazienti p
    JOIN Ricoveri r ON p.c_f = r.cf_ricoverato
    WHERE data_ricovero >= '2024-12-01'
),

WITH Chirurgi_capo AS(
    SELECT
    pe.badge, 
    pe.nome
    c.c_f
    FROM Personale_medico pe, Cartella_clinica c
    JOIN Lista_operazioni lo ON pe.badge = lo.badge
    JOIN Operazioni o ON o.id_operazione = lo.id_operazioni
    JOIN Cartella_clinica c ON o.id_cartella = c.id_cartella 
    WHERE pe.capo_reparto = TRUE
),

SELECT 
    cc.nome, 
    cc.badge,
    rd.nome
FROM Chirurgi_capo cc, Ricoveri_dopo rd
WHERE cc.cf = rd.c_f;

--query 2: stampa i nomi e cognomi di tutti i pazienti ricoverati in un reparto scelto da utente a cui sono stati prescritti farmaci
--e che hanno un allergia 
WITH Pazienti_selezionati AS (
    SELECT DISTINCT
        p.c_f,
    FROM Pazineti p, Cartella_clinica cl
    JOIN Lista_farmaci lf ON lf.id_cura = cl.id_cura
    WHERE cl.allergie != NULL AND cl.cf_paziente = p.c_f
),

WITH pazienti_reparti AS (
    SELECT 
        r.cf_ricoverato,
    FROM Ricoveri r
    WHERE Camere.id_camera = r.id_camera AND Camere.nome_reparto = "Oncologia"
    GROUP BY nome_reparto
),

SELECT
    p.nome
    p.cognome
FROM Pazienti p
WHERE Pazienti_reparto.cf_ricoverato = p.c_f

--query 3: stampa nome e grado di parentela degli accompagnatori (e cf del paziente accompagnato) di pazienti che hanno un 
--gruppo sanguigno scelto da utente e che sono in una camra con + di 3 posti letto
WITH stanze_posti AS (
	SELECT cf_ricoverato
	FROM Ricoveri, Camere
	WHERE Ricoveri.id_camera = Camere.id_camera AND Camere.massimo_letti >= 3
)

SELECT a.nome, a.parentela, p.c_f
FROM Accompagnatori AS a, Pazienti AS p
WHERE p.gruppo_sanguigno = 'A+' AND p.cf = stanze_posti.cf_ricoverato AND a.cf_accompagnato = p.c_f

--query 4: stampa il badge di medici che abbiano svolto operazioni che hanno avuto esito negativo in sale operatorie con un livello 
--di attrezzatura alto e il nome del paziente operato

--query 5: stampa nome, effetti collaterali e numero di pazienti a cui è prescitto per ogni reparto un farmaco scleto da utente tramite id

--query 6: stampa l'id del ricovero il numero di camera, il nome del reparto e il badge del medico che ha scitto la cartella clinica di
--ogni paziente che sia stato ricoverato precedentemente a una data inserita da utente e stampare (in booleano tipo si o no)
--se ha mai subito un'operazione

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
FROM Ricoveri_dopo, Chirurgi_capo
WHERE cc.cf = rd.c_f

--query 2: stampa i nomi di tutti i pazienti di un reparto scelto da utente a cui sono stati prescritti farmaci
--e che hanno un allergia 


--query 3: stampa nome e grado di parentela degli accompagnatori (e cf del paziente accompagnato) di pazienti che hanno un 
--gruppo sanguigno scelto da utente e che siano ricoverati in una camera che ha più di tre posti letto  

--query 4: stampa il badge di medici che abbiano svolto operazioni che hanno avuto esito negativo in sale operatorie con un livello 
--di attrezzatura alto e il nome del paziente operato

--query 5: stampa nome, effetti collaterali e numero di pazienti a cui è prescitto per ogni reparto un farmaco scleto da utente tramite id

--query 6: stampa l'id del ricovero il numero di camera, il nome del reparto e il badge del medico che ha scitto la cartella clinica di
--ogni paziente che sia stato ricoverato precedentemente a una data inserita da utente e stampare (in booleano tipo si o no)
--se ha mai subito un'operazione
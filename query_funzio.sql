WITH Ricoveri_dopo AS (
    SELECT 
        p.c_f,
        p.nome AS nome_paziente
    FROM Pazienti p
    JOIN Ricoveri r ON p.c_f = r.cf_ricoverato
    WHERE r.data_ricovero >= '2024-12-01'
),

Chirurgi_capo AS (
    SELECT
        p.badge, 
        p.nome AS nome_chirurgo,
        c.cf_paziente
    FROM Personale_medico p
    JOIN Lista_operazioni lo ON p.badge = lo.badge
    JOIN Operazioni o ON o.id_operazione = lo.id_operazione
    JOIN Cartella_clinica c ON o.id_cartella = c.id_cartella 
    WHERE p.capo_reparto = TRUE
)

SELECT 
    cc.nome_chirurgo, 
    cc.badge,
    rd.nome_paziente
FROM Chirurgi_capo cc 
JOIN Ricoveri_dopo rd ON rd.c_f = cc.cf_paziente;

--

WITH Pazienti_selezionati AS (
    SELECT 
        p.c_f,
        p.nome,
        p.cognome
    FROM Pazienti p
    JOIN Cartella_clinica cl ON cl.cf_paziente = p.c_f
	JOIN Lista_farmaci lf ON cl.id_cartella = cl.id_cartella
    WHERE cl.allergie IS NOT NULL
	),
	
pazienti_reparti AS (
    SELECT 
        r.cf_ricoverato
    FROM Ricoveri r
    JOIN Camere c ON r.id_camera = c.id_camera
    WHERE c.nome_reparto = 'Oncologia'
    GROUP BY r.cf_ricoverato
)

SELECT
    p.nome,
    p.cognome,
	f.nome
FROM Pazienti p
JOIN Pazienti_reparti pr ON pr.cf_ricoverato = p.c_f
JOIN Cartella_clinica cl ON cl.cf_paziente = p.c_f
JOIN Lista_farmaci lf ON cl.id_cartella = cl.id_cartella
JOIN Farmaci f ON f.id_farmaco = lf.id_farmaco
WHERE p.c_f IN (
	SELECT 
		c_f 
		FROM Pazienti_selezionati);


--query 3
WITH stanze_posti AS (
	SELECT cf_ricoverato
	FROM Ricoveri, Camere
	WHERE Ricoveri.id_camera = Camere.id_camera AND Camere.massimo_letti >= 3
)

SELECT a.nome, a.parentela, cf_ricoverato
FROM Accompagnatori AS a, stanze_posti
WHERE a.cf_paziente = stanze_posti.cf_ricoverato

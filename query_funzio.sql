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
        r.cf_ricoverato,
		r.data_ricovero
    FROM Ricoveri r
    JOIN Camere c ON r.id_camera = c.id_camera
    WHERE c.nome_reparto = 'Oncologia'
    ORDER BY r.data_ricovero DESC
)
SELECT
    p.nome,
    p.cognome,
	pr.data_ricovero
FROM Pazienti p
JOIN Pazienti_reparti pr ON pr.cf_ricoverato = p.c_f
WHERE p.c_f IN (
	SELECT 
		c_f 
		FROM Pazienti_selezionati);

--

WITH stanze_posti AS (
	SELECT cf_ricoverato
	FROM Ricoveri, Camere
	WHERE Ricoveri.id_camera = Camere.id_camera AND Camere.massimo_letti >= 3
)

SELECT 
a.nome,
a.parentela,
p.c_f
FROM Accompagnatori a
JOIN Pazienti p ON a.cf_paziente = p.c_f
JOIN Cartella_clinica cl ON cl.cf_paziente = p.c_f
WHERE cl.gruppo_sanguigno = 'A+' AND p.c_f IN (
	SELECT
	cf_ricoverato 
	FROM stanze_posti);

--

WITH operazioni_n AS(
	SELECT
		id_operazione,
		id_cartella
		FROM Operazioni 
		WHERE Operazioni.esito = 'negativo'
)

SELECT	
	p.badge,
	po.nome
FROM Personale_medico p
JOIN Lista_operazioni lo ON p.badge = lo.badge
JOIN Operazioni o ON o.id_operazione = lo.id_operazione
JOIN Cartella_clinica cl ON cl.id_cartella = o.id_cartella
JOIN Pazienti po ON po.c_f = cl.cf_paziente
WHERE 
	cl.id_cartella IN(
	SELECT id_cartella 
	FROM operazioni_n
	);

--

WITH Personale_n AS (
    SELECT p.nome, 
           COUNT(*) AS conta
    FROM Personale_medico p
    JOIN Lista_operazioni l ON l.badge = p.badge
    JOIN Operazioni o ON o.id_operazione = l.id_operazione
    JOIN Sale_operatorie so ON so.id_sala = o.sala
    WHERE o.esito = 'negativo' 
      AND so.livello_attrezzatura = 'basso'
    GROUP BY p.nome
    ORDER BY conta DESC
)
SELECT p.nome,
       p.cognome,
       p.badge
FROM Personale_medico p
JOIN Personale_n pn ON p.nome = pn.nome;
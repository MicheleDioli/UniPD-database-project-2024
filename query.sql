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
SELECT ROUND(AVG(pa),2) AS media_stanze, ROUND(AVG(pb),2) AS media_reparto
FROM media, media2

--2 : stampa il numero di chirurgi che hanno lavorato nelle sale operatorie raggruppandoli per il livello di attrezzatura della sala (tramite id)
SELECT
    so.livello_attrezzatura,
    COUNT(DISTINCT lo.badge) AS n_chirurgi
FROM Sale_operatorie AS so
         JOIN Operazioni AS o ON o.sala = so.id_sala
         JOIN Lista_operazioni AS lo ON lo.id_operazione = o.id_operazione
GROUP BY so.livello_attrezzatura;

--questa che e molto easy la metteri come prima ne do una della stessa difficolta come alternativa
--2.2:

--3: stampare i nome, cognome e badge del capo reparto (scelto da utente) e nome del reparto, del reparto con piu ricoverati
SELECT
    pm.nome,
    pm.cognome,
    pm.badge,
    pm.reparto,
    COUNT(DISTINCT ca.id_camera) AS numero_camere_occupate
FROM Personale_medico AS pm
         JOIN Camere AS ca ON pm.reparto = ca.nome_reparto
         JOIN Ricoveri AS ri ON ca.id_camera = ri.id_camera
WHERE pm.capo_reparto = TRUE
GROUP BY pm.nome, pm.cognome, pm.badge, pm.reparto
HAVING COUNT(DISTINCT ca.id_camera) = (
    SELECT
        MAX(numero_camere)
    FROM (
             SELECT
                 COUNT(DISTINCT ca.id_camera) AS numero_camere
             FROM Camere AS ca
                      JOIN Ricoveri AS ri ON ca.id_camera = ri.id_camera
             GROUP BY ca.nome_reparto
         ) AS conteggio
);

-- scelto un farmaco tramite id conta a quanti pazienti e stato prescritto e il reparto a in cui e stato prescritto

SELECT
    fa.nome, fa.dosaggio AS farmaco,
    COUNT(DISTINCT p.c_f) AS pazienti_prescritti,
    r.nome_reparto AS reparto_prescritto_di_piu
FROM
    Lista_farmaci lf
        JOIN Cure c ON lf.id_cura = c.id_cura
        JOIN Cartella_clinica cc ON c.id_cartella = cc.id_cartella
        JOIN Pazienti p ON cc.cf_paziente = p.c_f
        JOIN Personale_medico pm ON c.badge = pm.badge
        JOIN Reparti r ON pm.reparto = r.nome_reparto
        JOIN Farmaci fa ON lf.id_farmaco = fa.id_farmaco
WHERE fa.id_farmaco = 406
GROUP BY
    fa.nome, r.nome_reparto, fa.dosaggio
ORDER BY
    pazienti_prescritti DESC

-- anno scelto e n operazioni scelte con media eta chi, e eta paziente
SELECT
    o.id_operazione,
    o.data_ AS data_operazione,
    p.eta AS eta_paziente,
    ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, pm.data_nascita))),1) AS eta_media_chirurghi
FROM Operazioni AS o
         JOIN Lista_operazioni AS lo ON o.id_operazione = lo.id_operazione
         JOIN Personale_medico AS pm ON lo.badge = pm.badge
         JOIN Cartella_clinica AS cc ON o.id_cartella = cc.id_cartella
         JOIN Pazienti AS p ON cc.cf_paziente = p.c_f
WHERE o.data_ > '2024-01-01'
GROUP BY o.id_operazione, o.data_, p.eta
ORDER BY o.data_ ASC
    LIMIT 5;
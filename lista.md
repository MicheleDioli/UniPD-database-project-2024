-Pazienti (c.f, nome, cognome, sesso, data nascita, comune nascita, contatti)

-Cartella clinica (id cartella, c.f(fk), allergie, gruppo sanguigno, patologie,id cura(f.k))

-Camere (id camera, reparto(fk), numero letti)

-Ricoveri (id ricovero, id camera(fk), c.f.(fk), data ricovero, ora ricovero, data rilascio, ora rilascio, stato ricovero)

-Accompagnatori (c.f. acc, c.f(fk), nome, cognome, data nascita, parentela, contatti)

-Personale medico (badge, nome, cognome, data nascita, ruolo, salario, comune nascita)

-Farmaci (id farmaco,nome, dosaggio, effetti, controindicazioni,data scadenza)

-Cure (id cura, badge(fk), c.f.(fk), id farmaco(fk), data, ora, tipo)

-Operazioni (id operazione, durata, esito, data, sala(fk),c.f.(fk))

-Sala operatoria (id sala, max persone, livello attrezzatura)

//allergie come tabella per la terza forma normale??

-Reparto (nome reparto, piano, capacità massima, telefono reparto)

-Personale reparto(badge,nome reparto)

-Partecipazioni operazioni(badge id operazione)
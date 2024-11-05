*-Pazienti (c.f, nome, cognome, sesso, data nascita, comune nascita, contatti)

*-Cartella clinica (id cartella, c.f(fk), allergie, gruppo sanguigno, patologie)

*-Camere (id camera, disponibilità, reparto(fk), numero letti)

*-Ricoveri (id camera(fk), c.f.(fk), data ricovero, ora ricovero, data rilascio, ora rilascio, stato ricovero)

*-Accompagnatori (c.f. acc, c.f(fk), nome, cognome, data nascita, parentela, contatti)

*-Personale medico (badge, nome, cognome, primario, data nascita, specializzazione, salario, comune nascita)

*-Farmaci (id farmaco,nome, dosaggio, effetti, controindicazioni,data scadenza)

-Cure (id cura, badge(fk), c.f.(fk), id farmaco(fk), data, ora)

*-Operazioni (id operazione, durata, esito, badge chirurgo(fk), data, sala(fk),c.f.(fk))

*-Sala operatoria (id sala, max persone, livello attrezzatura)

*-Attrezzatura medica (id attrezzatura, nome attrezzatura, nome reparto(fk), stato manutenzione, tipo attrezzatura, pericolosità)

*-Reparto (nome reparto, capo reparto(fk), piano, capacità massima, telefono reparto)

*-Allergie(c.f.(fk), allergia)
-Personale medico (badge,cognome,nome,comune nascita, data nascita, ruolo, salario)

-Pazienti (c.f, nome, cognome, sesso, data nascita, comune nascita, contatti)

-Cartella clinica (id cartella, gruppo sanguigno, patologia, allergie)

-Camere (id camera, numero letti occupati, max letti, reparto(f.k.))

-Ricoveri (id ricovero, ora ricovero, data ricovero, ora rilascio, data rilascio, stato ricovero, id camera(f.k.))

-Accompagnatori (c.f. acc, nome, cognome, data nascita, parentela, contatti, c.f.(f.k.))

-Farmaci (id farmaco,nome, dosaggio, effetti, scadenza, controindicazioni, allergeni)

-Cure (id cura, data, ora, tipo, farmaco(f.k.), badge(f.k.), c.f.(f.k.))

-Operazioni (id operazione, durata, esito, data, orario inizio, id sala(f.k.))

-Sala operatoria (id sala, max persone, livello attrezzatura)

-Reparto (nome reparto, piano, capacità massima, telefono reparto)

-listaOperazioni(badge(f.k.), id operazione(f.k.), c.f.(f.k.))

-listaLavoratori(badge(f.k.), reparto(f.k.))

-listaRicoveri(c.f.(f.k.), id ricovero(c.k.),)

-listafarmaci(cura (id_cura), farmaci (id_farmaco))
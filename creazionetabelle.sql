DROP TABLE IF EXISTS Personale_medico CASCADE;
DROP TABLE IF EXISTS Reparti CASCADE;
DROP TABLE IF EXISTS Camere CASCADE;
DROP TABLE IF EXISTS Pazienti CASCADE;
DROP TABLE IF EXISTS Ricoveri CASCADE;
DROP TABLE IF EXISTS Accompagnatori CASCADE;
DROP TABLE IF EXISTS Sale_operatorie CASCADE;
DROP TABLE IF EXISTS Operazioni CASCADE;
DROP TABLE IF EXISTS Farmaci CASCADE;
DROP TABLE IF EXISTS Cartella_clinica CASCADE;
DROP TABLE IF EXISTS Cure CASCADE;
DROP TABLE IF EXISTS Lista_operazioni CASCADE;
DROP TABLE IF EXISTS Lavoratori_reparto CASCADE;
DROP TABLE IF EXISTS Camere_ricoveri CASCADE;
DROP TABLE IF EXISTS Lista_farmaci CASCADE;


CREATE TABLE IF NOT EXISTS Personale_medico(
    badge INT PRIMARY KEY,
    nome VARCHAR(32) NOT NULL,
    cognome VARCHAR(32) NOT NULL,
    data_nascita DATE NOT NULL,
    comune_nascita VARCHAR(32) NOT NULL,
    stipendio INT NOT NULL,
    reparto VARCHAR(32) NOT NULL
);

CREATE TABLE IF NOT EXISTS Reparti(
    nome_reparto VARCHAR(16) PRIMARY KEY,
    piano INT NOT NULL,
    capacita_massima INT NOT NULL,
    telefono_reparto  VARCHAR(10) NOT NULL,
    badge_capo_reparto INT NOT NULL,
    FOREIGN KEY badge_capo_reaprto REFERENCES Personale_medico(badge)
);

CREATE TABLE IF NOT EXISTS Camere(
    id_camera INT PRIMARY KEY,
    nome_reparto VARCHAR(16) NOT NULL,
    massimo_letti INT NOT NULL,
    FOREIGN KEY (nome_reparto) REFERENCES Reparti(nome_reparto)
);

CREATE TABLE IF NOT EXISTS Pazienti(
    c_f VARCHAR(16) PRIMARY KEY,
    nome VARCHAR(32) NOT NULL,
    cognome VARCHAR(32) NOT NULL,
    sesso VARCHAR(8) NOT NULL,
    data_nascita DATE NOT NULL,
    comune_nascita VARCHAR(32) NOT NULL
);

CREATE TABLE IF NOT EXISTS Ricoveri(
    id_ricovero INT PRIMARY KEY,
    data_ricovero DATE NOT NULL,
    ora_ricovero INT NOT NULL,
    stato_ricovero VARCHAR(16) NOT NULL,
    cf_paziente VARCHAR(16) NOT NULL,
    FOREIGN KEY (cf_paziente) REFERENCES Pazienti(cf_paziente)
);-- da aggiungere nella popolazione 


CREATE TABLE IF NOT EXISTS Accompagnatori(
    cf_accompagnatore VARCHAR(16) PRIMARY KEY,
    nome VARCHAR(32) NOT NULL,
    cognome VARCHAR(32) NOT NULL,
    data_nascita DATE NOT NULL,
    parentela VARCHAR(32) NOT NULL,
    contatti VARCHAR(64) NOT NULL,
    cf_paziente VARCHAR(16) NOT NULL,
    FOREIGN KEY (cf_paziente) REFERENCES Pazienti(c_f)
);
CREATE TYPE gruppo AS ENUM ('A+','A-','B+','B-','0+','0-','AB+','AB-');

CREATE TABLE IF NOT EXISTS Cartella_clinica(
    id_cartella INT PRIMARY KEY,
    allergie VARCHAR(64),
    patologie VARCHAR(64),
    gruppo_sanguigno GRUPPO NOT NULL,
    cf_paziente VARCHAR(16) NOT NULL,
    FOREIGN KEY (cf_paziente) REFERENCES Pazienti(c_f)
);

CREATE TABLE IF NOT EXISTS Sale_operatorie(
    id_sala INT PRIMARY KEY,
    max_persone INT NOT NULL,
    livello_attrezzatura INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Operazioni(
    id_operazione INT PRIMARY KEY,
    durata_ore INT NOT NULL,
    esito VARCHAR(32) NOT NULL,  
    data_ DATE NOT NULL,
    sala INT NOT NULL,
    orario_inizio TIME NOT NULL,
    id_cartella INT NOT NULL,
    FOREIGN KEY (sala) REFERENCES Sale_operatorie(id_sala),
    FOREIGN KEY id_cartella REFERENCES Cartella_clinica(id_cartella)
);

CREATE TABLE IF NOT EXISTS Farmaci(
    id_farmaco INT PRIMARY KEY,
    nome VARCHAR(32) NOT NULL,
    dosaggio VARCHAR(32) NOT NULL,
    -- effetti VARCHAR(64) NOT NULL, non mettere per facilità
    controindicazioni VARCHAR(64) NOT NULL,
    data_scandenza DATE NOT NULL,
    allergeni VARCHAR(64)
);  

CREATE TABLE IF NOT EXISTS Cure(
    id_cura INT PRIMARY KEY,
    badge INT NOT NULL,
    id_cartella VARCHAR(16) NOT NULL,
    FOREIGN KEY (badge) REFERENCES Personale_medico(badge),
    FOREIGN KEY (id_cartella) REFERENCES Cartella_clinica(id_cartella)
); -- data e ora mi sembravano inutili!


CREATE TABLE IF NOT EXISTS Lista_operazioni(
    badge INT NOT NULL,
    id_operazione INT NOT NULL,
    PRIMARY KEY(badge, id_operazione),
    FOREIGN KEY (badge) REFERENCES Personale_medico(badge),
    FOREIGN KEY (id_operazione) REFERENCES Operazioni(id_operazione),
);

CREATE TABLE IF NOT EXISTS Lavoratori_reparto(
    badge INT NOT NULL,
    reparto VARCHAR(16)NOT NULL,
    PRIMARY KEY(badge, reparto),
    FOREIGN KEY (badge) REFERENCES Personale_medico(badge),
    FOREIGN KEY (reparto) REFERENCES Reparti(nome_reparto)
);--attributo nome_reparto modificato con reparto

CREATE TABLE IF NOT EXISTS Camere_ricoveri(
    id_camera INT NOT NULL,
    id_ricovero INT NOT NULL,
    PRIMARY KEY(id_camera,id_ricovero),
    FOREIGN KEY (id_camera) REFERENCES Camere(id_camera),
    FOREIGN KEY (id_ricovero) REFERENCES Ricoveri(id_ricovero)
);

CREATE TABLE IF NOT EXISTS Camere_reparti(
    id_camera INT NOT NULL,
    reparto VARCHAR(16),
    PRIMARY KEY(id_camera, reparto),
    FOREIGN KEY (id_camera) REFERENCES Camere(id_camera),
    FOREIGN KEY (reparto) REFERENCES Reparti(nome_reparto)
)

CREATE TABLE IF NOT EXISTS Lista_farmaci(
    id_cura INT NOT NULL,    
    id_farmaco INT NOT NULL,
    PRIMARY KEY (id_cura, id_farmaco)
    FOREIGN KEY (id_cura) REFERENCES Cure(id_cura),
    FOREIGN KEY (id_farmaco) REFERENCES Farmaci(id_farmaco)
);


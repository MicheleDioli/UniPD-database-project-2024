DROP TABLE IF EXISTS Personale_medico CASCADE;
DROP TABLE IF EXISTS Pazienti CASCADE;
DROP TABLE IF EXISTS Accompagnatori CASCADE;
DROP TABLE IF EXISTS Sale_operatorie CASCADE;
DROP TABLE IF EXISTS Operazioni CASCADE;
DROP TABLE IF EXISTS Farmaci CASCADE;
DROP TABLE IF EXISTS Cartella_clinica CASCADE;
DROP TABLE IF EXISTS Reparti CASCADE;
DROP TABLE IF EXISTS Attrezzatura_medica CASCADE;
DROP TABLE IF EXISTS Cure CASCADE;
DROP TABLE IF EXISTS Camere CASCADE;
DROP TABLE IF EXISTS Ricoveri CASCADE;
DROP TABLE IF EXISTS Registro_operazioni CASCADE;
DROP TABLE IF EXISTS Capi_reparti CASCADE;
DROP TABLE IF EXISTS Allergie CASCADE;

CREATE TABLE IF NOT EXISTS Personale_medico(
    badge PRIMARY KEY,
    nome VARCHAR(32) NOT NULL,
    cognome VARCHAR(32) NOT NULL,
    primario BOOLEAN NOT NULL,
    ruolo VARCHAR(16) NOT NULL,
    data_nascita DATE NOT NULL,
    comune_nascita VARCHAR NOT NULL,
    stipendio INT NOT NULL,
);

CREATE TABLE IF NOT EXISTS Pazienti(
    c_f VARCHAR(16) PRIMARY KEY,
    nome VARCHAR(32) NOT NULL,
    cognome VARCHAR(32) NOT NULL,
    sesso VARCHAR(8) NOT NULL,
    data_nascita DATE NOT NULL,
    comune_nascita VARCHAR(32) NOT NULL,
    contatti VARCHAR(32) NOT NULL,
 );

CREATE TABLE IF NOT EXISTS Accompagnatori(
    nome VARCHAR(32) NOT NULL,
    cognome VARCHAR(32) NOT NULL,
    cf_accompagnatore VARCHAR(16) PRIMARY KEY,
    cf_paziente VARCHAR(16) NOT NULL,
    data_nascita DATE NOT NULL
    parentela VARCHAR(32) NOT NULL,
    contatti VARCHAR(64) NOT NULL,
    FOREIGN KEY (cf_paziente) REFERENCES Pazienti(c_f),
);

CREATE TABLE IF NOT EXISTS Sale_operatorie(
    id_sala INT PRIMARY KEY,
    max_persone INT NOT NULL,
    livello_attrezzatura INT NOT NULL,
);

CREATE TABLE IF NOT EXISTS Operazioni(
    id_operazione INT PRIMARY KEY,
    durata VARCHAR(32) NOT NULL,
    esito VARCHAR(32) NOT NULL,  
    badge_chilurgo INT NOT NULL,
    data_ DATE NOT NULL,
    sala INT NOT NULL,
    cf_paziente INT NOT NULL,
    FOREIGN KEY (cf_paziente) REFERENCES Pazienti(c_f),
    FOREIGN KEY (sala) REFERENCES Sale_operatorie(id_sala),
    FOREIGN KEY (badge_chilurgo) REFERENCES Personale_medico(badge);
);

CREATE TABLE IF NOT EXISTS Farmaci(
    id_farmaco INT PRIMARY KEY,
    nome VARCHAR(32) NOT NULL,
    dosaggio VARCHAR(32) NOT NULL,
    effetti VARCHAR(64) NOT NULL,
    controindicazioni VARCHAR(64) NOT NULL,
    data_scandenza DATE NOT NULL;
);

CREATE TABLE IF NOT EXISTS Cure(
    id_cura INT NOT NULL,
    badge INT NOT NULL,
    cf_paziente INT NOT NULL,
    id_farmaco INT NOT NULL,
    data_ DATA NOT NULL,
    ora INT NOT NULL,
    FOREIGN KEY (badge) REFERENCES Personale_medico(badge),
    FOREIGN KEY (id_farmaco) REFERENCES Farmaci(id_farmaco),
    FOREIGN KEY (cf_paziente) REFERENCES Pazienti(c_f);
);

CREATE TYPE gruppo AS ENUM ('A+','A-','B+','B-','0+','0-','AB+','AB-');

CREATE TABLE IF NOT EXISTS Cartella_clinica(
    gruppo_sanguigno GRUPPO NOT NULL,
    motivo_ricovero VARCHAR(128),
    cf_paziente VARCHAR(16) PRIMARY KEY,
    stato_paziente VARCHAR(32) NOT NULL,
    FOREIGN KEY (cf_paziente) REFERENCES Pazienti(c_f);
);

CREATE TABLE IF NOT EXISTS Reparti(
    nome_reparto VARCHAR PRIMARY KEY,
    piano INT NOT NULL,
    capacita_massima INT NOT NULL,
    telefono_reparto  VARCHAR(10) NOT NULL,
);

CREATE TABLE IF NOT EXISTS Attrezzatura_medica(
    id_attrezzatura INT NOT NULL,
    nome_attrezzatura VARCHAR(32) NOT NULL,
    nome_reparto VARCHAR(16) NOT NULL
    pericolosità INT NOT NULL,
    stato_manutenzione VARCHAR(32) NOT NULL,
    tipo_attrezzetura VARCHAR(32) NOT NULL,
    FOREIGN KEY (nome_reparto) REFERENCES Reparti(nome_reparto);
);

CREATE TABLE IF NOT EXISTS Camere(
    id_camera INT PRIMARY KEY,
    nome_reparto VARCHAR(16) NOT NULL,
    numero_letti INT NOT NULL,
    FOREIGN KEY (nome_reparto) REFERENCES Reparti(nome_reparto);
);

CREATE TABLE IF NOT EXISTS Ricoveri(
    id_camera INT NOT NULL,
    cf_paziente INT NOT NULL,
    data_ricovero DATE NOT NULL,
    ora_ricovero INT NOT NULL,
    data_rilascio DATE NOT NULL,
    ora_rilascio INT NOT NULL,
    stato_rilascio VARCHAR(16) NOT NULL,
    FOREIGN KEY (id_camera) REFERENCES Camere(id_camera),
    FOREIGN KEY (cf_paziente) REFERENCES Pazienti(c_f);
);

CREATE TABLE IF NOT EXISTS Capi_reparti(
    badge INT,
    nome_reparto VARCHAR(32),
    PRIMARY KEY(badge,nome_reparto),
    FOREIGN KEY (badge) REFERENCES Personale_medico(badge),
    FOREIGN KEY (nome_reparto) REFERENCES Reparti(nome_reparto);
);

CREATE TABLE IF NOT EXISTS Registro_operazioni(
    badge INT,
    id_operazione INT,
    PRIMARY KEY(badge, id_operazione),
    FOREIGN KEY (badge) REFERENCES Personale_medico(badge),
    FOREIGN KEY (id_operazione) REFERENCES Operazioni(id_operazione);
);

CREATE TABLE IF NOT EXISTS Allergie(
    cf_paziente VARCHAR(16),
    allergia VARCHAR(32),
    PRIMARY KEY(cf_paziente, allergia),
    FOREIGN KEY (cf_paziente) REFERENCES Pazienti(c_f);
);
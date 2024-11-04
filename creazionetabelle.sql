DROP TABLE IF EXISTS Personale_medico CASCADE;
DROP TABLE IF EXISTS Pazienti CASCADE;
DROP TABLE IF EXISTS Accompagnatori CASCADE;
DROP TABLE IF EXISTS Sale_operatorie CASCADE;
DROP TABLE IF EXISTS Operazioni CASCADE;
DROP TABLE IF EXISTS Farmaci CASCADE;
DROP TABLE IF EXISTS Visite_prenotate CASCADE;
DROP TABLE IF EXISTS Cartella_clinica CASCADE;
DROP TABLE IF EXISTS Reparti CASCADE;
DROP TABLE IF EXISTS Attrezzatura_medica CASCADE;
DROP TABLE IF EXISTS Riabilitazione CASCADE;
DROP TABLE IF EXISTS Camere CASCADE;

CREATE TABLE IF NOT EXISTS Personale_medico(
    badge PRIMARY KEY,
    nome VARCHAR(32) NOT NULL,
    cognome VARCHAR(32) NOT NULL,
    primario BOOLEAN NOT NULL,
    specializzazione VARCHAR(64),
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
    cf_paziente INT NOT NULL,
    data_nascita DATE NOT NULL
    parentela VARCHAR(32) NOT NULL,
    contatti VARCHAR(64) NOT NULL,
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
    badge chilurgo INT NOT NULL,
    data_ DATE NOT NULL,
    sala INT NOT NULL,
    cf_paziente INT NOT NULL,
);

CREATE TABLE IF NOT EXISTS Farmaci(
    id_farmaco INT PRIMARY KEY,
    nome VARCHAR(32) NOT NULL,
    dosaggio VARCHAR(32) NOT NULL,
    effetti VARCHAR(64) NOT NULL,
    controindicazioni VARCHAR(64) NOT NULL,
    data_scandenza DATE NOT NULL,
);

CREATE TABLE IF NOT EXISTS Cure(
    id_cura INT NOT NULL,
    badge INT NOT NULL,
    cf_paziente INT NOT NULL,
    id_farmaco INT NOT NULL,
    data_ DATA NOT NULL,
    ora INT NOT NULL,
);

CREATE TABLE IF NOT EXISTS Cartella_clinica(
    id_cartella INT PRIMARY KEY,
    allergie VARCHAR(128) NOT NULL,
    gruppo_sanguigno,
    patologie VARCHAR(128),
    cf_paziente INT NOT NULL,
);

CREATE TABLE IF NOT EXISTS Reparti(
    nome_reparto VARCHAR PRIMARY KEY,
    capo_reparto INT NOT NULL,
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
);

CREATE TABLE IF NOT EXISTS Ricoveri(
    id_camera INT NOT NULL,
    cf_paziente INT NOT NULL,
    data_ricovero DATE NOT NULL,
    ora_ricovero INT NOT NULL,
    data_rilascio DATE NOT NULL,
    ora_rilascio INT NOT NULL,
    stato_rilascio VARCHAR(16) NOT NULL,
);

CREATE TABLE IF NOT EXISTS Camere(
    id_camera INT PRIMARY KEY,
    disponibilita BOOLEAN NOT NULL,
    nome_reparto VARCHAR(16) NOT NULL,
    numero_letti INT NOT NULL,
);
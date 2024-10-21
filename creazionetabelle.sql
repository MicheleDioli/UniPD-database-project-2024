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
    id_paziente PRIMARY KEY,
    nome VARCHAR(32) NOT NULL,
    cognome VARCHAR(32) NOT NULL,
    sesso VARCHAR(8) NOT NULL,
    c_f VARCHAR(16) NOT NULL,
    data_nascita DATE NOT NULL,
    comune_nascita VARCHAR(32) NOT NULL,
    maggiorene BOOLEAN NOT NULL,
);

CREATE TABLE IF NOT EXISTS Accompagnatori(
    nome VARCHAR(32) NOT NULL,
    cognome VARCHAR(32) NOT NULL,
    c_f VARCHAR(16) NOT NULL,
    data_nascita DATE NOT NULL
    parentela VARCHAR(32) NOT NULL,
);

CREATE TABLE IF NOT EXISTS Sale_operatorie(
    id_sala
    id_sala INT PRIMARY KEY,
    max_persone INT NOT NULL,
    livello_attrezzatura INT NOT NULL,
);

CREATE TABLE IF NOT EXISTS Operazioni(
    id_operazione INT PRIMARY KEY,
    badge INT NOT NULL,
    durata INT NOT NULL,
    data DATE NOT NULL,
    risultato VARCHAR(32) NOT NULL,
);

CREATE TABLE IF NOT EXISTS Farmaci(
    nome VARCHAR(32) PRIMARY KEY,
    dosaggio VARCHAR(32) NOT NULL,
    effetti VARCHAR(64) NOT NULL,
    controindicazioni VARCHAR(64) NOT NULL,
);

CREATE TABLE IF NOT EXISTS Visite_prenotate(
    id_visita INT PRIMARY KEY,
    data DATE NOT NULL,
    prorita VARCHAR(32),
);

CREATE TABLE IF NOT EXISTS Cartella_clinica(
    id_cartella INT PRIMARY KEY,
    allergie VARCHAR(128) NOT NULL,
    paziente_debole BOOLEAN NOT NULL,
    gruppo_sanguigno,
    patologie VARCHAR(128),

);

CREATE TABLE IF NOT EXISTS Reparti(
    Nome_reparto VARCHAR PRIMARY KEY,
    piano INT NOT NULL,
    capacita_massima INT NOT NULL,
);

CREATE TABLE IF NOT EXISTS Attrezzatura_medica(
    nome_attrezzatura VARCHAR(32) PRIMARY KEY,
    pericolosità INT NOT NULL,
    stato_manutenzione VARCHAR(32) NOT NULL,
    tipo_attrezzetura VARCHAR(32) NOT NULL,
);

CREATE TABLE IF NOT EXISTS Riabilitazione(
    id_programma INT PRIMARY KEY,
    ambito VARCHAR(32) NOT NULL,
    frequenza VARCHAR NOT NULL,
);

CREATE TABLE IF NOT EXISTS Camere(
    id_camera INT PRIMARY KEY,
    disponibilita BOOLEAN NOT NULL,
    numero_letti INT NOT NULL,

);
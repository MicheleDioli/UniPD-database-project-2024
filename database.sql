DROP TABLE IF EXISTS Reparti CASCADE;
DROP TABLE IF EXISTS Personale_medico CASCADE;
DROP TABLE IF EXISTS Camere CASCADE;
DROP TABLE IF EXISTS Ricoveri CASCADE;
DROP TABLE IF EXISTS Pazienti CASCADE;
DROP TABLE IF EXISTS Accompagnatori CASCADE;
DROP TABLE IF EXISTS Sale_operatorie CASCADE;
DROP TABLE IF EXISTS Operazioni CASCADE;
DROP TABLE IF EXISTS Farmaci CASCADE;
DROP TABLE IF EXISTS Cartella_clinica CASCADE;
DROP TABLE IF EXISTS Cure CASCADE;
DROP TABLE IF EXISTS Lista_operazioni CASCADE;
DROP TABLE IF EXISTS Lista_farmaci CASCADE;
DROP TYPE IF EXISTS gruppo CASCADE;

CREATE TABLE IF NOT EXISTS Reparti(
    nome_reparto VARCHAR(32) PRIMARY KEY,
    piano INT NOT NULL,
    capacita_massima INT NOT NULL,
    telefono_reparto  VARCHAR(16) NOT NULL
    );

INSERT INTO Reparti (nome_reparto, piano, capacita_massima, telefono_reparto) VALUES
                                                                                  ('Cardiologia', 2, 45, '0811234567'),
                                                                                  ('Oncologia', 3, 40, '0812345678'),
                                                                                  ('Pediatria', 1, 50, '0813456789'),
                                                                                  ('Chirurgia', 2, 35, '0814567890'),
                                                                                  ('Ortopedia', 1, 30, '0815678901'),
                                                                                  ('Ostetricia', 4, 50, '0816789012'), --problema
                                                                                  ('Neurologia', 5, 48, '0817890123'),
                                                                                  ('Gastroenterologia', 3, 38, '0818901234'),
                                                                                  ('Dermatologia', 1, 30, '0819012345'),
                                                                                  ('Urologia', 4, 42, '0810123456');

CREATE TABLE IF NOT EXISTS Personale_medico(
    badge INT PRIMARY KEY,
    nome VARCHAR(32) NOT NULL,
    cognome VARCHAR(32) NOT NULL,
    ruolo VARCHAR(64) NOT NULL,
    data_nascita DATE NOT NULL,
    comune_nascita VARCHAR(32) NOT NULL,
    stipendio INT NOT NULL,
    capo_reparto BOOLEAN,
    reparto VARCHAR(32) NOT NULL,
    FOREIGN KEY (reparto) REFERENCES Reparti(nome_reparto)
    );


INSERT INTO Personale_medico (badge, nome, cognome, ruolo, data_nascita, comune_nascita, stipendio, capo_reparto, reparto) VALUES
                                                                                                                               (100, 'Mario', 'Rossi', 'medico - certificazione in Cardiologia', '1980-05-15', 'Roma', 25000, FALSE, 'Cardiologia'),
                                                                                                                               (101, 'Luca', 'Bianchi', 'chirurgo - specialista in Chirurgia Generale', '1910-09-12', 'Milano', 32000, TRUE, 'Chirurgia'),
                                                                                                                               (102, 'Giulia', 'Sartori', 'medico - certificazione in Neurologia Clinica', '1988-03-22', 'Napoli', 29000, FALSE, 'Neurologia'),
                                                                                                                               (103, 'Francesca', 'Russo', 'chirurgo - specialista in Ortopedia e Traumatologia', '1962-08-19', 'Torino', 34000, FALSE, 'Ortopedia'),
                                                                                                                               (104, 'Alessandro', 'Ferrari', 'medico - certificazione in Pediatria Avanzata', '1990-12-11', 'Palermo', 27000, TRUE, 'Pediatria'),
                                                                                                                               (105, 'Chiara', 'Esposito', 'chirurgo - specialista in Chirurgia Vascolare', '1978-06-07', 'Firenze', 33000, FALSE, 'Chirurgia'),
                                                                                                                               (106, 'Marco', 'Bruno', 'medico - certificazione in Oncologia Medica', '1985-01-24', 'Bologna', 26000, FALSE, 'Oncologia'),
                                                                                                                               (107, 'Elena', 'Marini', 'chirurgo - specialista in Cardiochirurgia', '1965-04-16', 'Genova', 34500, TRUE, 'Cardiologia'),
                                                                                                                               (108, 'Andrea', 'Galli', 'medico - certificazione in Ostetricia e Ginecologia', '1992-11-09', 'Venezia', 23000, FALSE, 'Ostetricia'),
                                                                                                                               (109, 'Valentina', 'Conti', 'chirurgo - specialista in Chirurgia Gastrointestinale', '1958-02-03', 'Verona', 31000, FALSE, 'Gastroenterologia'),
                                                                                                                               (110, 'Paolo', 'Barbieri', 'medico - certificazione in Dermatologia Estetica', '1960-09-14', 'Trieste', 28000, FALSE, 'Dermatologia'),
                                                                                                                               (111, 'Sara', 'Rinaldi', 'chirurgo - specialista in Oncologia Chirurgica', '1977-12-30', 'Cagliari', 32000, FALSE, 'Oncologia'),
                                                                                                                               (112, 'Giorgio', 'Grassi', 'medico - certificazione in Urologia', '1983-07-21', 'Perugia', 25000, TRUE, 'Urologia'),
                                                                                                                               (113, 'Marta', 'Colombo', 'chirurgo - specialista in Ortopedia Pediatrica', '1989-04-08', 'Ancona', 30000, FALSE, 'Ortopedia'),
                                                                                                                               (114, 'Giovanni', 'Fabbri', 'medico - certificazione in Neurologia Avanzata', '1970-05-19', 'Trento', 27000, TRUE, 'Neurologia'),
                                                                                                                               (115, 'Anna', 'Romano', 'chirurgo - specialista in Chirurgia Robotica', '1959-06-15', 'Udine', 34000, FALSE, 'Chirurgia'),
                                                                                                                               (116, 'Roberto', 'Ricci', 'medico - certificazione in Cardiologia Pediatrica', '1986-11-28', 'Rimini', 26000, FALSE, 'Cardiologia'),
                                                                                                                               (117, 'Elisa', 'Orlandi', 'chirurgo - specialista in Chirurgia Ostetrica', '1963-01-17', 'Pisa', 34500, FALSE, 'Ostetricia'),
                                                                                                                               (118, 'Stefano', 'Cattaneo', 'medico - certificazione in Pediatria Neonatale', '1991-03-24', 'Lecce', 23000, FALSE, 'Pediatria'),
                                                                                                                               (119, 'Monica', 'Pagani', 'chirurgo - specialista in Chirurgia Oncologica', '1964-08-11', 'Messina', 31000, TRUE, 'Oncologia'),
                                                                                                                               (120, 'Luigi', 'Pellegrini', 'medico - certificazione in Gastroenterologia Avanzata', '1957-02-20', 'Bolzano', 28000, TRUE, 'Gastroenterologia'),
                                                                                                                               (121, 'Claudia', 'Rizzi', 'chirurgo - specialista in Neurochirurgia', '1967-07-30', 'Aosta', 33000, FALSE, 'Neurologia'),
                                                                                                                               (122, 'Fabio', 'Marchetti', 'medico - certificazione in Cardiologia Interventistica', '1987-10-05', 'Reggio Calabria', 25000, FALSE, 'Cardiologia'),
                                                                                                                               (123, 'Silvia', 'Donati', 'chirurgo - specialista in Chirurgia Generale', '1980-12-12', 'Savona', 32000, FALSE, 'Chirurgia'),
                                                                                                                               (124, 'Matteo', 'Ferraro', 'medico - certificazione in Ostetricia', '1973-09-25', 'Forlì', 27000, TRUE, 'Ostetricia'),
                                                                                                                               (125, 'Federica', 'Piazza', 'chirurgo - specialista in Ortopedia Traumatologica', '1966-04-18', 'Treviso', 34000, TRUE, 'Ortopedia'),
                                                                                                                               (126, 'Antonio', 'Villa', 'medico - certificazione in Urologia Avanzata', '1990-08-07', 'Siena', 26000, FALSE, 'Urologia'),
                                                                                                                               (127, 'Ilaria', 'Caruso', 'chirurgo - specialista in Chirurgia Gastrointestinale', '1981-06-23', 'Bari', 34500, FALSE, 'Gastroenterologia'),
                                                                                                                               (128, 'Riccardo', 'Mancini', 'medico - certificazione in Dermatologia Clinica', '1961-03-31', 'Vicenza', 23000, TRUE, 'Dermatologia'),
                                                                                                                               (129, 'Laura', 'De Luca', 'chirurgo - specialista in Neurochirurgia Pediatrica', '1968-11-01', 'Modena', 31000, FALSE, 'Neurologia'),
                                                                                                                               (130, 'Daniele', 'Farina', 'medico - certificazione in Chirurgia Generale', '1974-02-14', 'Catania', 28000, FALSE, 'Chirurgia');


CREATE TABLE IF NOT EXISTS Pazienti(
    c_f VARCHAR(16) PRIMARY KEY,
    nome VARCHAR(32) NOT NULL,
    cognome VARCHAR(32) NOT NULL,
    data_nascita DATE NOT NULL,
    sesso VARCHAR(8) NOT NULL,
    comune_nascita VARCHAR(32) NOT NULL,
    eta INT NOT NULL
    );

INSERT INTO Pazienti (c_f, nome, cognome, data_nascita, sesso, comune_nascita, eta) VALUES
                                                                                        ('BNCLCU80E15H501T', 'Luca', 'Bianchi', '1980-05-15', 'maschio', 'Roma', 44),
                                                                                        ('VRDGLI92P23H501S', 'Giulia', 'Verdi', '1992-09-23', 'femmina', 'Milano', 32),
                                                                                        ('RSSMRC78S07H501L', 'Marco', 'Russo', '1978-11-07', 'maschio', 'Napoli', 46),
                                                                                        ('SPSCIA85A24H501N', 'Chiara', 'Esposito', '1985-01-24', 'femmina', 'Torino', 39),
                                                                                        ('RMNFNC62M19H501Z', 'Francesco', 'Romano', '1962-08-19', 'maschio', 'Palermo', 62),
                                                                                        ('RNLLSS90C12H501B', 'Alessia', 'Rinaldi', '1990-03-12', 'femmina', 'Firenze', 34),
                                                                                        ('MRNNDR83L22H501H', 'Andrea', 'Marini', '1983-07-22', 'maschio', 'Genova', 41),
                                                                                        ('CNTFRC71B14H501X', 'Federica', 'Conti', '1971-02-14', 'femmina', 'Venezia', 53),
                                                                                        ('FBBDVD69D01H501Q', 'Davide', 'Fabbri', '1969-04-01', 'maschio', 'Bologna', 55),
                                                                                        ('PLGELS87H18H501M', 'Elisa', 'Pellegrini', '1987-06-18', 'femmina', 'Verona', 37),
                                                                                        ('GRSMTT93P09H501E', 'Matteo', 'Grassi', '1993-09-09', 'maschio', 'Trieste', 31),
                                                                                        ('BRBSRN65T27H501Y', 'Serena', 'Barbieri', '1965-12-27', 'femmina', 'Cagliari', 58),
                                                                                        ('FRRGGR58E02H501V', 'Giorgio', 'Ferrari', '1958-05-02', 'maschio', 'Perugia', 66),
                                                                                        ('CSTNNA75C19H501R', 'Anna', 'Costa', '1975-03-19', 'femmina', 'Ancona', 49),
                                                                                        ('VLLMSS81L29H501K', 'Massimo', 'Villa', '1981-07-29', 'maschio', 'Trento', 43),
                                                                                        ('PZZVLN89S05H501T', 'Valentina', 'Piazza', '1989-11-05', 'femmina', 'Udine', 35),
                                                                                        ('GLLRRT74D08H501G', 'Roberto', 'Galli', '1974-04-08', 'maschio', 'Rimini', 50),
                                                                                        ('MRTGDA91M12H501P', 'Giada', 'Martini', '1991-08-12', 'femmina', 'Pisa', 33),
                                                                                        ('RCCSTF84R14H501C', 'Stefano', 'Ricci', '1984-10-14', 'maschio', 'Lecce', 40),
                                                                                        ('RLNCLD77H03H501U', 'Claudia', 'Orlandi', '1977-06-03', 'femmina', 'Messina', 47),
                                                                                        ('FRNTMS59B18H501O', 'Tommaso', 'Farina', '1959-02-18', 'maschio', 'Bolzano', 65),
                                                                                        ('DNTSLV88E09H501S', 'Silvia', 'Donati', '1988-05-09', 'femmina', 'Aosta', 36),
                                                                                        ('PGNLSN60L21H501I', 'Alessandro', 'Pagani', '1960-07-21', 'maschio', 'Reggio Calabria', 64),
                                                                                        ('CTNFDR79A17H501D', 'Federico', 'Cattaneo', '1979-01-17', 'maschio', 'Savona', 45),
                                                                                        ('MRCLRA82C04H501W', 'Laura', 'Marchetti', '1982-03-04', 'femmina', 'Forlì', 42),
                                                                                        ('RMNSMN73T23H501T', 'Simone', 'Romano', '1973-12-23', 'maschio', 'Treviso', 50),
                                                                                        ('NGRLNE94B06H501H', 'Elena', 'Negri', '1994-02-06', 'femmina', 'Siena', 30),
                                                                                        ('BTGNCL70P25H501S', 'Nicola', 'Battaglia', '1970-09-25', 'maschio', 'Bari', 54),
                                                                                        ('MNCFNC64M15H501Q', 'Francesca', 'Mancini', '1964-08-15', 'femmina', 'Vicenza', 60),
                                                                                        ('DLCLBT76H20H501L', 'Alberto', 'De Luca', '1976-06-20', 'maschio', 'Modena', 48),
                                                                                        ('MRTMTN80A08H501J', 'Martina', 'Moretti', '1980-01-08', 'femmina', 'Catania', 44),
                                                                                        ('PRSLNZ57D18H501F', 'Lorenzo', 'Parisi', '1957-04-18', 'maschio', 'Padova', 67),
                                                                                        ('GRRMNC72S11H501B', 'Monica', 'Guerra', '1972-11-11', 'femmina', 'Pescara', 52),
                                                                                        ('CRSFLP86L13H501Z', 'Filippo', 'Caruso', '1986-07-13', 'maschio', 'Ravenna', 38),
                                                                                        ('PLGCTR85P05H501K', 'Caterina', 'Pellegrini', '1985-09-05', 'femmina', 'Salerno', 39),
                                                                                        ('LNGGVN61B22H501R', 'Giovanni', 'Leone', '1961-02-22', 'maschio', 'Arezzo', 63),
                                                                                        ('VNTGBL67M14H501X', 'Gabriele', 'Ventura', '1967-08-14', 'maschio', 'Cremona', 57),
                                                                                        ('BNCLNZ11T05H501T', 'Lorenzo', 'Bianchi', '2011-12-05', 'maschio', 'Napoli', 13),
                                                                                        ('VRDMRT13H18H501R', 'Marta', 'Verdi', '2013-06-18', 'femmina', 'Torino', 11),
                                                                                        ('SPSRCR12P09H501F', 'Riccardo', 'Esposito', '2012-09-09', 'maschio', 'Firenze', 12),
                                                                                        ('RMNARR15R12H501D', 'Aurora', 'Romano', '2015-10-12', 'femmina', 'Genova', 9),
                                                                                        ('CLBTMS14A28H501L', 'Tommaso', 'Colombo', '2014-01-28', 'maschio', 'Venezia', 10),
                                                                                        ('CSTGNR16D17H501X', 'Ginevra', 'Costa', '2016-04-17', 'femmina', 'Bologna', 8),
                                                                                        ('MRNLND17M23H501K', 'Leonardo', 'Marini', '2017-08-23', 'maschio', 'Verona', 7),
                                                                                        ('RNLMME18S30H501S', 'Emma', 'Rinaldi', '2018-11-30', 'femmina', 'Palermo', 6);

CREATE TABLE IF NOT EXISTS Camere(
    id_camera INT PRIMARY KEY,
    nome_reparto VARCHAR(32) NOT NULL,
    massimo_letti INT NOT NULL,
    FOREIGN KEY (nome_reparto) REFERENCES Reparti(nome_reparto)
    );

INSERT INTO Camere (id_camera, nome_reparto, massimo_letti) VALUES
                                                                (1001, 'Cardiologia', 3),
                                                                (1002, 'Cardiologia', 4),
                                                                (1003, 'Cardiologia', 2),
                                                                (1004, 'Oncologia', 3),
                                                                (1005, 'Oncologia', 5),
                                                                (1006, 'Oncologia', 4),
                                                                (1007, 'Oncologia', 3),
                                                                (1008, 'Pediatria', 5),
                                                                (1009, 'Pediatria', 2),
                                                                (1010, 'Pediatria', 4),
                                                                (1011, 'Pediatria', 3),
                                                                (1012, 'Ortopedia', 2),
                                                                (1013, 'Ortopedia', 3),
                                                                (1014, 'Ortopedia', 4),
                                                                (1015, 'Ostetricia', 3),
                                                                (1016, 'Ostetricia', 4),
                                                                (1017, 'Ostetricia', 2),
                                                                (1018, 'Neurologia', 3),
                                                                (1019, 'Neurologia', 4),
                                                                (1020, 'Neurologia', 2),
                                                                (1021, 'Gastroenterologia', 3),
                                                                (1022, 'Gastroenterologia', 4),
                                                                (1023, 'Gastroenterologia', 2),
                                                                (1024, 'Dermatologia', 4),
                                                                (1025, 'Dermatologia', 3),
                                                                (1026, 'Dermatologia', 2),
                                                                (1027, 'Urologia', 4),
                                                                (1028, 'Urologia', 3),
                                                                (1029, 'Urologia', 2);

CREATE TABLE IF NOT EXISTS Ricoveri(
    id_ricovero INT PRIMARY KEY,
    data_ricovero DATE NOT NULL,
    ora_ricovero TIME NOT NULL,
    stato_ricovero VARCHAR(32) NOT NULL,
    id_camera INT NOT NULL,
    cf_ricoverato VARCHAR(16) NOT NULL,
    FOREIGN KEY (id_camera) REFERENCES Camere(id_camera),
    FOREIGN KEY (cf_ricoverato) REFERENCES Pazienti(c_f)
    );

INSERT INTO Ricoveri (id_ricovero, data_ricovero, ora_ricovero, stato_ricovero, id_camera, cf_ricoverato) VALUES
                                                                                                              (200, '2024-11-01', '08:30:00', 'grave', 1001, 'BNCLCU80E15H501T' ),
                                                                                                              (201, '2024-11-02', '09:15:00', 'non grave', 1002, 'VRDGLI92P23H501S'),
                                                                                                              (202, '2024-11-03', '10:45:00', 'in pericolo di vita', 1003, 'RSSMRC78S07H501L'),
                                                                                                              (203, '2024-11-04', '11:20:00', 'grave', 1004, 'SPSCIA85A24H501N'),
                                                                                                              (204, '2024-11-05', '13:00:00', 'non grave', 1005, 'RMNFNC62M19H501Z'),
                                                                                                              (205, '2024-11-06', '15:10:00', 'in pericolo di vita', 1006, 'RNLLSS90C12H501B'),
                                                                                                              (206, '2024-11-07', '14:30:00', 'non grave', 1007, 'MRNNDR83L22H501H'),
                                                                                                              (207, '2024-11-08', '17:50:00', 'grave', 1008, 'CNTFRC71B14H501X'),
                                                                                                              (208, '2024-11-09', '19:15:00', 'in pericolo di vita', 1009, 'FBBDVD69D01H501Q'),
                                                                                                              (209, '2024-11-10', '21:00:00', 'non grave', 1010, 'PLGELS87H18H501M'),
                                                                                                              (210, '2024-11-11', '07:30:00', 'grave', 1011, 'GRSMTT93P09H501E'),
                                                                                                              (211, '2024-11-12', '10:00:00', 'in pericolo di vita', 1012, 'BRBSRN65T27H501Y'),
                                                                                                              (212, '2024-11-13', '12:20:00', 'non grave', 1013, 'FRRGGR58E02H501V'),
                                                                                                              (213, '2024-11-14', '09:30:00', 'grave', 1014, 'CSTNNA75C19H501R'),
                                                                                                              (214, '2024-11-15', '11:15:00', 'non grave', 1015, 'VLLMSS81L29H501K'),
                                                                                                              (215, '2024-11-16', '14:45:00', 'in pericolo di vita', 1016, 'PZZVLN89S05H501T'),
                                                                                                              (216, '2024-11-17', '16:10:00', 'non grave', 1017,'GLLRRT74D08H501G'),
                                                                                                              (217, '2024-11-18', '18:20:00', 'grave', 1018,'MRTGDA91M12H501P'),
                                                                                                              (218, '2024-11-19', '20:30:00', 'in pericolo di vita', 1019, 'RCCSTF84R14H501C'),
                                                                                                              (219, '2024-11-20', '22:00:00', 'non grave', 1020, 'RLNCLD77H03H501U'),
                                                                                                              (220, '2024-11-21', '06:00:00', 'grave', 1021, 'FRNTMS59B18H501O'),
                                                                                                              (221, '2024-11-22', '08:50:00', 'in pericolo di vita',1022, 'DNTSLV88E09H501S'),
                                                                                                              (222, '2024-11-23', '11:30:00', 'non grave', 1023, 'PGNLSN60L21H501I'),
                                                                                                              (223, '2024-11-24', '15:40:00', 'grave', 1024, 'CTNFDR79A17H501D'),
                                                                                                              (224, '2024-11-25', '17:20:00', 'non grave', 1025, 'MRCLRA82C04H501W'),
                                                                                                              (225, '2024-11-26', '18:15:00', 'in pericolo di vita', 1026, 'RMNSMN73T23H501T'),
                                                                                                              (226, '2024-11-27', '20:40:00', 'grave', 1027, 'NGRLNE94B06H501H'),
                                                                                                              (227, '2024-11-28', '22:10:00', 'non grave', 1028, 'BTGNCL70P25H501S'),
                                                                                                              (228, '2024-11-29', '08:30:00', 'in pericolo di vita', 1029, 'MNCFNC64M15H501Q'),
                                                                                                              (229, '2024-11-30', '09:15:00', 'grave', 1001, 'DLCLBT76H20H501L'),
                                                                                                              (230, '2024-12-01', '10:45:00', 'non grave', 1002, 'MRTMTN80A08H501J'),
                                                                                                              (231, '2024-12-02', '11:20:00', 'grave', 1003, 'PRSLNZ57D18H501F'),
                                                                                                              (232, '2024-12-03', '13:00:00', 'in pericolo di vita', 1004,'GRRMNC72S11H501B'),
                                                                                                              (233, '2024-12-04', '15:10:00', 'non grave', 1005, 'CRSFLP86L13H501Z'),
                                                                                                              (234, '2024-12-05', '14:30:00', 'grave', 1006, 'PLGCTR85P05H501K'),
                                                                                                              (235, '2024-12-06', '17:50:00', 'in pericolo di vita', 1007, 'LNGGVN61B22H501R'),
                                                                                                              (236, '2024-12-07', '19:15:00', 'non grave', 1008, 'VNTGBL67M14H501X'),
                                                                                                              (237, '2024-12-12', '09:30:00', 'in pericolo di vita', 1009,'BNCLNZ11T05H501T'),
                                                                                                              (238, '2024-12-13', '11:15:00', 'non grave', 1010, 'VRDMRT13H18H501R'),
                                                                                                              (239, '2024-12-14', '14:45:00', 'grave', 1011, 'SPSRCR12P09H501F'),
                                                                                                              (240, '2024-12-15', '16:10:00', 'in pericolo di vita', 1001, 'RMNARR15R12H501D'),
                                                                                                              (241, '2024-12-16', '18:20:00', 'non grave', 1012,'CLBTMS14A28H501L'),
                                                                                                              (242, '2024-12-17', '20:30:00', 'grave', 1005, 'CSTGNR16D17H501X'),
                                                                                                              (243, '2024-12-18', '22:00:00', 'in pericolo di vita', 1013, 'MRNLND17M23H501K'),
                                                                                                              (244, '2024-12-18', '22:30:00', 'non grave', 1014,'RNLMME18S30H501S');


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

INSERT INTO Accompagnatori (cf_accompagnatore, nome, cognome, data_nascita, parentela, contatti, cf_paziente) VALUES
                                                                                                                  ('BNCLRN75C10H501L', 'Lorenzo', 'Bianchi', '1975-03-10', 'padre', '3351122334', 'BNCLNZ11T05H501T'),
                                                                                                                  ('GNTCLD78D22H501M', 'Claudia', 'Gentile', '1978-04-22', 'madre', '3365566778', 'VRDMRT13H18H501R'),
                                                                                                                  ('MRLLGI85E05H501P', 'Luigi', 'Morelli', '1985-05-05', 'fratello maggiore', '3378899001','SPSRCR12P09H501F'),
                                                                                                                  ('CNTVLT90F12H501R', 'Valentina', 'Conti', '1990-06-12', 'sorella maggiore', '3382233445', 'RMNARR15R12H501D'),
                                                                                                                  ('BRNSMN76G18H501T', 'Simone', 'Bernardi', '1976-07-18', 'padre', '3394455667','CLBTMS14A28H501L'),
                                                                                                                  ('GRNFRC80H25H501U', 'Francesco', 'Granata', '1980-08-25', 'fratello maggiore', '3406677889', 'CSTGNR16D17H501X'),
                                                                                                                  ('PLZANN88I10H501Z', 'Anna', 'Palazzi', '1988-09-10', 'sorella maggiore', '3417788990', 'MRNLND17M23H501K'),
                                                                                                                  ('TRCMRC92L05H501S', 'Marco', 'Tricarico', '1992-10-05', 'fratello maggiore', '3428899001', 'RNLMME18S30H501S');


CREATE TYPE gruppo AS ENUM ('A+','A-','B+','B-','0+','0-','AB+','AB-');

CREATE TABLE IF NOT EXISTS Cartella_clinica(
    id_cartella INT PRIMARY KEY,
    allergie VARCHAR(64),
    patologie VARCHAR(64),
    gruppo_sanguigno GRUPPO NOT NULL,
    cf_paziente VARCHAR(16) NOT NULL,
    FOREIGN KEY (cf_paziente) REFERENCES Pazienti(c_f)
    );

INSERT INTO Cartella_clinica (id_cartella, allergie, patologie, gruppo_sanguigno, cf_paziente) VALUES
                                                                                                   (301, 'Polline', 'Diabete tipo 2', 'A+', 'BNCLCU80E15H501T'),
                                                                                                   (302, NULL, 'Ipertensione', '0+', 'VRDGLI92P23H501S'),
                                                                                                   (303, 'Lattosio', 'Asma', 'B-', 'RSSMRC78S07H501L'),
                                                                                                   (304, NULL, 'Insufficienza renale', 'AB+', 'SPSCIA85A24H501N'),
                                                                                                   (305, 'Graminacee', 'Fibrosi cistica', 'A-', 'RMNFNC62M19H501Z'),
                                                                                                   (306, 'Penicillina', 'Morbo di Crohn', '0-', 'RNLLSS90C12H501B'),
                                                                                                   (307, NULL, 'Artrite reumatoide', 'B+', 'MRNNDR83L22H501H'),
                                                                                                   (308, 'Anestetici locali', 'Epilessia', 'AB-', 'CNTFRC71B14H501X'),
                                                                                                   (309, 'Noci', 'Malattia di Parkinson', 'A+', 'FBBDVD69D01H501Q'),
                                                                                                   (310, NULL, 'Colite ulcerosa', '0+', 'PLGELS87H18H501M'),
                                                                                                   (311, 'Polline', 'Diabete tipo 1', 'A-', 'GRSMTT93P09H501E'),
                                                                                                   (312, NULL, 'Ipertensione arteriosa', 'B+', 'BRBSRN65T27H501Y'),
                                                                                                   (313, 'Acari', 'Broncopneumopatia cronica', '0-', 'FRRGGR58E02H501V'),
                                                                                                   (314, NULL, 'Insufficienza cardiaca', 'AB-', 'CSTNNA75C19H501R'),
                                                                                                   (315, 'Frutti di mare', 'Morbo di Alzheimer', 'A+', 'VLLMSS81L29H501K'),
                                                                                                   (316, 'Graminacee', 'Sclerosi multipla', '0+', 'PZZVLN89S05H501T'),
                                                                                                   (317, 'Lattosio', 'Osteoporosi', 'B-', 'GLLRRT74D08H501G'),
                                                                                                   (318, NULL, 'Sindrome metabolica', 'A-', 'MRTGDA91M12H501P'),
                                                                                                   (319, 'Pecorino', 'Malattia di Huntington', 'B+', 'RCCSTF84R14H501C'),
                                                                                                   (320, NULL, 'Epilessia mioclonica', '0-', 'RLNCLD77H03H501U'),
                                                                                                   (321, 'Fragole', 'Disturbo bipolare', 'AB+', 'FRNTMS59B18H501O'),
                                                                                                   (322, NULL, 'Depressione maggiore', 'A+', 'DNTSLV88E09H501S'),
                                                                                                   (323, 'Glutine', 'Celiachia', 'B-', 'PGNLSN60L21H501I'),
                                                                                                   (324, NULL, 'Malattia di Addison', 'AB-', 'CTNFDR79A17H501D'),
                                                                                                   (325, 'Anestetici', 'Emofilia', 'A-', 'MRCLRA82C04H501W'),
                                                                                                   (326, NULL, 'Carenza di vitamina D', '0+', 'RMNSMN73T23H501T'),
                                                                                                   (327, 'Noci', 'Asma allergica', 'A+', 'NGRLNE94B06H501H'),
                                                                                                   (328, 'Penicillina', 'Insufficienza epatica', 'AB+', 'BTGNCL70P25H501S'),
                                                                                                   (329, 'Polvere', 'Artrite psoriasica', '0-', 'MNCFNC64M15H501Q'),
                                                                                                   (330, NULL, 'Tumore al seno', 'B+', 'DLCLBT76H20H501L'),
                                                                                                   (331, 'Latticini', 'Epatite C', '0+', 'MRTMTN80A08H501J'),
                                                                                                   (332, NULL, 'Fibromialgia', 'A-', 'PRSLNZ57D18H501F'),
                                                                                                   (333, 'Cioccolato', 'Sindrome di Sjögren', 'B-', 'GRRMNC72S11H501B'),
                                                                                                   (334, NULL, 'Morbo di Wilson', 'AB+', 'CRSFLP86L13H501Z'),
                                                                                                   (335, 'Frutti tropicali', 'Neuropatia periferica', 'A+', 'PLGCTR85P05H501K'),
                                                                                                   (336, NULL, 'Cancro al pancreas', 'B+', 'LNGGVN61B22H501R'),
                                                                                                   (337, 'Antibiotici', 'Anemia falciforme', '0-', 'VNTGBL67M14H501X'),
                                                                                                   (338, NULL, 'Sindrome di Tourette', 'A-', 'BNCLNZ11T05H501T'),
                                                                                                   (339, 'Miele', 'Policitemia', 'B-', 'VRDMRT13H18H501R'),
                                                                                                   (340, NULL, 'Morbo di Cushing', 'AB+', 'SPSRCR12P09H501F'),
                                                                                                   (341, 'Frutta secca', 'Anemia aplastica', 'A+', 'RMNARR15R12H501D'),
                                                                                                   (342, NULL, 'Displasia fibromuscolare', '0-', 'CLBTMS14A28H501L'),
                                                                                                   (343, 'Uova', 'Trombosi venosa profonda', 'AB-', 'CSTGNR16D17H501X'),
                                                                                                   (344, NULL, 'Sindrome da anticorpi antifosfolipidi', 'B+', 'MRNLND17M23H501K'),
                                                                                                   (345, NULL, 'Peritonite', 'A-', 'RNLMME18S30H501S');

CREATE TABLE IF NOT EXISTS Sale_operatorie(
    id_sala INT PRIMARY KEY,
    max_persone INT NOT NULL,
    livello_attrezzatura VARCHAR(16) NOT NULL
    );

INSERT INTO Sale_operatorie (id_sala, max_persone, livello_attrezzatura) VALUES
                                                                             (2001, 6, 'alto'),
                                                                             (2002, 5, 'medio'),
                                                                             (2003, 7, 'basso'),
                                                                             (2004, 6, 'alto'),
                                                                             (2005, 4, 'medio'),
                                                                             (2006, 8, 'alto'),
                                                                             (2007, 5, 'basso'),
                                                                             (2008, 7, 'alto'),
                                                                             (2009, 6, 'medio'),
                                                                             (2010, 3, 'basso');

CREATE TABLE IF NOT EXISTS Operazioni(
    id_operazione INT PRIMARY KEY,
    durata VARCHAR(32) NOT NULL,
    esito VARCHAR(32) NOT NULL,
    data_ DATE NOT NULL,
    nome_operazione VARCHAR(64) NOT NULL,
    sala INT NOT NULL,
    orario_inizio TIME NOT NULL,
    id_cartella INT NOT NULL,
    FOREIGN KEY (sala) REFERENCES Sale_operatorie(id_sala),
    FOREIGN KEY (id_cartella) REFERENCES Cartella_clinica(id_cartella)
    );

INSERT INTO Operazioni (id_operazione, durata, esito, data_, nome_operazione, sala, orario_inizio, id_cartella) VALUES
                                                                                                                    (501, 5, 'positivo', '2024-11-01', 'bypass aortocoronarico', 2001, '08:30:00', 301),
                                                                                                                    (502, 3, 'negativo', '2024-11-02', 'colecistectomia', 2002, '10:30:00', 302),
                                                                                                                    (503, 4, 'positivo', '2024-11-03', 'appendicectomia', 2003, '09:00:00', 303),
                                                                                                                    (504, 6, 'positivo', '2024-11-04', 'trapianto di fegato', 2004, '07:45:00', 304),
                                                                                                                    (505, 2, 'negativo', '2024-11-05', 'rimozione calcoli renali', 2005, '11:15:00', 305),
                                                                                                                    (506, 3, 'positivo', '2024-11-06', 'rimozione cisti ovarica', 2001, '14:30:00', 306),
                                                                                                                    (507, 5, 'negativo', '2024-11-07', 'resezione gastrica', 2002, '08:00:00', 307),
                                                                                                                    (508, 2, 'positivo', '2024-11-08', 'artroscopia al ginocchio', 2003, '16:15:00', 308),
                                                                                                                    (509, 7, 'positivo', '2024-11-09', 'neurochirurgia per tumore', 2004, '06:30:00', 309),
                                                                                                                    (510, 4, 'positivo', '2024-11-10', 'intervento alla spalla', 2005, '13:00:00', 310),
                                                                                                                    (511, 3, 'positivo', '2024-11-11', 'isterectomia', 2001, '12:45:00', 311),
                                                                                                                    (512, 6, 'positivo', '2024-11-12', 'trapianto di rene', 2002, '07:00:00', 312),
                                                                                                                    (513, 4, 'negativo', '2024-11-13', 'rimozione tumore polmonare', 2003, '09:15:00', 313),
                                                                                                                    (514, 2, 'positivo', '2024-11-14', 'riduzione frattura', 2004, '17:30:00', 314),
                                                                                                                    (515, 5, 'positivo', '2024-11-15', 'protesi d anca', 2005, '08:00:00', 315);

CREATE TABLE IF NOT EXISTS Farmaci(
    id_farmaco INT PRIMARY KEY,
    nome VARCHAR(32) NOT NULL,
    dosaggio VARCHAR(32) NOT NULL,
    controindicazioni VARCHAR(64) NOT NULL,
    data_scadenza DATE NOT NULL,
    allergeni VARCHAR(64)
    );

INSERT INTO Farmaci (id_farmaco, nome, dosaggio, controindicazioni, data_scadenza, allergeni) VALUES
                                                                                                  (401, 'Aspirina', '500 m.g.', 'Soggetti con ulcera gastrica, insufficienza renale', '2026-05-12', 'Acido acetilsalicilico'),
                                                                                                  (402, 'Ibuprofene', '400 m.g.', 'Non somministrare a pazienti con ulcera peptica', '2027-08-14', 'Acido ibuprofeno'),
                                                                                                  (403, 'Paracetamolo', '500 m.g.', 'Evitare in caso di insufficienza epatica', '2027-03-25', 'Paracetamolo'),
                                                                                                  (404, 'Amoxicillina', '1000 m.g.', 'Non somministrare in caso di allergia alla penicillina', '2027-06-30', 'Penicillina'),
                                                                                                  (405, 'Ciprofloxacina', '500 m.g.', 'Evitare nei pazienti con problemi renali', '2027-09-01', 'Nessun allergene segnalato'),
                                                                                                  (406, 'Omeprazolo', '20 m.g.', 'Soggetti con malattie epatiche gravi', '2027-12-10', 'Omeprazolo'),
                                                                                                  (407, 'Lorazepam', '2 m.g.', 'Non somministrare in pazienti con depressione respiratoria', '2028-02-20', 'Benzodiazepine'),
                                                                                                  (408, 'Clorazepato', '10 m.g.', 'Soggetti con glaucoma o insufficienza respiratoria', '2028-05-15', 'Benzodiazepine'),
                                                                                                  (409, 'Metformina', '500 m.g.', 'Soggetti con insufficienza renale', '2028-03-03', 'Metformina'),
                                                                                                  (410, 'Prednisolone', '5 m.g.', 'Soggetti con infezioni virali attive', '2028-07-22', 'Corticosteroidi'),
                                                                                                  (411, 'Cortisone', '10 m.g.', 'Non somministrare a pazienti con infezioni fungine', '2029-01-15', 'Corticosteroidi'),
                                                                                                  (412, 'Morfina', '10 m.g.', 'Soggetti con insufficienza respiratoria', '2029-06-11', 'Alcaloidi'),
                                                                                                  (413, 'Fentanil', '50 mcg/h', 'Evitare in pazienti con intolleranza agli oppioidi', '2029-04-22', 'Oppioidi'),
                                                                                                  (414, 'Doxiciclina', '100 m.g.', 'Non somministrare in gravidanza', '2029-08-14', 'Tetracicline'),
                                                                                                  (415, 'Acido folico', '5 m.g.', 'Soggetti con anemia perniciosa', '2029-05-30', 'Acido folico'),
                                                                                                  (416, 'Tachipirina', '500 m.g.', 'Evitare in caso di grave insufficienza epatica', '2029-02-25', 'Paracetamolo'),
                                                                                                  (417, 'Digossina', '0.25 m.g.', 'Non somministrare a pazienti con blocco atrioventricolare', '2030-01-17', 'Glicosidi cardiaci'),
                                                                                                  (418, 'Enalapril', '5 m.g.', 'Soggetti con stenosi bilaterale delle arterie renali', '2030-04-05', 'ACE-inibitori'),
                                                                                                  (419, 'Atorvastatina', '20 m.g.', 'Non somministrare a pazienti con epatite attiva', '2030-06-19', 'Statine'),
                                                                                                  (420, 'Simvastatina', '10 m.g.', 'Soggetti con insufficienza epatica', '2030-09-25', 'Statine'),
                                                                                                  (421, 'Lisinopril', '10 m.g.', 'Soggetti con angioedema angioedematoso', '2030-02-13', 'ACE-inibitori'),
                                                                                                  (422, 'Salmeterolo', '25 mcg', 'Evitare in caso di tachicardia', '2030-11-02', 'Beta-agonisti'),
                                                                                                  (423, 'Furosemide', '40 m.g.', 'Non somministrare in caso di ipokalemia', '2031-01-09', 'Diuretici'),
                                                                                                  (424, 'Alprazolam', '0.5 m.g.', 'Non somministrare in gravidanza', '2031-02-25', 'Benzodiazepine'),
                                                                                                  (425, 'Diazepam', '10 m.g.', 'Evitare in pazienti con glaucoma acuto', '2031-06-14', 'Benzodiazepine'),
                                                                                                  (426, 'Ranitidina', '150 m.g.', 'Non somministrare in caso di ulcera perforata', '2031-03-28', 'Ranitidina'),
                                                                                                  (427, 'Cetirizina', '10 m.g.', 'Soggetti con insufficienza epatica grave', '2031-05-12', 'Antistaminici'),
                                                                                                  (428, 'Loratadina', '10 m.g.', 'Evitare in gravidanza', '2031-09-01', 'Antistaminici'),
                                                                                                  (429, 'Levotiroxina', '50 m.g.', 'Soggetti con malattia cardiaca ischemica', '2032-01-20', 'Ormoni tiroidei'),
                                                                                                  (430, 'Metoclopramide', '10 m.g.', 'Non somministrare in caso di perforazione intestinale', '2032-03-11', 'Antiemetici'),
                                                                                                  (431, 'Prozac', '20 m.g.', 'Evitare in caso di epilessia', '2032-07-14', 'Antidepressivi'),
                                                                                                  (432, 'Sertralina', '50 m.g.', 'Non somministrare con inibitori MAO', '2032-09-03', 'Antidepressivi'),
                                                                                                  (433, 'Duloxetina', '30 m.g.', 'Non somministrare in caso di insufficienza renale grave', '2032-11-10', 'Antidepressivi'),
                                                                                                  (434, 'Losartan', '50 m.g.', 'Evitare in gravidanza', '2033-01-05', 'Antagonisti del recettore AT1'),
                                                                                                  (435, 'Vareniclina', '1 m.g.', 'Non somministrare a pazienti con disturbi psichiatrici', '2033-04-19', 'Agonisti nicotinici'),
                                                                                                  (436, 'Fluconazolo', '150 m.g.', 'Evitare in caso di insufficienza epatica', '2033-05-28', 'Antimicotici'),
                                                                                                  (437, 'Itraconazolo', '200 m.g.', 'Non somministrare in pazienti con insufficienza epatica', '2033-08-17', 'Antimicotici'),
                                                                                                  (438, 'Amlodipina', '5 m.g.', 'Non somministrare in caso di insufficienza cardiaca congestizia', '2033-06-02', 'Calcio-antagonisti'),
                                                                                                  (439, 'Candesartan', '8 m.g.', 'Non somministrare in gravidanza', '2033-09-25', 'Antagonisti del recettore AT1'),
                                                                                                  (440, 'Adenosina', '6 mg', 'Non somministrare a pazienti con malattie polmonari ostruttive', '2034-01-09', 'Farmaci antiaritmici'),
                                                                                                  (441, 'Salbutamolo', '100 mcg', 'Non somministrare in caso di malattia cardiaca grave', '2034-02-11', 'Beta-agonisti'),
                                                                                                  (442, 'Tobramicina', '80 m.g.', 'Soggetti con insufficienza renale', '2034-03-21', 'Aminoglicosidi'),
                                                                                                  (443, 'Gentamicina', '80 m.g.', 'Soggetti con insufficienza renale', '2034-04-23', 'Aminoglicosidi'),
                                                                                                  (444, 'Clindamicina', '300 m.g.', 'Soggetti con malattie epatiche gravi', '2034-05-19', 'Macrolidi'),
                                                                                                  (445, 'Aciclovir', '200 m.g.', 'Soggetti con insufficienza renale', '2034-06-30', 'Antivirali'),
                                                                                                  (446, 'Valaciclovir', '500 m.g.', 'Evitare in pazienti con trapianto di rene', '2034-07-15', 'Antivirali'),
                                                                                                  (447, 'Azitromicina', '500 m.g.', 'Soggetti con insufficienza epatica', '2034-08-25', 'Macrolidi'),
                                                                                                  (448, 'Leflunomide', '10 m.g.', 'Non somministrare in gravidanza', '2034-09-30', 'Farmaci immunosoppressori'),
                                                                                                  (449, 'Meflochina', '250 m.g.', 'Non somministrare a pazienti con epilessia', '2035-01-04', 'Antimalarici'),
                                                                                                  (450, 'Fosfomicina', '3 g', 'Non somministrare in caso di insufficienza renale', '2035-02-18', 'Antibiotici'),
                                                                                                  (451, 'Betametasone', '0.5 mg', 'Evitare nei pazienti con ulcera peptica', '2035-04-20', 'Corticosteroidi'),
                                                                                                  (452, 'Ketorolac', '10 m.g.', 'Non somministrare in caso di insufficienza renale grave', '2035-06-22', 'Antinfiammatori non steroidei'),
                                                                                                  (453, 'Naproxene', '250 m.g.', 'Soggetti con ulcera gastrica', '2035-07-28', 'Antinfiammatori non steroidei'),
                                                                                                  (454, 'Ibuprofene', '400 m.g.', 'Evitare in caso di insufficienza renale', '2035-09-15', 'Antinfiammatori non steroidei'),
                                                                                                  (455, 'Rivaroxaban', '20 m.g.', 'Non somministrare a pazienti con disturbi emorragici', '2035-10-10', 'Anticoagulanti'),
                                                                                                  (456, 'Apixaban', '5 m.g.', 'Soggetti con malattie epatiche', '2035-11-03', 'Anticoagulanti'),
                                                                                                  (457, 'Warfarin', '2 m.g.', 'Soggetti con disturbi della coagulazione', '2036-01-17', 'Anticoagulanti'),
                                                                                                  (458, 'Clopidogrel', '75 m.g.', 'Evitare nei pazienti con disturbi della coagulazione', '2036-02-25', 'Antipiastrinici'),
                                                                                                  (459, 'Aspirina', '100 m.g.', 'Soggetti con allergie all’aspirina', '2036-03-15', 'Acido acetilsalicilico'),
                                                                                                  (460, 'Heparina', '5000 U.I.', 'Non somministrare a pazienti con emorragie attive', '2036-04-28', 'Anticoagulanti');


CREATE TABLE IF NOT EXISTS Cure(
    id_cura INT PRIMARY KEY,
    tipo_cura VARCHAR(32) NOT NULL,
    data_somministrazione DATE NOT NULL,
    badge INT NOT NULL,
    id_cartella INT NOT NULL,
    FOREIGN KEY (badge) REFERENCES Personale_medico(badge),
    FOREIGN KEY (id_cartella) REFERENCES Cartella_clinica(id_cartella)
    );

INSERT INTO Cure (id_cura, tipo_cura, data_somministrazione, badge, id_cartella) VALUES
                                                                                     (3001, 'orale', '2024-12-01', 100, 301),
                                                                                     (3002, 'flebo', '2024-12-01', 102, 302),
                                                                                     (3003, 'iniezione', '2024-11-30', 104, 303),
                                                                                     (3004, 'orale', '2024-11-29', 106, 304),
                                                                                     (3005, 'flebo', '2024-11-28', 108, 305),
                                                                                     (3006, 'iniezione', '2024-11-27', 110, 306),
                                                                                     (3007, 'orale', '2024-11-26', 112, 307),
                                                                                     (3008, 'flebo', '2024-11-25', 114, 308),
                                                                                     (3009, 'iniezione', '2024-11-24', 116, 309),
                                                                                     (3010, 'orale', '2024-11-23', 118, 310),
                                                                                     (3011, 'flebo', '2024-11-22', 120, 311),
                                                                                     (3012, 'iniezione', '2024-11-21', 122, 312),
                                                                                     (3013, 'orale', '2024-11-20', 124, 313),
                                                                                     (3014, 'flebo', '2024-11-19', 126, 314),
                                                                                     (3015, 'iniezione', '2024-11-18', 128, 315),
                                                                                     (3016, 'orale', '2024-11-17', 100, 316),
                                                                                     (3017, 'flebo', '2024-11-16', 102, 317),
                                                                                     (3018, 'iniezione', '2024-11-15', 104, 318),
                                                                                     (3019, 'orale', '2024-11-14', 106, 319),
                                                                                     (3020, 'flebo', '2024-11-13', 108, 320),
                                                                                     (3021, 'iniezione', '2024-11-12', 110, 321),
                                                                                     (3022, 'orale', '2024-11-11', 112, 322),
                                                                                     (3023, 'flebo', '2024-11-10', 114, 323),
                                                                                     (3024, 'iniezione', '2024-11-09', 116, 324),
                                                                                     (3025, 'orale', '2024-11-08', 118, 325),
                                                                                     (3026, 'flebo', '2024-11-07', 120, 326),
                                                                                     (3027, 'iniezione', '2024-11-06', 122, 327),
                                                                                     (3028, 'orale', '2024-11-05', 124, 328),
                                                                                     (3029, 'flebo', '2024-11-04', 126, 329),
                                                                                     (3030, 'iniezione', '2024-11-03', 128, 330),
                                                                                     (3031, 'orale', '2024-11-02', 130, 331),
                                                                                     (3032, 'orale', '2024-11-01', 100, 332),
                                                                                     (3033, 'iniezione', '2024-10-31', 108, 333),
                                                                                     (3034, 'flebo', '2024-10-30', 102, 334),
                                                                                     (3035, 'orale', '2024-10-29', 112, 335),
                                                                                     (3036, 'flebo', '2024-10-28', 104, 336),
                                                                                     (3037, 'iniezione', '2024-10-27', 104, 337),
                                                                                     (3038, 'orale', '2024-10-26', 108, 338),
                                                                                     (3039, 'flebo', '2024-10-25', 112, 339),
                                                                                     (3040, 'iniezione', '2024-10-24', 108, 340),
                                                                                     (3041, 'orale', '2024-10-23', 112, 341),
                                                                                     (3042, 'flebo', '2024-10-22', 110, 342),
                                                                                     (3043, 'iniezione', '2024-10-21', 106, 343),
                                                                                     (3044, 'orale', '2024-10-20', 112, 344),
                                                                                     (3045, 'flebo', '2024-10-19', 110, 345);



CREATE TABLE IF NOT EXISTS Lista_operazioni(
    badge INT,
    id_operazione INT,
    PRIMARY KEY(badge, id_operazione),
    FOREIGN KEY (badge) REFERENCES Personale_medico(badge),
    FOREIGN KEY (id_operazione) REFERENCES Operazioni(id_operazione)
    );

INSERT INTO Lista_operazioni (badge, id_operazione) VALUES
                                                        (101, 501),
                                                        (103, 502),
                                                        (105, 503),
                                                        (107, 504),
                                                        (109, 505),
                                                        (111, 506),
                                                        (113, 507),
                                                        (115, 508),
                                                        (117, 509),
                                                        (119, 510),
                                                        (121, 511),
                                                        (123, 512),
                                                        (125, 513),
                                                        (127, 514),
                                                        (129, 515),
                                                        (101, 502),
                                                        (103, 503),
                                                        (105, 504),
                                                        (107, 505),
                                                        (109, 506),
                                                        (111, 507),
                                                        (113, 508),
                                                        (115, 509),
                                                        (117, 510),
                                                        (119, 511),
                                                        (121, 512),
                                                        (123, 513),
                                                        (125, 514),
                                                        (127, 515),
                                                        (129, 501),
                                                        (101, 503),
                                                        (103, 504),
                                                        (105, 505),
                                                        (107, 506),
                                                        (109, 507),
                                                        (111, 508),
                                                        (113, 509),
                                                        (115, 510),
                                                        (117, 511),
                                                        (119, 512),
                                                        (121, 513),
                                                        (123, 514),
                                                        (125, 515),
                                                        (127, 501),
                                                        (129, 502),
                                                        (101, 504),
                                                        (103, 505),
                                                        (105, 506),
                                                        (107, 507),
                                                        (109, 508),
                                                        (111, 509);

CREATE TABLE IF NOT EXISTS Lista_farmaci(
    id_cura INT,
    id_farmaco INT,
    PRIMARY KEY (id_cura, id_farmaco),
    FOREIGN KEY (id_cura) REFERENCES Cure(id_cura),
    FOREIGN KEY (id_farmaco) REFERENCES Farmaci(id_farmaco)
    );

INSERT INTO Lista_farmaci (id_cura, id_farmaco) VALUES
                                                    (3001, 401),
                                                    (3002, 402),
                                                    (3003, 403),
                                                    (3004, 404),
                                                    (3005, 405),
                                                    (3006, 406),
                                                    (3007, 407),
                                                    (3008, 408),
                                                    (3009, 409),
                                                    (3010, 410),
                                                    (3011, 411),
                                                    (3012, 412),
                                                    (3013, 413),
                                                    (3014, 414),
                                                    (3015, 415),
                                                    (3016, 416),
                                                    (3017, 417),
                                                    (3018, 418),
                                                    (3019, 419),
                                                    (3020, 420),
                                                    (3021, 421),
                                                    (3022, 422),
                                                    (3023, 423),
                                                    (3024, 424),
                                                    (3025, 425),
                                                    (3026, 426),
                                                    (3027, 427),
                                                    (3028, 428),
                                                    (3029, 429),
                                                    (3030, 430),
                                                    (3031, 431),
                                                    (3032, 432),
                                                    (3033, 433),
                                                    (3034, 434),
                                                    (3035, 435),
                                                    (3036, 436),
                                                    (3037, 437),
                                                    (3038, 438),
                                                    (3039, 439),
                                                    (3040, 440),
                                                    (3041, 441),
                                                    (3042, 442),
                                                    (3043, 443),
                                                    (3044, 444),
                                                    (3045, 445),
                                                    (3001, 449),
                                                    (3002, 450),
                                                    (3003, 451),
                                                    (3004, 452),
                                                    (3005, 453),
                                                    (3006, 454),
                                                    (3007, 455),
                                                    (3008, 456),
                                                    (3009, 457),
                                                    (3010, 458),
                                                    (3011, 459),
                                                    (3012, 460),
                                                    (3013, 401),
                                                    (3014, 402),
                                                    (3015, 403),
                                                    (3016, 404),
                                                    (3017, 405),
                                                    (3018, 406),
                                                    (3019, 407),
                                                    (3020, 408),
                                                    (3021, 409),
                                                    (3022, 410),
                                                    (3023, 411),
                                                    (3024, 412),
                                                    (3025, 413),
                                                    (3026, 414),
                                                    (3027, 415),
                                                    (3028, 416),
                                                    (3029, 417),
                                                    (3030, 418),
                                                    (3031, 419);

CREATE INDEX idx_sala ON Sale_operatorie(id_sala);
CREATE INDEX idx_id_operazione ON Operazioni(id_operazione);

--QUERY


-- : calcolare la media di ricoverati nell'ospedale per camera e poi scelto un reparto da utente calcolare il numero di
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

-- : stampa il numero di chirurgi che hanno lavorato nelle sale operatorie raggruppandoli per il livello di attrezzatura della sala (tramite id)
SELECT
    so.livello_attrezzatura,
    COUNT(DISTINCT lo.badge) AS n_chirurgi
FROM Sale_operatorie AS so
         JOIN Operazioni AS o ON o.sala = so.id_sala
         JOIN Lista_operazioni AS lo ON lo.id_operazione = o.id_operazione
GROUP BY so.livello_attrezzatura;

--questa che e molto easy la metteri come prima ne do una della stessa difficolta come alternativa

--: stampare i nome, cognome e badge del capo reparto (scelto da utente) e nome del reparto, del reparto con piu ricoverati
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
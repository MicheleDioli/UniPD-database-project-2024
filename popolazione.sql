INSERT INTO Personale_medico (badge, nome, cognome, ruolo, data_nascita, comune_nascita, stipendio) VALUES
(100, 'Mario', 'Rossi', 'medico', '1980-05-15', 'Roma', 25000),
(101, 'Luca', 'Bianchi', 'chirurgo', '1910-09-12', 'Milano', 32000),
(102, 'Giulia', 'Sartori', 'medico', '1988-03-22', 'Napoli', 29000),
(103, 'Francesca', 'Russo', 'chirurgo', '1962-08-19', 'Torino', 34000),
(104, 'Alessandro', 'Ferrari', 'medico', '1990-12-11', 'Palermo', 27000),
(105, 'Chiara', 'Esposito', 'chirurgo', '1978-06-07', 'Firenze', 33000),
(106, 'Marco', 'Bruno', 'medico', '1985-01-24', 'Bologna', 26000),
(107, 'Elena', 'Marini', 'chirurgo', '1965-04-16', 'Genova', 34500),
(108, 'Andrea', 'Galli', 'medico', '1992-11-09', 'Venezia', 23000),
(109, 'Valentina', 'Conti', 'chirurgo', '1958-02-03', 'Verona', 31000),
(110, 'Paolo', 'Barbieri', 'medico', '1960-09-14', 'Trieste', 28000),
(111, 'Sara', 'Rinaldi', 'chirurgo', '1977-12-30', 'Cagliari', 32000),
(112, 'Giorgio', 'Grassi', 'medico', '1983-07-21', 'Perugia', 25000),
(113, 'Marta', 'Colombo', 'chirurgo', '1989-04-08', 'Ancona', 30000),
(114, 'Giovanni', 'Fabbri', 'medico', '1970-05-19', 'Trento', 27000),
(115, 'Anna', 'Romano', 'chirurgo', '1959-06-15', 'Udine', 34000),
(116, 'Roberto', 'Ricci', 'medico', '1986-11-28', 'Rimini', 26000),
(117, 'Elisa', 'Orlandi', 'chirurgo', '1963-01-17', 'Pisa', 34500),
(118, 'Stefano', 'Cattaneo', 'medico', '1991-03-24', 'Lecce', 23000),
(119, 'Monica', 'Pagani', 'chirurgo', '1964-08-11', 'Messina', 31000),
(120, 'Luigi', 'Pellegrini', 'medico', '1957-02-20', 'Bolzano', 28000),
(121, 'Claudia', 'Rizzi', 'chirurgo', '1967-07-30', 'Aosta', 33000),
(122, 'Fabio', 'Marchetti', 'medico', '1987-10-05', 'Reggio Calabria', 25000),
(123, 'Silvia', 'Donati', 'chirurgo', '1980-12-12', 'Savona', 32000),
(124, 'Matteo', 'Ferraro', 'medico', '1973-09-25', 'Forlì', 27000),
(125, 'Federica', 'Piazza', 'chirurgo', '1966-04-18', 'Treviso', 34000),
(126, 'Antonio', 'Villa', 'medico', '1990-08-07', 'Siena', 26000),
(127, 'Ilaria', 'Caruso', 'chirurgo', '1981-06-23', 'Bari', 34500),
(128, 'Riccardo', 'Mancini', 'medico', '1961-03-31', 'Vicenza', 23000),
(129, 'Laura', 'De Luca', 'chirurgo', '1968-11-01', 'Modena', 31000),
(130, 'Daniele', 'Farina', 'medico', '1974-02-14', 'Catania', 28000),


--INSERT INTO Pazienti (nome, cognome, data_di_nascita, c_f, sesso, comune_di_nascita) VALUES -- da aggiungere contatti
INSERT INTO Pazienti (nome, cognome, data_nascita, c_f, sesso, comune_nascita) VALUES
('Luca', 'Bianchi', '1980-05-15', 'BNCLCU80E15H501T', 'maschio', 'Roma'),
('Giulia', 'Verdi', '1992-09-23', 'VRDGLI92P23H501S', 'femmina', 'Milano'),
('Marco', 'Russo', '1978-11-07', 'RSSMRC78S07H501L', 'maschio', 'Napoli'),
('Chiara', 'Esposito', '1985-01-24', 'SPSCIA85A24H501N', 'femmina', 'Torino'),
('Francesco', 'Romano', '1962-08-19', 'RMNFNC62M19H501Z', 'maschio', 'Palermo'),
('Alessia', 'Rinaldi', '1990-03-12', 'RNLLSS90C12H501B', 'femmina', 'Firenze'),
('Andrea', 'Marini', '1983-07-22', 'MRNNDR83L22H501H', 'maschio', 'Genova'),
('Federica', 'Conti', '1971-02-14', 'CNTFRC71B14H501X', 'femmina', 'Venezia'),
('Davide', 'Fabbri', '1969-04-01', 'FBBDVD69D01H501Q', 'maschio', 'Bologna'),
('Elisa', 'Pellegrini', '1987-06-18', 'PLGELS87H18H501M', 'femmina', 'Verona'),
('Matteo', 'Grassi', '1993-09-09', 'GRSMTT93P09H501E', 'maschio', 'Trieste'),
('Serena', 'Barbieri', '1965-12-27', 'BRBSRN65T27H501Y', 'femmina', 'Cagliari'),
('Giorgio', 'Ferrari', '1958-05-02', 'FRRGGR58E02H501V', 'maschio', 'Perugia'),
('Anna', 'Costa', '1975-03-19', 'CSTNNA75C19H501R', 'femmina', 'Ancona'),
('Massimo', 'Villa', '1981-07-29', 'VLLMSS81L29H501K', 'maschio', 'Trento'),
('Valentina', 'Piazza', '1989-11-05', 'PZZVLN89S05H501T', 'femmina', 'Udine'),
('Roberto', 'Galli', '1974-04-08', 'GLLRRT74D08H501G', 'maschio', 'Rimini'),
('Giada', 'Martini', '1991-08-12', 'MRTGDA91M12H501P', 'femmina', 'Pisa'),
('Stefano', 'Ricci', '1984-10-14', 'RCCSTF84R14H501C', 'maschio', 'Lecce'),
('Claudia', 'Orlandi', '1977-06-03', 'RLNCLD77H03H501U', 'femmina', 'Messina'),
('Tommaso', 'Farina', '1959-02-18', 'FRNTMS59B18H501O', 'maschio', 'Bolzano'),
('Silvia', 'Donati', '1988-05-09', 'DNTSLV88E09H501S', 'femmina', 'Aosta'),
('Alessandro', 'Pagani', '1960-07-21', 'PGNLSN60L21H501I', 'maschio', 'Reggio Calabria'),
('Federico', 'Cattaneo', '1979-01-17', 'CTNFDR79A17H501D', 'maschio', 'Savona'),
('Laura', 'Marchetti', '1982-03-04', 'MRCLRA82C04H501W', 'femmina', 'Forlì'),
('Simone', 'Romano', '1973-12-23', 'RMNSMN73T23H501T', 'maschio', 'Treviso'),
('Elena', 'Negri', '1994-02-06', 'NGRLNE94B06H501H', 'femmina', 'Siena'),
('Nicola', 'Battaglia', '1970-09-25', 'BTGNCL70P25H501S', 'maschio', 'Bari'),
('Francesca', 'Mancini', '1964-08-15', 'MNCFNC64M15H501Q', 'femmina', 'Vicenza'),
('Alberto', 'De Luca', '1976-06-20', 'DLCLBT76H20H501L', 'maschio', 'Modena'),
('Martina', 'Moretti', '1980-01-08', 'MRTMTN80A08H501J', 'femmina', 'Catania'),
('Lorenzo', 'Parisi', '1957-04-18', 'PRSLNZ57D18H501F', 'maschio', 'Padova'),
('Monica', 'Guerra', '1972-11-11', 'GRRMNC72S11H501B', 'femmina', 'Pescara'),
('Filippo', 'Caruso', '1986-07-13', 'CRSFLP86L13H501Z', 'maschio', 'Ravenna'),
('Caterina', 'Pellegrini', '1985-09-05', 'PLGCTR85P05H501K', 'femmina', 'Salerno'),
('Giovanni', 'Leone', '1961-02-22', 'LNGGVN61B22H501R', 'maschio', 'Arezzo'),
('Gabriele', 'Ventura', '1967-08-14', 'VNTGBL67M14H501X', 'maschio', 'Cremona'),
('Cristina', 'Santini', '1978-01-19', 'SNTCRN78A19H501M', 'femmina', 'La Spezia'),
('Edoardo', 'Barone', '1983-03-12', 'BRNDDR83C12H501I', 'maschio', 'Caserta'),
('Alessandro', 'Ferrari', '2009-03-15', 'FRRLSS09C15H501P', 'maschio', 'Roma'),
('Giulia', 'Rossi', '2010-07-22', 'RSSGLI10L22H501M', 'femmina', 'Milano'),
('Lorenzo', 'Bianchi', '2011-12-05', 'BNCLNZ11T05H501T', 'maschio', 'Napoli'),
('Marta', 'Verdi', '2013-06-18', 'VRDMRT13H18H501R', 'femmina', 'Torino'),
('Riccardo', 'Esposito', '2012-09-09', 'SPSRCR12P09H501F', 'maschio', 'Firenze'),
('Aurora', 'Romano', '2015-10-12', 'RMNARR15R12H501D', 'femmina', 'Genova'),
('Tommaso', 'Colombo', '2014-01-28', 'CLBTMS14A28H501L', 'maschio', 'Venezia'),
('Ginevra', 'Costa', '2016-04-17', 'CSTGNR16D17H501X', 'femmina', 'Bologna'),
('Leonardo', 'Marini', '2017-08-23', 'MRNLND17M23H501K', 'maschio', 'Verona'),
('Emma', 'Rinaldi', '2018-11-30', 'RNLMME18S30H501S', 'femmina', 'Palermo');





CREATE TABLE client (
    id_client NUMBER(10) PRIMARY KEY,
    email VARCHAR2(50) NOT NULL,
    nume VARCHAR2(50) NOT NULL,
    prenume VARCHAR2(80) NOT NULL,
    numar VARCHAR2(10) NOT NULL,
    strada VARCHAR2(50) NOT NULL,
    oras VARCHAR2(30) NOT NULL,
    judet VARCHAR2(30) NOT NULL,
    cod_postal VARCHAR2(10) NOT NULL,
    parola VARCHAR2(50) NOT NULL CONSTRAINT chk_parola CHECK (LENGTH(parola) >= 10 AND REGEXP_LIKE(parola, '[A-Z]') AND REGEXP_LIKE(parola, '[*_|!]'))
);

CREATE TABLE firma_de_curierat (
    id_firma_curierat number(10) PRIMARY KEY,
    nume_firma varchar2(50) NOT NULL UNIQUE,
    email_contact varchar2(50) NOT NULL UNIQUE
);


CREATE TABLE comanda (
    id_comanda NUMBER(10) PRIMARY KEY,
    id_client NUMBER(10) NOT NULL,
    plasata_la TIMESTAMP NOT NULL,
    AWB NUMBER(10) UNIQUE,
    id_firma_curierat NUMBER(10) NOT NULL,
    CONSTRAINT fk_id_client FOREIGN KEY (id_client) REFERENCES client(id_client) ON DELETE CASCADE,
    CONSTRAINT fk_firma_curierat FOREIGN KEY (id_firma_curierat) REFERENCES firma_de_curierat(id_firma_curierat) ON DELETE CASCADE
);

CREATE TABLE factura (
    id_factura number(10) PRIMARY KEY,
    id_comanda number(10) NOT NULL ,
    metoda_de_plata varchar2(30) NOT NULL,
    CONSTRAINT fk_factura FOREIGN KEY (id_comanda) REFERENCES comanda(id_comanda) ON DELETE CASCADE
);

CREATE TABLE distribuitor (
    id_distribuitor number(10) PRIMARY KEY,
    email_contact varchar2(50) NOT NULL,
    nume_distribuitor varchar2(50) NOT NULL UNIQUE
);

CREATE TABLE categorie (
    id_categorie number(5) PRIMARY KEY,
    nume_categorie varchar2(50) NOT NULL UNIQUE
);

CREATE TABLE produs (
    id_produs number(10) PRIMARY KEY,
    id_distribuitor number(10)  NOT NULL,
    id_categorie number(5),
    nume_produs varchar2(50) NOT NULL,
   autor varchar2(30),
    CONSTRAINT fk_distribuitor FOREIGN KEY (id_distribuitor) REFERENCES distribuitor(id_distribuitor) ON DELETE CASCADE,
    CONSTRAINT fk_categorie FOREIGN KEY (id_categorie) REFERENCES categorie(id_categorie) ON DELETE SET NULL
);

CREATE TABLE produs_comandat (
    id_comanda number(10) NOT NULL,
    id_produs number(10) NOT NULL,
    numar number(4) NOT NULL CONSTRAINT chk_numar CHECK (numar > 0),
    CONSTRAINT pk_produs_comandat PRIMARY KEY (id_comanda,id_produs),
    CONSTRAINT fk_comanda FOREIGN KEY (id_comanda) REFERENCES comanda(id_comanda) ON DELETE CASCADE,
    CONSTRAINT fk_produs  FOREIGN KEY (id_produs) REFERENCES produs(id_produs)  ON DELETE CASCADE
);



--Inserare clienti:
INSERT ALL
 INTO client VALUES (1, 'givechiLeonard@yahoo.com', 'Givechi', 'Leonard', '0773367782', 'Splaiul Independetei', 'Bucuresti', 'Bucuresti', '543231', 'Cabral456!')
 INTO client VALUES  (2, 'greblaGicu@gmail.com', 'Grebla', 'Gicu', '0773367782', 'Strada Stefan cel Mare', 'Vaslui', 'Vaslui', '54321', 'Parola456!')
 INTO client VALUES  (3, 'gigelprogaming12@outlook.com', 'Popa', 'Gigel', '0787878782', 'Strada Victoriei', 'Iasi', 'Iasi', '98765', 'Parola789*')
 INTO client VALUES  (4, 'ConstantinCostin29@outlook.com', 'Costantin', 'Costin Cosmin', '0793287601', 'Strada Progresului', 'Bucuresti', 'Bucuresti', '10065', 'Pa55sss789*')
 INTO client VALUES  (5, 'gigelprogaming12@outlook.com', 'Tudor', 'Vladimirescu', '0733558899', 'Strada Nicolae Iorga', 'Focsani', 'Vrancea', '84242', 'Ciscoconpa55!')
 INTO client VALUES  (6, 'deliutzaMihai@outlook.com', 'Mihai', 'Delia Irina', '0787234789', 'Strada Revolutiei', 'Targoviste', 'Targoviste', '123233', 'Parola123_')
 INTO client VALUES  (7, 'tomaPatrascu_03@gmail.com', 'Patrascu', 'Toma', '0774678289', 'Bulevardul Unirii', 'Targoviste', 'Targoviste', '98765', 'Parola789*')
 INTO client VALUES  (8, 'gicugi02@outlook.com', 'Gicu', 'Gigi', '0701234567', 'Strada Armatei', 'Barlad', 'Vaslui', '201765', 'Rdwola789*')
 INTO client VALUES  (9, 'iorga_90@gmail.com', 'Iorga', 'Iasmina', '0722355333', 'Strada Tudor Vladimirescu', 'Iasi', 'Iasi', '987125', 'LOlola789*')
 INTO client VALUES  (10, 'mirceaVladoiu1997@outlook.com', 'Vladoiu', 'Mircea', '0722210111', 'Strada Emanciparii', 'Bucuresti', 'Bucuresti', '012923', 'Parola789*')
 INTO client VALUES  (11, 'adrianLapusneanu@outlook.com', 'Lapusneanu', 'Adrian Andrei', '0772167890', 'Calea Plevnei', 'Bucuresti', 'Bucuresti', '2323', 'Lalala112!')
 INTO client VALUES  (12, 'hasdeuIon02@s.unibuc.ro', 'Hasdeu', 'Ion Pavel', '0763256563', 'Strada Spitalului', 'Vaslui', 'Vaslui', '07732', 'rockROCK689_')
 INTO client VALUES  (13, 'gigelpopa22@gmail.com', 'Popa', 'Gigel', '0780234333', 'Strada Victoriei', 'Iasi', 'Iasi', '12765', 'Dacola211*')
 INTO client VALUES  (14, 'popa_gherasim@outlook.com', 'Popa', 'Gherasim', '0774422333', 'Strada Atomistilor', 'Magurele', 'Ilfov', '923765', 'PavelPavel12*')
 INTO client VALUES  (15, 'atasieiFabia@outlook.com', 'Atasiei', 'Fabian', '0702101221', 'Strada Timisoara', 'Brasov', 'Brasov', '00021', 'PotecaUrsilor9!')
 INTO client VALUES  (16, 'fratila_teo2002@outlook.com', 'Fratila', 'Teo', '0729200121', 'Strada Fabrica de Zahar', 'Bucuresti', 'Bucuresti', '888888', '!Rautaterea12')
 INTO client VALUES  (17, 'dudarea@yahoo.com', 'Dudau', 'Gheorghe', '0786668782', 'Strada Dacia', 'Roman', 'Iasi', '78225', 'Parola6969*')
 INTO client VALUES  (18, 'obuStefan11@yahoo.com', 'Obu', 'Stefan', '0722342323', 'Strada Bucium', 'Iasi', 'Iasi', '100238', 'SecretDiscret789*')
 INTO client VALUES  (19, 'flaviusSepte@outlook.com', 'Ramura', 'Flavius', '0766352673', 'Strada Regina Maria', 'Iasi', 'Iasi', '10765', 'DiscretSecret909*')
 INTO client VALUES  (20, 'Constantin_tiberius@outlook.com', 'Tiberius', 'Constantin', '0787878782', 'Strada Carol I', 'Bucuresti', 'Bucuresti', '66765', 'Divanturc789*')
SELECT * FROM dual;
--Inserare firme curierat:
INSERT ALL
 INTO firma_de_curierat VALUES (400, 'Posta Romana', 'contact@posta.romana.ro')
 INTO firma_de_curierat VALUES  (401, 'Fan Curier', 'contact@fanCurier.ro')
 INTO firma_de_curierat VALUES (402, 'Cargus', 'contact@cargus.ro')
 INTO firma_de_curierat VALUES (403, 'DHL', 'contact@dhl.com')
 INTO firma_de_curierat VALUES (404, 'SameDay', 'contact@sameDay.ro')
 INTO firma_de_curierat VALUES (405, 'FedEx', 'contact@fedEx.ro')
 INTO firma_de_curierat VALUES (406, 'GLS', 'contact@gls.ro')
 INTO firma_de_curierat VALUES (407, 'Dragon Star Curier', 'contact@dgs.ro')
 INTO firma_de_curierat VALUES (408, 'UPS', 'contact@ups.ro')
SELECT * FROM dual;
--Inserare comenzi:
INSERT ALL
  INTO comanda VALUES (1010, 1, TO_TIMESTAMP('2023-02-01 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 921313210, 401)
  INTO comanda VALUES (1020, 2, TO_TIMESTAMP('2023-02-01 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), 9000043211, 401)
  INTO comanda VALUES (1030, 3, TO_TIMESTAMP('2023-03-01 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), 5678901234, 403)
  INTO comanda VALUES (1040, 3, TO_TIMESTAMP('2023-03-02 17:30:00', 'YYYY-MM-DD HH24:MI:SS'), 9876543212, 407)
  INTO comanda VALUES (1050, 3, TO_TIMESTAMP('2023-03-03 18:15:00', 'YYYY-MM-DD HH24:MI:SS'), 1112233446, 403)
  INTO comanda VALUES (1060, 3, TO_TIMESTAMP('2023-03-04 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 9998887771, 400)
  INTO comanda VALUES (1070, 1, TO_TIMESTAMP('2023-03-05 19:45:00', 'YYYY-MM-DD HH24:MI:SS'), 1111222234, 400)
  INTO comanda VALUES (1080, 9, TO_TIMESTAMP('2023-03-06 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), 4445556668, 407)
  INTO comanda VALUES (1090, 15, TO_TIMESTAMP('2023-03-07 21:15:00', 'YYYY-MM-DD HH24:MI:SS'), 7776665555, 403)
  INTO comanda VALUES (1100, 13, TO_TIMESTAMP('2023-03-08 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3334445557, 402)
  INTO comanda VALUES (1110, 19, TO_TIMESTAMP('2023-03-09 22:45:00', 'YYYY-MM-DD HH24:MI:SS'), 6667778890, 404)
  INTO comanda VALUES (1120, 18, TO_TIMESTAMP('2023-03-10 23:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1111112223, 403)
  INTO comanda VALUES (1130, 17, TO_TIMESTAMP('2023-03-11 11:45:30', 'YYYY-MM-DD HH24:MI:SS'), 8889990002, 405)
  INTO comanda VALUES (1140, 16, TO_TIMESTAMP('2023-03-12 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), 5554443333, 404)
  INTO comanda VALUES (1150, 12, TO_TIMESTAMP('2023-03-13 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), 2223334446, 405)
  INTO comanda VALUES (1160, 11, TO_TIMESTAMP('2023-03-14 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), 9990001113, 403)
  INTO comanda VALUES (1170, 10, TO_TIMESTAMP('2023-03-15 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), 8887776664, 403)
  INTO comanda VALUES (1180, 8, TO_TIMESTAMP('2023-03-16 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), 1011121315, 408)
  INTO comanda VALUES (1190, 7, TO_TIMESTAMP('2023-03-17 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), 1516171820, 400)     
  INTO comanda VALUES (1200, 6, TO_TIMESTAMP('2023-03-18 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), 2021222325, 408)
  INTO comanda VALUES (1210, 14, TO_TIMESTAMP('2023-03-19 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), 2526272830, 408)
 SELECT * FROM dual;

--Inserare facturi:
INSERT ALL
  INTO factura VALUES (100, 1010, 'card')
  INTO factura VALUES (101, 1020, 'ramburs')
  INTO factura VALUES (102, 1030, 'card')
  INTO factura VALUES (103, 1040, 'ramburs')
  INTO factura VALUES (104, 1050, 'card')
  INTO factura VALUES (105, 1060, 'ramburs')
  INTO factura VALUES (106, 1070, 'card')
  INTO factura VALUES (107, 1080, 'ramburs')
  INTO factura VALUES (108, 1090, 'card')
  INTO factura VALUES (109, 1100, 'ramburs')
  INTO factura VALUES (110, 1110, 'card')
  INTO factura VALUES (111, 1120, 'card')
  INTO factura VALUES (112, 1120, 'card')
  INTO factura VALUES (113, 1140, 'ramburs')
  INTO factura VALUES (114, 1150, 'card')
  INTO factura VALUES (115, 1160, 'ramburs')
  INTO factura VALUES (116, 1170, 'card')
  INTO factura VALUES (117, 1180, 'ramburs')
  INTO factura VALUES (118, 1200, 'card')
  INTO factura VALUES (119, 1210, 'ramburs')
  INTO factura VALUES (120, 1020, 'card')
  INTO factura VALUES (121, 1030, 'ramburs')
  INTO factura VALUES (122, 1040, 'card')
  INTO factura VALUES (123, 1050, 'ramburs')
  INTO factura VALUES (124, 1060, 'card')
  INTO factura VALUES (125, 1070, 'ramburs')
  INTO factura VALUES (126, 1080, 'card')
  INTO factura VALUES (127, 1110, 'ramburs')
  INTO factura VALUES (128, 1110, 'card')
  INTO factura VALUES (129, 1120, 'ramburs')
  INTO factura VALUES (130, 1130, 'card')
SELECT * FROM dual;
--Inserare distribuitori:
INSERT ALL
INTO distribuitor VALUES (500, 'contact@booklet.ro', 'Editura Booklet')
INTO distribuitor VALUES (525, 'contact@editura3.ro', 'Editura 3')
INTO distribuitor VALUES (550, 'contact@nemira.ro', 'Nemira')
INTO distribuitor VALUES (600, 'contact@rao.ro', 'RAO')
INTO distribuitor VALUES (650, 'contact@edituraParalel45.ro', 'Editura Paralela 45')
INTO distribuitor VALUES (700, 'contact@edituraCorint.ro', 'Corint')
INTO distribuitor VALUES (750, 'contact@humantis.ro', 'Humanitas')
INTO distribuitor VALUES (800, 'contact@penguin.com', 'Penguin')
INTO distribuitor VALUES (850, 'contact@adevarul.ro', 'Adevarul')
INTO distribuitor VALUES (900, 'contact@litera.ro', 'Litera')
SELECT * FROM dual;

--Inserare categorii:
INSERT ALL
INTO categorie VALUES  (10, 'Istorie')
INTO categorie VALUES  (20, 'Filozofie')
INTO categorie VALUES  (30, 'Psihologie')
INTO categorie VALUES  (40, 'Beletristica')
INTO categorie VALUES  (50, 'Litera Clasice')
INTO categorie VALUES  (60, 'Religie')
INTO categorie VALUES  (70, 'Manuale si auxiliare')
INTO categorie VALUES  (80, 'Stiinte')
INTO categorie VALUES  (90, 'Gastronomie')
INTO categorie VALUES  (100, 'Carte Straina')
SELECT * FROM dual;
--Inserare produse:
INSERT ALL
INTO produs VALUES  (5001, 600, 10, 'Ruleta Ruseasca', 'Michael Isikoff')
INTO produs VALUES  (5002, 600, 10, 'Pretul Deminitatii', 'Laura Ganea')
INTO produs VALUES  (5003, 600, 80, 'X-CYBER Viitorul incepe azi', 'Marc Goodman')
INTO produs VALUES  (5004, 600, 20, 'Filosofia lui Habermas', 'Andrei Marga')
INTO produs VALUES  (5005, 550, 40, 'Turnul Intunecat 2', 'Stephen King')
INTO produs VALUES  (5006, 550, 100, 'The Dark Tower 1', 'Stephen King')
INTO produs VALUES  (5007, 600, 50, 'Opere alese', 'Goethe')
INTO produs VALUES  (5008, 700, 70, 'Romania Atlas Geografic', 'Octavian Mandrut')
INTO produs VALUES  (5009, 700, 70, 'Bac Limba si literatura romana 2023', 'Monica Ciprian')
INTO produs VALUES  (5010, 650, 70, 'Evaluare Nationala Matematica', 'Gabriel Popa')
INTO produs VALUES  (5011, 650, 70, 'Matematica si explorarea mediului','Luis Gabriel')
INTO produs VALUES  (5012, 750, 30, 'Nu copilul e de vina', 'Ioana Scorus')
INTO produs VALUES  (5013, 750, 60, 'Dumnezeu, om, animal, masina', 'Meghan OGieblyn')
INTO produs VALUES  (5014, 800, 100, 'Crime and Punishment', 'Fyodor Dostoyevsky')
INTO produs VALUES  (5015, 750, 50, 'Insemnari din Subteran', 'Fyodor Dostoyevsky')
INTO produs VALUES  (5016, 800, 100, 'Portrait of Dorian Gray', 'Oscar Wilde')
INTO produs VALUES  (5017, 900, 40, 'Lumina din noi', 'Michael Obama')
INTO produs VALUES  (5018, 900, 40, 'IT', 'Stephen King' )
INTO produs VALUES  (5019, 850, 40, 'Winnetou 1','Karl May')
INTO produs VALUES  (5020, 850, 40, 'Werke', 'Karl May')
INTO produs VALUES  (5021, 600, 40, 'Comoara din Lacul de Argint', 'Karl May')
INTO produs VALUES  (5022, 550, 10, 'Inchisoarea OGPU', 'Sven Hassel')
INTO produs VALUES  (5023, 800, 30, 'Psihologia Iubirii', 'Sigmund Freud')
INTO produs VALUES  (5024, 900, 20, 'Alegoria Pesterii', 'Platon')
INTO produs VALUES  (5025, 650, 70, 'Auxiliar Clasa a V-a', 'Tiplea Sorin')
SELECT * FROM dual;
--Inserare  în tabelul Produs-Comandat:
INSERT ALL
INTO produs_comandat VALUES  (1010, 5009, 3)
INTO produs_comandat VALUES  (1010, 5024, 1)
INTO produs_comandat VALUES  (1020, 5025, 1)
INTO produs_comandat VALUES  (1030, 5001, 1)
INTO produs_comandat VALUES  (1030, 5002, 1)
INTO produs_comandat VALUES  (1040, 5025, 1)
INTO produs_comandat VALUES  (1050, 5025, 1)
INTO produs_comandat VALUES  (1060, 5025, 1)
INTO produs_comandat VALUES  (1070, 5008, 2)
INTO produs_comandat VALUES  (1070, 5015, 1)
INTO produs_comandat VALUES  (1080, 5025, 1)
INTO produs_comandat VALUES  (1080, 5022, 1)
INTO produs_comandat VALUES  (1080, 5018, 1)
INTO produs_comandat VALUES  (1090, 5019, 1)
INTO produs_comandat VALUES  (1090, 5020, 1)
INTO produs_comandat VALUES  (1100, 5015, 1)
INTO produs_comandat VALUES  (1110, 5005, 1)
INTO produs_comandat VALUES  (1120, 5014, 1)
INTO produs_comandat VALUES  (1130, 5016, 1)
INTO produs_comandat VALUES  (1140, 5023, 1)
INTO produs_comandat VALUES  (1150, 5025, 1)
INTO produs_comandat VALUES  (1160, 5022, 1)
INTO produs_comandat VALUES  (1160, 5024, 1)
INTO produs_comandat VALUES  (1170, 5011, 1)
INTO produs_comandat VALUES  (1170, 5012, 4)
INTO produs_comandat VALUES  (1170, 5025, 2)
INTO produs_comandat VALUES  (1180, 5013, 1)
INTO produs_comandat VALUES  (1190, 5017, 2)
INTO produs_comandat VALUES  (1120, 5004, 1)
INTO produs_comandat VALUES  (1120, 5006, 1)
INTO produs_comandat VALUES  (1120, 5007, 1)
INTO produs_comandat VALUES  (1120, 5008, 1)
INTO produs_comandat VALUES  (1120, 5010, 1)
INTO produs_comandat VALUES  (1210, 5020, 1)
INTO produs_comandat VALUES  (1210, 5021, 1)
INTO produs_comandat VALUES  (1200, 5004, 1)
SELECT * FROM dual;
COMMIT;


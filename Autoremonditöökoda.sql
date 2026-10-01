-- Created by Redgate Data Modeler (https://datamodeler.redgate-platform.com)
-- Last modification date: 2026-10-01 10:10:56.246
create database autoremondikoda;
use autoremondikoda
-- tables
-- Table: amet
CREATE TABLE amet (
    ametID int  NOT NULL IDENTITY,
    nimetus varchar(30)  NOT NULL,
    kirjeldus nvarchar(max)  NULL,
    CONSTRAINT amet_pk PRIMARY KEY  (ametID)
);

-- Table: ametimaaratus
CREATE TABLE ametimaaratus (
    ametimaaratusID int  NOT NULL IDENTITY,
    alguskuupaev date  NOT NULL,
    tootajaID int  NOT NULL,
    ametID int  NOT NULL,
    loppKuupaev date  NULL,
    CONSTRAINT ametimaaratus_pk PRIMARY KEY  (ametimaaratusID)
);

-- Table: arve
CREATE TABLE arve (
    arveID int  NOT NULL IDENTITY,
    kuupaev date  NOT NULL,
    summa int  NOT NULL,
    remonditooID int  NOT NULL,
    CONSTRAINT arve_pk PRIMARY KEY  (arveID)
);

-- Table: auto
CREATE TABLE auto (
    regnumber varchar(10)  NOT NULL,
    mark varchar(30)  NOT NULL,
    mudel varchar(30)  NOT NULL,
    aasta int  NOT NULL,
    labisoit int  NOT NULL,
    CONSTRAINT auto_pk PRIMARY KEY  (regnumber)
);

-- Table: kategooria
CREATE TABLE kategooria (
    kategooriaID int  NOT NULL IDENTITY,
    kategooria varchar(30)  NOT NULL,
    kirjeldus nvarchar(max)  NULL,
    kestvus int  NULL,
    CONSTRAINT kategooria_pk PRIMARY KEY  (kategooriaID)
);

-- Table: kliendiauto
CREATE TABLE kliendiauto (
    kliendiautoID int  NOT NULL IDENTITY,
    kuupaev date  NOT NULL,
    klientID int  NOT NULL,
    regnumber varchar(10)  NOT NULL,
    loppKuupaev date  NULL,
    CONSTRAINT kliendiauto_pk PRIMARY KEY  (kliendiautoID)
);

-- Table: klient
CREATE TABLE klient (
    klientID int  NOT NULL IDENTITY,
    klientiNimi varchar(30)  NOT NULL,
    tel varchar(13)  NULL,
    e_post varchar(30)  NULL,
    CONSTRAINT klient_pk PRIMARY KEY  (klientID)
);

-- Table: ladu
CREATE TABLE ladu (
    laduID int  NOT NULL IDENTITY,
    nimetus varchar(30)  NOT NULL,
    aadress varchar(30)  NOT NULL,
    CONSTRAINT ladu_pk PRIMARY KEY  (laduID)
);

-- Table: laduvaruosa
CREATE TABLE laduvaruosa (
    laduvaruosaID int  NOT NULL IDENTITY,
    kogus int  NOT NULL,
    varuosaID int  NOT NULL,
    laduID int  NOT NULL,
    CONSTRAINT laduvaruosa_pk PRIMARY KEY  (laduvaruosaID)
);

-- Table: remonditoo
CREATE TABLE remonditoo (
    remonditooID int  NOT NULL IDENTITY,
    kuupaev date  NOT NULL,
    kirjeldus nvarchar(max)  NOT NULL,
    regnumber varchar(10)  NOT NULL,
    kategooriaID int  NOT NULL,
    CONSTRAINT remonditoo_pk PRIMARY KEY  (remonditooID)
);

-- Table: tarneVaruosa
CREATE TABLE tarneVaruosa (
    tarneVaruosaID int  NOT NULL IDENTITY,
    ostuhind int  NOT NULL,
    varuosaID int  NOT NULL,
    tarnijaID int  NOT NULL,
    CONSTRAINT tarneVaruosa_pk PRIMARY KEY  (tarneVaruosaID)
);

-- Table: tarnija
CREATE TABLE tarnija (
    tarnijaID int  NOT NULL IDENTITY,
    nimetus varchar(30)  NOT NULL,
    kontakt varchar(30)  NOT NULL,
    aadress varchar(30)  NOT NULL,
    CONSTRAINT tarnija_pk PRIMARY KEY  (tarnijaID)
);

-- Table: tootaja
CREATE TABLE tootaja (
    tootajaID int  NOT NULL IDENTITY,
    nimi varchar(30)  NOT NULL,
    isikukood varchar(11)  NOT NULL,
    tel varchar(13)  NOT NULL,
    aadress varchar(30)  NOT NULL,
    CONSTRAINT isikukood UNIQUE (isikukood),
    CONSTRAINT tootaja_pk PRIMARY KEY  (tootajaID)
);

-- Table: tootajaRemondis
CREATE TABLE tootajaRemondis (
    tootajaRemondisID int  NOT NULL IDENTITY,
    status varchar(30)  NOT NULL,
    remonditooID int  NOT NULL,
    tootajaID int  NOT NULL,
    CONSTRAINT tootajaRemondis_pk PRIMARY KEY  (tootajaRemondisID)
);

-- Table: varuosa
CREATE TABLE varuosa (
    varuosaID int  NOT NULL IDENTITY,
    nimetus varchar(30)  NOT NULL,
    tootja varchar(30)  NOT NULL,
    muugihind int  NOT NULL,
    CONSTRAINT varuosa_pk PRIMARY KEY  (varuosaID)
);

-- Table: varuosaRemondis
CREATE TABLE varuosaRemondis (
    varuosaRemondisID int  NOT NULL IDENTITY,
    kogus int  NOT NULL,
    laduvaruosaID int  NOT NULL,
    remonditooID int  NOT NULL,
    CONSTRAINT varuosaRemondis_pk PRIMARY KEY  (varuosaRemondisID)
);

-- foreign keys
-- Reference: ametimaaratus_amet (table: ametimaaratus)
ALTER TABLE ametimaaratus ADD CONSTRAINT ametimaaratus_amet
    FOREIGN KEY (ametID)
    REFERENCES amet (ametID);

-- Reference: ametimaaratus_tootaja (table: ametimaaratus)
ALTER TABLE ametimaaratus ADD CONSTRAINT ametimaaratus_tootaja
    FOREIGN KEY (tootajaID)
    REFERENCES tootaja (tootajaID);

-- Reference: arve_remonditoo (table: arve)
ALTER TABLE arve ADD CONSTRAINT arve_remonditoo
    FOREIGN KEY (remonditooID)
    REFERENCES remonditoo (remonditooID);

-- Reference: kliendiauto_auto (table: kliendiauto)
ALTER TABLE kliendiauto ADD CONSTRAINT kliendiauto_auto
    FOREIGN KEY (regnumber)
    REFERENCES auto (regnumber);

-- Reference: kliendiauto_klient (table: kliendiauto)
ALTER TABLE kliendiauto ADD CONSTRAINT kliendiauto_klient
    FOREIGN KEY (klientID)
    REFERENCES klient (klientID);

-- Reference: laduvaruosa_ladu (table: laduvaruosa)
ALTER TABLE laduvaruosa ADD CONSTRAINT laduvaruosa_ladu
    FOREIGN KEY (laduID)
    REFERENCES ladu (laduID);

-- Reference: laduvaruosa_varuosa (table: laduvaruosa)
ALTER TABLE laduvaruosa ADD CONSTRAINT laduvaruosa_varuosa
    FOREIGN KEY (varuosaID)
    REFERENCES varuosa (varuosaID);

-- Reference: remonditoo_auto (table: remonditoo)
ALTER TABLE remonditoo ADD CONSTRAINT remonditoo_auto
    FOREIGN KEY (regnumber)
    REFERENCES auto (regnumber);

-- Reference: remonditoo_kategooria (table: remonditoo)
ALTER TABLE remonditoo ADD CONSTRAINT remonditoo_kategooria
    FOREIGN KEY (kategooriaID)
    REFERENCES kategooria (kategooriaID);

-- Reference: tarneVaruosa_tarnija (table: tarneVaruosa)
ALTER TABLE tarneVaruosa ADD CONSTRAINT tarneVaruosa_tarnija
    FOREIGN KEY (tarnijaID)
    REFERENCES tarnija (tarnijaID);

-- Reference: tarneVaruosa_varuosa (table: tarneVaruosa)
ALTER TABLE tarneVaruosa ADD CONSTRAINT tarneVaruosa_varuosa
    FOREIGN KEY (varuosaID)
    REFERENCES varuosa (varuosaID);

-- Reference: tootajaRemondis_remonditoo (table: tootajaRemondis)
ALTER TABLE tootajaRemondis ADD CONSTRAINT tootajaRemondis_remonditoo
    FOREIGN KEY (remonditooID)
    REFERENCES remonditoo (remonditooID);

-- Reference: tootajaRemondis_tootaja (table: tootajaRemondis)
ALTER TABLE tootajaRemondis ADD CONSTRAINT tootajaRemondis_tootaja
    FOREIGN KEY (tootajaID)
    REFERENCES tootaja (tootajaID);

-- Reference: varuosaRemondis_laduvaruosa (table: varuosaRemondis)
ALTER TABLE varuosaRemondis ADD CONSTRAINT varuosaRemondis_laduvaruosa
    FOREIGN KEY (laduvaruosaID)
    REFERENCES laduvaruosa (laduvaruosaID);

-- Reference: varuosaRemondis_remonditoo (table: varuosaRemondis)
ALTER TABLE varuosaRemondis ADD CONSTRAINT varuosaRemondis_remonditoo
    FOREIGN KEY (remonditooID)
    REFERENCES remonditoo (remonditooID);

-- End of file.

/* =====================================================================
   Autoremondikoda - testandmed (INSERT)
   Käivita PÄRAST tabelite loomist, TÜHJADE tabelite peal.
   ID-d (IDENTITY) hakkavad 1-st, seetõttu viitavad FK-d allpool ID-dele 1, 2, 3...
   Kui käivitasid INSERT-id juba korra, loo tabelid enne uuesti (DROP + CREATE).
   ===================================================================== */

USE autoremondikoda;

/* ---------- 1. Ametid ja töötajad ---------- */

INSERT INTO amet (nimetus, kirjeldus) VALUES
(N'Meister',     N'Töökoja juht, jaotab töid töötajate vahel'),
(N'Mehaanik',    N'Autode remont ja hooldus'),
(N'Diagnostik',  N'Arvutidiagnostika ja vigade otsimine'),
(N'Vastuvõtja',  N'Klientide vastuvõtt ja remonditööde registreerimine'),
(N'Laohoidja',   N'Varuosade ladu ja nende arvestus');

INSERT INTO tootaja (nimi, isikukood, tel, aadress) VALUES
(N'Peeter Saar',     '38505120123', '+37255501234', N'Tallinn, Tamme 5'),
(N'Marko Kuusk',     '39001150234', '+37255502345', N'Tallinn, Lepa 12'),
(N'Toomas Rebane',   '38207300345', '+37255503456', N'Tartu, Kase 3'),
(N'Anna Põld',       '49203210456', '+37255504567', N'Tallinn, Pärna 8'),
(N'Kristjan Ilves',  '39508180567', '+37255505678', N'Pärnu, Mere 20');

-- Ametikohtade ajalugu: Peeter Saar oli mehaanik, 2024. aastast meister
INSERT INTO ametimaaratus (alguskuupaev, tootajaID, ametID, loppKuupaev) VALUES
('2020-01-01', 1, 2, '2023-12-31'),   -- Peeter: mehaanik (lõppenud)
('2024-01-01', 1, 1, NULL),           -- Peeter: meister (praegune)
('2021-03-15', 2, 2, NULL),           -- Marko: mehaanik
('2022-06-01', 3, 3, NULL),           -- Toomas: diagnostik
('2019-09-01', 4, 4, NULL),           -- Anna: vastuvõtja
('2023-02-01', 5, 5, NULL);           -- Kristjan: laohoidja

/* ---------- 2. Kliendid ja autod ---------- */

INSERT INTO klient (klientiNimi, tel, e_post) VALUES
(N'Mati Tamm',    '+37255512345', 'mati.tamm@mail.ee'),
(N'Liis Kask',    '+37256623456', 'liis.kask@gmail.com'),
(N'Andres Sepp',  '+37253334567', NULL),
(N'Kadri Mägi',   '+37255545678', 'kadri.magi@hot.ee'),
(N'Jaan Org',     NULL,           'jaan.org@firma.ee');

INSERT INTO auto (regnumber, mark, mudel, aasta, labisoit) VALUES
('123ABC', N'Toyota',      N'Corolla', 2015, 182000),
('456DEF', N'Volkswagen',  N'Golf',    2012, 215000),
('789GHI', N'BMW',         N'320d',    2018, 128000),
('321JKL', N'Ford',        N'Focus',   2010, 263000),
('654MNO', N'Skoda',       N'Octavia', 2019,  97000),
('987PQR', N'Volvo',       N'V60',     2016, 154000);

-- Kliendil võib olla mitu autot (Mati: 2 autot, Liis: 2 autot); auto võib omanikku vahetada (456DEF)
INSERT INTO kliendiauto (kuupaev, klientID, regnumber, loppKuupaev) VALUES
('2018-03-10', 1, '123ABC', NULL),
('2019-06-15', 2, '456DEF', '2023-09-01'),   -- Liis müüs auto maha
('2023-09-01', 3, '456DEF', NULL),           -- uus omanik Andres
('2020-02-20', 4, '789GHI', NULL),
('2021-05-05', 1, '321JKL', NULL),           -- Matil on teine auto
('2022-08-12', 5, '654MNO', NULL),
('2024-01-10', 2, '987PQR', NULL);           -- Liisil uus auto

/* ---------- 3. Remonditööde kategooriad ja remonditööd ---------- */

INSERT INTO kategooria (kategooria, kirjeldus, kestvus) VALUES
(N'Õlivahetus',      N'Mootoriõli ja õlifiltri vahetus',        45),
(N'Pidurite remont', N'Piduriklotside ja ketaste vahetus',     120),
(N'Rehvide vahetus', N'Suve- ja talverehvide vahetus',          60),
(N'Mootori remont',  N'Mootori vigade parandamine',            480),
(N'Diagnostika',     N'Auto arvutidiagnostika',                 30);

-- Ühe auto kohta mitu remonditööd (123ABC: töö 1 ja 6)
INSERT INTO remonditoo (kuupaev, kirjeldus, regnumber, kategooriaID) VALUES
('2026-08-05', N'Õli ja õlifiltri vahetus',              '123ABC', 1),
('2026-08-12', N'Esimeste piduriklotside ja ketaste vahetus', '456DEF', 2),
('2026-08-20', N'Suverehvide vahetus talverehvide vastu', '789GHI', 3),
('2026-09-02', N'Mootori vibratsiooni remont',            '321JKL', 4),
('2026-09-10', N'Kontrolltuli põleb, diagnostika',        '654MNO', 5),
('2026-09-18', N'Pidurivedeliku vahetus',                 '123ABC', 2);

-- Ühe tööga tegeleb mitu töötajat (töö 2 ja 4); üks töötaja osaleb mitmes töös (Marko)
INSERT INTO tootajaRemondis (status, remonditooID, tootajaID) VALUES
(N'lõpetatud', 1, 2),
(N'lõpetatud', 2, 2),
(N'lõpetatud', 2, 1),
(N'lõpetatud', 3, 2),
(N'pooleli',   4, 1),
(N'pooleli',   4, 2),
(N'lõpetatud', 5, 3),
(N'lõpetatud', 6, 2);

/* ---------- 4. Varuosad, laod, tarnijad ---------- */

INSERT INTO ladu (nimetus, aadress) VALUES
(N'Pealadu',     N'Tallinn, Tööstuse 10'),
(N'Lisaladu',    N'Tallinn, Kopli 25'),
(N'Tartu ladu',  N'Tartu, Riia 40');

INSERT INTO varuosa (nimetus, tootja, muugihind) VALUES
(N'Õlifilter',          N'MANN',        12),
(N'Mootoriõli 5W-30',   N'Castrol',     35),
(N'Piduriklotsid',      N'Bosch',       48),
(N'Piduriketas',        N'Brembo',      85),
(N'Rehv 205/55 R16',    N'Continental', 95),
(N'Pidurivedelik DOT4', N'ATE',          9);

-- Mitu varuosa laos, sama varuosa võib olla mitmes laos (õlifilter, piduriklotsid)
INSERT INTO laduvaruosa (kogus, varuosaID, laduID) VALUES
(25, 1, 1),
(10, 1, 2),
(40, 2, 1),
(18, 3, 1),
( 6, 4, 2),
(16, 5, 3),
(12, 6, 1),
( 8, 3, 3);

-- Millist varuosa millise töö juures ja mitu tükki kasutati (õli kasutati töödel 1 ja 4)
INSERT INTO varuosaRemondis (kogus, laduvaruosaID, remonditooID) VALUES
(1, 1, 1),   -- töö 1: õlifilter
(4, 3, 1),   -- töö 1: õli
(1, 4, 2),   -- töö 2: piduriklotsid
(2, 5, 2),   -- töö 2: piduriketas
(4, 6, 3),   -- töö 3: rehvid
(1, 2, 4),   -- töö 4: õlifilter
(5, 3, 4),   -- töö 4: õli
(2, 7, 6);   -- töö 6: pidurivedelik

INSERT INTO tarnija (nimetus, kontakt, aadress) VALUES
(N'AutoOsad OÜ',    'info@autoosad.ee',    N'Tallinn, Peterburi tee 90'),
(N'Baltic Parts AS','+3726001234',         N'Tallinn, Mäepealse 3'),
(N'Rehviäri OÜ',    'rehvid@rehviari.ee',  N'Tartu, Ringtee 12'),
(N'Bosch Eesti',    'myyk@bosch.ee',       N'Tallinn, Pärnu mnt 139'),
(N'Õlimaailm OÜ',   '+3725005678',         N'Narva, Kreenholmi 4');

-- Üks tarnija pakub mitut varuosa, sama varuosa on saadaval mitme tarnija juures (eri hinnaga)
INSERT INTO tarneVaruosa (ostuhind, varuosaID, tarnijaID) VALUES
( 8, 1, 1),
( 9, 1, 2),
(26, 2, 5),
(28, 2, 1),
(35, 3, 1),
(33, 3, 4),
(60, 4, 2),
(70, 5, 3),
(72, 5, 2),
( 6, 6, 4);

/* ---------- 5. Arved (ainult lõpetatud töödele 1, 2, 3, 5, 6) ---------- */

INSERT INTO arve (kuupaev, summa, remonditooID) VALUES
('2026-08-05', 190, 1),
('2026-08-12', 318, 2),
('2026-08-20', 420, 3),
('2026-09-10',  40, 5),
('2026-09-18',  53, 6);

/* ---------- 6. Kontrollpäringud ---------- */

-- Laoseis (varuosal eraldi veergu pole, see arvutatakse)
SELECT v.nimetus, SUM(lv.kogus) AS laoseis
FROM varuosa v JOIN laduvaruosa lv ON lv.varuosaID = v.varuosaID
GROUP BY v.nimetus;

-- Milline töötaja millise remonditööga tegeles
SELECT t.nimi, r.remonditooID, r.kirjeldus, tr.status
FROM tootajaRemondis tr
JOIN tootaja t    ON t.tootajaID = tr.tootajaID
JOIN remonditoo r ON r.remonditooID = tr.remonditooID
ORDER BY r.remonditooID;

-- Töötaja ametikohtade ajalugu
SELECT t.nimi, a.nimetus AS amet, am.alguskuupaev, am.loppKuupaev
FROM ametimaaratus am
JOIN tootaja t ON t.tootajaID = am.tootajaID
JOIN amet a    ON a.ametID = am.ametID
ORDER BY t.nimi, am.alguskuupaev;

CREATE DATABASE bakaSQL;
use bakaSQL;

-- tabel loomine 
CREATE TABLE opilane(
opilaneID int PRIMARY KEY identity(1,1),
eesnimi varchar(25),
perenimi varchar(30) NOT null UNIQUE,
synniaeg date,
aadress TEXT,
kas_opib bit);
SELECT * FROM opilane; -- kuvab tabeli

-- tabeli kustutamine 
DROP TABLE opilane ;


-- andmete lisamine tabelisse opilane
INSERT INTO opilane(eesnimi, perenimi, synniaeg, kas_opib)
VALUES ('Nikita', 'Grossholm','2025-12-12', 1),
('Oleg', 'Berezevski', '2025-05-12', 1),
('Kirill', 'Fedulin', '2025-05-10', 0);
Select * from opilane;

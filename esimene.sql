CREATE DATABASE bakaSQL;
use bakaSQL;

-- tabel loomine 
CREATE TABLE opilane(
opilaneID int PRIMARY KEY identity(1,1),
eesnimi varchar(25),
perenimi varchar(30) NOT null,
synnieag date,
aadress TEXT,
kas_opib bit);
SELECT * FROM opilane;

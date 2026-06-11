create database mangud
use mangud

-- Tabel Mang 
CREATE TABLE Mang (
    MangID INT PRIMARY KEY IDENTITY(1,1),
    MangNimi VARCHAR(100) NOT NULL
);

-- tabel KyberSport
CREATE TABLE KyberSport (
    KyberSportID INT PRIMARY KEY IDENTITY(1,1),
    KyberManguNimi VARCHAR(100) NOT NULL,
    OsalejateArv INT NOT NULL,
    MangID INT,
    FOREIGN KEY (MangID) REFERENCES Mang(MangID)
);

-- tabel KyberOsaleja 
CREATE TABLE KyberOsaleja (
    OsalejaID INT PRIMARY KEY IDENTITY(1,1),
    OsalejaNimi VARCHAR(100) NOT NULL,
    Vanus INT,
    KyberSportID INT,
    FOREIGN KEY (KyberSportID) REFERENCES KyberSport(KyberSportID)
);

INSERT INTO Mang (MangNimi) VALUES 
('Shooter'),
('MOBA'),
('Strategy'),
('Racing'),
('Fighting');

GRANT SELECT, INSERT, DELETE ON KyberSport TO Yaroslav;
GRANT SELECT, INSERT, DELETE ON KyberOsaleja TO Yaroslav; 
GRANT SELECT ON Mang TO Yaroslav;

CREATE TABLE logi(
	id INT PRIMARY KEY IDENTITY(1,1),
	kasutaja VARCHAR(50) NOT NULL,
	kuupaev DATETIME,
	sisestatudAndmed VARCHAR(MAX));

select * from logi

-- Loomnine triger kustutaKyberSport
create trigger kustutaKyberSport
on KyberSport
for delete
as
insert into logi(kasutaja, kuupaev, sisestatudAndmed)
SELECT
    SYSTEM_USER, 
    GETDATE(),
    CONCAT('deleted: KyberSportID:', d.KyberSportID, ', ManguNimi: ', d.KyberManguNimi, ', OsalejateArv: ', d.OsalejateArv, ', MangID: ', m.MangNimi)
FROM deleted d
INNER JOIN Mang m ON d.MangID = m.MangID;

drop trigger kustutaKyberSport;

create trigger lisaKyberSport
on KyberSport
for insert
as
insert into logi(kasutaja, kuupaev, sisestatudAndmed)
SELECT
    SYSTEM_USER, 
    GETDATE(),
    CONCAT('inserted: KyberSportID:', i.KyberSportID, ', ManguNimi: ', i.KyberManguNimi, ', OsalejateArv: ', i.OsalejateArv, ', MangID: ', m.MangNimi)
FROM inserted i
INNER JOIN Mang m ON i.MangID = m.MangID;

select * from KyberSport;
select * from Mang

drop trigger lisaKyberSport;

--Loomine protseduur otsing1tahte
create procedure otsing1tahte
@taht char(1)
as
begin
select * from KyberSport where KyberManguNimi like @taht+'%';
end;
--kutse
exec otsing1tahte 't';


-- loomine protseduur lisaKyberMang_KyberOsalejaga, mis lisab kübermäng alati küberosalejega, sest lisada eraldi ei ole mugav
CREATE PROCEDURE lisaKyberMang_KyberOsalejaga
    @KyberManguNimi VARCHAR(100),
    @OsalejateArv INT,
    @MangID INT,
    @OsalejaNimi VARCHAR(50),
    @Vanus INT
AS
BEGIN
   
    INSERT INTO KyberSport (KyberManguNimi, OsalejateArv, MangID) 
    VALUES (@KyberManguNimi, @OsalejateArv, @MangID);
  
    INSERT INTO KyberOsaleja (OsalejaNimi, Vanus, KyberSportID) 
    VALUES (@OsalejaNimi, @Vanus, SCOPE_IDENTITY());

    SELECT * FROM KyberSport;
END;

drop procedure lisaKyberMang_KyberOsalejaga


-- protseduur kutse
EXEC lisaKyberMang_KyberOsalejaga @KyberManguNimi = 'CS 3',  @OsalejateArv = 10, @MangID = 1, @OsalejaNimi = 'S1mple2', @Vanus = 33;
 
 select * from KyberSport

-- loomine protseduur KustutaKyberMang_KyberOsalejaga mis kustutab 2 tabelist andmed KyberSropt järgi
CREATE PROCEDURE KustutaKyberMang_KyberOsalejaga
    @KyberSportID INT 
AS
BEGIN
	SELECT * FROM KyberOsaleja;
    SELECT * FROM KyberSport;
   
    DELETE FROM KyberOsaleja WHERE KyberSportID = @KyberSportID;
    DELETE FROM KyberSport WHERE KyberSportID = @KyberSportID;

	SELECT * FROM KyberOsaleja;
    SELECT * FROM KyberSport;
	
END;


drop procedure KustutaKyberMang_KyberOsalejaga

EXEC KustutaKyberMang_KyberOsalejaga @KyberSportID = 17;



-- create View mis kuvab mang Osalejaga
CREATE VIEW kuvaMangOsalejaga AS
SELECT o.OsalejaNimi, k.OsalejateArv, k.KyberManguNimi
FROM KyberOsaleja o, KyberSport k
WHERE o.KyberSportID = k.KyberSportID;

drop VIEW kuvaMangOsalejaga

select * from kuvaMangOsalejaga


-- loomine vaade mis kuvab ainult meeskonnad kus rohkem kui 5 osajalejad ja konkreetselt osaleja on täiskasvanud
CREATE VIEW taisMeeskondaMangud AS
SELECT o.OsalejaNimi, k.KyberManguNimi, k.OsalejateArv
FROM KyberOsaleja o
INNER JOIN KyberSport k ON o.KyberSportID = k.KyberSportID
WHERE k.OsalejateArv > 5 AND o.Vanus >= 18;

drop VIEW taisMeeskondaMangud

select * from taisMeeskondaMangud

-- loomine vaade mis kuvab ainult meeskonnad kus rohkem kui 5 osajalejad ja konkreetselt osaleja on laps
CREATE VIEW LapsMaakendaOsalejad AS
SELECT o.OsalejaNimi, o.Vanus, k.KyberManguNimi, k.OsalejateArv
FROM KyberOsaleja o
INNER JOIN KyberSport k ON o.KyberSportID = k.KyberSportID
WHERE k.OsalejateArv > 5 and o.Vanus < 18;

drop  VIEW LapsMaakendaOsalejad

select * from LapsMaakendaOsalejad



-- LISAMINE OMA TEGEVUS


-- drop trigger uuendaKyberSport, mis jälgib tabeli uuendamine
-- selgitus: on vaja jälgida ka uuendamine tabelis

CREATE TRIGGER uuendaKyberSport
ON KyberSport
FOR UPDATE
AS
BEGIN
    INSERT INTO logi(kasutaja, kuupaev, sisestatudAndmed)
    SELECT
        SYSTEM_USER, 
        GETDATE(),
       CONCAT( 
            'UPDATED: ',
            'VANAD ANDMED: KyberSportID: ', d.KyberSportID, ', ManguNimi: ', d.KyberManguNimi, ', OsalejateArv: ', d.OsalejateArv, ', MangID: ', m1.MangNimi, ' | ',
            'UUED ANDMED: KyberSportID: ', i.KyberSportID, ', ManguNimi: ', i.KyberManguNimi, ', OsalejateArv: ', i.OsalejateArv, ', MangID: ', m2.MangNimi
        )
    FROM deleted d
    INNER JOIN inserted i ON d.KyberSportID = i.KyberSportID
    INNER JOIN Mang m1 ON d.MangID = m1.MangID
    INNER JOIN Mang m2 ON i.MangID = m2.MangID;

end;

Update KyberSport set OsalejateArv = 5
where KyberSportID = 6 ;

drop trigger uuendaKyberSport

select * from logi


--------- Yaroslav ---------- kasutaja


select * from Mang

INSERT INTO KyberSport (KyberManguNimi, OsalejateArv, MangID) VALUES 
('Counter-Strike 2', 10, 1),
('Dota 2', 10, 2),
('StarCraft II', 2, 3),
('Minecraft', 8, 4),
('Terraria', 2, 5);

INSERT INTO KyberSport (KyberManguNimi, OsalejateArv, MangID) VALUES 
('GTA 5', 11, 5);

select * from KyberSport

delete from KyberSport where KyberSportID = 4;


INSERT INTO KyberOsaleja (OsalejaNimi, Vanus, KyberSportID) VALUES 
('s1mple', 26, 2),
('Notail', 30, 3),
('Serral', 28, 4),
('Dream', 24, 5),
('Arslan Ash', 28, 6);

SELECT * FROM KyberOsaleja

delete from KyberOsaleja where KyberSportID = 5


--kontroll

INSERT INTO Mang (MangNimi) VALUES 
('Shooter'),
('MOBA'),
('Strategy'),
('Racing'),
('Fighting');

Update KyberSport set OsalejateArv = 5
where KyberSportID = 6 ;

Update KyberOsaleja set Vanus = 29
where OsalejaID = 6 ;

select * from logi;

create table proovmang( 
id int primary key identity(1,1),
nimi VARCHAR(30));


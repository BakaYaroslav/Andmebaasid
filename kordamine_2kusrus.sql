-- connect to databases (localdb)\MSSQLLocalDB

use KordamineIKT25;

CREATE TABLE opilane(
opilaneID int primary key identity(1,1),
nimi VARCHAR(50),
isikukood char(11) not null,
ryhmID int);

CREATE TABLE ryhm(
ryhmID INT PRIMARY KEY IDENTITY(1,1),
ryhmNimi char(10) UNIQUE,
opilasteArv int);

--välisvõti -- FK

ALTER TABLE opilane ADD FOREIGN KEY (ryhmID) references ryhm(ryhmID);

-- tebali kustutamine 
--  DROP TABLE ...;


-- õiguste määramine varem tehtud kasatsjale

GRANT SELECT TO YaroslavBaka; -- saab vaadata kõik tabeleid

GRANT INSERT ON opilane TO YaroslavBaka; -- saab lisada ainult tabelisse opilane

DENY DELETE TO YaroslavBaka; 



--user YaroslavBaka
SELECT * FROM opilane, ryhm 
WHERE opilane.ryhmID=ryhm.ryhmID;


DELETE FROM opilane WHERE opilaneID =1;

INSERT INTO opilane VALUES ('Nikita', '1234567890', 1);



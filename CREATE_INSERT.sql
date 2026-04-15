Create Database Maybabaas;

--ab kustutamine
DROP Database BakaTrigger;

USE Maybabaas;
CREATE TABLE tootaja(
tootajaID int PRIMARY KEY identity(1,1), --identity - automaatselt kasvav arv +1
eesnimi varchar(15) not null,
perekonnanimi varchar(30) not null,
synniaeg date,
aadress TEXT,
koormus int CHECK (koormus>0), -- piirang, et koormus > 0
aktiivne bit)

--tabeli kuvamine
SELECT * FROM tootaja;

--tabeli andmete lisamine
INSERT INTO tootaja(perekonnanimi,eesnimi,synniaeg)
VALUES ('Ilus','Liis','2005-05-15')

INSERT INTO tootaja
VALUES ('Katja','Punane','2022-09-22','Tartu', 120, 1),
('Maksim','Petrov','2008-11-03','Narva', 200, 1);

--andmete uuendamine tabelis
UPDATE tootaja SET aadress='Tallinn', koormus=10, aktiivne=1
WHERE tootajaID=1;

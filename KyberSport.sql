CREATE DATABASE KyberSportDatabase;

USE KyberSportDatabase;

CREATE TABLE Mang(
MangID int identity(1,1) primary key,
MangNimi varchar(100) not null);

CREATE TABLE KyberSport(
KyberSportID int identity(1,1) primary key,
KyberRyhmNimi varchar(50) not null,
OsalejateArv int,
MangID int,
FOREIGN KEY (MangID) REFERENCES Mang(MangID));

CREATE TABLE KyberOsaleja(
OsalejaID int identity(1,1) primary key,
OsalejaNimi varchar(50) not null,
Vanus int,
KyberSportID int,
FOREIGN KEY (KyberSportID) REFERENCES KyberSport(KyberSportID));

GRANT SELECT, INSERT, DELETE on KyberSport TO osalejaAnastassia;
GRANT SELECT, INSERT, DELETE on KyberOsaleja TO osalejaAnastassia;
GRANT SELECT on Mang TO osalejaAnastassia;

INSERT INTO Mang
VALUES ('Paw Patrol');

INSERT INTO KyberSport
VALUES('Wolves',4,6);

INSERT INTO KyberOsaleja
VALUES('Daria',19,8);

SELECT * FROM Mang;
SELECT * FROM KyberSport;
SELECT * FROM KyberOsaleja;

Create table logi(
id int PRIMARY KEY IDENTITY (1,1),
kasutaja varchar(50),
kuupaev DATETIME,
sisestatudAndmed  text);

CREATE TRIGGER KyberSportKustutamine
ON KyberSport 
FOR DELETE
AS
INSERT INTO logi(kuupaev, kasutaja, sisestatudAndmed)
SELECT
GETDATE(),
SYSTEM_USER,
concat('Kustutatud KyberRyhmNimi: ', deleted.KyberRyhmNimi, ', OsalejateArv: ', deleted.OsalejateArv, 'MangID: ', deleted.MangID,  ' MangNimi: ', Mang.MangNimi)
FROM deleted INNER JOIN Mang ON Mang.MangID=deleted.MangID;


CREATE TRIGGER KyberSportLisamine
ON KyberSport 
FOR INSERT
AS
INSERT INTO logi(kuupaev, kasutaja, sisestatudAndmed)
SELECT
GETDATE(),
SYSTEM_USER,
concat('Sisestatud KyberRyhmNimi: ', inserted.KyberRyhmNimi, ', OsalejateArv: ', inserted.OsalejateArv, 'MangID: ', inserted.MangID  ' MangNimi: ', Mang.MangNimi)
FROM inserted INNER JOIN Mang ON Mang.MangID=inserted.MangID;


SELECT * FROM logi;

CREATE Procedure lisaOsaleja
@OsalejaNimi varchar(30),
@Vanus int,
@KyberSportID int
AS
BEGIN
	INSERT INTO KyberOsaleja(OsalejaNimi, Vanus, KyberSportID)
	VALUES (@OsalejaNimi, @Vanus, @KyberSportID);
	SELECT * FROM KyberOsaleja;
END;

EXEC lisaOsaleja 'Mark', 19,1;

CREATE procedure kustutaOsaleja
@OsalejaID int
AS
BEGIN
	SELECT * FROM KyberOsaleja;
	DELETE FROM KyberOsaleja WHERE OsalejaID=@OsalejaID;
	SELECT * FROM KyberOsaleja;
END;

EXEC kustutaOsaleja 4

CREATE procedure otsiRyhm
@taht char(1)
AS
BEGIN
	SELECT * FROM KyberSport
	WHERE KyberRyhmNimi LIKE @taht + '%';
END;

EXEC otsiRyhm 'B';

CREATE VIEW vaadeOsalejadRyhmad
AS
SELECT OsalejaNimi, KyberRyhmNimi FROM KyberOsaleja, KyberSport
WHERE KyberOsaleja.KyberSportID=KyberSport.KyberSportID;

SELECT * FROM vaadeOsalejadRyhmad;

CREATE VIEW vaadeOsalejad
AS
SELECT KyberRyhmNimi, OsalejateArv, MangNimi FROM KyberSport, Mang
WHERE KyberSport.MangID=Mang.MangID and OsalejateArv > 4;

SELECT * FROM vaadeOsalejad;

CREATE VIEW vaadeRyhmadMangud
AS
SELECT KyberRyhmNimi, MangNimi FROM KyberSport, Mang
WHERE KyberSport.MangID=Mang.MangID;

SELECT * FROM vaadeRyhmadMangud;

CREATE TABLE Saavutus(
SaavutusID int identity(1,1) primary key,
SaavutusNimi varchar(100),
KyberSportID int,
FOREIGN KEY (KyberSportID) REFERENCES KyberSport(KyberSportID));

INSERT INTO Saavutus
VALUES ('Parim meeskond',6);

SELECT * FROM Saavutus;

SELECT SaavutusNimi, KyberRyhmNimi FROM Saavutus, KyberSport
WHERE Saavutus.KyberSportID=KyberSport.KyberSportID;



--Kasutaja kontrollimine
SELECT * FROM Mang;
SELECT * FROM KyberSport;
SELECT * FROM KyberOsaleja;

INSERT INTO KyberOsaleja
VALUES('Mila',20,1);

UPDATE KyberOsaleja SET Vanus=25 WHERE OsalejaID=2;

DELETE FROM KyberOsaleja WHERE OsalejaID=2;

INSERT INTO KyberSport
VALUES('Tigers',4,1);

UPDATE KyberSport SET OsalejateArv=5 WHERE KyberSportID=2;

DELETE FROM KyberSport WHERE KyberSportID=4;

CREATE TABLE Test(
TestID int identity(1,1) primary key,
nimi varchar(50));

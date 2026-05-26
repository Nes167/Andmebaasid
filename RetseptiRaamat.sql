--Loodi andmebaas
CREATE DATABASE RetseptiRaamat;

USE RetseptiRaamat;

--Loodud tabelid
CREATE TABLE kasutaja (
kasutaja_id INT PRIMARY KEY IDENTITY(1,1),
eesnimi VARCHAR(50),
perenimi VARCHAR(50),
email VARCHAR(150));

CREATE TABLE kategooria (
kategooria_id INT PRIMARY KEY IDENTITY(1,1),
kategooria_nimi VARCHAR(50));

CREATE TABLE toiduaine (
toiduaine_id INT PRIMARY KEY IDENTITY(1,1),
toiduaine_nimi VARCHAR(100));

CREATE TABLE yhik (
yhik_id INT PRIMARY KEY IDENTITY(1,1),
yhik_nimi VARCHAR(100));

CREATE TABLE retsept (
retsept_id INT PRIMARY KEY IDENTITY(1,1),
retsepti_nimi VARCHAR(100),
kirjeldus VARCHAR(200),
juhend VARCHAR(500),
sisestatud_kp DATE,
kasutaja_id INT,
FOREIGN KEY (kasutaja_id) REFERENCES kasutaja(kasutaja_id),
kategooria_id INT,
FOREIGN KEY (kategooria_id) REFERENCES kategooria(kategooria_id));

CREATE TABLE koostis (
koostis_id INT PRIMARY KEY IDENTITY(1,1),
kogus INT,
retsept_retsept_id INT,
FOREIGN KEY (retsept_retsept_id) REFERENCES retsept(retsept_id),
toiduaine_id INT,
FOREIGN KEY (toiduaine_id) REFERENCES toiduaine(toiduaine_id),
yhik_id INT, FOREIGN KEY (yhik_id) REFERENCES yhik(yhik_id));

CREATE TABLE tehtud (
tehtud_id INT PRIMARY KEY IDENTITY(1,1),
tehtud_kp DATE,
retsept_id INT,
FOREIGN KEY (retsept_id) REFERENCES retsept(retsept_id));

SELECT * FROM kasutaja;
SELECT * FROM kategooria;
SELECT * FROM toiduaine;
SELECT * FROM yhik;
SELECT * FROM retsept;
SELECT * FROM koostis;
SELECT * FROM tehtud;

--Loodud protseduurid
CREATE Procedure lisaKasutaja
--parameetrid @...
@eesnimi varchar(50),
@perenimi varchar(50),
@email varchar(150)
AS
BEGIN
--kirjedus
	INSERT INTO kasutaja
	VALUES (@eesnimi,@perenimi,@email);
	SELECT * FROM kasutaja;
END;

--kutse
EXEC lisaKasutaja 'Maria','Petrova','maria@gmail.com';

CREATE Procedure lisaKategooria
@nimi varchar(30)
AS
BEGIN
	INSERT INTO kategooria(kategooria_nimi)
	VALUES (@nimi);
	SELECT * FROM kategooria;
END;

--kutse
EXEC lisaKategooria 'Jook';

CREATE Procedure lisaToiduaine
@nimi varchar(100)
AS
BEGIN
	INSERT INTO toiduaine(toiduaine_nimi)
	VALUES (@nimi);
	SELECT * FROM toiduaine;
END;

--kutse
EXEC lisaToiduaine 'Sool';

CREATE Procedure lisaYhik
@nimi varchar(100)
AS
BEGIN
	INSERT INTO yhik(yhik_nimi)
	VALUES (@nimi);
	SELECT * FROM yhik;
END;

--kutse
EXEC lisaYhik 'l';

CREATE PROCEDURE lisaRetsept
@nimi VARCHAR(100),
@kirjeldus VARCHAR(200),
@juhend VARCHAR(500),
@kp DATE,
@kasutaja INT,
@kategooria INT
AS
BEGIN
	INSERT INTO retsept(retsepti_nimi,kirjeldus,juhend,sisestatud_kp,kasutaja_id,kategooria_id)
	VALUES(@nimi,@kirjeldus,@juhend,@kp,@kasutaja,@kategooria);
	SELECT * FROM retsept;
END;

EXEC lisaRetsept 'Mahl','Jook', 'Vala', '2026-05-26',5,5;


CREATE PROCEDURE lisaKoostis
@kogus INT,
@retsept INT,
@toiduaine INT,
@yhik INT
AS
BEGIN
	INSERT INTO koostis(kogus,retsept_retsept_id,toiduaine_id,yhik_id)
	VALUES(@kogus,@retsept,@toiduaine,@yhik);
END;

EXEC lisaKoostis 1,5,5,4;


CREATE PROCEDURE lisaTehtud
@kuupaev DATE,
@retsept INT
AS
BEGIN
	INSERT INTO tehtud(tehtud_kp,retsept_id)
	VALUES(@kuupaev,@retsept);
	SELECT * FROM tehtud;
END;

EXEC lisaTehtud '2026-05-26',5;

--Protseduur tabeli muutmiseks
CREATE PROCEDURE muudaTabel
	@tegevus VARCHAR(10),
	@tabelinimi VARCHAR(50),
	@veerunimi VARCHAR(50),
	@tyyp VARCHAR(50)=NULL
AS
BEGIN
	DECLARE @sqltegevus VARCHAR(MAX)

	SET @sqltegevus = CASE
		WHEN @tegevus='add' THEN
			CONCAT ('ALTER TABLE ', @tabelinimi, ' ADD ', @veerunimi, ' ', @tyyp)

		WHEN @tegevus='drop' THEN
			CONCAT('ALTER TABLE ', @tabelinimi, ' DROP COLUMN ', @veerunimi)

		WHEN @tegevus='alter' THEN
			CONCAT('ALTER TABLE ', @tabelinimi, ' ALTER COLUMN ', @veerunimi, ' ', @tyyp)

		END;

	PRINT @sqltegevus;
	EXEC(@sqltegevus);

END;

EXEC muudaTabel 'add','kasutaja','telefon','varchar(20)';
EXEC muudaTabel 'alter','kasutaja','telefon','varchar(50)';
EXEC muudaTabel 'drop','kasutaja','telefon';

SELECT * FROM kasutaja;

--SELECT-päringud

--Päring kuvab kasutaja eesnime, perekonnanime ja tema retseptide nimetused.
SELECT kasutaja.eesnimi, kasutaja.perenimi, retsept.retsepti_nimi FROM kasutaja, retsept
WHERE kasutaja.kasutaja_id=retsept.kasutaja_id;

--Päring kuvab retsepti nimetuse ja sellele vastava kategooria.
SELECT retsept.retsepti_nimi,kategooria.kategooria_nimi FROM retsept, kategooria
WHERE retsept.kategooria_id=kategooria.kategooria_id;

--Päring kuvab koostises kasutatud toiduained ja nende kogused.
SELECT toiduaine.toiduaine_nimi, koostis.kogus FROM toiduaine, koostis
WHERE toiduaine.toiduaine_id=koostis.toiduaine_id;


--Lisatöö

CREATE TABLE kommentaar(
kommentaar_id INT IDENTITY(1,1) PRIMARY KEY,
tekst VARCHAR(200),
retsept_id INT,
FOREIGN KEY(retsept_id) REFERENCES retsept(retsept_id));

CREATE PROCEDURE lisaKommentaar
@tekst VARCHAR(200),
@retsept INT
AS
BEGIN
	INSERT INTO kommentaar
	VALUES(@tekst,@retsept);
	SELECT * FROM kommentaar;
END;

EXEC lisaKommentaar 'Teen uuesti', 5;

--kirjete kustutamiseks protseduur
CREATE PROCEDURE kustutaKommentaar
@id INT
AS
BEGIN
	DELETE FROM kommentaar
	WHERE kommentaar_id=@id;
	SELECT * FROM kommentaar;
END;


EXEC kustutaKommentaar 1;

--kasutaja staff õigused
--omab ligipääsu tabelitele: toiduaine, kategooria, kasutaja
GRANT SELECT ON kasutaja TO staff;
GRANT SELECT ON toiduaine TO staff;
GRANT SELECT ON kategooria TO staff;

--tohib lisada ja vaadata toiduaineid ja kategooriaid
GRANT INSERT ON toiduaine TO staff;
GRANT INSERT ON kategooria TO staff;

--ei tohi muuta ega kustutada toiduaineid ja kategooriaid
DENY UPDATE, DELETE ON toiduaine TO staff;
DENY UPDATE, DELETE ON kategooria TO staff;
--tabelis kasutaja on lubatud ainult vaatamine
DENY INSERT, UPDATE, DELETE ON kasutaja TO staff;

--kasutaja manager õigused
--omab ligipääsu kõigile tabelitele
GRANT SELECT ON kasutaja TO manager;
GRANT SELECT ON toiduaine TO manager;
GRANT SELECT ON kategooria TO manager;
GRANT SELECT ON yhik TO manager;
GRANT SELECT ON tehtud TO manager;
GRANT SELECT ON kommentaar TO manager;

--ei tohi lisada uusi toiduaineid (toiduaine) ega uusi kasutajaid (kasutaja)
DENY INSERT ON kasutaja TO manager;
DENY INSERT ON toiduaine TO manager;

--omab täielikku haldusõigust retseptidega seotud tabelites (retsept ja koostis)
GRANT SELECT, INSERT, UPDATE, DELETE ON retsept TO manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON koostis TO manager;

--Staff kontroll 
USE RetseptiRaamat;

INSERT INTO toiduaine
VALUES ('Banaan');

SELECT * FROM kasutaja;

UPDATE toiduaine SET toiduaine_nimi='Test'
WHERE toiduaine_id=1;

DELETE FROM kategooria
WHERE kategooria_id=1;

--Manager kontroll
USE RetseptiRaamat;

Insert INTO retsept
VALUES ('Test','Test','Test','2026-05-26',1,1);

SELECT * FROM retsept;

INSERT INTO kasutaja
VALUES('Test','Test','Test@gmail.com');

INSERT INTO toiduaine
VALUES('Test');






CREATE DATABASE RetseptiRaamat;

USE RetseptiRaamat;

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

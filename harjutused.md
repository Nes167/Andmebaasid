CREATE DATABASE harjutused;

USE harjutused;

CREATE TABLE harjutused(
id int primary key identity(1,1),
nimetus varchar(100),
lihasgrupp varchar(50),
korduste_arv int,
raskusaste varchar(20));

INSERT INTO harjutused
VALUES ('Plank', 'kõht', 1, 'Raske');

SELECT * FROM harjutused;

Create table logi(
id int PRIMARY KEY IDENTITY (1,1),
kuupaev DATETIME,
kasutaja varchar(30),
toiming  varchar(100), --tegevus
andmed TEXT); --tabelist harjutused

--insert triger
CREATE TRIGGER harLisamine
ON harjutused --tabelinimi, mis on vaja jälgida
FOR INSERT
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER, --kasutaja mis on sisselogitud srverisse
'on tehtud INSERT käsk',  --toiming
concat('nimetus: ', inserted.nimetus, ', lihasgrupp: ', inserted.lihasgrupp, ', korduste_arv: ', inserted.korduste_arv,', raskusaste: ', inserted.raskusaste)  --andmed tabelist harjutused
FROM inserted;

INSERT INTO harjutused
VALUES ('Burpee', 'Kogu keha', 10, 'Raske');

SELECT * FROM logi;


--UPDATE triger
CREATE TRIGGER harMuutine
ON harjutused --tabelinimi, mis on vaja jälgida
FOR UPDATE
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER, --kasutaja mis on sisselogitud serverisse
'on tehtud UPDATE käsk',  --toiming
concat('vanad andmed - nimetus: ', deleted.nimetus, ', lihasgrupp: ', deleted.lihasgrupp, 'korduste_arv: ', deleted.korduste_arv, 'raskusaste: ', deleted.raskusaste,'uued andmed - nimetus: ', inserted.nimetus, ', lihasgrupp: ', inserted.lihasgrupp, 'korduste_arv: ', inserted.korduste_arv, 'raskusaste: ', inserted.raskusaste)  --andmed tabelist harjutused
FROM deleted INNER JOIN inserted 
ON deleted.id=inserted.id;

UPDATE harjutused SET korduste_arv=30
WHERE id=1;
SELECT * FROM harjutused;
SELECT * FROM logi;

--DELETE trigger
CREATE TRIGGER harKustutamine
ON harjutused --tabelinimi, mis on vaja jälgida
FOR DELETE
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER, --kasutaja mis on sisselogitud srverisse
'on tehtud DELETE käsk',  --toiming
concat('nimetus: ', deleted.nimetus, ', lihasgrupp: ', deleted.lihasgrupp, ', korduste_arv: ', deleted.korduste_arv, ', raskusaste: ', deleted.raskusaste)  --andmed tabelist linnad
FROM deleted;

DELETE FROM harjutused WHERE id=3;
SELECT * FROM harjutused;
SELECT * FROM logi;


--Kombineerime INSERT ja DELETE triggerid
DISABLE TRIGGER harLisamine ON harjutused;
DISABLE TRIGGER harKustutamine ON harjutused;

CREATE TRIGGER harLisaKustuta
ON harjutused --tabelinimi, mis on vaja jälgida
FOR INSERT, DELETE
AS
BEGIN
SET NOCOUNT ON;
	INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
	SELECT
	GETDATE(),  --aeg
	SYSTEM_USER, --kasutaja mis on sisselogitud srverisse
	'on tehtud INSERT käsk',  --toiming
	concat('nimetus: ', inserted.nimetus, ', lihasgrupp: ', inserted.lihasgrupp, ', korduste_arv: ', inserted.korduste_arv,', raskusaste: ', inserted.raskusaste)  --andmed tabelist harjutused
	FROM inserted

	UNION ALL

	SELECT
	GETDATE(),  --aeg
	SYSTEM_USER, --kasutaja mis on sisselogitud srverisse
	'on tehtud DELETE käsk',  --toiming
	concat('nimetus: ', deleted.nimetus, ', lihasgrupp: ', deleted.lihasgrupp, ', korduste_arv: ', deleted.korduste_arv, ', raskusaste: ', deleted.raskusaste)  --andmed tabelist linnad
	FROM deleted;
END;

--kontroll
--INSERT Trigeri tegevuse kontroll
INSERT INTO harjutused
VALUES ('Hüppenöör', 'jalad', 50, 'Lihtne');

DELETE FROM harjutused WHERE id=5;
SELECT * FROM harjutused;
SELECT * FROM logi;

EXEC sp_helptext 'harKustutamine';
EXEC sp_helptext 'harLisamine';
EXEC sp_helptext 'harMuutine';

GRANT SELECT, INSERT, DELETE ON harjutused TO sekretär;
DENY SELECT, DELETE ON logi TO sekretär;



kasutaja sekretär

USE harjutused;

Select * FROM harjutused;

INSERT INTO harjutused
VALUES ('Test', 'Test', 1, 'Test');

DELETE FROM harjutused WHERE nimetus='Test';

SELECT * FROM logi;

EXEC sp_helptext 'harLisamine';

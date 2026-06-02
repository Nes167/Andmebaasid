## Trigger
### pääastik
### SQL triggerid on spetsiaalsed andmebaasi objektid, mis käivituvad automaatselt, kui toimub teatud sündmus (nt INSERT, UPDATE või DELETE).
```sql
--Trigger lisatud kirjeid jälgimiseks tabelis “linnad” – INSERT
--Jälgib andmete sisestamine tabelis linnad ja teeb vastava kirje tabelis logi

CREATE TRIGGER linnaLisamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR INSERT
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER, --kasutaja mis on sisselogitud srverisse
'on tehtud INSERT käsk',  --toiming
concat('linn: ', inserted.linnanimi, ', rahvaarv: ', inserted.rahvaarv)  --andmed tabelist linnad
FROM inserted;
```
<img width="299" height="239" alt="{1B7E24AE-420F-4208-8B7B-AB171C6DC276}" src="https://github.com/user-attachments/assets/da0b623d-8c7c-4ce4-8218-80b5b41409ec" />

```sql
--INSERT Trigeri tegevuse kontroll
INSERT INTO linnad(linnanimi, rahvaarv)
VALUES ('Narva', 350000);
SELECT * FROM linnad;
SELECT * FROM logi;
```
<img width="728" height="384" alt="{BC65EA16-AD8A-4D71-A27B-60D05A66A20B}" src="https://github.com/user-attachments/assets/9bf6175e-5e2a-4cde-9e7b-51b8c92519c7" />

```sql
--DELETE triger

CREATE TRIGGER linnaKustutamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR DELETE
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER, --kasutaja mis on sisselogitud srverisse
'on tehtud DELETE käsk',  --toiming
concat('linn: ', deleted.linnanimi, ', rahvaarv: ', deleted.rahvaarv)  --andmed tabelist linnad
FROM deleted;

--drop trigger ....
DISABLE TRIGGER linnaKustutamine ON linnad;
ENABLE TRIGGER linnaKustutamine ON linnad;

--DELETE trigeri kontroll

DELETE FROM linnad WHERE linnID=3;
SELECT * FROM linnad;
SELECT * FROM logi;
```
<img width="665" height="336" alt="{680B2896-79C2-42E6-8E40-5146F5BFB83E}" src="https://github.com/user-attachments/assets/33fa09c2-37bf-4de8-bba3-ef640686c532" />

### Kombineerime INSERT ja DELETE triggerid
### See SQL trigger linnaLisKustuta salvestab logi iga kord, kui linnade tabelis lisatakse uus linn või kustutatakse olemasolev linn. Trigger käivitub pärast INSERT või DELETE toimingut ja salvestab logisse andmed.

```sql
--Kombineerime INSERT ja DELETE triggerid
DISABLE TRIGGER linnaLisamine ON linnad;
DISABLE TRIGGER linnaKustutamine ON linnad;

CREATE TRIGGER linnaLisaKustuta
ON linnad --tabelinimi, mis on vaja jälgida
FOR INSERT, DELETE
AS
BEGIN
SET NOCOUNT ON;
	INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)

	SELECT
	GETDATE(),  --aeg
	SYSTEM_USER, --kasutaja mis on sisselogitud srverisse
	'on tehtud INSERT käsk',  --toiming
	concat('linn: ', inserted.linnanimi, ', rahvaarv: ', inserted.rahvaarv)  --andmed tabelist linnad
	FROM inserted

	UNION ALL

	SELECT
	GETDATE(),  --aeg
	SYSTEM_USER, --kasutaja mis on sisselogitud srverisse
	'on tehtud DELETE käsk',  --toiming
	concat('linn: ', deleted.linnanimi, ', rahvaarv: ', deleted.rahvaarv)  --andmed tabelist linnad
	FROM deleted;
END;

--kontroll
--INSERT Trigeri tegevuse kontroll
INSERT INTO linnad(linnanimi, rahvaarv)
VALUES ('Narva2', 200000);

DELETE FROM linnad WHERE linnID=6;
SELECT * FROM linnad;
SELECT * FROM logi;
```
<img width="626" height="341" alt="{0E346EB2-A427-4075-9A9A-C813C4DDCBCE}" src="https://github.com/user-attachments/assets/8eebc7ad-b520-4368-a64b-a3dc2663f8ef" />

### Trigger muudetud kirjeid jälgimiseks tabelis “linnad” – UPDATE
```sql
--UPDATE triger
CREATE TRIGGER linnaUuendamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR UPDATE
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER, --kasutaja mis on sisselogitud srverisse
'on tehtud UPDATE käsk',  --toiming
concat('vanad andmed - linn: ', deleted.linnanimi, ', rahvaarv: ', deleted.rahvaarv, 'uued andmed - linn: ', inserted.linnanimi, ', rahvaarv: ', inserted.rahvaarv)  --andmed tabelist linnad
FROM deleted INNER JOIN inserted 
ON deleted.linnID=inserted.linnID;

--UPDATE kontroll
UPDATE linnad SET linnanimi='Narva22', rahvaarv=0 WHERE linnanimi='Narva';
SELECT * FROM linnad;
SELECT * FROM logi;
```

<img width="675" height="320" alt="{FBA30A1E-993F-4C48-87AD-33D9DD26A9B1}" src="https://github.com/user-attachments/assets/a540bafa-bc1b-4369-961d-b2652310019e" />

### kasutaja sekretaarAnastassia, parool 12345
### Õigused - sekretaarAnastassia ei saa luua ehk muuta trigeri, ei näi tabeli logi,
### saab ainult näha, lisada ja kustutada tabelist linnad
```sql
GRANT SELECT, INSERT, DELETE ON linnad TO sekretaarAnastassia;
DENY SELECT, DELETE ON logi TO sekretaarAnastassia;
```
### kasutaja sekretaarAnastassia kontroll
```sql
SELECT * FROM logi;

INSERT INTO linnad(linnanimi, rahvaarv)
VALUES ('Narva35', 225000);

DELETE FROM linnad WHERE linnID=7;
SELECT * FROM linnad;
SELECT * FROM logi;
```



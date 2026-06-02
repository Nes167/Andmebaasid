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

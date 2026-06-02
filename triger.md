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
concat('linn: ', inserted.linnanimi, ' rahvaarv', inserted.rahvaarv)  --andmed tabelist linnad
FROM inserted;
```

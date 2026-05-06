## SQL protseduur - 
store procedure - salvestatud protseduurid - sama mis on funktsioonid programeerimises, mingi tegevus, mis on salvestatud andmebaasi ja mida saab automaatsel teha (INSERT, UPDATE, SELECT, DELETE).

```sql
--protseduur mis lisab andmeid tabelisse ja kohe kuvab neid. (INSERT, SELECT)
CREATE Procedure lisaKategooria
--parameetrid @...
@uusKategooria varchar(30)
AS
BEGIN
--kirjedus
	INSERT INTO categories(category_name)
	VALUES (@uusKategooria);
	SELECT * FROM categories;
END;
```
<img width="343" height="210" alt="{E71ADD6B-3D87-46CB-A235-B5049C59AA76}" src="https://github.com/user-attachments/assets/8bad212d-891c-4816-bd1f-c6cf97c51d00" />

```sql
--protseduur, mis kustutab kategooria id järgi
CREATE procedure kustutaKategooria
@kustutaID int
AS
BEGIN
	SELECT * FROM categories;
	DELETE FROM categories WHERE category_id=@kustutaID;
	SELECT * FROM categories;
END;

--kutse
EXEC kustutaKategooria 1
```
<img width="300" height="223" alt="{58110880-5BFE-4C6E-B60D-610F29AA0F53}" src="https://github.com/user-attachments/assets/3b3aa351-9795-4b85-8b05-a2c00b477e47" />

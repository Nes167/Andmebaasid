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

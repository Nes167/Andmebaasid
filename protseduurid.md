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

--kutse
EXEC lisaKategooria 'Auto';
```
<img width="343" height="210" alt="{E71ADD6B-3D87-46CB-A235-B5049C59AA76}" src="https://github.com/user-attachments/assets/8bad212d-891c-4816-bd1f-c6cf97c51d00" />
<img width="285" height="131" alt="{E91E16F2-34CE-44B4-B40B-26B0811E6DD7}" src="https://github.com/user-attachments/assets/cec0fde9-354d-487b-87a0-95176a57f2e0" />

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
<img width="273" height="246" alt="{93A8288A-D867-433A-A3CD-21959892AFB7}" src="https://github.com/user-attachments/assets/529e4b77-a455-4824-9659-a005298bf5bc" />

```sql
--protseduur mis kuvab kategooriad sisestatud esimese tähe järgi
CREATE procedure otsing1taht
@taht char(1)
AS
BEGIN
	SELECT * FROM categories
	WHERE category_name LIKE @taht + '%'; --% - teised sümbolid
END;

--kutse
EXEC otsing1taht 'A';
```
<img width="326" height="238" alt="{3E68E553-A791-4DDD-8A57-297461E52C64}" src="https://github.com/user-attachments/assets/216c2985-8aec-4068-908d-65783135f3c5" />
<img width="304" height="88" alt="{D0E64F0A-79B4-40D7-9BA4-C95F1587B55B}" src="https://github.com/user-attachments/assets/bd91be62-cddd-448f-8aa5-c9d5fe8a9051" />

```sql
--protseduur, mis kuvab tooded, kus on hind suurem kui sisestatud hind
CREATE procedure suuremHind
@hind int
AS
BEGIN
	SELECT * FROM products
	WHERE list_price > @hind;
END;

--kutse 
EXEC suuremHind 400;
```
<img width="265" height="109" alt="{BE22CFB6-6CE2-4787-AC21-2661B76D8482}" src="https://github.com/user-attachments/assets/d1b5512d-c48c-4da9-a787-6524c62c1796" />
<img width="469" height="129" alt="{85099C03-DA9F-40E0-88F5-C1F7E672175B}" src="https://github.com/user-attachments/assets/d4a5cf69-d112-40e3-9d4c-56292e89cd8e" />


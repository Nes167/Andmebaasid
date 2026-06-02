## SQL Server – Kasutajate autentimine ja õiguste haldamine

[Põhimõisted](README.md) | [Kasutajad](kasutaja.md) | [Kasutajad XAMPP](kasutajaXampp.md) | [Trigerid](triger.md) | [Triggerid XAMPP](trigeridXAMPP.md) | [Protseduurid](protseduurid.md) | [Võtmed/Keys](keys.md) | [Küsimused](küsimused.md)

Mis on autentimine SQL Serveris?
### Autentimine tähendab kasutaja tuvastamist ehk kontrollimist, kas kasutajal on õigus SQL Serverisse sisse logida.

**SQL Serveris kasutatakse kahte peamist autentimise tüüpi:**

1. Windows Authentication
Selle puhul kasutatakse samu kasutajaandmeid, millega logitakse sisse Windows operatsioonisüsteemi.

>Kasutajanimi ja parool on seotud Windowsiga. 
>Turvalisem lahendus. 
>Paroole haldab Windows. 
>Kasutaja ei pea eraldi SQL Serveri parooli teadma.
<img width="607" height="736" alt="image" src="https://github.com/user-attachments/assets/8fa0090e-0759-4c8e-b197-c3bb542bc1f4" />


2. SQL Server Authentication
>Selle puhul luuakse kasutaja otse SQL Serverisse.
>Kasutaja ei ole seotud Windowsiga. 
>Määratakse eraldi kasutajanimi ja parool. 
>Sobib veebirakenduste jaoks.
<img width="420" height="522" alt="image" src="https://github.com/user-attachments/assets/762e7454-ce8a-47d3-9ad3-ba63603eb6ef" />

---------------------------------------------------------------
**Näide kasutajast: DirectorAnastassia. Parool: director**
----------------------------------------------------------------
## Kasutaja loomine SQL Serveris
1. Serveritaseme kasutaja loomine (Login)
Sammud
Ava:

Security → Logins
Tee paremklikk ja vali:

New Login...

<img width="960" height="805" alt="image" src="https://github.com/user-attachments/assets/6659552b-43dc-485d-b51f-dbb6af73b638" />


Harjutamiseks võib eemaldada linnukese:  User must change password at next login.

**Server Roles**
Menüüst Server Roles saab määrata serveri üldised õigused.

Tavaliselt piisab rollist: public

<img width="958" height="806" alt="image" src="https://github.com/user-attachments/assets/e6d188c7-baeb-49ad-be6b-c5d48d8f9a61" />


2. Andmebaasi kasutaja loomine (User)
Ava:

Database → Security → Users
Tee paremklikk:  New User...

Seosta kasutaja loginiga
<img width="392" height="426" alt="image" src="https://github.com/user-attachments/assets/b0a2aae8-27da-47cb-b30c-3859e1467ea0" />


**Membership ja õigused**
Menüüst Membership saab määrata kasutaja rollid.

>db_datareader → võib lugeda SELECT

>db_datawriter → võib kirjutada INSERT, UPDATE, DELETE


<img width="962" height="547" alt="image" src="https://github.com/user-attachments/assets/2efd56d3-880a-4b43-a3a9-a1749469ac11" />


-----------------------------------------------------------------------
## Kasutaja õiguste kontroll

1. tuleb sisselogida kasutajana directorAnastassia. Connect--> Database Engine

   <img width="602" height="725" alt="image" src="https://github.com/user-attachments/assets/e79604e6-06f3-4391-ac6b-0e87a31a612d" />


2. saab tabeli sisu näha ja sisestada uus kiri.
   <img width="881" height="612" alt="image" src="https://github.com/user-attachments/assets/893851fd-54be-422c-a552-55c2bf42ef70" />


3. kontrollime tegevus, mis ei ole lubatud kasutajale, näiteks tabeli loomine.

<img width="816" height="545" alt="image" src="https://github.com/user-attachments/assets/ea201ab3-4b5e-43fa-ad9a-6ba3b829f284" />




------------------------------------------------------------------------
```
#### SQL Server Authentication Mode muutmine
Kui ilmub viga: Error 18456, siis on tavaliselt lubatud ainult Windows Authentication.
Lahendus: Server → Properties -->
Security
 Vali: SQL Server and Windows Authentication mode
```

```sql
--GRANT - õiguste määramine
--DENY - õiguste keelamine

--db_datareader -SELECT 
--db_datawriter - INSERT, DELETE, UPDATE

--anname kasutajale directorIrina õigus 
--ainult kustutada ja uuendada tabelit 
--(DELETE, UPDATE, SELECT)

GRANT DELETE ON puhkus TO directorAnastassia;
GRANT UPDATE ON puhkus TO directorAnastassia;
GRANT SELECT ON puhkus TO directorAnastassia;

--keelame INSERT
DENY INSERT ON puhkus TO directorAnastassia;

```


<img width="960" height="807" alt="image" src="https://github.com/user-attachments/assets/1a4cee0c-0bc0-432e-9e83-5c9a8a045789" />



SELECT	Lugemine
INSERT	Lisamine
UPDATE	Muutmine
DELETE	Kustutamine

<img width="750" height="398" alt="image" src="https://github.com/user-attachments/assets/3c84ab57-18e9-4dc2-a525-3df7b9a5842b" />
<img width="862" height="462" alt="image" src="https://github.com/user-attachments/assets/c89bcf56-8ba4-4bc8-bf62-96a058064934" />
<img width="803" height="758" alt="image" src="https://github.com/user-attachments/assets/705ff6a4-e6ea-4433-936c-cf4d049d16f7" />


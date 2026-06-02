# Andmebaasi võtmed (Keys)

[Põhimõisted](README.md) | [Kasutajad](kasutaja.md) | [Kasutajad XAMPP](kasutajaXampp.md) | [Trigerid](triger.md) | [Triggerid XAMPP](trigeridXAMPP.md) | [Protseduurid](protseduurid.md) | [Võtmed/Keys](keys.md) | [Küsimused](küsimused.md)

## Primary Key

Primary Key (peamine võti) on väli või väljade kogum, mis identifitseerib iga tabeli rea unikaalselt.

Kasutatakse andmete unikaalseks tuvastamiseks.

Erinevus teistest võtmetest:
Ei tohi sisaldada NULL väärtusi ja tabelis saab olla ainult üks Primary Key.

```sql
CREATE TABLE Student (
    StudentID INT identity(1,1) PRIMARY KEY,
    Nimi VARCHAR(50)
);
```

StudentID identifitseerib iga õpilase unikaalselt.

<img width="303" height="107" alt="image" src="https://github.com/user-attachments/assets/88a088d4-8706-478c-a7ab-96d5dbceddb5" />


## Foreign Key

Foreign Key (välisvõti) on väli, mis viitab teise tabeli Primary Key-le.

Kasutatakse seoste loomiseks tabelite vahel.

Erinevus teistest võtmetest:  
Ei loo ise unikaalsust, vaid ühendab andmeid.

```sql
CREATE TABLE Klass (
    KlassID INT IDENTITY(1,1) PRIMARY KEY,
    KlassNimi VARCHAR(50)
);

CREATE TABLE Opilane (
    OpilaneID INT IDENTITY(1,1) PRIMARY KEY,
    Nimi VARCHAR(50),
    KlassID INT,
    FOREIGN KEY (KlassID)
    REFERENCES Klass(KlassID)
);
```

KlassID seob õpilase tema klassiga.

<img width="341" height="107" alt="image" src="https://github.com/user-attachments/assets/f0d09d8a-d258-48de-a71a-3e66aa414ae8" />

<img width="316" height="121" alt="image" src="https://github.com/user-attachments/assets/0410c0e3-e239-4cdf-a5fd-91863bf5ab76" />


## Unique Key

Unique Key tagab, et kõik väärtused veerus on unikaalsed.

Kasutatakse korduvate väärtuste vältimiseks.

Erinevus teistest võtmetest:  
Lubab tavaliselt ühe NULL väärtuse ning tabelis võib olla mitu Unique Key-d.

```sql
CREATE TABLE Kasutaja (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Email VARCHAR(100) UNIQUE
);
```

Email peab olema igal kasutajal erinev.

<img width="366" height="180" alt="image" src="https://github.com/user-attachments/assets/5cc6f768-8c00-400a-8e60-8092af7eae6d" />


## Simple Key

Simple Key on võti, mis koosneb ainult ühest väljast.

Kasutatakse kirje unikaalseks määramiseks ühe atribuudi järgi.

Erinevus teistest võtmetest:  
Koosneb ainult ühest veerust.

```sql
CREATE TABLE Toode (
    ToodeID INT IDENTITY(1,1) PRIMARY KEY,
    Nimetus VARCHAR(50)
);
```

ToodeID on üksik võti.

<img width="370" height="162" alt="image" src="https://github.com/user-attachments/assets/3fae6bc2-60cd-4f55-b903-902994bfe981" />


## Composite Key

Composite Key koosneb kahest või enamast väljast.

Kasutatakse siis, kui üks väli ei taga unikaalsust.

Erinevus teistest võtmetest:  
Kirje identifitseeritakse mitme välja kombinatsiooniga.

```sql
CREATE TABLE Tellimus (
    TellimusID INT,
    ToodeID INT,
    PRIMARY KEY (TellimusID, ToodeID)
);
```

TellimusID ja ToodeID koos moodustavad võtme.

<img width="352" height="150" alt="image" src="https://github.com/user-attachments/assets/50fa74a3-3b2c-40af-a74b-92f5fceddf0d" />


## Compound Key

Compound Key on võti, mis koosneb mitmest väljast ja kõik osad on vajalikud.

Kasutatakse keerukamate seoste kirjeldamiseks.

Erinevus teistest võtmetest:  
Mitme välja kombinatsioon töötab ühe võtmena.

```sql
CREATE TABLE Hindamine (
    OpilaneID INT,
    AineID INT,
    PRIMARY KEY (OpilaneID, AineID)
);
```

OpilaneID ja AineID koos identifitseerivad hinde.

<img width="383" height="148" alt="image" src="https://github.com/user-attachments/assets/14c11cea-4cb5-41fd-818f-b8309c5642bf" />


## Superkey

Superkey on üks või mitu välja, mis võimaldavad kirje unikaalselt tuvastada.

Kasutatakse unikaalse identifikaatori moodustamiseks.

Erinevus teistest võtmetest:  
Võib sisaldada üleliigseid välju.

```sql
CREATE TABLE TooTaja (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Email VARCHAR(50),
    Telefon VARCHAR(20)
);
```

Näited Superkey:
(ID)  
(ID, Email)  
(ID, Email, Telefon)

ID üksi juba määrab kirje unikaalselt.

<img width="338" height="170" alt="image" src="https://github.com/user-attachments/assets/3fc8da8d-f229-4a96-b45f-5f8b8177fc0c" />

## Candidate Key

Candidate Key on võimalik kandidaat Primary Key jaoks.

Kasutatakse sobiva peamise võtme valimiseks.

Erinevus teistest võtmetest:  
Ühes tabelis võib olla mitu Candidate Key-d.

```sql
CREATE TABLE Klient (
    KlientID INT IDENTITY(1,1) PRIMARY KEY,
    Telefon VARCHAR(20) UNIQUE,
    Email VARCHAR(100) UNIQUE
);
```

Telefon ja Email võivad samuti olla kandidaatvõtmed.

<img width="332" height="202" alt="image" src="https://github.com/user-attachments/assets/06469be3-d753-48c8-a6e6-701a47556785" />


## Alternate Key

Alternate Key on Candidate Key, mida ei valitud Primary Key-ks.

Kasutatakse täiendava unikaalsuse tagamiseks.

Erinevus teistest võtmetest:  
Ei ole peamine võti.

```sql
CREATE TABLE Tootaja2(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Isikukood VARCHAR(20) UNIQUE
);
```

Isikukood on Alternate Key, sest Primary Key on ID.

<img width="338" height="158" alt="image" src="https://github.com/user-attachments/assets/72adbef2-23a6-4e4e-8905-bc472fd4ab3e" />

## Kasutatud allikad

1. GeeksforGeeks – Types of Keys in Relational Model (Primary, Foreign, Candidate, Super, Alternate, Composite jne)  
https://www.geeksforgeeks.org/types-of-keys-in-relational-model-candidate-super-primary-alternate-and-foreign/

3. SQL-võtmete tüübid
https://otus.ru/journal/kljuchi-v-sql-tablicah/

Create Database ulesanne1;

USE ulesanne1;

CREATE TABLE Liik(
liigi_kood int PRIMARY KEY identity(1,1), 
nimetus varchar(30) not null unique);

INSERT INTO Liik
VALUES ('Elektroonika'),
('Toit'),
('Riided');

SELECT * FROM Liik
SELECT * FROM Kaup
SELECT * FROM Ostja
SELECT * FROM Müük

CREATE TABLE Kaup(
kauba_kood int PRIMARY KEY identity(1,1), 
nimetus varchar(30) not null, 
liigi_kood int,
FOREIGN KEY (liigi_kood) REFERENCES Liik(liigi_kood), 
hind decimal(10,2) CHECK (hind>0));

INSERT INTO Kaup
VALUES ('Telefon', 1, 599.95),
('Sülearvuti', 1, 780.95),
('Leib', 2, 1.50),
('Piim', 2, 0.69),
('T-särk', 3, 15.95);

CREATE TABLE Müük(
müügi_kood int PRIMARY KEY identity(1,1), 
kauba_kood int, 
FOREIGN KEY (kauba_kood) REFERENCES Kaup(kauba_kood),
ostja_kood int, 
FOREIGN KEY (ostja_kood) REFERENCES Ostja(ostja_kood),
arv int, 
kuupäev date);

INSERT INTO Müük
VALUES (1,1,1,'2025-04-01','1tk'),
(3,2,2,'2025-04-25','2tk'),
(5,2,1,'2025-04-24','1tk'),
(2,1,1,'2026-03-11','2tk');

CREATE TABLE Ostja(
ostja_kood int PRIMARY KEY identity(1,1),
nimetus varchar(40) not null,
Kontakt varchar(30));

INSERT INTO Ostja
VALUES ('Milana','milana@gmail.com'),
('Jana', 'Jana@gmail.com');


--izmenenie tipa polja
ALTER TABLE Kaup
ALTER COLUMN hind decimal(12,2);

--dobavlenie polja mõõtmise ühikud v müük
ALTER TABLE Müük
ADD mõõtmise_ühikud varchar(20);

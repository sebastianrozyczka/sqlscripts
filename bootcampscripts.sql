#Tworzy tabelę pracownik(imie, nazwisko, wyplata, data urodzenia, stanowisko). W tabeli mogą być dodatkowe kolumny, które uznasz za niezbędne.
CREATE TABLE employee (
Id INT AUTO_INCREMENT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Salary DECIMAL(10,2),
BirthDate DATE,
Position VARCHAR(50));

#Wstawia do tabeli co najmniej 6 pracowników
INSERT INTO employee(FirstName, LastName, Salary, BirthDate, Position)
VALUES ('Sebastian', 'Rozyczka', 6854.69, '1997-8-09', 'Junior Java Developer'),
('Artur', 'Kowalski', 4587.02, '1993-2-02', 'Junior Software Testes'),
('Pawel', 'Nowak', 8820.54, '1990-6-06', 'Java Developer'),
('Karol', 'Fraczek', 10372.30, '1987-1-01', 'Project Manager'),
('Kasjan', 'Kowalczyk', 5902.63, '1998-12-19', 'Junior Java Developer'),
('Michal', 'Kaczorowski', 7022.05, '1991-11-28', 'Software Tester');

#Pobiera wszystkich pracowników i wyświetla ich w kolejności alfabetycznej po nazwisku
SELECT * FROM employee
ORDER BY LastName ASC;

#Pobiera pracowników na wybranym stanowisku
SELECT * FROM employee 
WHERE Position = 'Java Developer';

#Pobiera pracowników, którzy mają co najmniej 30 lat
SELECT * FROM employee 
WHERE TIMESTAMPDIFF(YEAR, BirthDate, NOW()) >= 30;

#Zwiększa wypłatę pracowników na wybranym stanowisku o 10%
UPDATE employee 
SET Salary = Salary * 0.1 + Salary
WHERE Position = 'Junior Java Developer';

#Usuwa najmłodszego pracownika
DELETE FROM employee 
ORDER BY BirthDate ASC 
LIMIT 1;

#Usuwa tabelę pracownik
DROP TABLE employee;

#Tworzy tabelę stanowisko (nazwa stanowiska, opis, wypłata na danym stanowisku)
CREATE TABLE position (
Id INT AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR(50),
Description VARCHAR(250),
Salary DECIMAL(10,2)
);

#Tworzy tabelę adres (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)
CREATE TABLE address (
Id INT AUTO_INCREMENT PRIMARY KEY,
Street VARCHAR(50),
PostCode VARCHAR(6),
City VARCHAR(50)
);

#Tworzy tabelę pracownik (imię, nazwisko) + relacje do tabeli stanowisko i adres
CREATE TABLE employee (
Id INT AUTO_INCREMENT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
AddressId INT,
PositionId INT,
FOREIGN KEY (AddressId) REFERENCES address (id),
FOREIGN KEY (PositionId) REFERENCES position (id));

#Dodaje dane testowe (w taki sposób, aby powstały pomiędzy nimi sensowne powiązania)
INSERT INTO address (Street, PostCode, City)
VALUES ('Kochanowskiego 7', '50-306', 'Wroclaw'),
('Mianowskiego 19', '01-201', 'Warszawa');
INSERT INTO position (Name, Description, Salary)
VALUES ('Java Developer', 'Specialist responsible for designing solutions and creating software.', 8170.50),
('Software Tester', 'Specialist responsible for software testing.', 6940.00);
INSERT INTO employee (FirstName, LastName, AddressId, PositionId)
VALUES ('Sebastian', 'Rozyczka', 1, 1),
('Artur', 'Kowalski', 2, 2);

#Pobiera pełne informacje o pracowniku (imię, nazwisko, adres, stanowisko)
SELECT * FROM employee
JOIN address ON address.id = employee.AddressId
JOIN position ON position.id = employee.PositionId;

#Oblicza sumę wypłat dla wszystkich pracowników w firmie
SELECT SUM(position.Salary) salaries
FROM position 
JOIN employee 
ON position.Id = employee.PositionId;

#Pobiera pracowników mieszkających w lokalizacji z kodem pocztowym 90210 (albo innym, który będzie miał sens dla Twoich danych testowych)
SELECT * FROM employee
JOIN address 
ON address.Id = employee.AddressId
WHERE address.PostCode = '50-306';

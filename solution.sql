CREATE DATABASE company_employees;
USE company_employees;

# 1. Tworzy tabelę pracownik(imie, nazwisko, wyplata, data urodzenia, stanowisko). W tabeli mogą być dodatkowe kolumny, które uznasz za niezbędne.
CREATE TABLE employee (
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(40) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    birthDate DATE NOT NULL,
    title VARCHAR(50) NOT NULL
);

# 2. Wstawia do tabeli co najmniej 6 pracowników
INSERT INTO employee (name, surname, salary, birthDate, title)
VALUES ("Tadek", "Nowak", 5555.01, '1986-06-26', "IT Specialist"),
("Adam", "Michnik", 1800, '1985-11-21', "Readwriter"),
("Przemek", "Kościelniak", 19000, '1986-08-28', "IT Specialist"),
("Aneta", "Mauer", 5555.01, '1986-12-01', "Teacher"),
("Jan", "Chryzostom-Pasek", 3000, '1989-09-12', "Baker"),
("Jan", "Nowak-Jeziorański", 13101.04, '1989-06-02', "President"),
("Angelika", "Mafija", 7000, '1989-02-10', "Helpdesk"),
("Angelika", "Nowy", 22222.22, '1986-06-26', "Helpdesk");

# 3. Pobiera wszystkich pracowników i wyświetla ich w kolejności alfabetycznej po nazwisku
SELECT * FROM employee 
ORDER BY surname ASC;

# 4. Pobiera pracowników na wybranym stanowisku
SELECT * FROM employee
WHERE title = 'IT Specialist';

# 5. Pobiera pracowników, którzy mają co najmniej 30 lat
SELECT * FROM employee
WHERE birthDate <= date_sub(curdate(), interval 30 year);

# 6. Zwiększa wypłatę pracowników na wybranym stanowisku o 10%
UPDATE employee
SET salary = (salary + salary * 0.1)
WHERE title = 'Helpdesk';

# 7. Pobiera najmłodszego pracowników (uwzględnij przypadek, że może być kilku urodzonych tego samego dnia)
SELECT * FROM employee
WHERE birthDate = (SELECT MAX(birthDate) FROM employee);

# 8. Usuwa tabelę pracownik
DROP TABLE employee;

# 9. Tworzy tabelę stanowisko (nazwa stanowiska, opis, wypłata na danym stanowisku)
CREATE TABLE title (
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    description VARCHAR(300),
    salary DECIMAL(10, 2) NOT NULL
);

# 10. Tworzy tabelę adres (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)
CREATE TABLE address (
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(60) NOT NULL,
    houseNumber VARCHAR(10) NOT NULL,
    postalCode VARCHAR(12) NOT NULL,
    city VARCHAR(60)
);

# 11. Tworzy tabelę pracownik (imię, nazwisko) + relacje do tabeli stanowisko i adres
CREATE TABLE employee (
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(40) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    addressId BIGINT,
    titleId BIGINT,
    FOREIGN KEY (addressId) REFERENCES address(id),
    FOREIGN KEY (titleId) REFERENCES title(id)
);

# 12. Dodaje dane testowe (w taki sposób, aby powstały pomiędzy nimi sensowne powiązania)
INSERT INTO title (name, description, salary)
VALUES ('Software Engineer', 'Develops and maintains software systems', 70000.33),
('Project Manager', 'Oversees and manages technology projects', 85000.44),
('Database Administrator', 'Maintains and optimizes database systems', 75000.55),
('Web Developer', 'Designs and develops websites and web applications', 65000.66),
('System Analyst', 'Analyzes and improves the efficiency of software systems', 73000.00),
('Helpdesk Support', 'Provides technical assistance and support', 50000.11);

INSERT INTO address (street, houseNumber, postalCode, city) VALUES
('Grabowa', '14A', '59300', 'Lubin'),
('Pine Road', '105', 'SW4 8LY', 'Manchester'),
('Elm Drive', '67', '90210', 'Bevery Hils'),
('Oak Avenue', '22B', 'W12 7RJ', 'Liverpool'),
('Ash Lane', '80', 'SE1 9GF', 'Leeds'),
('Birch Close', '5', 'M1 1AE', 'Bristol');

INSERT INTO employee(name, surname, addressId, titleId)
VALUES("Tadek", "Nowak", 2, 1),
("Jacek", "Podarek", 1, 3),
("Mateusz", "Cichocki", 6, 3),
("Edward", "Gierek", 2, 4),
("Adam", "Młokos", 2, 1),
("Przemek", "Żwawy", 4, 5),
("Gienia", "Mała", 2, 4),
("Hanka", "Samek", 2, 3),
("Adam", "Dobroński", 6, 1),
("Tadek", "Nowak", 2, 6);

# 13. Pobiera pełne informacje o pracowniku (imię, nazwisko, adres, stanowisko)
SELECT e.name, e.surname, a.street, a.houseNumber, a.postalCode, a.city, t.name FROM employee e
JOIN address a 
ON (e.addressId = a.id)
JOIN title t
ON (e.titleId = t.id);

# 14. Oblicza sumę wypłat dla wszystkich pracowników w firmie
SELECT SUM(t.salary) FROM employee e
JOIN title t
ON (e.titleId = t.id);

# 15. Pobiera pracowników mieszkających w lokalizacji z kodem pocztowym 90210 (albo innym, który będzie miał sens dla Twoich danych testowych)
SELECT e.name, e.surname, a.street, a.houseNumber, a.postalCode, a.city, a.* FROM employee e
JOIN address a 
ON (e.addressId = a.id)
WHERE postalCode = 'SW4 8LY'
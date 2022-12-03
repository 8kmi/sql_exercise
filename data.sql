--
-- Question 1
--
CREATE TABLE Patient(
    Mat_Pat VARCHAR(10) NOT NULL,
    Nom TEXT NOT NULL,
    Prenon TEXT NOT NULL,
    Date_Naiss DATE ,
    Groupe_Sanguin TEXT,
    Poids INT(11) , 
    Taille FLOAT ,
    Sexe  VARCHAR(5)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Maladie(
    Code_Mal VARCHAR(10) NOT NULL ,
    Designation TEXT
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Consultation(
    Num INT(11) ,
    Mat_Pat TEXT,
    Date_Cons  DATE,
    Heure_Cons TIME,
    Type_Cons  TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Suivi(
    Mat_Pat VARCHAR(10) NOT NULL ,
    Code_Mal  VARCHAR(10) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Question 3
--
ALTER TABLE Patient
    ADD adresse TEXT;

--
-- Question 4
--
ALTER TABLE Consultation
    MODIFY Type_Cons VARCHAR(30);
--
-- Question 5 : Ajout de contraintes
--

--
-- 1er tiret
--

ALTER TABLE Patient
    ADD PRIMARY KEY(Mat_Pat);

ALTER TABLE Maladie
    ADD PRIMARY KEY(Code_Mal);

ALTER TABLE Consultation
    ADD PRIMARY KEY (Num) NOT NULL AUTO_INCREMENT,
    ADD FOREIGN KEY (Mat_Pat) REFERENCES Patient (Mat_Pat);

ALTER TABLE Suivi
    ADD FOREIGN KEY (Mat_Pat) REFERENCES Patient(Mat_Pat),
    ADD FOREIGN KEY (Code_Mal) REFERENCES Maladie(Code_Mal);

--
-- 2e tiret à 5e tiret
--
ALTER TABLE Patient
    MODIFY Column Groupe_Sanguin ENUM('O-', 'O+', 'A-','A+','B-','B+','AB-','AB+'),
    ADD nom NOT NULL, prenom NOT NULL,
    MODIFY Poids INT BETWEEN 3 AND 200,
    MODIFY Column Sexe ENUM('M', 'F'),
    MODIFY Column Type_Cons ENUM('Normale', 'Contrôle', 'Domicile');


--
-- Question 6 : saisie de données
--
INSERT INTO Patient 
    VALUES
        ('120001','ABDI', 'Sami', 1960/07/01, 'A+', 60, 1.6 ,'M'),
        ('120002','BEN KHALED', 'Ahlem', 1980/04/24, 'B+', 50, 1.55 ,'F'),
        ('120003','BEN SLIMANE', 'Abdelkerim', 1980/05/16, 'O-', 68, 1.7 ,'M'),
        ('120004','GHARBI', 'Isam', 1975/06/03, 'O+', 68, 1.75 ,'M'),
        ('120005','MELKI', 'Raoudha', 1968/12/15, 'A+', 54, 1.45 ,'F'),
        ('120006','SELMI', 'Ali', 1952/11/13, 'A-', 60, 1.55 ,'M');

INSERT INTO Maladies VALUES
    ('150001','Fièvre'),
    ('150002','GRIPPE'),
    ('150003','Asthme'),
    ('150001','Diabète');

INSERT INTO Consultation VALUES
    (1,'120003','2004-04-12','08:30','NORmale'),(2,'120003','2004-05-12','15:00','Contrôle'),
    (3,'120002','2004-04-12','20:20','Domicile'),(4,'120001','2004-04-20','15:30','NORmale');

INSERT INTO Suivi VALUES
    ('120003','150002'),
    ('120002','150003'),
    ('120005','150003'),
    ('120001','150004');

COMMIT;



--
-- Question 7-a
--

SELECT nom FROM Patient;

--
-- Question 7-b
--
SELECT *  FROM Patient WHERE Groupe_Sanguin='A+';

--
-- Question 7-c
-- 
SELECT * FROM Patient WHERE Sexe='F' AND (Groupe_Sanguin='O+' OR Groupe_Sanguin='O-') AND Poids<=70;

--
-- Question 7-d
-- 
SELECT * FROM Patient WHERE Taille > 1.6 AND Poids > 62;

--
-- Question 7-e
--
SELECT nom FROM Patient WHERE date_Naiss BETWEEN 1975 AND 1985;

--
-- Question 7-f
--
SELECT * FROM Patient WHERE nom LIKE '%S%';

--
-- Question 7-g
--
SELECT * FROM Patient WHERE nom LIKE '_E%';

--
-- Question 7-h
--
SELECT * FROM Patient WHERE nom NOT LIKE 'S%' OR 'A%';

--
-- Question 7-i
--
SELECT * FROM Patient ORDER BY Poids ;

--
-- Question 7-j
--
SELECT * FROM Patient WHERE Poids = 100*Taille;

--
-- Question 7-k
--
SELECT * FROM Consultation WHERE Type_Cons = 'Domicile' AND Heure_consul > 12:00;

--
-- Requetes de jointure
--

--
-- Question 7-l
--
SELECT Nom, Prenom, Sexe, Designation FROM Patient JOIN Maladie;

--
-- Question 7-m
--
SELECT Nom, Prenom, Date_Cons ,Heure_Cons, Type_Cons FROM Patient JOIN Consultation WHERE Date_Naiss != 1980;

--
-- Question 7-n
--
SELECT Nom, Date_Cons ,Heure_Cons, Type_Cons FROM Patient JOIN Consultation

COMMIT;

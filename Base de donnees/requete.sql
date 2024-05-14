-- Création de la base de données VenteFilms
DROP DATABASE IF EXISTS VenteFilms;
CREATE DATABASE IF NOT EXISTS VenteFilms;

-- Utilisation de la base de données VenteFilms
USE VenteFilms;


-- Création de la table Films
CREATE TABLE IF NOT EXISTS Films (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(255),
    réalisateur VARCHAR(255),
    année_de_sortie INT,
    genre VARCHAR(100),
    description TEXT,
    prix DECIMAL(10,2)
);

-- Création de la table Utilisateurs
CREATE TABLE IF NOT EXISTS Utilisateurs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    mot_de_passe VARCHAR(255)
);

-- Création de la table Administrateurs
CREATE TABLE IF NOT EXISTS Administrateurs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    mot_de_passe VARCHAR(255)
);

-- Création de la table Commentaires
CREATE TABLE IF NOT EXISTS Commentaires (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_film INT,
    id_utilisateur INT,
    commentaire TEXT,
    date_commentaire TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_film) REFERENCES Films(id),
    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateurs(id)
);

-- Création de la table Paniers
CREATE TABLE IF NOT EXISTS Paniers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_utilisateur INT,
    date_ajout TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateurs(id)
);

-- Création de la table Factures
CREATE TABLE IF NOT EXISTS Factures (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_utilisateur INT,
    date_facture TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    montant_total DECIMAL(10,2),
    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateurs(id)
);

-- Création de la table Achats
CREATE TABLE IF NOT EXISTS Achats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_facture INT,
    id_film INT,
    quantite INT,
    prix_unitaire DECIMAL(10,2),
    FOREIGN KEY (id_facture) REFERENCES Factures(id),
    FOREIGN KEY (id_film) REFERENCES Films(id)
);

-- Création de la table CritereDeFiltreHistorique
CREATE TABLE IF NOT EXISTS CritereDeFiltreHistorique (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_critere VARCHAR(100),
    description TEXT
);

-- Création de la table Statistiques
CREATE TABLE IF NOT EXISTS Statistiques (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_film INT,
    nombre_de_vues INT,
    note_moyenne DECIMAL(3,2),
    FOREIGN KEY (id_film) REFERENCES Films(id)
);

-- Création de la table Personnes
CREATE TABLE IF NOT EXISTS Personnes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    date_de_naissance DATE,
    sexe ENUM('M', 'F'),
    adresse VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    mot_de_passe VARCHAR(255),
    profil ENUM('Abonne', 'Administrateur', 'Acteur', 'Producteur'),
    nombre_de_connexion INT,
    AjouedansunFilm ENUM('Oui', 'Non'),
    AproduitunFilm ENUM('Oui', 'Non')
);

-- Génération de 10 enregistrements pour la table Administrateurs
DELIMITER //
CREATE PROCEDURE PopulateAdministrateurs()
BEGIN
    DECLARE i INT DEFAULT 1;
    
    WHILE i <= 10 DO
        INSERT INTO Administrateurs (nom, email, mot_de_passe)
        VALUES (
            CONCAT('Admin', i),
            CONCAT('admin', i, '@example.com'),
            MD5(CONCAT('adminpassword', i))
        );
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

-- Appel de la procédure pour peupler la table Administrateurs
CALL PopulateAdministrateurs();

-- Génération de 50 enregistrements pour la table Personnes
DELIMITER //
CREATE PROCEDURE PopulatePersons()
BEGIN
    DECLARE i INT DEFAULT 1;
    
    WHILE i <= 50 DO
        INSERT INTO Personnes (nom, prenom, date_de_naissance, sexe, adresse, email, mot_de_passe, profil, nombre_de_connexion, AjouedansunFilm, AproduitunFilm)
        VALUES (
            CONCAT('Nom', i),
            CONCAT('Prenom', i),
            DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 50) YEAR),
            IF(RAND() > 0.5, 'M', 'F'),
            CONCAT('Adresse', i),
            CONCAT('email', i, '@example.com'),
            MD5(CONCAT('password', i)),
            CASE
                WHEN i <= 10 THEN 'Abonne'
                WHEN i BETWEEN 11 AND 20 THEN 'Administrateur'
                WHEN i BETWEEN 21 AND 40 THEN 'Acteur'
                ELSE 'Producteur'
            END,
            FLOOR(RAND() * 100),
            CASE
                WHEN i <= 40 AND (i <= 20 OR i > 30) THEN 'Non'
                ELSE IF(RAND() > 0.5, 'Oui', 'Non')
            END,
            CASE
                WHEN i > 30 THEN IF(RAND() > 0.5, 'Oui', 'Non')
                ELSE 'Non'
            END
        );
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

-- Appel de la procédure pour peupler la table Personnes
CALL PopulatePersons();

-- Génération aléatoire des enregistrements pour la table Films
INSERT INTO Films (titre, réalisateur, année_de_sortie, genre, description, prix)
SELECT
    CONCAT('Film', id),
    CONCAT('Réalisateur', id),
    YEAR(CURRENT_DATE()) - FLOOR(RAND() * 50),
    CASE 
        WHEN RAND() > 0.5 THEN 'Action'
        ELSE 'Comédie'
    END,
    CONCAT('Description du film ', id),
    RAND() * 100
FROM
    (SELECT (a.N + b.N * 10) AS id
     FROM (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS a,
          (SELECT 0 AS N UNION SELECT 1 UNION SELECT


-- Génération aléatoire des enregistrements pour les utilisateurs administrateurs
INSERT INTO Administrateurs (nom, email, mot_de_passe)
SELECT
    CONCAT('Admin', id),
    CONCAT('admin', id, '@example.com'),
    MD5(CONCAT('adminpassword', id))
FROM
    (SELECT (MAX(id) + a.N + b.N * 10) AS id
     FROM Administrateurs,
          (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3) AS a,
          (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3) AS b) AS numbers
LIMIT 4;



-- Accorder tous les privilèges aux administrateurs
GRANT ALL PRIVILEGES ON VenteFilms.* TO 'Admin1'@'localhost';
GRANT ALL PRIVILEGES ON VenteFilms.* TO 'Admin2'@'localhost';
GRANT ALL PRIVILEGES ON VenteFilms.* TO 'Admin3'@'localhost';
GRANT ALL PRIVILEGES ON VenteFilms.* TO 'Admin4'@'localhost';

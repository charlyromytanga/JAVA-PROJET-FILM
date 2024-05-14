-- ------------------------------------------------------------------------------
-- - Reconstruction de la base de données                                     ---
-- ------------------------------------------------------------------------------
DROP DATABASE IF EXISTS vente_films_en_ligne;
CREATE DATABASE vente_films_en_ligne;
USE vente_films_en_ligne;

DROP TABLE IF EXISTS T_Administrateurs;
DROP TABLE IF EXISTS T_Utilisateurs;
DROP TABLE  IF EXISTS T_films ;
DROP TABLE IF EXISTS T_Abonnes;
DROP TABLE IF EXISTS T_Personnes;
DROP TABLE IF EXISTS T_Producteurs ;
DROP TABLE IF EXISTS T_Acteurs;
DROP TABLE IF EXISTS T_Commentaires;
DROP TABLE IF EXISTS T_Factures;
DROP TABLE IF EXISTS T_Achats;
DROP TABLE IF EXISTS T_Paniers; 
DROP TABLE IF EXISTS T_CritereDeFiltreHistorique; 
DROP TABLE IF EXISTS T_Statistiques;
-- -----------------------------------------------------------------------------
-- - Construction de la table des administrateurs                            ---
-- -----------------------------------------------------------------------------
CREATE TABLE T_Administrateurs (
	IdAdministrateur	INT 			PRIMARY KEY AUTO_INCREMENT,
	-- Rights				varchar(10) 	NOT NULL,
    ConnectionNumber	INT				NOT NULL DEFAULT 0
) ENGINE = InnoDB;
-- SELECT * FROM T_Utilisateurs;


-- -----------------------------------------------------------------------------
-- - Construction de la table des utilisateurs                               ---
-- -----------------------------------------------------------------------------
CREATE TABLE T_Utilisateurs (
	idUtilisateur		INT					PRIMARY KEY AUTO_INCREMENT,
    Login				varchar(100)			NOT NULL,
    ConnectionNumber	INT					NOT NULL DEFAULT 0
) ENGINE = InnoDB;
-- SELECT * FROM T_Utlisateurs;


-- -----------------------------------------------------------------------------
-- - Construction de la tables des films en vente                         ---
-- -----------------------------------------------------------------------------
CREATE TABLE T_films (
	idfilm				INT				PRIMARY KEY AUTO_INCREMENT,
	titre				varchar(255)	NOT NULL,
    AnnéedeSortie 						INT,
	genre ENUM('Aventure', 'Animation',  'Comédie romantique', 'Romance', 'Thriller', 'Crime', 'Psychologique', 'Documentaire pour adultes', 'Documentaire pour enfants', 'Guerre', 'Histoire', 'Action', 'Comédie', 'Drame', 'Comédie dramatique', 'Fiction jeunesse', 'Film musical', 'Policier', 'Espionnage', 'Science fiction', 'Fantastique', 'Horreur', 'Western'),
    description 		TEXT,
    notefilm				INT,
    prixfilm 				DECIMAL(10,2)
) ENGINE = InnoDB;
-- SELECT * FROM T_films;


-- -----------------------------------------------------------------------------
-- - Construction de la table des abonnées                                  ---
-- -----------------------------------------------------------------------------
CREATE TABLE T_Abonnes (
	idAbonne			INT					PRIMARY KEY AUTO_INCREMENT,
    idUtilisateur		INT					UNIQUE,
    reduction			LONG,
    aUneRededuction		ENUM('Oui', 'Nom'),
    FOREIGN KEY 		(idUtilisateur) 	REFERENCES T_Utilisateurs(idUtilisateur)
) ENGINE = InnoDB;
-- SELECT * FROM T_Abonnes;


-- -----------------------------------------------------------------------------
-- - Construction de la table des Personnes                                  ---
-- -----------------------------------------------------------------------------
CREATE TABLE T_Personnes (
	idPersonne				INT 																		AUTO_INCREMENT PRIMARY KEY, 
--  idUtilisateur			INT																				UNIQUE,
--  IdAdministrateur		INT																				UNIQUE,
--  idProducteur			INT																				UNIQUE,
--  idActeur				INT																				UNIQUE,
    profilPersonne		 	ENUM('Abonne', 'Utilisateur', 'Administrateur', 'Acteur', 'Producteur')    		NOT NULL,
    nom 					VARCHAR(100) 																	NOT NULL UNIQUE,
    prenom 					VARCHAR(100)																	NOT NULL UNIQUE,
    
    DatedeNaissance 		DATE,
    sexe 					ENUM('M', 'F'),
    adresse 				VARCHAR(255),
    email 					VARCHAR(255) 																	NOT NULL UNIQUE,
    motdepasse 				VARCHAR(255)																	NOT NULL UNIQUE,
    
    
    AjouedansunFilm 		ENUM('Oui', 'Non'),
    AproduitunFilm 			ENUM('Oui', 'Non')
    
--  FOREIGN KEY 			(idUtilisateur) 																REFERENCES T_Utilisateurs(idUtilisateur),
--  FOREIGN KEY				(IdAdministrateur)																REFERENCES T_Administrateurs(IdAdministrateur),
--  FOREIGN KEY				(idProducteur)																	REFERENCES T_Producteurs(idProducteur), 
--  FOREIGN KEY				(idActeur)																		REFERENCES T_idActeurs(idActeur)

) ENGINE = InnoDB;
-- Ajout d'un index sur la colonne profilPersonne
ALTER TABLE T_Personnes ADD INDEX idx_profilPersonne (profilPersonne);
-- SELECT * FROM T_Personnes;


-- -----------------------------------------------------------------------------
-- - Construction de la table des Producteurs                                ---
-- -----------------------------------------------------------------------------
CREATE TABLE T_Producteurs (
	idProducteur		INT																			PRIMARY KEY AUTO_INCREMENT,
    idFilm				INT																			UNIQUE,
    profilPersonne		ENUM('Abonne', 'Utilisateur', 'Administrateur', 'Acteur', 'Producteur')     UNIQUE,
    
    FOREIGN KEY 		(idFilm) 																	REFERENCES T_Films(idFilm),
    FOREIGN KEY			(profilPersonne)															REFERENCES T_Personnes(profilPersonne)
) ENGINE = InnoDB;
-- SELECT * FROM T_Producteurs;



-- -----------------------------------------------------------------------------
-- - Construction de la table des acteurs                                   ---
-- -----------------------------------------------------------------------------
CREATE TABLE T_Acteurs (
	idActeur			INT																				PRIMARY KEY AUTO_INCREMENT,
    idFilm				INT																			UNIQUE,
    profilPersonne		ENUM('Abonne', 'Utilisateur', 'Administrateur', 'Acteur', 'Producteur')     UNIQUE,
    
    
    FOREIGN KEY 		(idFilm) 																	REFERENCES T_Films(idFilm),
    FOREIGN KEY			(profilPersonne)															REFERENCES T_Personnes(profilPersonne)
) ENGINE = InnoDB;
-- SELECT * FROM T_Acteurs;






-- -----------------------------------------------------------------------------
-- - Construction de la tables des commentaires                              ---
-- -----------------------------------------------------------------------------
CREATE TABLE T_Commentaires (
	idCommentaire 	INT 					AUTO_INCREMENT PRIMARY KEY,
    idfilm 			INT						UNIQUE,
    idUtilisateur 	INT						UNIQUE,
    commentaire 	VARCHAR(500)			UNIQUE,
    dateCommentaire datetime    			NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY 	(idfilm) 			REFERENCES T_Films(idfilm),
    FOREIGN KEY 	(idUtilisateur) 	REFERENCES T_Utilisateurs(idUtilisateur)
) ENGINE = InnoDB;
-- SELECT * FROM T_Commenetaires;



-- -----------------------------------------------------------------------------
-- - Construction de la table des factures                                   ---
-- -----------------------------------------------------------------------------
CREATE TABLE T_Factures (
	idFacture		INT																				PRIMARY KEY AUTO_INCREMENT,
	idUtilisateur	INT																				NOT NULL,
    montant_total 	DECIMAL(10,2)																	NOT NULL,
	dateFacture 	datetime		 																DEFAULT CURRENT_TIMESTAMP,
	profilFacture	 ENUM('Abonne', 'Utilisateur')    												UNIQUE,		
	FOREIGN KEY 	(idUtilisateur) 																REFERENCES T_Utilisateurs(idUtilisateur)
) ENGINE = InnoDB;
-- SELECT * FROM T_Facture;


-- -----------------------------------------------------------------------------
-- - Construction de la table des achats                                     ---
-- -----------------------------------------------------------------------------
CREATE TABLE T_Achats (
	idAchat		INT					PRIMARY KEY AUTO_INCREMENT,
	idFacture		INT					UNIQUE,
	idFilm			INT					UNIQUE,
	quantite		INT 				NOT NULL,
    prixUnitaire	DECIMAL(10, 2) 		NOT NULL,
    
    FOREIGN KEY 	(idFacture) 			REFERENCES T_Factures(idFacture),
    FOREIGN KEY	 	(idFilm) 				REFERENCES T_Films(idFilm)
) ENGINE = InnoDB;
-- SELECT * FROM T_Achats;



-- -----------------------------------------------------------------------------
-- - Construction de la table des paniers                                    ---
-- -----------------------------------------------------------------------------
CREATE TABLE T_Paniers (
	idPanier		INT			AUTO_INCREMENT PRIMARY KEY,
    date_ajout 		datetime 	DEFAULT CURRENT_TIMESTAMP,
    idAchat			INT			NOT NULL,
    idUtilisateur 	INT			NOT NULL,
	
	FOREIGN KEY 	(idAchat)			REFERENCES T_Achats(idAchat),
    FOREIGN KEY 	(idUtilisateur) 	REFERENCES T_Utilisateurs(idUtilisateur)
) ENGINE = InnoDB;
-- SELECT * FROM T_Paniers;


-- -----------------------------------------------------------------------------
-- - Construction de la table des CritereDeFiltreHistorique                  ---
-- -----------------------------------------------------------------------------
CREATE TABLE T_CritereDeFiltreHistorique (
	idCritereDeFiltreHistorique 			INT AUTO_INCREMENT PRIMARY KEY,
    nom_critere 							VARCHAR(200),
    description 							TEXT
) ENGINE = InnoDB;
-- SELECT * FROM T_CritereDeFiltreHistorique;



-- -----------------------------------------------------------------------------
-- - Construction de la table des Statistiques                               ---
-- -----------------------------------------------------------------------------
CREATE TABLE T_Statistiques (
	IdStatistique	INT					PRIMARY KEY AUTO_INCREMENT,
	idFilm			INT					NOT NULL,
	NombredeVue		INT,
	noteMoyenne		DECIMAL(3, 2) 		NOT NULL,
    FOREIGN KEY 	(idFilm) 			REFERENCES T_Films(idFilm)
) ENGINE = InnoDB;
-- SELECT * FROM T_Films;



-- ------------------------------------------------------------------------------
-- - Remplissage des tables de la basse de données                            ---
-- ------------------------------------------------------------------------------

-- La table : T_Administrateurs
DELIMITER //
CREATE PROCEDURE InsertRandomAdministrateurs()
BEGIN
    DECLARE i INT DEFAULT 0;

    WHILE i < 10 DO
        INSERT INTO T_Administrateurs (ConnectionNumber)
        VALUES (FLOOR(RAND() * 10)); -- Insère un nombre aléatoire entre 0 et 99 pour ConnectionNumber
        SET i = i + 1;
    END WHILE;
END//


-- table T_Utilisateurs
DELIMITER //
CREATE PROCEDURE InsertRandomUtilisateurs()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE characters VARCHAR(62) DEFAULT 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    DECLARE login_length INT DEFAULT 8; -- Longueur du login

    WHILE i < 100 DO
        -- Générer un login aléatoire
        SET @login := '';
        WHILE LENGTH(@login) < login_length DO
            SET @char := SUBSTRING(characters, FLOOR(RAND() * 62) + 1, 1);
            SET @login := CONCAT(@login, @char);
        END WHILE;

        -- Insérer l'utilisateur avec le login aléatoire et un nombre aléatoire de connexions
        INSERT INTO T_Utilisateurs (Login, ConnectionNumber)
        VALUES (@login, FLOOR(RAND() * 100));

        SET i = i + 1;
    END WHILE;
END//


-- La table de films
DELIMITER //
CREATE PROCEDURE InsertRandomFilmsWithGenreAndYearAndTitles()
BEGIN
    DECLARE idfilm INT DEFAULT 0;
    DECLARE titre VARCHAR(255);
   
	DECLARE genre ENUM('Aventure', 'Animation',  'Comédie romantique', 'Romance', 'Thriller', 'Crime', 'Psychologique', 'Documentaire pour adultes', 'Documentaire pour enfants', 'Guerre', 'Histoire', 'Action', 'Comédie', 'Drame', 'Comédie dramatique', 'Fiction jeunesse', 'Film musical', 'Policier', 'Espionnage', 'Science fiction', 'Fantastique', 'Horreur', 'Western');

    DECLARE AnnéedeSortie INT;
    DECLARE description TEXT;
    DECLARE notefilm INT;
    DECLARE prixfilm DECIMAL(10,2);

    -- Insertion des films dans la table T_films
    INSERT INTO T_films (titre, AnnéedeSortie, genre, description, notefilm, prixfilm)
    VALUES
    ('Indiana Jones et les Aventuriers de l\'arche perdue', FLOOR(RAND() * 25) + 2000, 'Aventure', 'Un archéologue intrépide part à la recherche d\'artefacts antiques.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Le Monde de Nemo', FLOOR(RAND() * 25) + 2000, 'Documentaire pour enfants', 'Un poisson clown part à la recherche de son fils perdu dans l\'océan.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Shutter Island', FLOOR(RAND() * 25) + 2000, 'Psychologique', 'Des enquêteurs découvrent des secrets sombres sur une île psychiatrique.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Scarface', FLOOR(RAND() * 25) + 2000, 'Crime', 'Un immigrant cubain monte dans le monde du crime à Miami.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Il faut sauver le soldat Ryan', FLOOR(RAND() * 25) + 2000, 'Guerre', 'Un groupe de soldats américains part à la recherche d\'un soldat disparu pendant la Seconde Guerre mondiale.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Gladiator', FLOOR(RAND() * 25) + 2000, 'Action', 'Un ancien général romain cherche à se venger de l\'assassinat de sa famille.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('La La Land', FLOOR(RAND() * 25) + 2000, 'Comédie', 'Une romance musicale à Hollywood.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Le Silence des agneaux', FLOOR(RAND() * 25) + 2000, 'Drame', 'Un agent du FBI recherche un tueur en série avec l\'aide d\'un psychopathe.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Forrest Gump', FLOOR(RAND() * 25) + 2000, 'Comédie dramatique', 'La vie extraordinaire d\'un homme simple.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Harry Potter à l\'école des sorciers', FLOOR(RAND() * 25) + 2000, 'Fiction jeunesse', 'Un jeune sorcier découvre le monde de la magie.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Les Misérables', FLOOR(RAND() * 25) + 2000, 'Film musical', 'Une adaptation musicale du célèbre roman de Victor Hugo.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Pulp Fiction', FLOOR(RAND() * 25) + 2000, 'Policier', 'Des histoires entrelacées de gangsters, de boxeurs et de tueurs.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Mission: Impossible', FLOOR(RAND() * 25) + 2000, 'Espionnage', 'Un agent secret doit déjouer une conspiration internationale.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Interstellar', FLOOR(RAND() * 25) + 2000, 'Science fiction', 'Un voyage spatial pour sauver l\'humanité.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Le Seigneur des Anneaux : La Communauté de l\'anneau', FLOOR(RAND() * 25) + 2000, 'Fantastique', 'Une quête pour détruire un anneau maléfique et sauver le monde.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('L\'Exorciste', FLOOR(RAND() * 25) + 2000, 'Horreur', 'Un prêtre catholique tente d\'exorciser un démon d\'une jeune fille possédée.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Il était une fois dans l\'Ouest', FLOOR(RAND() * 25) + 2000, 'Western', 'Une histoire de vengeance dans le Far West.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Le Parrain', FLOOR(RAND() * 25) + 2000, 'Crime', 'Le chef d\'une famille mafieuse cherche un successeur.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Les Dents de la mer', FLOOR(RAND() * 25) + 2000, 'Thriller', 'Un grand requin blanc terrorise une ville côtière.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Le Roi Lion', FLOOR(RAND() * 25) + 2000, 'Animation', 'Un jeune lion hérite du royaume et doit apprendre à devenir roi.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Inception', FLOOR(RAND() * 25) + 2000, 'Science fiction', 'Des voleurs d\'esprit plongent dans les rêves des autres pour voler des secrets.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Titanic', FLOOR(RAND() * 25) + 2000, 'Romance', 'Une histoire d\'amour épique à bord d\'un paquebot.', FLOOR(RAND() * 10) + 1, RAND() * 100),
    ('Le Fabuleux Destin d\'Amélie Poulain', FLOOR(RAND() * 25) + 2000, 'Comédie romantique', 'Une jeune femme timide cherche le bonheur à Paris.', FLOOR(RAND() * 10) + 1, RAND() * 10),
    ('Jurassic Park', FLOOR(RAND() * 25) + 2000, 'Fantastique', 'Des dinosaures ramenés à la vie dans un parc à thème.', FLOOR(RAND() * 10) + 1, RAND() * 10);
END//


-- La table Abonnes
DELIMITER //
CREATE PROCEDURE InsertRandomAbonnes()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE idUser INT;
    DECLARE reduction FLOAT;
    DECLARE aUneRededuction ENUM('Oui', 'Non');

    WHILE i < 100 DO
        -- Sélection aléatoire d'un utilisateur existant dans T_Utilisateurs
        SET idUser = (SELECT idUtilisateur FROM T_Utilisateurs ORDER BY RAND() LIMIT 1);

        -- Vérifier si l'utilisateur n'est pas déjà dans T_Abonnes
        IF NOT EXISTS (SELECT 1 FROM T_Abonnes WHERE idUtilisateur = idUser) THEN
            -- Générer une réduction aléatoire entre 0 et 0.3 (limite de 30%)
            SET reduction = RAND() * 0.3;

            SET aUneRededuction = IF(reduction > 0, 'Oui', 'Non'); -- Si reductionVal > 0, alors 'Oui' sinon 'Non'

            -- Insérer l'enregistrement dans T_Abonnes
            INSERT INTO T_Abonnes (idUtilisateur, reduction, aUneRededuction)
            VALUES (idUser, reduction, aUneRededuction);

            SET i = i + 1;
        END IF;
    END WHILE;
END//


-- La table 

DELIMITER //
CREATE PROCEDURE InsertRandomPersonnes()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE characters VARCHAR(62) DEFAULT 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    DECLARE nom_length INT DEFAULT 20; -- Longueur du nom
    DECLARE prenom_length INT DEFAULT 20; -- Longueur du prénom
    DECLARE userId INT;

    WHILE i < 100 DO
        -- Générer un nom aléatoire
        SET @nom := '';
        WHILE LENGTH(@nom) < nom_length DO
            SET @char := SUBSTRING(characters, FLOOR(RAND() * 62) + 1, 1);
            SET @nom := CONCAT(@nom, @char);
        END WHILE;

        -- Générer un prénom aléatoire
        SET @prenom := '';
        WHILE LENGTH(@prenom) < prenom_length DO
            SET @char := SUBSTRING(characters, FLOOR(RAND() * 62) + 1, 1);
            SET @prenom := CONCAT(@prenom, @char);
        END WHILE;

        -- Générer une date de naissance aléatoire
        SET @DatedeNaissance := DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 80) + 18 YEAR);

        -- Générer un sexe aléatoire
        SET @sexe := IF(RAND() < 0.5, 'M', 'F');

        -- Générer une adresse aléatoire
        SET @adresse := CONCAT(FLOOR(RAND() * 10000) + 1, ' Rue de ', SUBSTRING(characters, FLOOR(RAND() * 62) + 1, 1), SUBSTRING(characters, FLOOR(RAND() * 62) + 1, 1), SUBSTRING(characters, FLOOR(RAND() * 62) + 1, 1));

        -- Générer un email aléatoire
        SET @email := CONCAT(@prenom, '.', @nom, '@gmail.com');

        -- Générer un mot de passe aléatoire
        SET @motdepasse := CONCAT(@prenom, @nom, FLOOR(RAND() * 1000));

        -- Vérifier si l'utilisateur existe déjà dans une des colonnes référencées
        IF @profil = 'Utilisateur' THEN
            SET userId = NULL;
            SELECT idUtilisateur INTO userId FROM T_Utilisateurs WHERE idUtilisateur = i LIMIT 1;

        END IF;

        -- Générer AjouedansunFilm et AproduitunFilm selon le profil
        IF RAND() < 0.2 THEN
            SET @profil := 'Administrateur';
            SET @AjouedansunFilm := 'Non';
            SET @AproduitunFilm := 'Non';
        ELSEIF RAND() < 0.4 THEN
            SET @profil := 'Utilisateur';
            -- Vérifier si 'Utilisateur' existe déjà dans T_Personnes
            IF NOT EXISTS (SELECT 1 FROM T_Personnes WHERE profilPersonne = 'Utilisateur') THEN
                SET @AjouedansunFilm := 'Non';
                SET @AproduitunFilm := 'Non';
            ELSE
                -- Générer aléatoirement 'Abonne' ou 'Acteur' ou 'Producteur'
                SET @profil := IF(RAND() < 0.33, 'Abonne', IF(RAND() < 0.5, 'Acteur', 'Producteur'));
                SET @AjouedansunFilm := IF(@profil = 'Acteur', IF(RAND() < 0.5, 'Oui', 'Non'), 'Non');
                SET @AproduitunFilm := IF(@profil = 'Producteur', IF(RAND() < 0.5, 'Oui', 'Non'), 'Non');
            END IF;
        ELSEIF RAND() < 0.6 THEN
            SET @profil := 'Acteur';
            SET @AjouedansunFilm := IF(RAND() < 0.5, 'Oui', 'Non');
            SET @AproduitunFilm := 'Non';
        ELSEIF RAND() < 0.8 THEN
            SET @profil := 'Producteur';
            SET @AjouedansunFilm := 'Non';
            SET @AproduitunFilm := IF(RAND() < 0.5, 'Oui', 'Non');
        ELSE
            SET @profil := 'Abonne';
            SET @AjouedansunFilm := 'Non';
            SET @AproduitunFilm := 'Non';
        END IF;

        -- Insérer la personne avec les données aléatoires
        INSERT INTO T_Personnes (profilPersonne, nom, prenom, DatedeNaissance, sexe, adresse, email, motdepasse, AjouedansunFilm, AproduitunFilm)
        VALUES (@profil, @nom, @prenom, @DatedeNaissance, @sexe, @adresse, @email, @motdepasse, @AjouedansunFilm, @AproduitunFilm);

        SET i = i + 1;
    END WHILE;
END//



-- La table Producteurs:
DELIMITER //

CREATE PROCEDURE InsertRandomProducteurs()
BEGIN
    DECLARE i INT DEFAULT 0;

    -- Vérifier si la table T_Producteurs est vide
    IF NOT EXISTS (SELECT 1 FROM T_Producteurs) THEN
        WHILE i < 50 DO
            -- Générer un identifiant de film aléatoire
            SET @idFilm := (SELECT idFilm FROM T_Films ORDER BY RAND() LIMIT 1);

            -- Vérifier si le profil de personne 'Producteur' n'existe pas déjà dans T_Producteurs
            IF NOT EXISTS (SELECT 1 FROM T_Producteurs WHERE profilPersonne = 'Producteur') THEN
                -- Insérer l'enregistrement dans la table T_Producteurs
                INSERT INTO T_Producteurs (idFilm, profilPersonne) VALUES (@idFilm, 'Producteur');
                SET i = i + 1;
            END IF;
        END WHILE;
    END IF;
END //


DELIMITER ;


CALL InsertRandomAdministrateurs();
CALL InsertRandomUtilisateurs();
CALL InsertRandomFilmsWithGenreAndYearAndTitles();
CALL InsertRandomAbonnes();
CALL InsertRandomPersonnes();
CALL InsertRandomProducteurs();

-- SELECT * FROM T_Administrateurs;
-- SELECT * FROM T_Utilisateurs;
-- SELECT * FROM T_FilmsWithGenreAndYearAndTitles;
-- SELECT * FROM T_Abonnes;
-- SELECT * FROM T_Personnes;
SELECT * FROM T_Producteurs;

-- ------------------------------------------------------------------------------
-- - Création d'utilisateur de la base de  données                            ---
-- ------------------------------------------------------------------------------

-- Création des utilisateurs supplémentaires
-- CREATE USER 'charly'@'localhost' IDENTIFIED BY 'charly';
-- GRANT ALL PRIVILEGES ON Vente_films_en_lignes.* TO 'charly'@'localhost';

-- CREATE USER 'raphael'@'localhost' IDENTIFIED BY 'raphael';
-- GRANT ALL PRIVILEGES ON Vente_films_en_lignes.* TO 'raphael'@'localhost';

-- CREATE USER 'emma'@'localhost' IDENTIFIED BY 'emma';
-- GRANT ALL PRIVILEGES ON Vente_films_en_lignes.* TO 'emma'@'localhost';

--  CREATE USER 'erwann'@'localhost' IDENTIFIED BY 'erwann';
-- GRANT ALL PRIVILEGES ON Vente_films_en_lignes.* TO 'erwann'@'localhost';

-- Rafraîchissement des privilèges
-- FLUSH PRIVILEGES;

-- Visualisation de la basse de données;
-- SHOW TABLES;




-- Suppression d'un enregistrement de la table Clients
DELETE FROM Clients WHERE Id = [ID_A_SUPPRIMER];

-- Suppression d'un enregistrement de la table Administrateur
DELETE FROM Administrateur WHERE Id = [ID_A_SUPPRIMER];

-- Suppression d'un enregistrement de la table Films
DELETE FROM Films WHERE Id = [ID_A_SUPPRIMER];



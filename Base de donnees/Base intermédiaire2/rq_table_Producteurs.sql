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
-- -------------------------------------







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
    reduction			DECIMAL(3, 2),
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
    nom 					VARCHAR(100) 																	NOT NULL,
    prenom 					VARCHAR(100)																	NOT NULL,
    
    DatedeNaissance 		DATE,
    sexe 					ENUM('M', 'F'),
    adresse 				VARCHAR(255),
    email 					VARCHAR(255) 																	NOT NULL,
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
-- ------------------------------------------------------------------------------
-- - Reconstruction de la base de données                                     ---
-- ------------------------------------------------------------------------------
DROP DATABASE IF EXISTS vente_films_en_ligne;
CREATE DATABASE vente_films_en_ligne;
USE vente_films_en_ligne;

DROP TABLE IF EXISTS T_Administrateurs;
-- DROP TABLE IF EXISTS T_Utilisateurs;
-- DROP TABLE  IF EXISTS T_films ;
-- DROP TABLE IF EXISTS T_Abonnes;
-- DROP TABLE IF EXISTS T_Personnes;
-- DROP TABLE IF EXISTS T_Producteurs ;
-- DROP TABLE IF EXISTS T_Acteurs;
-- DROP TABLE IF EXISTS T_Commentaires;
-- DROP TABLE IF EXISTS T_Factures;
-- DROP TABLE IF EXISTS T_Achats;
-- DROP TABLE IF EXISTS T_Paniers; 
-- DROP TABLE IF EXISTS T_CritereDeFiltreHistorique; 
-- DROP TABLE IF EXISTS T_Statistiques;
-- -----------------------------------------------------------------------------
-- - Construction de la table des administrateurs                            ---
-- -----------------------------------------------------------------------------
CREATE TABLE T_Administrateurs (
	IdAdministrateur	INT 			PRIMARY KEY AUTO_INCREMENT,
	-- Rights				varchar(10) 	NOT NULL,
    ConnectionNumber	INT				NOT NULL DEFAULT 0
) ENGINE = InnoDB;
-- SELECT * FROM T_Utilisateurs;


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
DELIMITER;
CALL InsertRandomAdministrateurs;

-- ------------------------------------------------------------------------------
-- - Visualisation                                                            ---
-- ------------------------------------------------------------------------------
SELECT * FROM T_Administrateurs;
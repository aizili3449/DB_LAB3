-- ============================================================
-- MySQL Lab 3 : Exercices pratiques - SELECT
-- Base : bibliotheque (creee dans Lab 2)
-- ============================================================
--
-- Avant de commencer :
-- 1) Executer sql/00_compatibilite_emprunt.sql une seule fois
--    si la colonne date_fin_prevue manque dans emprunt.
-- 2) Renseigner les dates de fin prevues pour les emprunts concernes.
-- 3) Executer les requetes de ce fichier une par une.
--
-- Les cinq exercices ci-dessous reprennent les consignes du Lab 3.
-- Chaque requete est accompagnee d'un commentaire explicatif.
-- ============================================================

USE bibliotheque;

-- Verification de la base et des tables (preparation)
SELECT DATABASE();
SHOW TABLES;


-- ============================================================
-- EXERCICE 1 : Ouvrages recents
-- Consigne : recuperer les trois ouvrages les plus recemment ajoutes.
-- Hypothese donnee dans l'enonce : id incremente avec le temps.
-- ============================================================

SELECT *
FROM ouvrage
ORDER BY id DESC
LIMIT 3;


-- ============================================================
-- EXERCICE 2 : Auteurs a nom long
-- Consigne : lister les auteurs dont le nom comporte au moins
-- cinq caracteres.
-- ============================================================

SELECT *
FROM auteur
WHERE CHAR_LENGTH(nom) >= 5;


-- ============================================================
-- EXERCICE 3 : Abonnes hors domaine
-- Consigne : afficher le nom et l'email des abonnes dont l'email
-- ne provient ni de example.com ni de test.org.
-- ============================================================

SELECT nom, email
FROM abonne
WHERE email NOT LIKE '%@example.com'
  AND email NOT LIKE '%@test.org';


-- ============================================================
-- EXERCICE 4 : Emprunts en retard
-- Consigne : date de fin prevue anterieure a aujourd'hui ET
-- emprunt non encore retourne.
--
-- Adaptation necessaire au schema Lab 2 fourni :
--   date_fin_prevue : colonne ajoutee par 00_compatibilite_emprunt.sql
--   date_fin        : date de retour effective (dans Lab 2)
-- La page du cours sur NULL precise que date_fin IS NULL signifie
-- qu'un emprunt est toujours en cours.
-- ============================================================

SELECT *
FROM emprunt
WHERE date_fin_prevue < CURDATE()
  AND date_fin IS NULL;


-- ============================================================
-- EXERCICE 5 : Statistiques par auteur
-- Consigne : pour chaque auteur, compter le nombre total d'ouvrages
-- et le nombre d'ouvrages disponibles.
--
-- LEFT JOIN conserve aussi les auteurs qui n'ont aucun ouvrage.
-- COUNT(o.id) renvoie alors 0 pour ces auteurs.
-- ============================================================

SELECT
    a.id,
    a.nom,
    COUNT(o.id) AS total_ouvrages,
    SUM(CASE WHEN o.disponible = TRUE THEN 1 ELSE 0 END)
        AS ouvrages_disponibles
FROM auteur AS a
LEFT JOIN ouvrage AS o
    ON o.auteur_id = a.id
GROUP BY a.id, a.nom
ORDER BY a.id;


-- ============================================================
-- EXPORT DES CINQ RESULTATS EN CSV
--
-- Les consignes demandent de sauvegarder chaque resultat au format
-- CSV avec SELECT ... INTO OUTFILE.
--
-- Etapes :
-- 1) Executer : SHOW VARIABLES LIKE 'secure_file_priv';
-- 2) Copier le dossier autorise retourne par MySQL.
-- 3) Remplacer <DOSSIER_AUTORISE> dans chaque chemin ci-dessous.
-- 4) Decommenter et executer chaque bloc separement.
--
-- MySQL cree les fichiers sur le serveur MySQL, pas necessairement
-- dans le dossier local du projet. Copier ensuite les CSV generes
-- dans le dossier exports/ de ce depot.
--
-- ATTENTION : INTO OUTFILE refuse d'ecraser un fichier existant.
-- Utiliser un nouveau nom de fichier a chaque nouvelle execution.
-- Les exports ne sont pas executes automatiquement pour eviter
-- un echec du script si le chemin ou les permissions ne conviennent pas.
-- ============================================================

/*
-- CSV - Exercice 1
SELECT *
INTO OUTFILE '<DOSSIER_AUTORISE>/exercice1_ouvrages_recents.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM ouvrage
ORDER BY id DESC
LIMIT 3;
*/

/*
-- CSV - Exercice 2
SELECT *
INTO OUTFILE '<DOSSIER_AUTORISE>/exercice2_auteurs_nom_long.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM auteur
WHERE CHAR_LENGTH(nom) >= 5;
*/

/*
-- CSV - Exercice 3
SELECT nom, email
INTO OUTFILE '<DOSSIER_AUTORISE>/exercice3_abonnes_hors_domaine.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM abonne
WHERE email NOT LIKE '%@example.com'
  AND email NOT LIKE '%@test.org';
*/

/*
-- CSV - Exercice 4
SELECT *
INTO OUTFILE '<DOSSIER_AUTORISE>/exercice4_emprunts_en_retard.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM emprunt
WHERE date_fin_prevue < CURDATE()
  AND date_fin IS NULL;
*/

/*
-- CSV - Exercice 5
SELECT
    a.id,
    a.nom,
    COUNT(o.id) AS total_ouvrages,
    SUM(CASE WHEN o.disponible = TRUE THEN 1 ELSE 0 END)
        AS ouvrages_disponibles
INTO OUTFILE '<DOSSIER_AUTORISE>/exercice5_statistiques_auteurs.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM auteur AS a
LEFT JOIN ouvrage AS o
    ON o.auteur_id = a.id
GROUP BY a.id, a.nom
ORDER BY a.id;
*/

CREATE DATABASE sel_edweb2;
USE sel_edweb2;

--
-- Table structure for table `COMPETENCE`
--

DROP TABLE IF EXISTS `COMPETENCE`;

CREATE TABLE `COMPETENCE` (
  `ID_COMPETENCE` int(11) NOT NULL AUTO_INCREMENT,
  `NOM_COMPETENCE` varchar(45) NOT NULL COMMENT 'Nom court de la compétence',
  `DESCRIPTION_COMPETENCE` varchar(250) DEFAULT NULL COMMENT 'description longue de la compétence',
  PRIMARY KEY (`ID_COMPETENCE`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COMMENT='Table des compétences partageables';


--
-- Dumping data for table `COMPETENCE`
--

LOCK TABLES `COMPETENCE` WRITE;
/*!40000 ALTER TABLE `COMPETENCE` DISABLE KEYS */;
INSERT INTO `COMPETENCE` VALUES (1,'POESIE','Ecriture de poëmes'),(2,'ALGORITHMIE','Algorithme et complexité'),(3,'ARCHEOLOGIE','Analyses d\'oeuvres rupestres'),(4,'CUISINE','Cours de cuisine'),(5,'GOLF','Cours de golf ou partage de parcours'),(6,'BADMINTON','Techniques avancées de badminton'),(7,'CHANT','Cours de chant'),(8,'PHILOSOPHIE','Accompagnement maieutique'),(9,'JEU D\'ECHECS','Apprentissage du jeu d\'échec');
/*!40000 ALTER TABLE `COMPETENCE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MEMBRE`
--

DROP TABLE IF EXISTS `MEMBRE`;

CREATE TABLE `MEMBRE` (
                          `ID_MEMBRE` int(11) NOT NULL AUTO_INCREMENT,
                          `NOM` varchar(45) NOT NULL COMMENT 'Nom de famille',
                          `PRENOM` varchar(45) NOT NULL COMMENT 'prénom',
                          `MDP` varchar(10) NOT NULL COMMENT 'Mot de passe',
                          `LOGIN` varchar(12) NOT NULL COMMENT 'login du membre',
                          PRIMARY KEY (`ID_MEMBRE`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COMMENT='table des membres du SEL';


--
-- Dumping data for table `MEMBRE`
--

LOCK TABLES `MEMBRE` WRITE;
/*!40000 ALTER TABLE `MEMBRE` DISABLE KEYS */;
INSERT INTO `MEMBRE` VALUES (1,'TRIOLLET','ELSA','a','etriollet'),(2,'ARENDT','HANNAH','a','harendt'),(3,'DOUMANE','AMINA','a','adoumane'),(4,'HAMILTON','MARGARET','a','mhamilton'),(5,'NAMONO','CATHERINE','a','cnamono'),(6,'FRASER','ELISABETH','a','efraser');
/*!40000 ALTER TABLE `MEMBRE` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table `TALENT`
--

DROP TABLE IF EXISTS `TALENT`;

CREATE TABLE `TALENT` (
                          `ID_TALENT` int(11) NOT NULL AUTO_INCREMENT,
                          `ID_COMPETENCE` int(11) NOT NULL COMMENT 'Identifiant de la compétence ',
                          `ID_MEMBRE` int(11) NOT NULL COMMENT 'Identifiant du membre',
                          PRIMARY KEY (`ID_TALENT`),
                          KEY `fk_TALENT_1_idx` (`ID_MEMBRE`),
                          KEY `fk_TALENT_2_idx` (`ID_COMPETENCE`),
                          CONSTRAINT `fk_TALENT_1` FOREIGN KEY (`ID_MEMBRE`) REFERENCES `MEMBRE` (`ID_MEMBRE`) ON DELETE NO ACTION ON UPDATE NO ACTION,
                          CONSTRAINT `fk_TALENT_2` FOREIGN KEY (`ID_COMPETENCE`) REFERENCES `COMPETENCE` (`ID_COMPETENCE`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COMMENT='Table des talents des membres';


--
-- Dumping data for table `TALENT`
--

LOCK TABLES `TALENT` WRITE;
/*!40000 ALTER TABLE `TALENT` DISABLE KEYS */;
INSERT INTO `TALENT` VALUES (1,1,1),(2,8,1),(3,8,2),(4,5,2),(5,2,3),(6,7,3),(7,2,4),(8,4,4),(9,3,5),(10,7,6),(11,6,6);
/*!40000 ALTER TABLE `TALENT` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `ECHANGE`
--

DROP TABLE IF EXISTS `ECHANGE`;

CREATE TABLE `ECHANGE` (
  `ID_ECHANGE` int(11) NOT NULL AUTO_INCREMENT,
  `DATE_DEMANDE` date NOT NULL COMMENT 'Date à laquelle est effectuée la demande',
  `DATE_ECHANGE` date NOT NULL COMMENT 'Date à laquelle est effectuée l''échange de service',
  `ID_TALENT` int(11) NOT NULL COMMENT 'Identifiant du talent concerné par l''échange(membre/compétence)',
  `CONSOMMATEUR` int(11) NOT NULL COMMENT 'Identifiant du membre qui va consommer le service',
  `MESSAGE` varchar(45) DEFAULT NULL COMMENT 'Message laissé par le consommateur au fournisseur de service',
  `ETAT_ECHANGE` varchar(30) NOT NULL DEFAULT 'EN ATTENTE DE REPONSE' COMMENT 'Etat de l''échange',
  PRIMARY KEY (`ID_ECHANGE`),
  KEY `ECHANGE_TALENT_ID_TALENT_fk` (`ID_TALENT`),
  KEY `ECHANGE_MEMBRE_ID_MEMBRE_fk` (`CONSOMMATEUR`),
  CONSTRAINT `ECHANGE_MEMBRE_ID_MEMBRE_fk` FOREIGN KEY (`CONSOMMATEUR`) REFERENCES `MEMBRE` (`ID_MEMBRE`),
  CONSTRAINT `ECHANGE_TALENT_ID_TALENT_fk` FOREIGN KEY (`ID_TALENT`) REFERENCES `TALENT` (`ID_TALENT`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='Table des échanges de services';


--
-- Dumping data for table `ECHANGE`
--

LOCK TABLES `ECHANGE` WRITE;
/*!40000 ALTER TABLE `ECHANGE` DISABLE KEYS */;
INSERT INTO `ECHANGE` VALUES (1,'2023-06-01','2023-06-12',1,5,'Je suis impatiente de t\'écouter !','ACCEPTE'),(2,'2023-06-02','2023-06-29',2,6,'Génial !','EN ATTENTE DE REPONSE'),(3,'2023-06-02','2023-06-20',3,1,'Cool','EN ATTENTE DE REPONSE'),(4,'2023-06-03','2023-12-12',8,1,NULL,'ACCEPTE'),(5,'2023-06-03','2023-07-12',6,4,NULL,'EN ATTENTE DE REPONSE'),(6,'2023-06-03','2023-09-01',11,5,NULL,'ACCEPTE'),(7,'2023-06-03','2023-12-15',7,6,NULL,'ACCEPTE');
/*!40000 ALTER TABLE `ECHANGE` ENABLE KEYS */;
UNLOCK TABLES;

DELIMITER ;;
CREATE TRIGGER ECHANGE_BEFORE_INSERT BEFORE INSERT ON `ECHANGE` FOR EACH ROW
BEGIN
SET NEW.DATE_DEMANDE = CURDATE();
END ;;
DELIMITER ;


--
-- Final view structure for view `V_ECHANGES`
--

DROP VIEW IF EXISTS `V_ECHANGES`;

CREATE VIEW `V_ECHANGES` AS
select `ECHANGE`.`ID_ECHANGE` AS `ID_ECHANGE`,`ECHANGE`.`DATE_DEMANDE` AS `DATE_DEMANDE`,`ECHANGE`.`DATE_ECHANGE` AS `DATE_ECHANGE`,`ECHANGE`.`ETAT_ECHANGE` AS `ETAT_ECHANGE`,`F`.`ID_MEMBRE` AS `ID_FOURNISSEUR`,concat(`F`.`PRENOM`,' ',`F`.`NOM`) AS `FOURNISSEUR`,`C`.`ID_MEMBRE` AS `ID_CONSOMMATEUR`,concat(`C`.`PRENOM`,' ',`C`.`NOM`) AS `CONSOMMATEUR`,`CPT`.`ID_COMPETENCE` AS `ID_COMPETENCE`,`CPT`.`NOM_COMPETENCE` AS `NOM_COMPETENCE`,`CPT`.`DESCRIPTION_COMPETENCE` AS `DESCRIPTION_COMPETENCE`
    from ((((`ECHANGE` join `MEMBRE` `F`) join `MEMBRE` `C`) join `COMPETENCE` `CPT`) join `TALENT`) where ((`ECHANGE`.`ID_TALENT` = `TALENT`.`ID_TALENT`) and (`TALENT`.`ID_MEMBRE` = `F`.`ID_MEMBRE`) and (`ECHANGE`.`CONSOMMATEUR` = `C`.`ID_MEMBRE`) and (`TALENT`.`ID_COMPETENCE` = `CPT`.`ID_COMPETENCE`)) ;

--
-- Final view structure for view `V_TALENTS`
--

DROP VIEW IF EXISTS `V_TALENTS`;

CREATE VIEW `V_TALENTS` AS select `T`.`ID_TALENT` AS `ID_TALENT`,`T`.`ID_COMPETENCE` AS `ID_COMPETENCE`,`T`.`ID_MEMBRE` AS `ID_MEMBRE`,`C`.`NOM_COMPETENCE` AS `NOM_COMPETENCE`,concat(`M`.`PRENOM`,' ',`M`.`NOM`) AS `NOM_FOURNISSEUR`
from ((`TALENT` `T` join `COMPETENCE` `C`) join `MEMBRE` `M`) where ((`T`.`ID_MEMBRE` = `M`.`ID_MEMBRE`) and (`T`.`ID_COMPETENCE` = `C`.`ID_COMPETENCE`)) order by `M`.`NOM`,`M`.`PRENOM` ;



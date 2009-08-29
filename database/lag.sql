SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Base de données: `lag`
--
DROP DATABASE IF EXISTS `lag`;
CREATE DATABASE `lag` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci; 

USE `lag`;

-- --------------------------------------------------------
-- -------------------- SITE ------------------------------
-- --------------------------------------------------------

-- --------------------------------------------------------

--
-- Structure de la table `lan`
--
DROP TABLE IF EXISTS `lan`;
CREATE TABLE IF NOT EXISTS `lag` (
	`idLan`	int(10)	unsigned NOT NULL AUTO_INCREMENT,
	`nom` varchar(30) CHARACTER SET utf8 NOT NULL,
	`adresse` varchar(60) CHARACTER SET utf8 NOT NULL,
	`datedeb` date NOT NULL,
	`datefin` date NOT NULL,
	`nbmaxpers` int(10) NOT NULL,
	`prix` int(10) NOT NULL,
	`description` longtext CHARACTER SET utf8,
	`nbclick` int(10) unsigned,
	PRIMARY KEY(`idLan`)

)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `jeux`
--
DROP TABLE IF EXISTS `jeux`;
CREATE TABLE IF NOT EXISTS `jeux` (
	`idJeux`	int(10)	unsigned NOT NULL AUTO_INCREMENT,
	`nom` varchar(30) CHARACTER SET utf8 NOT NULL,
	`type` varchar(20) CHARACTER SET utf8 NOT NULL,
	`lien` varchar(60) CHARACTER SET utf8 NOT NULL,
	`description` longtext CHARACTER SET utf8,
	`nbclick` int(10) unsigned,
	PRIMARY KEY(`idJeux`)

)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `team`
--
DROP TABLE IF EXISTS `team`;
CREATE TABLE IF NOT EXISTS `team` (
	`idTeam`	int(10)	unsigned NOT NULL AUTO_INCREMENT,
	`nom` varchar(30) CHARACTER SET utf8 NOT NULL,
	PRIMARY KEY(`idTeam`)

)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `lanjeux`
--
DROP TABLE IF EXISTS `lanjeux`;
CREATE TABLE IF NOT EXISTS `lanjeux` (
	`idLanJeux`	int(10)	unsigned NOT NULL AUTO_INCREMENT,
	`idLan` int(10) NOT NULL,
	`idJeux` int(10) NOT NULL,
	`nbmaxteam` int(10) NOT NULL,
	`nbmaxjoueur` int(10) NOT NULL,
	`nbmaxjoueurparteam` int(10) NOT NULL,
	`ordre` int(10) NOT NULL,
	PRIMARY KEY(`idLanJeux`),
	FOREIGN KEY (`idLan`) REFERENCES `lan`(`idLan`),
	FOREIGN KEY (`idJeux`) REFERENCES `jeux`(`idJeux`)

)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `statut`
--
DROP TABLE IF EXISTS `statut`;
CREATE TABLE IF NOT EXISTS `statut` (
	`idStatut`	int(10)	unsigned NOT NULL AUTO_INCREMENT,
	`nom` varchar(30) CHARACTER SET utf8 NOT NULL,
	`ordre` int(10) NOT NULL,
	PRIMARY KEY(`idStatut`)

)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `compte`
--
DROP TABLE IF EXISTS `compte`;
CREATE TABLE IF NOT EXISTS `compte` (
	`idCompte`	int(10)	unsigned NOT NULL AUTO_INCREMENT,
	`idStatut` int(10) unsigned NOT NULL,
	`login` varchar(60) CHARACTER SET utf8 NOT NULL,
	`password` varchar(60) CHARACTER SET utf8 NOT NULL,
	`nom` varchar(30) CHARACTER SET utf8 NOT NULL,
	`prenom` varchar(30) CHARACTER SET utf8 NOT NULL,
	`datenaissance` date not null,
	`dateins` date not null,
	`dateco` date not null,
	`temps` int(10) not null,
	`ip` varchar(15) CHARACTER SET utf8 not null,
	`jeuxprefere` varchar(100) CHARACTER SET utf8,
	`site` varchar(100) CHARACTER SET utf8,
	`configpc` longtext CHARACTER SET utf8,
	`citationpreferee` varchar(140) CHARACTER SET utf8,
	`description` longtext CHARACTER SET utf8,
	`nbconnexion` int(10) unsigned,
	PRIMARY KEY(`idCompte`),
	FOREIGN KEY (`idStatut`) REFERENCES `statut`(`idStatut`)

)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `lanjeuxjoueurteam`
--
DROP TABLE IF EXISTS `lanjeuxjoueurteam`;
CREATE TABLE IF NOT EXISTS `lanjeuxjoueurteam` (
	`idLanJeuxJoueurTeam`	int(10)	unsigned NOT NULL AUTO_INCREMENT,
	`idLan` int(10) unsigned NOT NULL,
	`idJeux` int(10) unsigned NOT NULL,
	`idCompte` int(10) unsigned NOT NULL,
	`idTeam` int(10) unsigned NOT NULL,
	`dateins` date not null,
	`paiement` tinyint not null,
	`validation` bool not null,
	PRIMARY KEY(`idLanJeuxJoueurTeam`),
	FOREIGN KEY (`idLan`) REFERENCES `lan`(`idLan`),
	FOREIGN KEY (`idJeux`) REFERENCES `jeux`(`idJeux`),
	FOREIGN KEY (`idTeam`) REFERENCES `team`(`idTeam`),
	FOREIGN KEY (`idCompte`) REFERENCES `compte`(`idCompte`)

)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `charte`
--
DROP TABLE IF EXISTS `charte`;
CREATE TABLE IF NOT EXISTS `charte` (
	`idCharte`	int(10)	unsigned NOT NULL AUTO_INCREMENT,
	`idJeux` int(10) unsigned NOT NULL,
	`nom` varchar(60) CHARACTER SET utf8 NOT NULL,
	`ordre` int(10) NOT NULL,
	PRIMARY KEY(`idCharte`)

)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `chartearticle`
--
DROP TABLE IF EXISTS `chartearticle`;
CREATE TABLE IF NOT EXISTS `chartearticle` (
	`idCharteArticle`	int(10)	unsigned NOT NULL AUTO_INCREMENT,
	`idCharte` int(10) unsigned NOT NULL,
	`titre` varchar(60) CHARACTER SET utf8 NOT NULL,
	`description` longtext CHARACTER SET utf8,
	`ordre` int(10) NOT NULL,
	PRIMARY KEY(`idCharteArticle`),
	FOREIGN KEY (`idCharte`) REFERENCES `charte`(`idCharte`)

)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `news`
--
DROP TABLE IF EXISTS `news`;
CREATE TABLE IF NOT EXISTS `news` (
	`idNews`	int(10)	unsigned NOT NULL AUTO_INCREMENT,
	`idCompte` int(10) unsigned NOT NULL,
	`titre` varchar(60) CHARACTER SET utf8 NOT NULL,
	`date` date NOT NULL,
	`description` longtext CHARACTER SET utf8,
	PRIMARY KEY(`idNews`)

)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `newscom`
--
DROP TABLE IF EXISTS `newscom`;
CREATE TABLE IF NOT EXISTS `newscom` (
	`idNewsCom`	int(10)	unsigned NOT NULL AUTO_INCREMENT,
	`idNews` int(10) unsigned NOT NULL,
	`idCompte` int(10) unsigned NOT NULL,
	`date` date NOT NULL,
	`description` longtext CHARACTER SET utf8,
	PRIMARY KEY(`idNewsCom`),
	FOREIGN KEY (`idNews`) REFERENCES `news`(`idNews`),
	FOREIGN KEY (`idCompte`) REFERENCES `compte`(`idCompte`)

)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `multimedia`
--
DROP TABLE IF EXISTS `multimedia`;
CREATE TABLE IF NOT EXISTS `multimedia` (
	`idMultimedia`	int(10)	unsigned NOT NULL AUTO_INCREMENT,
	`titre` varchar(60) CHARACTER SET utf8 NOT NULL,
	`type` varchar(40) CHARACTER SET utf8 NOT NULL,
	`date` date NOT NULL,
	`lien` varchar(120) CHARACTER SET utf8,
	`description` longtext CHARACTER SET utf8,
	`nbclick` int(10) unsigned,
	PRIMARY KEY(`idMultimedia`)

)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `multimediacom`
--
DROP TABLE IF EXISTS `multimediacom`;
CREATE TABLE IF NOT EXISTS `multimediacom` (
	`idMultimediaCom`	int(10)	unsigned NOT NULL AUTO_INCREMENT,
	`idMultimedia` int(10) unsigned NOT NULL,
	`idCompte` int(10) unsigned NOT NULL,
	`date` date NOT NULL,
	`description` longtext CHARACTER SET utf8,
	PRIMARY KEY(`idMultimediaCom`),
	FOREIGN KEY (`idMultimedia`) REFERENCES `multimedia`(`idMultimedia`)

)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `fonction`
--
DROP TABLE IF EXISTS `fonction`;
CREATE TABLE IF NOT EXISTS `fonction` (
	`idFonction`	int(10)	unsigned NOT NULL AUTO_INCREMENT,
	`nom` varchar(40) CHARACTER SET utf8 NOT NULL,
	`ordre` int(10) NOT NULL,
	PRIMARY KEY(`idFonction`)

)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `fonctioncompte`
--
DROP TABLE IF EXISTS `fonctioncompte`;
CREATE TABLE IF NOT EXISTS `fonctioncompte` (
	`idFonctionCompte`	int(10)	unsigned NOT NULL AUTO_INCREMENT,
	`idFonction` int(10) unsigned NOT NULL,
	`idCompte` int(10) unsigned NOT NULL,
	PRIMARY KEY(`idFonctionCompte`),
	FOREIGN KEY (`idFonction`) REFERENCES `fonction`(`idFonction`),
	FOREIGN KEY (`idCompte`) REFERENCES `compte`(`idCompte`)

)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `mentionlegale`
--
DROP TABLE IF EXISTS `mentionlegale`;
CREATE TABLE IF NOT EXISTS `mentionlegale` (
	`idMentionLegale`	int(10)	unsigned NOT NULL AUTO_INCREMENT,
	`titre` varchar(40) CHARACTER SET utf8 NOT NULL,
	`description` longtext CHARACTER SET utf8,
	`ordre` int(10),
	PRIMARY KEY(`idMentionLegale`)

)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `materiel`
--
DROP TABLE IF EXISTS `materiel`;
CREATE TABLE IF NOT EXISTS `materiel` (
	`idMateriel`	int(10)	unsigned NOT NULL AUTO_INCREMENT,
	`nom` varchar(40) CHARACTER SET utf8 NOT NULL,
	`type` varchar(40) CHARACTER SET utf8 NOT NULL,
	`dateachat` date NOT NULL,
	`description` longtext CHARACTER SET utf8,
	`ordre` int(10),
	`img` varchar(200) CHARACTER SET utf8,
	PRIMARY KEY(`idMateriel`)

)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `bug`
--
DROP TABLE IF EXISTS `bug`;
CREATE TABLE IF NOT EXISTS `bug` (
	`idBug` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`idCompte` int(10) unsigned NOT NULL,
	`titre` varchar(60) CHARACTER SET utf8 NOT NULL,
	`datebug` date NOT NULL,
	`datedebug` date NOT NULL,
	`statut` varchar(20) CHARACTER SET utf8 NOT NULL,
	`priorite` int(11) NOT NULL,
	`categorie` varchar(30) CHARACTER SET utf8 NOT NULL,
	`navigateur` varchar(20) CHARACTER SET utf8 NOT NULL,
	`description` longtext CHARACTER SET utf8 NOT NULL,
	`noteDebugger` longtext CHARACTER SET utf8 NOT NULL,
	PRIMARY KEY (`idBug`),
	FOREIGN KEY (`idCompte`) REFERENCES `compte`(`idCompte`)

)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `config`
--

DROP TABLE IF EXISTS `config`;
CREATE TABLE IF NOT EXISTS `config` (
    `idConfig` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `titre` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
    `cle` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
    `valeur` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
    PRIMARY KEY (`idConfig`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1 ;


-- --------------------------------------------------------
-- ------------------- FORUM ------------------------------
-- --------------------------------------------------------

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE IF NOT EXISTS `categorie` (
    `idCategorie` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `titre` varchar(60) CHARACTER SET utf8 NOT NULL,
    `description` longtext CHARACTER SET utf8 NOT NULL,
    `visible` tinyint NOT NULL,
    `ordre` int(10) NOT NULL,
    PRIMARY KEY (`idCategorie`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `souscategorie`
--

DROP TABLE IF EXISTS `souscategorie`;
CREATE TABLE IF NOT EXISTS `souscategorie` (
    `idSousCategorie` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `idCategorie` int(10) unsigned NOT NULL,
    `titre` varchar(60) CHARACTER SET utf8 NOT NULL,
    `description` longtext CHARACTER SET utf8 NOT NULL,
    `visible` tinyint NOT NULL,
    `ordre` int(10) NOT NULL,
    PRIMARY KEY (`idSousCategorie`),
	FOREIGN KEY (`idCategorie`) REFERENCES `categorie`(`idCategorie`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `sujet`
--

DROP TABLE IF EXISTS `sujet`;
CREATE TABLE IF NOT EXISTS `sujet` (
    `idSujet` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `idSousCategorie` int(10) unsigned NOT NULL,
    `idCompte` int(10) unsigned NOT NULL,
    `titre` varchar(60) CHARACTER SET utf8 NOT NULL,
    `date` date NOT NULL,
    `vu` bool NOT NULL,
    `ip` varchar(15) CHARACTER SET utf8 NOT NULL,
    `visible` tinyint NOT NULL,
	`nbvue` int(10) unsigned,
    PRIMARY KEY (`idSujet`),
	FOREIGN KEY (`idSousCategorie`) REFERENCES `souscategorie`(`idSousCategorie`),
	FOREIGN KEY (`idCompte`) REFERENCES `compte`(`idCompte`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `message`
--

DROP TABLE IF EXISTS `message`;
CREATE TABLE IF NOT EXISTS `message` (
    `idMessage` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `idSujet` int(10) unsigned NOT NULL,
    `idCompte` int(10) unsigned NOT NULL,
    `date` date NOT NULL,
    `description` longtext CHARACTER SET utf8 NOT NULL,
    `ip` varchar(15) CHARACTER SET utf8 NOT NULL,
    PRIMARY KEY (`idMessage`),
	FOREIGN KEY (`idSujet`) REFERENCES `sujet`(`idSujet`),
	FOREIGN KEY (`idCompte`) REFERENCES `compte`(`idCompte`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------
-- ------------------ EXTERNE -----------------------------
-- --------------------------------------------------------

-- --------------------------------------------------------

--
-- Structure de la table `partenaire`
--

DROP TABLE IF EXISTS `partenaire`;
CREATE TABLE IF NOT EXISTS `partenaire` (
  `idPartenaire` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `titre` varchar(60) CHARACTER SET utf8 NOT NULL,
  `date` date NOT NULL,
  `nbclick` int(10) NOT NULL,
  `type` varchar(60) CHARACTER SET utf8 NOT NULL,
  `lien` varchar(60) CHARACTER SET utf8 NOT NULL,
  `logo` varchar(200) CHARACTER SET utf8 NOT NULL,
  `description` longtext CHARACTER SET utf8 NOT NULL,
  `ordre` int(10) NOT NULL,
  PRIMARY KEY (`idPartenaire`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `lien`
--

DROP TABLE IF EXISTS `lien`;
CREATE TABLE IF NOT EXISTS `lien` (
  `idLien` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `titre` varchar(60) CHARACTER SET utf8 NOT NULL,
  `lien` varchar(60) CHARACTER SET utf8 NOT NULL,
  `ordre` int(10) NOT NULL,
  PRIMARY KEY (`idLien`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `contact`
--

DROP TABLE IF EXISTS `contact`;
CREATE TABLE IF NOT EXISTS `contact` (
  `idContact` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `titre` varchar(60) CHARACTER SET utf8 NOT NULL,
  `mail` varchar(60) CHARACTER SET utf8 NOT NULL,
  `type` varchar(60) CHARACTER SET utf8 NOT NULL,
  `date` date NOT NULL,
  `description` longtext CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`idContact`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1 ;

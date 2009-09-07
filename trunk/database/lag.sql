-- phpMyAdmin SQL Dump
-- version 3.1.3.1
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- Généré le : Lun 07 Septembre 2009 à 17:38
-- Version du serveur: 5.1.33
-- Version de PHP: 5.2.9-2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Base de données: `lag`
--
DROP DATABASE `lag`;
CREATE DATABASE `lag` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `lag`;

-- --------------------------------------------------------

--
-- Structure de la table `bug`
--

DROP TABLE IF EXISTS `bug`;
CREATE TABLE IF NOT EXISTS `bug` (
  `idBug` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idCompte` int(10) unsigned NOT NULL,
  `titre` varchar(60) NOT NULL,
  `datebug` date NOT NULL,
  `datedebug` date NOT NULL,
  `statut` varchar(20) NOT NULL,
  `priorite` int(11) NOT NULL,
  `categorie` varchar(30) NOT NULL,
  `navigateur` varchar(20) NOT NULL,
  `description` longtext NOT NULL,
  `noteDebugger` longtext NOT NULL,
  PRIMARY KEY (`idBug`),
  KEY `idCompte` (`idCompte`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `bug`
--


-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE IF NOT EXISTS `categorie` (
  `idCategorie` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `titre` varchar(60) NOT NULL,
  `description` longtext NOT NULL,
  `visible` tinyint(4) NOT NULL,
  `ordre` int(10) NOT NULL,
  PRIMARY KEY (`idCategorie`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `categorie`
--


-- --------------------------------------------------------

--
-- Structure de la table `charte`
--

DROP TABLE IF EXISTS `charte`;
CREATE TABLE IF NOT EXISTS `charte` (
  `idCharte` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idJeux` int(10) unsigned NOT NULL,
  `nom` varchar(60) NOT NULL,
  `ordre` int(10) NOT NULL,
  PRIMARY KEY (`idCharte`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `charte`
--


-- --------------------------------------------------------

--
-- Structure de la table `chartearticle`
--

DROP TABLE IF EXISTS `chartearticle`;
CREATE TABLE IF NOT EXISTS `chartearticle` (
  `idCharteArticle` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idCharte` int(10) unsigned NOT NULL,
  `titre` varchar(60) NOT NULL,
  `description` longtext,
  `ordre` int(10) NOT NULL,
  PRIMARY KEY (`idCharteArticle`),
  KEY `idCharte` (`idCharte`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `chartearticle`
--


-- --------------------------------------------------------

--
-- Structure de la table `compte`
--

DROP TABLE IF EXISTS `compte`;
CREATE TABLE IF NOT EXISTS `compte` (
  `idCompte` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idGrade` int(10) unsigned NOT NULL,
  `login` varchar(60) NOT NULL,
  `password` varchar(60) NOT NULL,
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(30) NOT NULL,
  `email` varchar(60) NOT NULL,
  `datenaissance` date NOT NULL,
  `dateins` date NOT NULL,
  `dateco` date NOT NULL,
  `temps` int(10) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `jeuxprefere` varchar(100) DEFAULT NULL,
  `site` varchar(100) DEFAULT NULL,
  `configpc` longtext,
  `citationpreferee` varchar(140) DEFAULT NULL,
  `description` longtext,
  `nbconnexion` int(10) unsigned DEFAULT NULL,
  `keyvalidation` varchar(8) DEFAULT NULL,
  `actif` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`idCompte`),
  KEY `idGrade` (`idGrade`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `compte`
--

INSERT INTO `compte` (`idCompte`, `idGrade`, `login`, `password`, `nom`, `prenom`, `email`, `datenaissance`, `dateins`, `dateco`, `temps`, `ip`, `jeuxprefere`, `site`, `configpc`, `citationpreferee`, `description`, `nbconnexion`, `keyvalidation`, `actif`) VALUES
(1, 1, 'sieg', '6ae357dc98f739341238fc52aea9d00d', 'Méhault', 'Maxime', 'lag.sieg@gmail.com', '1988-02-09', '2009-09-06', '2009-09-07', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `config`
--

DROP TABLE IF EXISTS `config`;
CREATE TABLE IF NOT EXISTS `config` (
  `idConfig` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `titre` varchar(60) DEFAULT NULL,
  `cle` varchar(45) DEFAULT NULL,
  `valeur` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`idConfig`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `config`
--


-- --------------------------------------------------------

--
-- Structure de la table `contact`
--

DROP TABLE IF EXISTS `contact`;
CREATE TABLE IF NOT EXISTS `contact` (
  `idContact` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `titre` varchar(60) NOT NULL,
  `mail` varchar(60) NOT NULL,
  `type` varchar(60) NOT NULL,
  `date` date NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`idContact`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `contact`
--


-- --------------------------------------------------------

--
-- Structure de la table `fonction`
--

DROP TABLE IF EXISTS `fonction`;
CREATE TABLE IF NOT EXISTS `fonction` (
  `idFonction` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(40) NOT NULL,
  `ordre` int(10) NOT NULL,
  `afficher` tinyint(1) DEFAULT NULL,
  `sceller` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idFonction`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `fonction`
--

INSERT INTO `fonction` (`idFonction`, `nom`, `ordre`, `afficher`, `sceller`) VALUES
(1, 'superadmin', 1, 1, 1),
(2, 'admin', 2, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `fonctioncompte`
--

DROP TABLE IF EXISTS `fonctioncompte`;
CREATE TABLE IF NOT EXISTS `fonctioncompte` (
  `idFonctionCompte` int(10) unsigned NOT NULL,
  `idFonction` int(10) unsigned NOT NULL,
  `idCompte` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idFonctionCompte`),
  KEY `idFonction` (`idFonction`),
  KEY `idCompte` (`idCompte`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `fonctioncompte`
--

INSERT INTO `fonctioncompte` (`idFonctionCompte`, `idFonction`, `idCompte`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `grade`
--

DROP TABLE IF EXISTS `grade`;
CREATE TABLE IF NOT EXISTS `grade` (
  `idGrade` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `nbmessages` int(10) NOT NULL,
  PRIMARY KEY (`idGrade`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `grade`
--

INSERT INTO `grade` (`idGrade`, `nom`, `nbmessages`) VALUES
(1, 'peon''noob', 25),
(2, 'peon', 50);

-- --------------------------------------------------------

--
-- Structure de la table `jeux`
--

DROP TABLE IF EXISTS `jeux`;
CREATE TABLE IF NOT EXISTS `jeux` (
  `idJeux` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `type` varchar(20) NOT NULL,
  `lien` varchar(60) NOT NULL,
  `description` longtext,
  `nbclick` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`idJeux`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `jeux`
--


-- --------------------------------------------------------

--
-- Structure de la table `lag`
--

DROP TABLE IF EXISTS `lag`;
CREATE TABLE IF NOT EXISTS `lag` (
  `idLan` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `adresse` varchar(60) NOT NULL,
  `datedeb` date NOT NULL,
  `datefin` date NOT NULL,
  `nbmaxpers` int(10) NOT NULL,
  `prix` int(10) NOT NULL,
  `description` longtext,
  `nbclick` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`idLan`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `lag`
--


-- --------------------------------------------------------

--
-- Structure de la table `lanjeux`
--

DROP TABLE IF EXISTS `lanjeux`;
CREATE TABLE IF NOT EXISTS `lanjeux` (
  `idLanJeux` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idLan` int(10) NOT NULL,
  `idJeux` int(10) NOT NULL,
  `nbmaxteam` int(10) NOT NULL,
  `nbmaxjoueur` int(10) NOT NULL,
  `nbmaxjoueurparteam` int(10) NOT NULL,
  `ordre` int(10) NOT NULL,
  PRIMARY KEY (`idLanJeux`),
  KEY `idLan` (`idLan`),
  KEY `idJeux` (`idJeux`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `lanjeux`
--


-- --------------------------------------------------------

--
-- Structure de la table `lanjeuxjoueurteam`
--

DROP TABLE IF EXISTS `lanjeuxjoueurteam`;
CREATE TABLE IF NOT EXISTS `lanjeuxjoueurteam` (
  `idLanJeuxJoueurTeam` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idLan` int(10) unsigned NOT NULL,
  `idJeux` int(10) unsigned NOT NULL,
  `idCompte` int(10) unsigned NOT NULL,
  `idTeam` int(10) unsigned NOT NULL,
  `dateins` date NOT NULL,
  `paiement` tinyint(4) NOT NULL,
  `validation` tinyint(1) NOT NULL,
  PRIMARY KEY (`idLanJeuxJoueurTeam`),
  KEY `idLan` (`idLan`),
  KEY `idJeux` (`idJeux`),
  KEY `idTeam` (`idTeam`),
  KEY `idCompte` (`idCompte`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `lanjeuxjoueurteam`
--


-- --------------------------------------------------------

--
-- Structure de la table `lien`
--

DROP TABLE IF EXISTS `lien`;
CREATE TABLE IF NOT EXISTS `lien` (
  `idLien` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `titre` varchar(60) NOT NULL,
  `lien` varchar(60) NOT NULL,
  `ordre` int(10) NOT NULL,
  PRIMARY KEY (`idLien`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `lien`
--


-- --------------------------------------------------------

--
-- Structure de la table `materiel`
--

DROP TABLE IF EXISTS `materiel`;
CREATE TABLE IF NOT EXISTS `materiel` (
  `idMateriel` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(40) NOT NULL,
  `type` varchar(40) NOT NULL,
  `dateachat` date NOT NULL,
  `description` longtext,
  `ordre` int(10) DEFAULT NULL,
  `img` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idMateriel`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `materiel`
--


-- --------------------------------------------------------

--
-- Structure de la table `mentionlegale`
--

DROP TABLE IF EXISTS `mentionlegale`;
CREATE TABLE IF NOT EXISTS `mentionlegale` (
  `idMentionLegale` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `titre` varchar(40) NOT NULL,
  `description` longtext,
  `ordre` int(10) DEFAULT NULL,
  PRIMARY KEY (`idMentionLegale`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `mentionlegale`
--


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
  `description` longtext NOT NULL,
  `ip` varchar(15) NOT NULL,
  PRIMARY KEY (`idMessage`),
  KEY `idSujet` (`idSujet`),
  KEY `idCompte` (`idCompte`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `message`
--


-- --------------------------------------------------------

--
-- Structure de la table `multimedia`
--

DROP TABLE IF EXISTS `multimedia`;
CREATE TABLE IF NOT EXISTS `multimedia` (
  `idMultimedia` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `titre` varchar(60) NOT NULL,
  `type` varchar(40) NOT NULL,
  `date` date NOT NULL,
  `lien` varchar(120) DEFAULT NULL,
  `description` longtext,
  `nbclick` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`idMultimedia`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `multimedia`
--


-- --------------------------------------------------------

--
-- Structure de la table `multimediacom`
--

DROP TABLE IF EXISTS `multimediacom`;
CREATE TABLE IF NOT EXISTS `multimediacom` (
  `idMultimediaCom` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idMultimedia` int(10) unsigned NOT NULL,
  `idCompte` int(10) unsigned NOT NULL,
  `date` date NOT NULL,
  `description` longtext,
  PRIMARY KEY (`idMultimediaCom`),
  KEY `idMultimedia` (`idMultimedia`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `multimediacom`
--


-- --------------------------------------------------------

--
-- Structure de la table `news`
--

DROP TABLE IF EXISTS `news`;
CREATE TABLE IF NOT EXISTS `news` (
  `idNews` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idCompte` int(10) unsigned NOT NULL,
  `titre` varchar(60) NOT NULL,
  `date` date NOT NULL,
  `description` longtext,
  PRIMARY KEY (`idNews`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `news`
--


-- --------------------------------------------------------

--
-- Structure de la table `newscom`
--

DROP TABLE IF EXISTS `newscom`;
CREATE TABLE IF NOT EXISTS `newscom` (
  `idNewsCom` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idNews` int(10) unsigned NOT NULL,
  `idCompte` int(10) unsigned NOT NULL,
  `date` date NOT NULL,
  `description` longtext,
  PRIMARY KEY (`idNewsCom`),
  KEY `idNews` (`idNews`),
  KEY `idCompte` (`idCompte`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `newscom`
--


-- --------------------------------------------------------

--
-- Structure de la table `partenaire`
--

DROP TABLE IF EXISTS `partenaire`;
CREATE TABLE IF NOT EXISTS `partenaire` (
  `idPartenaire` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `titre` varchar(60) NOT NULL,
  `date` date NOT NULL,
  `nbclick` int(10) NOT NULL,
  `type` varchar(60) NOT NULL,
  `lien` varchar(60) NOT NULL,
  `logo` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `ordre` int(10) NOT NULL,
  PRIMARY KEY (`idPartenaire`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `partenaire`
--


-- --------------------------------------------------------

--
-- Structure de la table `souscategorie`
--

DROP TABLE IF EXISTS `souscategorie`;
CREATE TABLE IF NOT EXISTS `souscategorie` (
  `idSousCategorie` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idCategorie` int(10) unsigned NOT NULL,
  `titre` varchar(60) NOT NULL,
  `description` longtext NOT NULL,
  `visible` tinyint(4) NOT NULL,
  `ordre` int(10) NOT NULL,
  PRIMARY KEY (`idSousCategorie`),
  KEY `idCategorie` (`idCategorie`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `souscategorie`
--


-- --------------------------------------------------------

--
-- Structure de la table `sujet`
--

DROP TABLE IF EXISTS `sujet`;
CREATE TABLE IF NOT EXISTS `sujet` (
  `idSujet` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idSousCategorie` int(10) unsigned NOT NULL,
  `idCompte` int(10) unsigned NOT NULL,
  `titre` varchar(60) NOT NULL,
  `date` date NOT NULL,
  `vu` tinyint(1) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `visible` tinyint(4) NOT NULL,
  `nbvue` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`idSujet`),
  KEY `idSousCategorie` (`idSousCategorie`),
  KEY `idCompte` (`idCompte`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `sujet`
--


-- --------------------------------------------------------

--
-- Structure de la table `team`
--

DROP TABLE IF EXISTS `team`;
CREATE TABLE IF NOT EXISTS `team` (
  `idTeam` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  PRIMARY KEY (`idTeam`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `team`
--


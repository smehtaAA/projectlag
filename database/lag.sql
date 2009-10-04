-- phpMyAdmin SQL Dump
-- version 3.1.3.1
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- Généré le : Mer 09 Septembre 2009 à 09:06
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
  `idJeux` int(10) unsigned NULL,
  `nom` varchar(60) NOT NULL,
  `ordre` int(10) NOT NULL,
  PRIMARY KEY (`idCharte`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `charte`
--

INSERT INTO `charte` (`idCharte`, `idJeux`, `nom`, `ordre`) VALUES
(1, 0, 'Association', 0),
(2, 2, 'Warcraft III TFT', 2);

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

INSERT INTO `chartearticle` (`idCharteArticle`, `idCharte`, `titre`, `description`, `ordre`) VALUES
(1, 1, 'Introduction', '<p>Association &agrave; but non lucratif, bas&eacute;e sur la loi 1901 <br />Merci de lire attentivement la CHARTE et de ne sauter aucune ligne. <br /><br />Toute personne incitant ou consommant elle-m&ecirc;me de la drogue quelqu''elle soit sera exclue de la Lan sans pr&eacute;avis. <br /><br />Toute vid&eacute;o &agrave; caract&egrave;re pornographique ou incitant &agrave; la violence est strictement interdite sous peine d''&ecirc;tre exclu de la lan. <br /><br />Tout jeu grav&eacute; sera &agrave; la charge de son propri&eacute;taire et non &agrave; celle de l''association. <br /><br />Si une personne ne respecte pas cette Charte, elle sera dans l''impossibilit&eacute; de jouer ou de participer aux Lan.</p>\r\n<p>-------------------------&nbsp;<br /><br />Afin que le LAN organis&eacute; par l''association LAG puisse se d&eacute;rouler dans les meilleures conditions, nous avons r&eacute;dig&eacute; un r&egrave;glement int&eacute;rieur. Nous demandons simplement aux participants de bien vouloir le lire attentivement et le respecter. Merci.&nbsp;<br /><br />Il est imp&eacute;ratif de s''inscrire pour participer &agrave; toute LAN . Cette inscription est payante. <br /><br />Ce paiement s''effectuera en esp&egrave;ce ou par ch&egrave;que en Euro lors des &eacute;v&egrave;nements. Un syst&egrave;me de pr&eacute;-inscription est appliqu&eacute;e, le paiement des pr&eacute;-inscriptions peut s''effectuer par l''envoi d''un ch&egrave;que ou par PayPal.&nbsp;<br /><br />L''association Local Arena Games se r&eacute;serve le droit de changer ses tarifs.&nbsp;<br /><br />Des tarifs d&eacute;gressifs sont appliqu&eacute;s : <br />les places en pr&eacute; vente sont moins ch&egrave;res que celles achet&eacute;es sur place.</p>', 1),
(2, 1, 'Inscription et Participation', '<p>2.1 Ne seront admis que ceux dont l''inscription a &eacute;t&eacute; pay&eacute;e et confirm&eacute;e. <br /><br />2.2 Les branchements des prises &eacute;lectriques et des c&acirc;bles r&eacute;seaux sur les switchs vous seront indiqu&eacute;s par les organisateurs. <br /><br />2.3 L''introduction de toute sorte de nourriture quelqu''elle soit est interdite dans l''espace de jeux, ainsi que tout type de boisson alcoolis&eacute;e. Un espace r&eacute;serv&eacute; &agrave; cet effet vous sera indiqu&eacute;. <br /><br />2.4 Seul l''emploi du casque audio est autoris&eacute;. <br /><br />2.5 L''association ne fournit pas les multiprises n&eacute;cessaires &agrave; votre mat&eacute;riel. <br /><br />2.6 Vous devez poss&eacute;der une carte r&eacute;seau (Base 10T/100T/1000T) et un c&acirc;ble RJ45 d''au moins 5 m&egrave;tres minimum.</p>', 2),
(3, 1, 'Sécurité', '<p><strong>3.1</strong> Pour pallier aux &eacute;ventuels accidents, pr&eacute;voir une assurance responsabilit&eacute; civile individuelle. Toutefois, l''association Golden-Nethix-Lan, son mat&eacute;riel et les locaux sont assur&eacute;s, et les membres de l''association veilleront au bon d&eacute;roulement des festivit&eacute;s. <br /><br /><strong>3.2.1</strong> Les LAN sont des &eacute;v&eacute;nements qui r&eacute;unissent des joueurs pour des tournois de jeux vid&eacute;os en r&eacute;seau. En aucun cas les LAN ne doivent devenir un lieu d''&eacute;changes ou de copies ill&eacute;gales de donn&eacute;es. L''association G-N-L d&eacute;cline toute responsabilit&eacute; vis-&agrave;-vis de la nature potentiellement ill&eacute;gale des donn&eacute;es contenues sur les machines personnelles des joueurs ou transitant par le r&eacute;seau. <br /><br /><strong>3.2.2</strong> Toute tentative d''intrusion sur les serveurs ou mat&eacute;riel r&eacute;seau du staff est passible d''exclusion au cours de chaque LAN. <br /><br /><strong>3.3</strong> Les mineurs seront accept&eacute;s sous la responsabilit&eacute; de leurs parents (autorisation &eacute;crite et sign&eacute;e sera exig&eacute;e) ou accompagn&eacute;s d''une personne majeure et responsable. <br /><br /><strong>3.4</strong> L''association G-N-L d&eacute;cline toute responsabilit&eacute; quant aux d&eacute;g&acirc;ts pouvant &ecirc;tre occasionn&eacute;s aux mat&eacute;riels des joueurs suite &agrave; une &eacute;ventuelle d&eacute;faillance &eacute;lectrique ou autre. En revanche, Golden-Nethix-Lan certifie qu''elle fera son maximum pour que ceci n''arrive pas. <br /><br /><strong>3.5</strong> Les organisateurs d&eacute;clinent toute responsabilit&eacute; en cas de vols commis &agrave; l''encontre des participants. <br /><br /><strong>3.6</strong>.1 Il est strictement interdit de fumer ou boire de l''alcool dans la salle sous peine d''expulsion et ce, pour des raisons de s&eacute;curit&eacute;. <br /><br /><strong>3.6.2</strong> Il est strictement interdit de faire cuire des aliments dans la salle et aux abords de celle-ci outre l''endroit indiqu&eacute; par les organisateurs. <br /><br /><strong>3.7.1</strong> Il est strictement interdit d''apporter aux LAN et d''utiliser d''autres appareilles &eacute;lectriques que votre PC personnel, pour des raisons de s&eacute;curit&eacute; et de consommation &eacute;lectrique. <br /><br /><strong>3.7.2</strong> Il est strictement interdit de brancher des onduleurs. <br /><br /><strong>3.8</strong> Pour des raisons de s&eacute;curit&eacute;, il vous est interdit d''entrer dans les locaux en possession d''un couteau ou tout autre accessoire consid&eacute;r&eacute; comme arme blanche. <br /><br /><strong>3.9</strong> Il sera impossible d''entrer et sortir des LAN entre minuit et six heures du matin durant la nuit du samedi au dimanche (pour des raisons de s&eacute;curit&eacute;).</p>', 3),
(4, 1, 'Civilité', '<p>4.1 Il est strictement interdit de faire entrer des animaux dans l''enceinte des locaux. <br /><br />4.2 Toute provocation verbale ou physique &agrave; l''encontre de toute personne est strictement interdite. L''expulsion des fauteurs de troubles sera imm&eacute;diate et sans remboursement. <br /><br />4.3 D&eacute;gradation mat&eacute;rielle lors du LAN doit faire l''objet d''une r&eacute;paration financi&egrave;re. <br /><br />Les organisateurs expulseront des LAN toutes personnes ne se soumettant pas au pr&eacute;sent r&egrave;glement.</p>', 4),
(5, 2, 'Informations générales', '<p>En participant au tournoi, les joueurs acceptent, sans r&eacute;ticence ou interpr&eacute;tation, de respecter le r&egrave;glement. Les joueurs acceptent l''application de ce r&egrave;glement et son application par les organisateurs.</p>', 5),
(6, 2, 'Structure de la compétition', '<p>2.1 Le tournoi utilise la structure: Poules puis arbre en simple &eacute;limination.&nbsp;<br /><br />2.2 Pour les poules, matchs sans possibilit&eacute; d''&eacute;galit&eacute;, un point est attribu&eacute; pour une victoire, aucun point pour une d&eacute;faite. Si plusieurs &eacute;quipes finissent &agrave; &eacute;galit&eacute;, un sous classement sera effectu&eacute; sur le nombre de points acquis entre les joueurs en question. Si certains joueurs sont toujours &agrave; &eacute;galit&eacute; apr&egrave;s ce d&eacute;partage, les matchs entre ces joueurs devront &ecirc;tre re-jou&eacute;s. <br /><br />2.3 Dans un arbre en simple &eacute;limination, les joueurs commencent tous dans un arbre principal. Les joueurs gagnants avancent dans l''arbre jusqu''&agrave; la finale. Un joueur est &eacute;limin&eacute; du tournoi lorsqu''il perd 1 match. Chaque match est jou&eacute; en une manche gagnante.</p>', 6),
(7, 2, 'Paramètres de jeu', '<p>3.1 La comp&eacute;tition utilise le jeu vid&eacute;o Warcraft III - The Frozen Throne avec la derni&egrave;re version de jeu en cours sur Battle.net, et oppose un joueur contre un autre.&nbsp;<br /><br />3.2 Le param&egrave;tre de jeu Gameplay est r&eacute;gl&eacute; &agrave; Rapide. <br /><br />3.3 La liste des maps disponibles est compos&eacute;e de : <br /> o Twisted Meadows <br /> o Turtle Rock <br /> o Gnoll Wood <br /> o Lost Temple <br /> o Terenas Stand <br /><br />3.4 La s&eacute;lection des maps pour chaque match se d&eacute;roule de la fa&ccedil;on suivante: <br />Un tirage au sort sera effectu&eacute; pour d&eacute;terminer la map du match.</p>', 7),
(8, 2, 'Responsabilités des participants', '<p>4.1 Les joueurs acceptent de respecter les points suivants:&nbsp;<br /> o Toute forme de discrimination est prohib&eacute;e. <br /> o Les participants acceptent de se conformer au r&egrave;glement en vigueur <br /> o Les participants acceptent les d&eacute;cisions des representant officiels du tournoi <br /> o Les participants acceptent de ne pas utiliser des proc&eacute;d&eacute;s interdit ou illicites. <br /> o Les participants acceptent de respecter l''esprit de fair-play et de non violence. <br /> o Les participants acceptent de respecter leurs engagements. <br /><br />4.2 Les participants acceptent de ne pas tenter de duper, l&eacute;ser, mentir ou soudoyer les repr&eacute;sentants officiels du tournoi.</p>', 8),
(9, 2, 'Déroulement du tournoi', '<p>Convocation&nbsp;<br /><br />5.1 Aucun joueur ne peut rejoindre le tournoi en cours, par cons&eacute;quent tout les joueurs absents lors du premier tour des poules, ne participeront pas au tournoi.&nbsp;<br /><br />5.2 Chaque joueur doit disposer d''un PC en &eacute;tat de marche et d''une version de Warcraft 3 - The Frozen Throne, install&eacute;e et correctement configur&eacute;e d&egrave;s le d&eacute;but du tournoi.&nbsp;<br /><br />5.3 Les joueurs doivent &ecirc;tre pr&eacute;sents &agrave; leur heure de convocation. Tout retard sup&eacute;rieur &agrave; 15 min pourra entra&icirc;ner un r&eacute;sultat &laquo; forfait pour ce tour &raquo; si celui-ci n''est pas motiv&eacute; par une raison valable.&nbsp;<br />Tout joueur souffrant d''un probl&egrave;me technique bloquant peut b&eacute;n&eacute;ficier d''un report de son match de 20 min, au del&agrave; desquelles, il est d&eacute;clar&eacute; forfait pour ce tour s''il n''est toujours pas en mesure de jouer. <br /><br />Installation et Echauffement <br /><br />5.4 Les r&egrave;gles suivantes s''appliquent uniquement lorsque les joueurs utilisent leurs ordinateurs sur scene.&nbsp;<br />- Les joueurs sont responsables du bon d&eacute;roulement de l''installation et du fonctionnement de leur mat&eacute;riel. <br /><br />5.5 Les joueurs ne peuvent pas utiliser de logiciel externe au jeu interagissant dans le jeu, ni installer n?importe quelle forme de modification alt&eacute;rant la version du jeu vid&eacute;o.&nbsp;<br /><br />D&eacute;roulement d''un match <br /><br />5.6 Les joueurs rencontrent leurs adversaires en fonction de la structure et du planning du tournoi.&nbsp;<br /><br />5.7 Les joueurs doivent recevoir l''autorisation d?un responsable de tournoi avant de commencer un match.&nbsp;<br /><br />5.8 Les joueurs ne peuvent pas communiquer avec d?autres personnes lors d''un match officiel.&nbsp;<br /><br />5.9 Si une partie est involontairement interrompue (crash client, crash serveur, coupure r&eacute;seau, ...)&nbsp;<br />la partie est rejou&eacute;e si elle a d&eacute;but&eacute; depuis moins de 5 min. Dans le cas contraire, l''&eacute;quipe ayant le plus haut score l''emporte. <br /><br />5.10 La pr&eacute;sence d''observateurs dans les parties est soumise &agrave; l''approbation des 2 joueurs, exception faites des arbitres qui peuvent observer toutes les parties.</p>', 9),
(10, 2, 'Infractions au règlement', '<p>Avertissement&nbsp;<br /><br />6.1 Par d&eacute;cision des responsables du tournoi, un joueur qui a involontairement transgress&eacute; une r&egrave;gle peut recevoir un avertissement.&nbsp;<br /><br />Forfait <br /><br />6.2 Par d&eacute;cision des responsables du tournoi, un joueur qui ne s''est pas pr&eacute;sent&eacute; peut perdre son match par forfait et, le cas &eacute;ch&eacute;ant, recevoir un avertissement.&nbsp;<br /><br />6.3 Les joueurs qui sont disqualifi&eacute; perdent automatiquement tout leurs &eacute;ventuels prochains matchs par forfait. En poule tout les matchs du joueur disqualifi&eacute; seront annul&eacute;s et les points redistribu&eacute;s.&nbsp;<br /><br />Disqualification <br /><br />6.4 Par d&eacute;cision des organisateurs du tournoi, un joueur qui a re&ccedil;u 2 avertissements peut &ecirc;tre disqualifi&eacute; du tournoi.&nbsp;<br /><br />6.5 Par d&eacute;cision des organisateurs du tournoi, un joueur qui a intentionnellement transgress&eacute; une r&egrave;gle peut &ecirc;tre directement disqualifi&eacute;. La d&eacute;termination du degr&eacute; d''intention est &agrave; la discr&eacute;tion des organisateurs du tournoi.&nbsp;<br /><br />6.6 Toute forme de tricherie, d&eacute;connexion intentionnelle, flooding, attaque de serveur, etc... r&eacute;sultera d''une disqualification imm&eacute;diate du joueur.&nbsp;<br /><br />6.7 Un joueur disqualifi&eacute; ne peut plus prendre part au tournoi, perd ses prix et lots acquis qui lui serait destin&eacute; et peut &ecirc;tre banni pour la comp&eacute;tition de l''ann&eacute;e suivante.</p>', 10);



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
  `msn` varchar(60),
  `img` varchar(200),
  `phone` varchar(10),
  `datenaissance` date NOT NULL,
  `dateins` datetime NOT NULL,
  `dateco` date NOT NULL,
  `temps` int(10) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `jeuxprefere` varchar(100) DEFAULT NULL,
  `site` varchar(100) DEFAULT NULL,
  `configpc` longtext,
  `citationpreferee` varchar(140) DEFAULT NULL,
  `description` longtext,
  `nbconnexion` int(10) unsigned DEFAULT NULL,
  `keyvalidation` varchar(45) DEFAULT NULL,
  `actif` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`idCompte`),
  KEY `idGrade` (`idGrade`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `compte`
--

INSERT INTO `compte` (`idCompte`, `idGrade`, `login`, `password`, `nom`, `prenom`, `email`, `datenaissance`, `dateins`, `dateco`, `temps`, `ip`, `jeuxprefere`, `site`, `configpc`, `citationpreferee`, `description`, `nbconnexion`, `keyvalidation`, `actif`) VALUES
(1, 1, 'sieg', 'l@g8?6ae357dc98f739341238fc52aea9d00dpe6r!e8', 'Méhault', 'Maxime', 'lag.sieg@gmail.com', '1988-02-09', '2009-09-06', '2009-09-07', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);

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
  `IP` varchar(15) NOT NULL,
  `script` varchar(60) NOT NULL,
  `referrer` varchar(60) NOT NULL,
  `remote_host` varchar(60) NOT NULL,
  `os` varchar(30) NOT NULL,
  `language` varchar(60) NOT NULL,
  `user_agent` varchar(60) NOT NULL,
  `date` date NOT NULL,
  `description` longtext NOT NULL,
  `lu` boolean DEFAULT false,
  `repondu` boolean DEFAULT false,
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `fonction`
--

INSERT INTO `fonction` (`idFonction`, `nom`, `ordre`, `afficher`, `sceller`) VALUES
(1, 'superadmin', 1, 1, 1),
(2, 'admin', 2, 1, 1),
(3, 'joueur', 3, 1, 0);

-- --------------------------------------------------------

--
-- Structure de la table `fonctioncompte`
--

DROP TABLE IF EXISTS `fonctioncompte`;
CREATE TABLE IF NOT EXISTS `fonctioncompte` (
  `idFonctionCompte` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idFonction` int(10) unsigned NOT NULL,
  `idCompte` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idFonctionCompte`),
  KEY `idFonction` (`idFonction`),
  KEY `idCompte` (`idCompte`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=2;

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

-- --------------------------------------------------------

--
-- Structure de la table `jeux`
--

DROP TABLE IF EXISTS `jeux`;
CREATE TABLE IF NOT EXISTS `jeux` (
  `idJeux` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `type` varchar(20) NOT NULL,
  `datesortie` date NOT NULL,
  `lien` varchar(60) NOT NULL,
  `description` longtext,
  `nbclick` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`idJeux`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `jeux`
--

INSERT INTO `jeux` (`idJeux`, `nom`, `type`, `lien`, `description`, `nbclick`) VALUES
(1, 'Wolfenstein', 'FPS', 'www.google.fr', '<p>gzhefhenzafbvlzebfvz</p>', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `lan`
--

DROP TABLE IF EXISTS `lan`;
CREATE TABLE IF NOT EXISTS `lan` (
  `idLan` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `adresse` varchar(60) NOT NULL,
  `datedeb` date NOT NULL,
  `datefin` date NOT NULL,
  `nbmaxpers` int(10) NOT NULL,
  `prix` int(10) NOT NULL,
  `inscription` boolean NOT NULL DEFAULT FALSE,
  `telethon` boolean NOT NULL DEFAULT FALSE,
  `prepaiement` boolean NOT NULL DEFAULT FALSE,
  `prix_prepaiement` int(10) NOT NULL,
  `description` longtext,
  `nbclick` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`idLan`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `lan`
--

INSERT INTO `lan` (`idLan`, `nom`, `adresse`, `datedeb`, `datefin`, `nbmaxpers`, `prix`, `description`, `nbclick`) VALUES
(2, 'G4', 'Mont', '2009-09-12', '2009-09-13', 50, 10, '<p>test d''ajout avec datepicker</p>', NULL);

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
  `tournoi` tinyint(1) DEFAULT NULL,
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
-- Structure de la table `lanjoueur`
--

DROP TABLE IF EXISTS `lanjoueur`;
CREATE TABLE IF NOT EXISTS `lanjoueur` (
  `idLanJoueur` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idLan` int(10) NOT NULL,
  `idCompte` int(10) NOT NULL,
  `dateins` date NOT NULL,
  `paiement` int(10) NOT NULL,
  `validation` int(10) NOT NULL,
  PRIMARY KEY (`idLanJoueur`),
  KEY `idLan` (`idLan`),
  KEY `idCompte` (`idCompte`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `lanjoueur`
--


-- --------------------------------------------------------

--
-- Structure de la table `lanjeuxjoueurteam`
--

DROP TABLE IF EXISTS `lanjeuxjoueurteam`;
CREATE TABLE IF NOT EXISTS `lanjeuxjoueurteam` (
  `idLanJeuxJoueurTeam` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idLanJoueur` int(10) unsigned NOT NULL,
  `idJeux` int(10) unsigned NOT NULL,
  `idTeam` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`idLanJeuxJoueurTeam`),
  KEY `idLanJoueur` (`idLanJoueur`),
  KEY `idJeux` (`idJeux`),
  KEY `idTeam` (`idTeam`)
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
  `type_n` varchar(20) DEFAULT NULL,
  `img` varchar(200) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`idNews`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

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
-- Structure de la table `newsletter`
--

DROP TABLE IF EXISTS `newsletter`;
CREATE TABLE IF NOT EXISTS `newsletter` (
  `idNewsletter` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idAdmin` int(10) unsigned DEFAULT NULL,
  `titre` varchar(100) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `img` varchar(200) DEFAULT NULL,
  `description` longtext,
  `IP` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idNewsletter`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `newsletter`
--


-- --------------------------------------------------------

--
-- Structure de la table `newslettermail`
--

DROP TABLE IF EXISTS `newslettermail`;
CREATE TABLE IF NOT EXISTS `newslettermail` (
  `idNewsletterMail` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mail` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idNewsletterMail`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `newslettermail`
--


-- --------------------------------------------------------

--
-- Structure de la table `newslettermailtype`
--

DROP TABLE IF EXISTS `newslettermailtype`;
CREATE TABLE IF NOT EXISTS `newslettermailtype` (
  `idNewsletterMailType` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idNewsletterType` int(10) unsigned NOT NULL,
  `idNewsletterMail` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idNewsletterMailType`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `newslettermailtype`
--


-- --------------------------------------------------------

--
-- Structure de la table `newslettertype`
--

DROP TABLE IF EXISTS `newslettertype`;
CREATE TABLE IF NOT EXISTS `newslettertype` (
  `idNewsletterType` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idNewsletterType`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `newslettertype`
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
-- Structure de la table `staff`
--

DROP TABLE IF EXISTS `staff`;
CREATE TABLE IF NOT EXISTS `staff` (
  `idStaff` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `unik` boolean DEFAULT true,
  `ordre` int(10) NOT NULL,
  PRIMARY KEY (`idStaff`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;



-- --------------------------------------------------------

--
-- Structure de la table `staffcompte`
--

DROP TABLE IF EXISTS `staffcompte`;
CREATE TABLE IF NOT EXISTS `staffcompte` (
  `idStaffCompte` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idStaff` int(10) unsigned NOT NULL,
  `idCompte` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idStaffCompte`),
  KEY `idStaff` (`idStaff`),
  KEY `idCompte` (`idCompte`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `team`
--

INSERT INTO `team` (`idTeam`, `nom`) VALUES
(1, 'Sans Team');

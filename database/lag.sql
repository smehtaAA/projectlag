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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `charte`
--

INSERT INTO `charte` (`idCharte`, `idJeux`, `nom`, `ordre`) VALUES
(1, 0, 'Association', 0),
(2, 1, 'Warcraft III TFT', 2),
(3, 12, 'Counter Strike Source', 3),
(4, 9, 'Trackmania Nations Forever', 4);

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

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
(10, 2, 'Infractions au règlement', '<p>Avertissement&nbsp;<br /><br />6.1 Par d&eacute;cision des responsables du tournoi, un joueur qui a involontairement transgress&eacute; une r&egrave;gle peut recevoir un avertissement.&nbsp;<br /><br />Forfait <br /><br />6.2 Par d&eacute;cision des responsables du tournoi, un joueur qui ne s''est pas pr&eacute;sent&eacute; peut perdre son match par forfait et, le cas &eacute;ch&eacute;ant, recevoir un avertissement.&nbsp;<br /><br />6.3 Les joueurs qui sont disqualifi&eacute; perdent automatiquement tout leurs &eacute;ventuels prochains matchs par forfait. En poule tout les matchs du joueur disqualifi&eacute; seront annul&eacute;s et les points redistribu&eacute;s.&nbsp;<br /><br />Disqualification <br /><br />6.4 Par d&eacute;cision des organisateurs du tournoi, un joueur qui a re&ccedil;u 2 avertissements peut &ecirc;tre disqualifi&eacute; du tournoi.&nbsp;<br /><br />6.5 Par d&eacute;cision des organisateurs du tournoi, un joueur qui a intentionnellement transgress&eacute; une r&egrave;gle peut &ecirc;tre directement disqualifi&eacute;. La d&eacute;termination du degr&eacute; d''intention est &agrave; la discr&eacute;tion des organisateurs du tournoi.&nbsp;<br /><br />6.6 Toute forme de tricherie, d&eacute;connexion intentionnelle, flooding, attaque de serveur, etc... r&eacute;sultera d''une disqualification imm&eacute;diate du joueur.&nbsp;<br /><br />6.7 Un joueur disqualifi&eacute; ne peut plus prendre part au tournoi, perd ses prix et lots acquis qui lui serait destin&eacute; et peut &ecirc;tre banni pour la comp&eacute;tition de l''ann&eacute;e suivante.</p>', 10),
(11, 3, 'Informations Générales', '<p><strong>1.1</strong> Le tournoi Counter-Strike Source est un tournoi qui se dispute en 5 contre 5.&nbsp;<br /><br /><strong>1.2</strong> Chaque participant n''a le droit de participer qu''&agrave; un tournoi et une seule fois dans le tournoi. Un joueur tentant de s''inscrire plusieurs fois sera disqualifi&eacute;. <br /><br /><strong>1.3</strong> L''inscription au tournoi est limit&eacute;e &agrave; 16 &eacute;quipes. <br /><br /><strong>1.4</strong> Toute &eacute;quipe qui ne se pr&eacute;sente pas &agrave; l''heure pr&eacute;vue pour jouer son match sera d&eacute;clar&eacute; forfait (d&eacute;faite arbitraire). <br /><br /><strong>1.5</strong> Toute enfreinte au r&egrave;glement peut engendrer la disqualification du joueur ou de l''&eacute;quipe. Chaque &eacute;quipe s''engage &agrave; respecter toutes les conditions de ce r&egrave;glement.</p>', 11),
(12, 3, 'Paramètres de jeu', '<p><strong>2.1</strong> Chaque match oppose une &eacute;quipe contre une autre en fonction de la structure de tournoi. <br /><br /><strong>2.2</strong> Pour chaque match, le joueur a droit &agrave; 3 minutes de ''warmup'': p&eacute;riode pendant laquelle l''&eacute;quipe peut s''&eacute;chauffer et se pr&eacute;parer pour le match. Au del&agrave; de ces 3 minutes, l''arbitre peut exiger que les &eacute;quipes commencent le match, qu''ils soient pr&ecirc;ts ou non. Le joueur de remplacement a 2 minutes pour s''installer et ce uniquement entre les manches. Aucun temps additionnel ne sera accord&eacute; pour la substitution des joueurs. <br /><br /><strong>2.3</strong> Pour chacune des manches, les &eacute;quipes jouent alternativement les terroristes et les anti-terroristes. L''&eacute;quipe commen&ccedil;ant comme terroriste est d&eacute;finie par un round ''cut''. &Agrave; la fin de la premi&egrave;re manche, les deux &eacute;quipes commutent leur c&ocirc;t&eacute;. <br />Chaque manche se joue sur 12 rounds. L''&eacute;quipe gagnante est celle qui a remport&eacute; le maximum de rounds sur les 2 manches. En cas d''&eacute;galit&eacute;, une nouvelle partie sera jou&eacute;e sur 2 manches de 3 rounds et en cas de nouvelle &eacute;galit&eacute;, une manche d&eacute;cisive sera jou&eacute;e pour d&eacute;clar&eacute;e l''&eacute;quipe gagnante. Une &eacute;quipe victorieuse d''un match de poule remporte 3 points pour le classement de la poule. Une &eacute;quipe ayant perdu son match ne gagne aucun point. En cas d''&eacute;galit&eacute; au nombre de rounds entre les deux &eacute;quipes, chaque &eacute;quipe marque 1 point au classement de la poule. <br /><br /><strong>2.4</strong> Si un des joueurs se d&eacute;connecte durant le match, il doit revenir aussi rapidement que possible. Les &eacute;quipes peuvent faire une pause pendant le round pour permettre au joueur de revenir. L''utilisation abusive de la pause sera sanctionn&eacute;e. <br /><br /><strong>2.5</strong> Si un match est interrompu &agrave; cause d''un probl&egrave;me externe aux joueurs ( crash d''un joueur/serveur, coupure r&eacute;seau, etc.. ), le match sera rejou&eacute; de la mani&egrave;re suivante: <br />- si le probl&egrave;me a lieu avant la fin du 1er round, le match sera rejou&eacute; <br />- si le probl&egrave;me a lieu apr&egrave;s le 1er round, le match continuera suivant le nombre de ronds restants, et les points seront ajout&eacute;s au score final. <br /><br /><strong>2.6</strong> Certaines actions possibles dans le jeu (bugs de map) sont interdites. Si une &eacute;quipe enfreint les r&egrave;gles, elle s''expose &agrave; des sanctions allant de l''avertissement au round de p&eacute;nalit&eacute; . Si une &eacute;quipe r&eacute;cidive, elle sera alors exclue du tournoi. <br /><br /><strong>2.7</strong> Un joueur re&ccedil;oit un avertissement lorsqu''il ne respecte pas une r&egrave;gle du tournoi de mani&egrave;re involontaire. Un avertissement ne peut &ecirc;tre donn&eacute; que par un admin du tournoi CS. Si un joueur a d&eacute;j&agrave; un avertissement, l''admin principal du tournoi peut le disqualifier. Un maximum de trois avertissements sera donn&eacute; &agrave; un joueur. <br /><br /><strong>2.8</strong> Toute forme de triche, d&eacute;connections, ping flood, etc. se verra sanctionn&eacute;e par une disqualification imm&eacute;diate du joueur ou de l''&eacute;quipe.</p>', 12),
(13, 3, 'Configuration des cfgs serveurs', '<p><strong>3.1</strong> La version de Counter-Strike doit &ecirc;tre Source Lan (en t&eacute;l&eacute;chargement sur le site lors de l''inscription). <br /><br /><strong>3.2</strong> Les param&egrave;tre suivants seront utilis&eacute;s : <br /><br /> o sv_pausable 0 <br /> o mp_friendlyfire 1 <br /> o mp_freezetime 5 <br /> o mp_c4timer 35 <br /> o mp_roundtime 2.5 <br /> o mp_buytime 0.20 <br /> o allow_spectators 0 <br /> o mp_forcecamera 1 <br /> o mp_fadetoblack 0 <br /> o mp_footsteps 1 <br /> o mp_flashlight 1 <br /> o mp_autocrosshair 0 <br /> o mp_limitteams 0 <br /> o mp_autoteambalance 0 <br /> o mp_autokick 0 <br /> o mp_tkpunish 0 <br /> o mp_startmoney 800 <br /> o mp_maxrounds 0 <br /> o mp_fraglimit 0 <br /> o mp_timelimit 0 <br /> o sv_cheats 0 <br /> o sv_maxrate 20000 <br /> o sv_minrate 2500 <br /> o mp_spawnprotectiontime 0 <br /> o sv_maxupdaterate 101 <br /> o sv_minupdaterate 50 <br /> o sv_maxspeed 320 <br /> o sv_gravity 800 <br /> o mp_hostagepenalty 0 <br /> o sv_airmove 1 <br /> o sv_airaccelerate 10 <br /> o sv_alltalk 0 <br /> o sv_playerid 0 <br /> o log on <br /> o sv_logfile 1 <br /> o sv_pure 2 <br /> o mp_logdetail 3 <br /> o mp_decals 4096 <br /> o sv_consistency 1 <br /> o sv_lan 1 <br /> o mp_winlimit 0 <br /> o sv_allowupload 0 <br /> o sv_allow_color_correction 0 <br />/** --------------------------------- **/ <br />/** -------- Source TV ----------- **/ <br />/** --------------------------------- **/ <br /> o tv_enable 1 <br /> o tv_autorecord 1 <br /> o tv_maxclients 0 <br /> o tv_name Source TV Private <br /> o tv_password =&gt; ne sera pas communiqu&eacute;</p>', 13),
(14, 3, 'Configuration côté client', '<p><strong>4.1</strong> Les variables pour la communication du client avec le serveur seront les suivantes : <br /><br /> o rate = "81920" <br /> o cl_updaterate "101" <br /> o cl_cmdrate "101" <br /> o Ces commandes devront &ecirc;tre obligatoirement entr&eacute;es par tous les joueurs. <br /><br /><strong>4.2</strong> Aucune modification des fichiers de texture et de model sera admise, ainsi skins d''armes, d''objets d''environnement et skins de joueurs devront &ecirc;tre ceux d''origine.</p>', 14),
(15, 3, 'Règles des cartes', '<p><strong>5.1</strong> Les seules cartes autoris&eacute;es sont: <br /><br /> o de_dust2 <br /> o de_inferno <br /> o de_nuke <br /> o de_train <br /> o de_tuscan <br /><br /><strong>5.2</strong> Chaque match est jou&eacute; sur une carte tir&eacute;e au sort par le corps arbitral et se compose de 2 manches sauf pour l''arbre de finale o&ugrave; les maps seront identiques par niveau.</p>', 15),
(16, 3, 'Conduite des participants et spectateurs', '<p><strong>6.1</strong> Les joueurs sont tenus de se conduire de mani&egrave;re amicale, respectueuse et raisonnable envers les autres joueurs et admin officiels. L''utilisation d''un langage vulgaire ou d''un comportement agressif sera sanctionn&eacute;e par un avertissement, un forfait ou une disqualification du joueur pour le tournoi ou l''&eacute;v&eacute;nement. <br /><br /><strong>6.2</strong> Il est interdit de communiquer avec un participant lorsqu''il joue un match officiel. <br /><br /><strong>6.3</strong> Le joueur ne peut pas communiquer avec quelqu''un d''autre lorsqu''il joue un match officiel. <br /><br /><strong>6.4</strong> Il est conseill&eacute; aux spectateurs et aux autres participants de ne pas trop faire de bruit lorsqu''un match officiel est jou&eacute;.</p>', 16),
(17, 3, 'Structure de la compétition', '<p><strong>7.1</strong> Un seeding sera effectu&eacute; avant le tournoi. Tous les joueurs pourront le consulter. <br /><br /><strong>7.2</strong> A partir du seeding, les joueurs seront r&eacute;partis dans des poules. Les premiers et seconds de chaque poules (selon l''organisation du tournoi) seront qualifi&eacute;s pour acc&eacute;der &agrave; l''arbre de finale. <br /><br /><strong>7.3</strong> L''arbre finale d&eacute;butera au niveau des huiti&egrave;mes de finale jusqu''&agrave; la finale. Une petite finale afin de d&eacute;terminer le troisi&egrave;me et le quatri&egrave;me sera organis&eacute; avant la grande finale.</p>', 17),
(18, 3, 'Plaintes', '<p><strong>8.1</strong> Tout d&eacute;saccord avec une d&eacute;cision prise durant le tournoi doit &ecirc;tre prononc&eacute; verbalement par le manager d''&eacute;quipe au corps arbitral au moment de l''incident, afin qu''il se r&eacute;unisse et qu''une d&eacute;cision prompte soit prise en consultation avec le responsable du tournoi. Les d&eacute;cisions du corps arbitral sont d&eacute;finitives. <br /><br /><strong>8.2</strong> L''administrateur du tournoi se r&eacute;serve le droit de changer ce r&egrave;glement avant le d&eacute;but du tournoi si une situation particuli&egrave;re l''impose. <br /><br /><strong>Les organisateurs se r&eacute;servent le droit de modifier certains param&egrave;tres.</strong></p>', 18),
(19, 4, 'Informations Générales', '<p>Le tournoi TM Nations Forever est un tournoi reposant sur le jeu Trackmania Nations, de Nadeo. <br /><br />Les joueurs acceptent, sans r&eacute;ticence ou interpr&eacute;tation, de respecter le r&egrave;glement. Les joueurs acceptent l''application de ce r&egrave;glement par les organisateurs et que toute d&eacute;cision prise par les organisateurs pr&eacute;vaut sur ce r&egrave;glement.</p>', 19),
(20, 4, 'Structure de la compétition', '<p>Une heure sera fix&eacute;e pour chaque circuit. Les joueurs cumuleront le nombre de points de chaque circuit. Un joueur n''ayant pas particip&eacute; &agrave; un circuit sera &eacute;limin&eacute;.</p>', 20),
(21, 4, 'Paramètres de jeu', '<p><strong>3.1</strong> La comp&eacute;tition utilise le jeu vid&eacute;o Trackmania Nations Forever ESWC et oppose des joueurs contre d''autre. <br /><br /><strong>3.2</strong> Les options de jeu suivantes seront utilis&eacute;es pour tous les matchs: <br /> o Max player : no limit <br /> o Mode : Round <br /> o Point Limit : 3 <br /> o Use alternate rules : oui</p>', 21),
(22, 4, 'Responsabilités des participants', '<p><strong>4.1</strong> Les joueurs acceptent de se conformer &agrave; la Charte de Golden-Nethix-Lan et de respecter les points suivants:&nbsp;<br /><br /> o Toute forme de discrimination est prohib&eacute;e. <br /> o Les participants acceptent de se conformer au r&egrave;glement en vigueur. <br /> o Les participants acceptent les d&eacute;cisions des repr&eacute;sentants officiels du tournoi. <br /> o Les participants acceptent de ne pas utiliser des proc&eacute;d&eacute;s interdits ou illicites. <br /> o Les participants acceptent de respecter l''esprit de fair-play et de non violence. <br /> o Les participants acceptent de respecter leurs engagements. <br /><br /><strong>4.2</strong> Les participants acceptent de ne pas tenter de duper, l&eacute;ser, mentir ou soudoyer les repr&eacute;sentants officiels du tournoi.&nbsp;<br /><br /><strong>4.3</strong> Les participants acceptent de ne pas interf&eacute;rer ou communiquer avec d''autres participants qui seraient en cours de match.</p>', 22),
(23, 4, 'Déroulement du tournoi', '<p><strong>Convocation</strong> <br /><br /><strong>5.1</strong> Les joueurs doivent &ecirc;tre pr&eacute;sents &agrave; l''aire de jeu &agrave; leur heure de convocation. Il est conseill&eacute; aux joueurs de pr&eacute;voir quelques minutes d''avance pour &eacute;viter tout retard impr&eacute;visible. <br /><br /><strong>5.2</strong> L''heure de convocation indique l''heure &agrave; laquelle les joueurs doivent &ecirc;tre pr&eacute;sents pour commencer une session de matchs. Une session de matchs inclus l''installation du joueur (telle que l''installation des p&eacute;riph&eacute;riques, leur configuration et l''&eacute;chauffement) et un ou plusieurs matchs de comp&eacute;tition, tel qu''il est d&eacute;fi ni dans le planning du tournoi. <br />Les joueurs doivent quitter l''aire de jeu une fois la ession de matchs termin&eacute;e. <br /><br /><strong>Installation et Echauffement</strong> <br /><br /><strong>5.3</strong> Les joueurs doivent utiliser les ordinateurs de comp&eacute;tition d&eacute;sign&eacute;s par les responsables du tournoi. Ceux-ci peuvent &ecirc;tre des ordinateurs fournis par les organisateurs ou l''ordinateur du joueur. Lorsqu''un match est jou&eacute; sur sc&egrave;ne, les joueurs acceptent de jouer dans les conditions de la sc&egrave;ne telles que l?&eacute;clairage, les cardio-fr&eacute;quencem&egrave;tres, et l''utilisation des &eacute;couteurs sp&eacute;ciaux fournis par les organisateurs. <br /><br /><strong>5.4</strong> Les r&egrave;gles suivantes s''appliquent :&nbsp;<br /><br /> o Les joueurs peuvent amener et utiliser des p&eacute;riph&eacute;riques personnels, tels qu''un clavier, une souris ou une manette, &agrave; condition qu''ils disposent des pilotes ad&eacute;quats pour chaque p&eacute;riph&eacute;rique. <br /> o Les joueurs doivent amener leurs propres casques audio et ne peuvent pas utiliser des enceintes. Dans certains cas, les joueurs devront utiliser les casques audio fournis par les organisateurs. <br /> o Les joueurs ne peuvent pas utiliser de fichier de configuration. <br /> o Les joueurs sont responsables du bon d&eacute;roulement de l''installation et du fonctionnement de leur mat&eacute;riel. <br /> o Le temps attribu&eacute; aux joueurs pour installer leur mat&eacute;riel et s''&eacute;chauffer s''&eacute;tend depuis l''heure de convocation jusqu''&agrave; l''heure du d&eacute;marrage du premier match &agrave; jouer. <br /><br /><strong>5.5</strong> Les joueurs ne peuvent pas utiliser de logiciel externe au jeu interagissant dans le jeu, ni installer n''importe quelle forme de modification alt&eacute;rant la version du jeu vid&eacute;o.&nbsp;<br /><br /><strong>5.6</strong> Les joueurs peuvent modifier les param&egrave;tres de luminosit&eacute; du moniteur &agrave; condition que ceux-ci restent dans des valeurs raisonnables. Les param&egrave;tres de luminosit&eacute; du syst&egrave;me d''exploitation ne peuvent &ecirc;tre chang&eacute;s.&nbsp;<br /><br /><strong>D&eacute;roulement d''un match</strong> <br /><br /><strong>5.7</strong> Les joueurs rencontrent leurs adversaires en fonction de la structure et du planning du tournoi.&nbsp;<br /><br /><strong>5.8</strong> Les joueurs doivent recevoir l''autorisation d''un responsable de tournoi avant de commencer un match.&nbsp;<br /><br /><strong>5.9</strong> Les joueurs ne peuvent pas communiquer avec d''autres personnes lors d''un match officiel.&nbsp;<br /><br /><strong>5.10</strong> Les joueurs ne peuvent pas quitter un match officiel en cours.&nbsp;<br /><br /><strong>5.11</strong> Si une partie est involontairement interrompue (crash client, crash serveur, coupure r&eacute;seau, ...) les responsables du tournoi peuvent d&eacute;cider de rejouer la partie sans donner un quelconque avantage &agrave; l''un ou l''autre joueur.</p>', 23),
(24, 4, 'Infractions au règlement', '<p><strong>D&eacute;finitions</strong> <br /><br /><strong>6.1</strong> Chaque match est contr&ocirc;l&eacute; par un arbitre. Celui-ci a tout pouvoir pour appliquer le r&egrave;glement en relation avec le&nbsp;<br />match en question et peut, si n&eacute;cessaire, donner des avertissements aux joueurs (voir 7.4) <br /><br /><strong>6.2</strong> Le tournoi est contr&ocirc;l&eacute; par un directeur de tournoi. Celui-ci a tout pouvoir pour appliquer le r&egrave;glement en relation avec le tournoi et tous les matchs de ce tournoi. Le directeur de tournoi attribue les arbitres aux matchs, peut donner des avertissements, peut donner des p&eacute;nalit&eacute;s &agrave; des joueurs, et prendre part dans l''&eacute;tude des infractions effectu&eacute;es afin d''&eacute;tablir d''&eacute;ventuelles sanctions suppl&eacute;mentaires (voir 7.4 et 7.5)&nbsp;<br /><br /><strong>6.3</strong> Les officiels du tournoi sont les arbitres, le directeur du tournoi et le directeur de la comp&eacute;tition Trackmania Nations Forever ESWC GNL.&nbsp;<br /><br /><strong>Avertissements et Sanctions</strong> <br /><br /><strong>6.4</strong> Un joueur peut &ecirc;tre r&eacute;primand&eacute; et recevoir un avertissement si il commet l''une des infractions suivantes :&nbsp;<br /><br /> o Refuser de suivre les instructions d''un officiel du tournoi. <br /> o Arriver en retard &agrave; l''heure de convocation. <br /> o Contester la d&eacute;cision d''un officiel de tournoi. <br /> o Utiliser un langage ou des gestes insultants. <br /> o Etre coupable de comportement anti-sportif. <br /><br /><strong>6.5</strong> Un joueur peut &ecirc;tre r&eacute;primand&eacute; et recevoir une p&eacute;nalit&eacute; si il commet l''une des infractions suivantes :&nbsp;<br /><br /> o Recevoir plus d''un avertissement. <br /> o Etre coupable d''actes violents. <br /> o Tricher ou utiliser un proc&eacute;d&eacute; in&eacute;quitable. <br /> o Mentir ou induire en erreur un officiel du tournoi. <br /> o Arriver en retard &agrave; l''heure de son match. <br /><br /><strong>6.6</strong> Un joueur recevant une p&eacute;nalit&eacute; perd automatiquement le match en cours, ou son prochain match si il ne joue pas.&nbsp;<br /><br /><strong>6.7</strong> Apr&egrave;s &eacute;tude de l''infraction par le directeur de la comp&eacute;tition et du directeur de tournoi, un joueur ayant re&ccedil;u une p&eacute;nalit&eacute; peut &eacute;galement recevoir des sanctions suppl&eacute;mentaires telles que plusieurs d&eacute;faites automatiques, la disqualification du joueur, l''expulsion du joueur et l''interdiction de participer aux futures comp&eacute;titions durant un an.&nbsp;<br /><br /><strong>6.8</strong> Un joueur disqualifi&eacute; perd automatiquement tous ses prochains matchs et perd tous les droits et dotations qu''il aurait pu recevoir. Dans une phase de poules, tous les r&eacute;sultats des matchs pr&eacute;c&eacute;dents sont convertis en d&eacute;faite. Tous les points gagn&eacute;s ou perdus sont recalcul&eacute;s en cons&eacute;quence.</p>', 24);


-- --------------------------------------------------------

--
-- Structure de la table `compte`
--

DROP TABLE IF EXISTS `compte`;
CREATE TABLE IF NOT EXISTS `compte` (
  `idCompte` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idGrade` int(10) unsigned NOT NULL DEFAULT 1,
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `compte`
--

INSERT INTO `compte` (`idCompte`, `idGrade`, `login`, `password`, `nom`, `prenom`, `email`, `datenaissance`, `dateins`, `dateco`, `temps`, `ip`, `jeuxprefere`, `site`, `configpc`, `citationpreferee`, `description`, `nbconnexion`, `keyvalidation`, `actif`) VALUES
(1, 1, 'Sieg', 'a16585fa2acbfe4761048c52d5987f166c027279', 'Méhault', 'Maxime', 'lag.sieg@gmail.com', '1988-02-09', '2009-09-06', '2009-09-07', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(2, 1, 'Ash', '43b474c03a22dc04541159cc1d424a62c33c6ef7', 'Moraux', 'Antoine', 'lag.ash@gmail.com', '1988-06-14', '2009-09-06', '2009-09-07', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(3, 1, 'Ryzen', '43b474c03a22dc04541159cc1d424a62c33c6ef7', 'Bourgeois', 'Steevens', 'lag.ryzen@gmail.com', '1987-07-25', '2009-09-06', '2009-09-07', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(4, 1, 'Belette', '43b474c03a22dc04541159cc1d424a62c33c6ef7', 'Frayon', 'Johan', 'belette_0161@hotmail.com', '1987-05-26', '2009-09-06', '2009-09-07', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(5, 1, 'Risk.Breaker', '43b474c03a22dc04541159cc1d424a62c33c6ef7', 'Barrat', 'Eric', 'parodius02@msn.com', '1900-05-26', '2009-09-06', '2009-09-07', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);

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
INSERT INTO `config` (`idConfig`, `titre`, `cle`, `valeur`) VALUES(1,'Nombre max de news par page', 'nb_max_news_page', 2);

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=6;

--
-- Contenu de la table `fonctioncompte`
--

INSERT INTO `fonctioncompte` (`idFonctionCompte`, `idFonction`, `idCompte`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 3),
(4, 2, 4),
(5, 2, 5);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Contenu de la table `jeux`
--

INSERT INTO `jeux` (`idJeux`, `nom`, `type`, `datesortie`, `lien`, `description`, `nbclick`) VALUES
(1, 'Warcraft III TFT', 'Stratégie', '2003-07-04', 'http://eu.blizzard.com/fr-fr/games/war3/', '<p>The Frozen Throne est une extension pour le jeu de stratégie Warcraft III sur PC. De nouveaux Héros de Légende et de nouvelles unités sont disponibles pour une quête de 26 missions solo. Illidan, le démon que les joueurs ont connu dans Warcraft III est parvenu à s\'échapper et menace de nouveau le monde. Vous pourrez rejoindre les rangs des humains, des morts-vivants, des orcs et des elfes.</p>', NULL),
(2, 'Wolfenstein', 'FPS', '2009-08-28', 'http://www.wolfenstein.com/home/agegate?ref=home', '<p>Wolfenstein sur PC est le troisième volet de la célèbre série de FPS. Le titre nous plonge encore une fois en pleine Seconde Guerre mondiale, dans la peau de BJ Blazkowicz. Votre mission consiste à surveiller les recherches des nazis dans le domaine du paranormal. Vous serez rapidement confronté à des créations issues de dimensions parallèles ouvertes par les scientifiques du Reich.</p>', NULL),
(3, 'Quake 3', 'FPS', '1999-12-15', 'http://www.idsoftware.com/', '<p>Quake III Arena sur PC est un jeu de tir à la première personne orienté multijoueur. Un arsenal varié et complet est à votre disposition pour organiser une joyeuse boucherie seul ou par équipe. Les modes classiques du genre sont tous là (Capture The Flag, Possession, Deathmatch...).</p>', NULL),
(4, 'Call of Duty 4', 'FPS', '2007-11-09', 'http://www.callofduty.com/', '<p>Call of Duty 4 : Modern Warfare un jeu de tir en vue subjective sur PC qui se déroule dans un contexte contemporain et qui permet de suivre deux conflits fictifs en parallèle. Le premier place le joueur dans la peau d\'un marine américain coincé dans une guérilla urbaine au Moyen-Orient, tandis que dans l\'autre lui fait incarner un agent d\'élite britannique embarqué dans des missions discrètes en Russie et Europe de l\'Est. Plusieurs modes multijoueurs sont aussi de la partie.</p>', NULL),
(5, 'Counter Strike 1.6', 'FPS', '2000-12-11', 'http://store.steampowered.com/', '<p>Créé à partir du célèbre moteur de Half-Life, Counter-Strike sur PC est un jeu de tir à la première personne se jouant exclusivement en ligne. Le jeu, qui compte une grande communauté, vous permet de choisir votre camp entre les terroristes et les contre-terroristes. Plusieurs objectifs différents en fonction du camp adopté et de la carte choisie doivent être menés à bien afin de remporter la partie. Vous disposez également d\'un large choix d\'armes existantes afin de renforcer l\'immersion.</p>', NULL),
(6, 'Starcraft', 'Stratégie', '1998-04-01', 'http://eu.blizzard.com/fr-fr/games/sc/', '<p>Starcraft est un jeu de stratégie sur PC prenant place dans un univers futuriste. Le scénario oppose trois grandes factions : les humains, les protoss et les zergs. Chacune de ces races propose ses propres unités, bâtiments, technologies ainsi que sa propre campagne de jeu solo. Starcraft est également jouable en ligne et nécessite une faible configuration.</p>', NULL),
(7, 'Left 4 Dead', 'FPS', '2008-11-20', 'http://www.l4d.com/', '<p>Left 4 Dead sur PC est un FPS horrifique basé en grande partie sur la coopération. En effet, vous incarnez un personnage dans un groupe de quatre, mais les trois autres peuvent être dirigés par des amis. Echappez aux zombies en veillant donc les uns sur les autres. Pour corser le tout, le jeu offre la possibilité à quatre autres joueurs d\'incarner des morts-vivants pour sillonner la ville et traquer les héros.</p>', NULL),
(8, 'Team Fortress 2', 'FPS', '2007-10-10', 'http://store.steampowered.com/', '<p>Team Fortress 2 est un jeu de tir à la première personne sur PC. Le jeu propose de se bastonner en réseau dans un univers très cartoon et coloré, mais qui n\'en oublie pas pour autant d\'inclure de nombreuses armes et arènes de jeu. Plusieurs personnages sont disponibles, avec leurs propres spécificités, armes et capacités, sur six cartes différentes.</p>', NULL),
(9, 'Trackmania Nations Forever', 'Course', '2008-04-16', 'http://www.trackmania.com/index.php?lang=fr', '<p>Faisant suite à TrackMania Nations, TrackMania Nations Forever sur PC est un jeu de courses arcade à vocation communautaire entièrement gratuit. Accompagné par un éditeur de circuits extrêmement complet, le titre permet de créer ses propres tracés ou vidéos pour ensuite les partager avec les autres joueurs sur internet.</p>', NULL),
(10, 'Age of Empires II', 'Stratégie', '1999-10-01', 'http://www.microsoft.com/Games/age2/', '<p>Age of Empires II est un jeu de stratégie sur PC. C\'est un contexte médiéval qui est à l\'honneur dans le titre, traversé par de grandes figures historiques, de Jeanne D\'Arc à Saladin en passant par Gengis Kahn ou Yoshidune. Construisez votre empire et faites-le évoluer afin de régner en maître absolu sur vos adversaires.</p>', NULL),
(11, 'Worms Armageddon', 'Action / Stratégie', '1999-02-01', 'http://wormsarmageddon.team17.com/main.html?page=home&area=welc', '<p>Worms 2 : Armageddon sur PC marque le retour des lombrics. Le principe reste le même : plusieurs équipes de vers de terre débiles s\'affrontent sur des arènes à l\'aide d\'armes ridiculement mortelles. Prenez en compte le sens du vent et les différents obstacles entre vous et votre cible et lancez-vous dans une boucherie à la dimension aussi tactique qu\'aléatoire.</p>', NULL),
(12, 'Counter Strike Source', 'FPS', '2004-10-01', 'http://store.steampowered.com/', '<p>Counter-Strike : Source sur PC est un jeu de tir à la première personne qui se joue exclusivement en ligne et qui compte une grande communauté. Le jeu permet au joueur de choisir son camp entre les terroristes et les contre-terroristes. Plusieurs objectifs différents en fonction du camp adopté et de la carte choisie doivent être menées à bien afin de remporter la partie. Le jeu met également à disposition du joueur un large choix d\'armes existantes afin de renforcer l\'immersion.</p>', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `lan`
--

DROP TABLE IF EXISTS `lan`;
CREATE TABLE IF NOT EXISTS `lan` (
  `idLan` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `adresse` varchar(60) NOT NULL,
  `datedeb` datetime NOT NULL,
  `datefin` datetime NOT NULL,
  `nbmaxpers` int(10) NOT NULL,
  `prix` int(10) NOT NULL,
  `inscription` boolean NOT NULL DEFAULT FALSE,
  `date_inscription` date NULL,
  `telethon` boolean NOT NULL DEFAULT FALSE,
  `prepaiement` boolean NOT NULL DEFAULT FALSE,
  `prix_prepaiement` int(10) NOT NULL,
  `description` longtext,
  `nbclick` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`idLan`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `lan`
--

INSERT INTO `lan` (`idLan`, `nom`, `adresse`, `datedeb`, `datefin`, `nbmaxpers`, `prix`, `inscription`, `telethon`, `prepaiement`, `prix_prepaiement`, `description`, `nbclick`) VALUES
(1, 'LAG Téléthon 2009', '<p>Salle Poniatowsky <br/> Mont Notre Dame </p>', '2009-12-04 20:00:00', '2009-12-05 17:00:00', 75, 5, 0, 1, 1, 5, '<p>LAG organise sa première Lan au profit du téléthon</p>', NULL);

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Contenu de la table `lanjeux`
--
INSERT INTO `lanjeux` (idLanJeux, `idLan`, `idJeux`, `nbmaxteam`, `nbmaxjoueur`, `nbmaxjoueurparteam`, `tournoi`, `ordre`) VALUES
(1, 1, 1, 20, 20, 1, 0, 1),
(2, 1, 2, 8, 40, 5, 0, 1),
(3, 1, 3, 8, 40, 5, 0, 1),
(4, 1, 4, 8, 40, 5, 0, 1),
(5, 1, 5, 8, 40, 5, 0, 1),
(6, 1, 6, 20, 20, 1, 0, 1),
(7, 1, 7, 8, 40, 5, 0, 1),
(8, 1, 8, 8, 40, 5, 0, 1),
(9, 1, 9, 20, 20, 1, 0, 1),
(10, 1, 10, 20, 20, 1, 0, 1),
(11, 1, 11, 20, 20, 1, 0, 1);

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
  `validation` boolean DEFAULT false,
  `present` boolean DEFAULT false,
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
  `idPartenaire` int(10) unsigned DEFAULT NULL,
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
INSERT INTO `news` VALUES(1, 0, 0, 'La LAG ', '2009-10-10', 'Association', NULL, '<p>\r\n<p style=\\"\\\\\\"><span style=\\"\\\\\\">Salut &agrave; tous,</span></p>\r\n<p style=\\"\\\\\\"><span style=\\"\\\\\\">Nous avons le plaisir de vous pr&eacute;senter notre petite prot&eacute;g&eacute;e, la <strong>Local Arena Games</strong>. En effet, les anciens membres de l&rsquo;association Golden Nethix Lan (GNL pour les intimes) ont d&eacute;cid&eacute;s de se regrouper sous le nom d&rsquo;une nouvelle association, la <strong>LAG</strong> !&nbsp; :D. Le si&egrave;ge social ayant chang&eacute;, les &eacute;v&eacute;nements se d&eacute;rouleront maintenant dans une salle plus grande, o&ugrave; nous pourrons accueillir plus de joueurs. Nous pouvons donc mettre &agrave; disposition des joueurs, des &laquo;plus&raquo; tels qu&rsquo;un coin restauration, ou encore des activit&eacute;s sur console (PS2, Wii, ...)</span></p>\r\n<p style=\\"\\\\\\"><span style=\\"\\\\\\">La LAG est donc pleine de PGM ... euh plut&ocirc;t <strong>d&rsquo;enthousiasme</strong> et esp&egrave;re vous voir nombreux lors de ses &eacute;v&eacute;nements.</span></p>\r\n<p style=\\"\\\\\\"><span style=\\"\\\\\\">Bon, parlons plus s&eacute;rieusement, la premier &eacute;v&eacute;nement organisait par la LAG sera, comme &agrave; son habitude, une LAN <strong>enti&egrave;rement</strong> au profit du t&eacute;l&eacute;thon. Cet &eacute;v&eacute;nement porte le nom de &laquo;<strong>LAG T&eacute;l&eacute;thon 2009</strong>&raquo; et se d&eacute;roulera &agrave; la salle Poniatowsky de Mont Notre Dame (02220). Cette LAN aura pour but de r&eacute;unir des joueurs afin de jouer &agrave; un maximum de jeux diff&eacute;rents. En effet, aucun &laquo;vrai&raquo; tournoi ne sera organis&eacute;, la lan vise des jeux plus &laquo;<strong>fun</strong>&raquo; et dont la jouabilit&eacute; en multi-joueurs est plus que remarquable (Quake 3, Trackmania, Left 4 Dead et bien plus encore ...). L&rsquo;&eacute;quipe de la LAG esp&egrave;re que cette initiative vous plaira et reste &agrave; votre disposition pour toutes questions ou propositions.</span></p>\r\n<p style=\\"\\\\\\"><span style=\\"\\\\\\">@ bient&ocirc;t</span></p>\r\n<p style=\\"\\\\\\"><span style=\\"\\\\\\">L&rsquo;&eacute;quipe de la LAG</span></p>\r\n');


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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `partenaire`
--
INSERT INTO `partenaire` (`idPartenaire`, `titre`, `date`, `nbclick`, `type`, `lien`, `logo`, `description`, `ordre`) VALUES
(1, 'Steelseries', '2009-10-01', 0, 'Informatique', 'http://www.steelseries.com/', 'SteelSeries.jpg', '<p>SteelSeries est un vendeur de matériels informatiques spécialisé dans les jeux vidéo (casques, claviers, souris, tapis de souris,...). Depuis sa création en 2001, SteelSeries est en coopération avec de grands joueurs professionnels et son développement devient de plus en plus important dans cet univers.</p>', 1),
(2, 'FOCUS HOME INTERACTIVE', '2009-10-01', 0, 'Informatique', 'http://www.focus-home.com/', 'Focus.jpg', '<p>Créé en 1996, Focus Home Interactive est un éditeur français indépendant basé en région parisienne. Spécialisé dans le jeu vidéo depuis 2000, Focus a multiplié les succès en lançant bon nombre de titres originaux devenus de véritables références comme le jeu d\'aventure Runaway, le populaire Cycling Manager ou encore le fameux TrackMania. Reconnu pour la variété, la qualité et l\'originalité de son catalogue, Focus édite et distribue désormais une partie de ses titres dans de nombreux territoires en Europe et dans le monde à travers un réseau de distributeurs performants ou encore de manière digitale pour certains produits spécifiques.</p>', 2),
(3, 'Thermaltake', '2009-10-01', 0, 'Informatique', 'http://fr.thermaltake.eu/', 'Thermaltake.jpg', '<p>La personnalité de la marque d\'unique, d\'agressif, de vif, et d\'élégant fait de Thermaltake un expert dans la création de choses passionnantes et d\'environnement fascinant pour les gamers et les passionnés. L\'excellente capacité d\'expertise technique et d\'intégration, plus l\'audace d\'expérimenter sur les nouvelles possibilités donnent à Thermaltake la source d\'autorité sur le marché. De plus, Thermaltake se rapproche des consommateurs et observe le comportement et la demande des utilisateurs leaders, pour concevoir des produits esthétiques et de qualité qui amélioreront considérablement les performances du système et apporteront à l\'utilisateur le plus grand potentiel. Avec un design innovateur et un style unique, les produits de Thermaltake se répandent rapidement parmi les passionnés sur le marché DIY et deviennent bientôt le choix numéro un pour les passionnés de bricolage de PC dans le monde entier.</p>', 3);


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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

INSERT INTO `staff` (`idStaff`, `nom`, `unik`, `ordre`) VALUES
(1, 'Président', 1, 1),
(2, 'Vide-Président', 1, 2),
(3, 'Trésorier', 1, 3),
(4, 'Secrétaire', 1, 4),
(5, 'Admin War III', 0, 5);

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

INSERT INTO `staffcompte` (`idStaffCompte`, `idStaff`, `idCompte`) VALUES
(1, 1, 1),
(2, 2, 4),
(3, 3, 2),
(4, 4, 3),
(5, 5, 5);

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

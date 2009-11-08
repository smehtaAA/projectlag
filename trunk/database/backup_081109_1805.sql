-- phpMyAdmin SQL Dump
-- version OVH
-- http://www.phpmyadmin.net
--
-- Serveur: mysql5-9
-- Généré le : Dim 08 Novembre 2009 à 18:05
-- Version du serveur: 5.0.68
-- Version de PHP: 4.4.9

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Base de données: `lansoiss`
--

-- --------------------------------------------------------

--
-- Structure de la table `bug`
--

DROP TABLE IF EXISTS `bug`;
CREATE TABLE IF NOT EXISTS `bug` (
  `idBug` int(10) unsigned NOT NULL auto_increment,
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
  PRIMARY KEY  (`idBug`),
  KEY `idCompte` (`idCompte`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `bug`
--

INSERT INTO `bug` (`idBug`, `idCompte`, `titre`, `datebug`, `datedebug`, `statut`, `priorite`, `categorie`, `navigateur`, `description`, `noteDebugger`) VALUES
(1, 0, 'tessttt', '2009-11-08', '0000-00-00', 'Non lu', 0, 'Erreur', 'Internet Explorer', 'testtter', ''),
(2, 0, 'test', '2009-11-08', '0000-00-00', 'Non lu', 0, 'Erreur', 'Internet Explorer', 'test', ''),
(3, 0, 'fgdgdgd', '2009-11-08', '0000-00-00', 'Non lu', 0, 'Faute d''orthographe', 'Chrome', 'gdfgdgdgdfgdfgdgdgfdgdfgdg', ''),
(4, 0, 'fgdgdgdfdgdfgdh tyf h', '2009-11-08', '0000-00-00', 'Non lu', 0, 'Faute d''orthographe', 'Chrome', 'gdfgdgdgdfgdfgdgdgfdgdfgdggdfgdfgdfgdfgsd gfsdfgsd gdf hfgh fyh ftghftyh', ''),
(5, 0, 'tretrtert et dftg dfgdf ', '2009-11-08', '0000-00-00', 'Non lu', 0, 'Erreur', 'Internet Explorer', 'ghfd hfh fghgf jhfg hjg jghj gf', '');

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE IF NOT EXISTS `categorie` (
  `idCategorie` int(10) unsigned NOT NULL auto_increment,
  `titre` varchar(60) NOT NULL,
  `img` varchar(60) NOT NULL,
  `description` longtext NOT NULL,
  `visible` tinyint(4) NOT NULL,
  `admin` tinyint(4) NOT NULL,
  `ordre` int(10) NOT NULL,
  PRIMARY KEY  (`idCategorie`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `categorie`
--

INSERT INTO `categorie` (`idCategorie`, `titre`, `img`, `description`, `visible`, `admin`, `ordre`) VALUES
(1, 'Local Arena Games', '', '<p>Forum G&eacute;n&eacute;ral Local Arena Games</p>', 1, 0, 1),
(2, 'Lan', '', '<p>Pr&eacute;sentation des lans</p>', 1, 0, 2),
(3, 'Games', '', '<p>Jeux PC ou ... pas</p>', 1, 0, 3),
(4, 'Lan', '', '<p>Parler des lans entre admins</p>', 1, 1, 4),
(5, 'Site', '', '<p>Probl&ecirc;mes ou am&eacute;liorations trouv&eacute;es.</p>', 1, 1, 5);

-- --------------------------------------------------------

--
-- Structure de la table `charte`
--

DROP TABLE IF EXISTS `charte`;
CREATE TABLE IF NOT EXISTS `charte` (
  `idCharte` int(10) unsigned NOT NULL auto_increment,
  `idJeux` int(10) unsigned default NULL,
  `nom` varchar(60) NOT NULL,
  `ordre` int(10) NOT NULL,
  PRIMARY KEY  (`idCharte`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

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
  `idCharteArticle` int(10) unsigned NOT NULL auto_increment,
  `idCharte` int(10) unsigned NOT NULL,
  `titre` varchar(60) NOT NULL,
  `description` longtext,
  `ordre` int(10) NOT NULL,
  PRIMARY KEY  (`idCharteArticle`),
  KEY `idCharte` (`idCharte`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

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
  `idCompte` int(10) unsigned NOT NULL auto_increment,
  `idGrade` int(10) unsigned NOT NULL default '1',
  `login` varchar(60) NOT NULL,
  `password` varchar(60) NOT NULL,
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(30) NOT NULL,
  `email` varchar(60) NOT NULL,
  `msn` varchar(60) default NULL,
  `cp` varchar(5) default NULL,
  `ville` varchar(60) default NULL,
  `img` varchar(200) default 'no_logo.png',
  `phone` varchar(10) default NULL,
  `datenaissance` date NOT NULL,
  `dateins` datetime NOT NULL,
  `dateco` date NOT NULL,
  `temps` int(10) NOT NULL,
  `last_time_connexion` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `ip` varchar(15) NOT NULL,
  `jeuxprefere` varchar(100) default NULL,
  `site` varchar(100) default NULL,
  `configpc` longtext,
  `citationpreferee` varchar(140) default NULL,
  `description` longtext,
  `nbconnexion` int(10) unsigned default NULL,
  `keyvalidation` varchar(45) default NULL,
  `actif` int(10) unsigned default NULL,
  PRIMARY KEY  (`idCompte`),
  KEY `idGrade` (`idGrade`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Contenu de la table `compte`
--

INSERT INTO `compte` (`idCompte`, `idGrade`, `login`, `password`, `nom`, `prenom`, `email`, `msn`, `cp`, `ville`, `img`, `phone`, `datenaissance`, `dateins`, `dateco`, `temps`, `last_time_connexion`, `ip`, `jeuxprefere`, `site`, `configpc`, `citationpreferee`, `description`, `nbconnexion`, `keyvalidation`, `actif`) VALUES
(1, 1, 'Sieg', 'a16585fa2acbfe4761048c52d5987f166c027279', 'Méhault', 'Maxime', 'sieg@asso-lag.fr', 'maxime.me@hotmail.fr', '51100', 'Reims', 'Sieg.jpg', '', '1988-02-09', '2009-09-06 00:00:00', '2009-09-07', 1, '0000-00-00 00:00:00', '', 'Warcraft III, Wolfenstein, ...', 'www.asso-lag.fr', 'Change prochainement', 'Goutte à goutte, l''eau creuse la montage !', 'Président de la LAG, aime l''informatique ( logique ^^), les mangas, ciné .....', NULL, NULL, 1),
(2, 1, 'Ash', 'a5b6f4ea958a621f4a7def5ba052c59da94cdf1a', 'Moraux', 'Antoine', 'ash@asso-lag.fr', 'antoine_mo@hotmail.com', '38100', 'Grenoble', 'Ash.gif', '0670871427', '1988-06-14', '2009-09-06 00:00:00', '2009-09-07', 1, '0000-00-00 00:00:00', '', 'warcraft 3 tft, cs, quake 3 ^^   ', ' http://www.asso-lag.fr', 'Intel Core 2 Duo E8400 (OC : 3.8 Ghz), Asus P5K Delux Edition, 4Go DDR2 Dual Chanel Corsair XMS2, Asus ATI Radeon 4870 512mo, LG 22''', 'Faut pas parler aux cons, ça les instruit.', 'informatique, via ferrata, ski, manga, films, bars, ...', NULL, NULL, 1),
(3, 1, 'Ryzen', '3020d74a6f6ec0b146981d0db0c0d220949c225e', 'Bourgeois', 'Steevens', 'ryzen@asso-lag.fr', 'offspring0013@hotmail.com', '60200', 'COMPIEGNE', 'Ryzen.jpg', '0670729969', '1987-07-25', '2009-09-06 00:00:00', '2009-09-07', 1, '0000-00-00 00:00:00', '', 'Warcraft 3 / DDR ;) Pinball', 'http://www.asso-lag.fr', '', 'Les femmes c''est comme les cunilingus, un écart de langue et t''es dans la merde', 'Basket, Airsoft, Via ferrata, Informatique, manga , ....', NULL, NULL, 1),
(4, 1, 'Belette', '1d8ecb05b60f9c43b41469023ff38671665d4e7b', 'Frayon', 'Johan', 'belette@asso-lag.fr', 'belette_0161@hotmail.com', '02200', 'PERNANT', 'no_logo.png', '0609238392', '1987-05-26', '2009-09-06 00:00:00', '2009-09-07', 1, '0000-00-00 00:00:00', '', 'medal of honor, age of empire 2, ...', 'http://www.koopamania.fr', '', '', '', NULL, NULL, 1),
(5, 1, 'RisK.BreaKeR', 'dbf1ee3eb027dfc69ad9b3c6ac9f8803f0a875a6', 'Barrat', 'Eric', 'risk.breaker@asso-lag.fr', 'parodius02@msn.com', '02210', 'Rocourt-Saint-Martin', 'RisK.BreaKeR.jpg', '', '1973-09-06', '2009-09-06 00:00:00', '2009-09-07', 1, '0000-00-00 00:00:00', '', 'Warcraft 3TFT(DOTA .... ), Wolfenstein Enemy Territory,quake 3 ,Age Of empire 2, ...', 'http://www.asso-lag.fr', '', 'Je suis un G@MER', '', NULL, NULL, 1),
(12, 1, 'Valou', '080f0c3080879ebc1a33a0a3eb355ad9725a2899', 'Serrurier', 'Valérie', 'valerie.ser@gmail.com', 'valou2b@hotmail.com', '51100', 'Reims', 'no_logo.png', '', '1988-04-07', '2009-10-19 22:25:55', '2009-10-19', 0, '0000-00-00 00:00:00', '88.165.83.147', '', '', '', '', '', NULL, 'b4c2b4ad61174afe399100b02626e2cdf4b3c6ca', 1),
(13, 1, 'loulou', 'e521047be430cca4ff12bd81c97642cc928aefe9', 'semo', 'emmanuel', 'emmanuel1.semo@hotmail.fr', '', '75013', 'paris', 'no_logo.png', '', '1988-05-22', '2009-10-20 12:02:56', '2009-10-20', 0, '0000-00-00 00:00:00', '163.173.48.11', '', '', '', '', '', NULL, '9d4bae293c185e111fb4b5af66a151119dd29874', 1),
(14, 1, 'Pere Nucleaire', '674fe8c330da3025d2ae4f7d4c27719cf34ecd78', 'Durand', 'Xavier', 'xavier@emeutevisuelle.com', 'perenucleaire@hotmail.fr', '51100', 'Reims', 'no_logo.png', '0618972232', '1980-05-20', '2009-10-25 19:48:13', '2009-10-25', 0, '0000-00-00 00:00:00', '77.200.228.112', 'GTA 4, Left 4 Dead, Hearts Of Iron 2, Europa Universalis, Defcon, etc.', 'http://www.emeutevisuelle.com', 'Core 2 Duo 8400, 8800 GT, etc.', '', '', NULL, '9a0fe0719325e4f11f5581e8281ba15f52941509', 1),
(15, 1, 'MaRSiGnoU', 'f9e5a2536ef236fb4cef9220e65180549dc8fc20', 'Desirant', 'Louis', 'thegnou@hotmail.com', '', '02200', 'Soissons', 'MaRSiGnoU.png', '', '1993-08-03', '2009-10-27 09:34:08', '2009-10-27', 0, '0000-00-00 00:00:00', '92.142.250.54', '', '', '', 'Qui roule pète', '', NULL, '4a5bf167cfd305358e0d23bfeff25e884d08e898', 1),
(17, 1, 'charlotte car''s', '809fc1b07b99420b7d422c4484b8f2de72234637', 'jarzaguet', 'charlotte', 'banane.shake@hotmail.fr', '', '51100', 'reims', 'no_logo.png', '', '1989-02-17', '2009-10-29 18:38:22', '2009-10-29', 0, '0000-00-00 00:00:00', '79.87.12.165', '', '', '', '', '', NULL, '8113a6a2842558c816d3de6a5340afec3193a0f8', NULL),
(18, 1, 'legolas97', '6cd1781d8d9b8598584c96df300252a7cdcd0c0e', 'GENDRY', 'Fabien', 'fabien_bouvard@hotmail.com', '', '93500', 'PANTIN', 'no_logo.png', '', '1984-04-21', '2009-11-03 12:38:57', '2009-11-03', 0, '0000-00-00 00:00:00', '217.108.241.241', '', '', '', '', '', NULL, 'bbebdcad95e44d148d942169761b144d9373ded8', 1),
(19, 1, 'cooba', '42835cfe9fdbb0d46d3cd6a859da262461c9fcb1', 'tony', 'nolin', 'chezcooba@hotmail.fr', 'chezcooba@hotmail.fr', '02210', 'coincy', 'no_logo.png', '0323711706', '1990-10-03', '2009-11-03 19:59:05', '2009-11-03', 0, '0000-00-00 00:00:00', '90.34.38.26', 'WARXRAFT 3', '', 'CM:P5Q3 deluxeDDR3/graphe:GTX260DDR3/2gigaDDR3 ^^', 'être bon c''est bien, mais etre le meilleur c''est mieux !!!^^', '', NULL, '423e4451f48e8ea8e0e12aff0bf16392b16fb9a4', 1),
(20, 1, 'Gregz', '1d808a92032ff75376b5ad4dda15c577ae4e3bad', 'JUDAS', 'Grégoire', 'schwarzy90@hotmail.com', 'schwarzy90@hotmail.com', '02200', 'SOISSONS', 'no_logo.png', '', '1988-01-06', '2009-11-04 21:05:03', '2009-11-04', 0, '0000-00-00 00:00:00', '79.82.13.205', '', '', '', '', '', NULL, '4beba1476abd9d657fb3922573b49229b9a60fc2', 1),
(21, 1, 'Tremp', '0ff297052fe351874793456606f203cc59bb9b9e', 'Caillot', 'Jean Baptiste', 'caillot.jb@gmail.com', 'sheepshager@hotmail.fr', '51100', 'Reims', 'no_logo.png', '', '1988-01-10', '2009-11-05 18:28:41', '2009-11-05', 0, '0000-00-00 00:00:00', '88.165.83.147', 'WoW !! :D :P', '', 'Config de la mort qui tue !!', 'Je t''encule !!', '', NULL, '717fc4a1d41c1567cee0cfff909c0bc633e94d43', 1),
(22, 1, 'fafinou', '6070f1890b0c9860c7e62cd85a06d632593de9d7', 'Lehougre', 'Maxime', 'craps_fmj@hotmail.fr', '', '51100', 'Reims', 'no_logo.png', '0688511240', '1989-11-07', '2009-11-05 20:25:01', '2009-11-05', 0, '0000-00-00 00:00:00', '88.165.83.147', 'halo', '', '', '', '', NULL, 'fbe5299360aa94e8c16c6258c176eeac1fa4875a', 1),
(23, 1, 'Thonio', '68e4dd1df1a9745e87deeb0439021ccff2ab9067', 'Richard', 'Anthony', 'wass.thonio@hotmail.fr', '', '02210', 'rocourt st martin', 'Thonio.jpg', '', '1988-11-24', '2009-11-06 17:29:05', '2009-11-06', 0, '0000-00-00 00:00:00', '77.204.38.37', '', '', 'core 2 quad Q6600 // 4g de ram // hd 4870 X2', '', '', NULL, '7e519eefc8d940593ac26e699a6459b211b0fe13', 1);

-- --------------------------------------------------------

--
-- Structure de la table `config`
--

DROP TABLE IF EXISTS `config`;
CREATE TABLE IF NOT EXISTS `config` (
  `idConfig` int(10) unsigned NOT NULL auto_increment,
  `titre` varchar(60) default NULL,
  `cle` varchar(45) default NULL,
  `valeur` varchar(200) default NULL,
  PRIMARY KEY  (`idConfig`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `config`
--

INSERT INTO `config` (`idConfig`, `titre`, `cle`, `valeur`) VALUES
(1, 'Nombre max de news par page', 'nb_max_news_page', '2'),
(2, 'Nombre max de news partenaire par page', 'nb_max_news_partenaire_page', '5'),
(3, 'Ouverture du Forum', 'ouverture_forum', '1'),
(4, 'Mail de Contact', 'mail_contact', 'association.lag@gmail.com'),
(5, 'Key API Google Map', 'key_google', 'ABQIAAAADNrtNEKC87esbJai0XIwcRQWCLFO9fZBImejaIh1nL6hobfpIxTSenKP_pi6irnYBRQbOxSEfQ1HfA');

-- --------------------------------------------------------

--
-- Structure de la table `contact`
--

DROP TABLE IF EXISTS `contact`;
CREATE TABLE IF NOT EXISTS `contact` (
  `idContact` int(10) unsigned NOT NULL auto_increment,
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
  `lu` tinyint(1) default '0',
  `repondu` tinyint(1) default '0',
  PRIMARY KEY  (`idContact`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Contenu de la table `contact`
--

INSERT INTO `contact` (`idContact`, `titre`, `mail`, `type`, `IP`, `script`, `referrer`, `remote_host`, `os`, `language`, `user_agent`, `date`, `description`, `lu`, `repondu`) VALUES
(12, 'TÃ©lÃ©thon', 'fabien_bouvard@hotmail.com', 'Autre...', '217.108.241.241', '/index.php', 'http://www.asso-lag.fr/contact/form', '217.108.241.241', 'os non dispo', 'fr', 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4', '2009-11-03', 'Bonjour,\r\n\r\nJe viens de tomber sur votre projet de LAN pour le TÃ©lÃ©thon et je trouve que c''est une idÃ©e grandiose. Ca fait un moment que j''aimerais apporter mon soutien d''une maniÃ¨re ou d''une autre, et, avec ce projet, je peux l''apporter tout en m''Ã©clatant.\r\nDonc je serai interessÃ©.\r\nLa question que je me pose est la suite :\r\nFaut-il possÃ©der les jeux indiquÃ©s pour participer, ou fournissez-vous les jeux le temps de la LAN?\r\nJe demande Ã§a car je n''ai quasimment aucun de ces jeux, et je me vois mal acheter ceux auquels j''aimerais jouer juste pour une LAN.\r\nMerci d''avance pour votre rÃ©ponse.\r\nFabien', 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `fonction`
--

DROP TABLE IF EXISTS `fonction`;
CREATE TABLE IF NOT EXISTS `fonction` (
  `idFonction` int(10) unsigned NOT NULL auto_increment,
  `nom` varchar(40) NOT NULL,
  `ordre` int(10) NOT NULL,
  `afficher` tinyint(1) default NULL,
  `sceller` tinyint(1) default NULL,
  PRIMARY KEY  (`idFonction`)
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
  `idFonctionCompte` int(10) unsigned NOT NULL auto_increment,
  `idFonction` int(10) unsigned NOT NULL,
  `idCompte` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`idFonctionCompte`),
  KEY `idFonction` (`idFonction`),
  KEY `idCompte` (`idCompte`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Contenu de la table `fonctioncompte`
--

INSERT INTO `fonctioncompte` (`idFonctionCompte`, `idFonction`, `idCompte`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 3),
(4, 2, 4),
(5, 2, 5),
(10, 3, 10),
(9, 3, 9),
(11, 3, 11),
(12, 3, 12),
(13, 3, 13),
(14, 3, 15),
(16, 3, 17),
(17, 3, 18),
(18, 3, 19),
(19, 3, 14),
(20, 3, 20),
(21, 3, 21),
(22, 3, 22),
(23, 3, 23);

-- --------------------------------------------------------

--
-- Structure de la table `grade`
--

DROP TABLE IF EXISTS `grade`;
CREATE TABLE IF NOT EXISTS `grade` (
  `idGrade` int(10) unsigned NOT NULL auto_increment,
  `nom` varchar(30) NOT NULL,
  `nbmessages_mini` int(10) NOT NULL,
  `nbmessages_maxi` int(10) NOT NULL,
  PRIMARY KEY  (`idGrade`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `grade`
--

INSERT INTO `grade` (`idGrade`, `nom`, `nbmessages_mini`, `nbmessages_maxi`) VALUES
(1, 'Peon''Noob', 0, 25),
(2, 'Kikoo''Lol', 26, 50);

-- --------------------------------------------------------

--
-- Structure de la table `information`
--

DROP TABLE IF EXISTS `information`;
CREATE TABLE IF NOT EXISTS `information` (
  `idInformation` int(10) unsigned NOT NULL auto_increment,
  `titre` varchar(30) NOT NULL,
  `description` varchar(150) default NULL,
  `ordre` int(3) NOT NULL,
  `date` datetime NOT NULL,
  `img` varchar(50) NOT NULL,
  `affiche` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`idInformation`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `information`
--

INSERT INTO `information` (`idInformation`, `titre`, `description`, `ordre`, `date`, `img`, `affiche`) VALUES
(1, 'Local Arena Games', 'La Local Arena Games (LAG) est une association loi 1901 qui a pour but de regrouper un maximum de joueurs.', 2, '2009-10-10 11:00:00', 'Local_Arena_Games.jpg', 1),
(2, 'LAG Téléthon 2009', 'La LAG organise une LAN au profit du téléthon, de nombreux jeux seront joués lors de cette nuit de folie.', 1, '2009-10-10 11:00:00', 'LAG_Telethon_2009.jpg', 1);

-- --------------------------------------------------------

--
-- Structure de la table `jeux`
--

DROP TABLE IF EXISTS `jeux`;
CREATE TABLE IF NOT EXISTS `jeux` (
  `idJeux` int(10) unsigned NOT NULL auto_increment,
  `nom` varchar(30) NOT NULL,
  `type` varchar(20) NOT NULL,
  `datesortie` date NOT NULL,
  `img` varchar(255) NOT NULL,
  `lien` varchar(60) NOT NULL,
  `description` longtext,
  `nbclick` int(10) unsigned default NULL,
  PRIMARY KEY  (`idJeux`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Contenu de la table `jeux`
--

INSERT INTO `jeux` (`idJeux`, `nom`, `type`, `datesortie`, `img`, `lien`, `description`, `nbclick`) VALUES
(1, 'Warcraft III TFT (Dota)', 'Stratégie', '2003-07-04', '', 'http://eu.blizzard.com/fr-fr/games/war3/', '<p>The Frozen Throne est une extension pour le jeu de strat&eacute;gie Warcraft III sur PC. De nouveaux H&eacute;ros de L&eacute;gende et de nouvelles unit&eacute;s sont disponibles pour une qu&ecirc;te de 26 missions solo. Illidan, le d&eacute;mon que les joueurs ont connu dans Warcraft III est parvenu &agrave; s''&eacute;chapper et menace de nouveau le monde. Vous pourrez rejoindre les rangs des humains, des morts-vivants, des orcs et des elfes.</p>', NULL),
(2, 'Wolfenstein', 'FPS', '2009-08-28', '', 'http://www.wolfenstein.com/home/agegate?ref=home', '<p>Wolfenstein sur PC est le troisième volet de la célèbre série de FPS. Le titre nous plonge encore une fois en pleine Seconde Guerre mondiale, dans la peau de BJ Blazkowicz. Votre mission consiste à surveiller les recherches des nazis dans le domaine du paranormal. Vous serez rapidement confronté à des créations issues de dimensions parallèles ouvertes par les scientifiques du Reich.</p>', NULL),
(3, 'Quake 3', 'FPS', '1999-12-15', '', 'http://www.idsoftware.com/', '<p>Quake III Arena sur PC est un jeu de tir à la première personne orienté multijoueur. Un arsenal varié et complet est à votre disposition pour organiser une joyeuse boucherie seul ou par équipe. Les modes classiques du genre sont tous là (Capture The Flag, Possession, Deathmatch...).</p>', NULL),
(4, 'Call of Duty 4', 'FPS', '2007-11-09', '', 'http://www.callofduty.com/', '<p>Call of Duty 4 : Modern Warfare un jeu de tir en vue subjective sur PC qui se déroule dans un contexte contemporain et qui permet de suivre deux conflits fictifs en parallèle. Le premier place le joueur dans la peau d''un marine américain coincé dans une guérilla urbaine au Moyen-Orient, tandis que dans l''autre lui fait incarner un agent d''élite britannique embarqué dans des missions discrètes en Russie et Europe de l''Est. Plusieurs modes multijoueurs sont aussi de la partie.</p>', NULL),
(5, 'Counter Strike 1.6', 'FPS', '2000-12-11', '', 'http://store.steampowered.com/', '<p>Créé à partir du célèbre moteur de Half-Life, Counter-Strike sur PC est un jeu de tir à la première personne se jouant exclusivement en ligne. Le jeu, qui compte une grande communauté, vous permet de choisir votre camp entre les terroristes et les contre-terroristes. Plusieurs objectifs différents en fonction du camp adopté et de la carte choisie doivent être menés à bien afin de remporter la partie. Vous disposez également d''un large choix d''armes existantes afin de renforcer l''immersion.</p>', NULL),
(6, 'Starcraft', 'Stratégie', '1998-04-01', '', 'http://eu.blizzard.com/fr-fr/games/sc/', '<p>Starcraft est un jeu de strat&eacute;gie sur PC prenant place dans un univers futuriste. Le sc&eacute;nario oppose trois grandes factions : les humains, les protoss et les zergs. Chacune de ces races propose ses propres unit&eacute;s, b&acirc;timents, technologies ainsi que sa propre campagne de jeu solo. Starcraft est &eacute;galement jouable en ligne et n&eacute;cessite une faible configuration.</p>', NULL),
(7, 'Left 4 Dead', 'FPS', '2008-11-20', '', 'http://www.l4d.com/', '<p>Left 4 Dead sur PC est un FPS horrifique basé en grande partie sur la coopération. En effet, vous incarnez un personnage dans un groupe de quatre, mais les trois autres peuvent être dirigés par des amis. Echappez aux zombies en veillant donc les uns sur les autres. Pour corser le tout, le jeu offre la possibilité à quatre autres joueurs d''incarner des morts-vivants pour sillonner la ville et traquer les héros.</p>', NULL),
(8, 'Team Fortress 2', 'FPS', '2007-10-10', '', 'http://store.steampowered.com/', '<p>Team Fortress 2 est un jeu de tir à la première personne sur PC. Le jeu propose de se bastonner en réseau dans un univers très cartoon et coloré, mais qui n''en oublie pas pour autant d''inclure de nombreuses armes et arènes de jeu. Plusieurs personnages sont disponibles, avec leurs propres spécificités, armes et capacités, sur six cartes différentes.</p>', NULL),
(9, 'Trackmania Nations Forever', 'Course', '2008-04-16', '', 'http://www.trackmania.com/index.php?lang=fr', '<p>Faisant suite à TrackMania Nations, TrackMania Nations Forever sur PC est un jeu de courses arcade à vocation communautaire entièrement gratuit. Accompagné par un éditeur de circuits extrêmement complet, le titre permet de créer ses propres tracés ou vidéos pour ensuite les partager avec les autres joueurs sur internet.</p>', NULL),
(10, 'Age of Empires II', 'Stratégie', '1999-10-01', '', 'http://www.microsoft.com/Games/age2/', '<p>Age of Empires II est un jeu de strat&eacute;gie sur PC. C''est un contexte m&eacute;di&eacute;val qui est &agrave; l''honneur dans le titre, travers&eacute; par de grandes figures historiques, de Jeanne D''Arc &agrave; Saladin en passant par Gengis Kahn ou Yoshidune. Construisez votre empire et faites-le &eacute;voluer afin de r&eacute;gner en ma&icirc;tre absolu sur vos adversaires.</p>', NULL),
(11, 'Worms Armageddon', 'Action / Stratégie', '1999-02-01', '', 'http://wormsarmageddon.team17.com/main.html?page=home&area=w', '<p>Worms 2 : Armageddon sur PC marque le retour des lombrics. Le principe reste le m&ecirc;me : plusieurs &eacute;quipes de vers de terre d&eacute;biles s''affrontent sur des ar&egrave;nes &agrave; l''aide d''armes ridiculement mortelles. Prenez en compte le sens du vent et les diff&eacute;rents obstacles entre vous et votre cible et lancez-vous dans une boucherie &agrave; la dimension aussi tactique qu''al&eacute;atoire.</p>', NULL),
(12, 'Counter Strike Source', 'FPS', '2004-10-01', '', 'http://store.steampowered.com/', '<p>Counter-Strike : Source sur PC est un jeu de tir à la première personne qui se joue exclusivement en ligne et qui compte une grande communauté. Le jeu permet au joueur de choisir son camp entre les terroristes et les contre-terroristes. Plusieurs objectifs différents en fonction du camp adopté et de la carte choisie doivent être menées à bien afin de remporter la partie. Le jeu met également à disposition du joueur un large choix d''armes existantes afin de renforcer l''immersion.</p>', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `lan`
--

DROP TABLE IF EXISTS `lan`;
CREATE TABLE IF NOT EXISTS `lan` (
  `idLan` int(10) unsigned NOT NULL auto_increment,
  `nom` varchar(30) NOT NULL,
  `adresse` varchar(60) NOT NULL,
  `ville` varchar(60) NOT NULL,
  `cp` varchar(5) NOT NULL,
  `datedeb` datetime NOT NULL,
  `datefin` datetime NOT NULL,
  `img` varchar(255) NOT NULL,
  `nbmaxpers` int(10) NOT NULL,
  `prix` int(10) NOT NULL,
  `inscription` tinyint(1) NOT NULL default '0',
  `date_inscription` date default NULL,
  `telethon` tinyint(1) NOT NULL default '0',
  `prepaiement` tinyint(1) NOT NULL default '0',
  `prix_prepaiement` int(10) NOT NULL,
  `prix_prepaiement_paypal` int(10) NOT NULL,
  `extra` longtext,
  `description` longtext,
  `nbclick` int(10) unsigned default NULL,
  PRIMARY KEY  (`idLan`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `lan`
--

INSERT INTO `lan` (`idLan`, `nom`, `adresse`, `ville`, `cp`, `datedeb`, `datefin`, `img`, `nbmaxpers`, `prix`, `inscription`, `date_inscription`, `telethon`, `prepaiement`, `prix_prepaiement`, `prix_prepaiement_paypal`, `extra`, `description`, `nbclick`) VALUES
(1, 'LAG Téléthon 2009', 'Salle Poniatowsky', 'Mont Notre Dame', '02220', '2009-12-04 20:00:00', '2009-12-05 17:00:00', '', 75, 9, 1, '2009-10-29', 1, 1, 5, 6, '<p>Pour cet &eacute;v&eacute;nement, la LAG a r&eacute;fl&eacute;chi afin de mettre &agrave; votre disposition des "activit&eacute;s" suppl&eacute;mentaires. Apr&egrave;s quelques cerveaux grill&eacute;s, l''&eacute;quipe des administrateurs a sorti quelques id&eacute;es (seules 3 id&eacute;es sont ressorties sur l''ensemble des &nbsp;... autres) :</p>\r\n<ul>\r\n<li>Un tournoi&nbsp;<strong><span style="color: #ff0000;">Dance Dance Revolution</span>&nbsp;</strong>(DDR), il s''agit d''un jeu sur PS2 o&ugrave; l''on jouera sur un vid&eacute;o-projecteur. Pour ceux qu''il ne connaisse pas, regardez quelques vid&eacute;os sur youtube.</li>\r\n<li><strong><span style="color: #ff0000;">Bowling sur Wii</span></strong>, en effet, un tournoi bowling sur Wii est susceptible d''&ecirc;tre propos&eacute;. Le tournoi se r&eacute;alisera &agrave; l''aide d''une Wii (.. heureusement !!) et un vid&eacute;o-projecteur !</li>\r\n<li>Le meilleur pour la faim : un <strong><span style="color: #ff0000;">coin restauration</span></strong><strong>&nbsp;</strong>sera mis &agrave; disposition des joueurs o&ugrave; seront disponibles <strong>boissons</strong>, <strong>cr&ecirc;pes</strong>, <strong>gaufres</strong> ou encore des <strong>croque-monsieurs</strong>.</li>\r\n</ul>\r\n<p>Voici les meilleures id&eacute;es sorties par notre &eacute;quipe d''administrateur. Mais bon, si vous en avez, n''h&eacute;sitez pas en proposer, elles seront peut &ecirc;tre accept&eacute;es et r&eacute;alisables !! &nbsp;:D</p>', '<p>Afin de marquer les d&eacute;buts de la "<strong><span style="color: #ff0000;">Local Arena Games</span></strong>" (Association loi 1901 de jeux en r&eacute;seaux), nous organisons une LAN (<strong>jeux en r&eacute;seaux</strong>) au profit du <strong>T&eacute;l&eacute;thon</strong>. Cet &eacute;v&egrave;nement porte le nom de "<strong><span style="color: #ff0000;">LAG T&eacute;l&eacute;thon 2009</span></strong>" et se d&eacute;roulera &agrave; la Salle Poniatowki de <strong>Mont Notre Dame</strong> (situ&eacute; &agrave; <strong>20min de Soissons</strong> et <strong>30min de Reims</strong>) (<a href="http://maps.google.fr/maps?f=q&amp;source=s_q&amp;hl=fr&amp;geocode=&amp;q=mont+notre+dame+02&amp;sll=49.279453,3.832855&amp;sspn=0.681771,1.733093&amp;g=Mont-Notre-Dame,+Aisne,+Picardie&amp;ie=UTF8&amp;hq=&amp;hnear=Mont-Notre-Dame,+Aisne,+Picardie&amp;ll=49.227463,3.725739&amp;spn=0.716569,1.733093&amp;t=h&amp;z=10" target="_blank">voir plan</a>). Cet &eacute;v&egrave;nement d&eacute;butera le <strong><span style="color: #ff0000;">Vendredi 4 D&eacute;cembre 2009</span></strong> &agrave; partir de <strong>20h</strong> et se terminera le <strong><span style="color: #ff0000;">Samedi 5 D&eacute;cembre</span></strong> &agrave; <strong>17h</strong>. Cet &eacute;v&egrave;nement fait parti du programme officiel du T&eacute;l&eacute;thon, et est accr&eacute;dit&eacute; par "<span style="color: #ff0000;"><strong>l''Association Fran&ccedil;aise contre les Myopathies</strong></span>" (AFM) (<a href="http://www.afm-telethon.fr/" target="_blank">voir site</a>).</p>\r\n<p>Lors de cet &eacute;v&egrave;nement, <strong>aucun tournoi officiel</strong> ne sera organis&eacute;, nous souhaitons seulement r&eacute;unir un maximum de personnes pour une noble cause et que ces personnes passent une bonne soir&eacute;e autour d''un r&eacute;seau commun et de jeux vari&eacute;s. Une liste de jeux est propos&eacute;e avec de grands noms tels que <strong>Left 4 Dead</strong>, <strong>TrackMania</strong>, <strong>UT 2004</strong>, <strong>Quake 3</strong> et bien d''autres encore. Il faut noter que cette liste est non exhaustive et qu''il sera possible de jouer &agrave; bien d''autres jeux.</p>\r\n<p>Tout ceci pour un tarif raisonnable de <strong>5&euro; <span style="color: #ff0000;">minimum</span></strong> (&agrave; discr&eacute;tion) pour <strong>21 heures de jeux</strong> et une <strong>ambiance amicale</strong>. L''ensemble des b&eacute;n&eacute;fices r&eacute;alis&eacute;s lors de cet &eacute;v&egrave;nement est <strong>revers&eacute; &agrave; l''AFM</strong> qui servira directement pour la lutte des myopathies.</p>', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `lanjeux`
--

DROP TABLE IF EXISTS `lanjeux`;
CREATE TABLE IF NOT EXISTS `lanjeux` (
  `idLanJeux` int(10) unsigned NOT NULL auto_increment,
  `idLan` int(10) NOT NULL,
  `idJeux` int(10) NOT NULL,
  `nbmaxteam` int(10) NOT NULL,
  `nbmaxjoueur` int(10) NOT NULL,
  `nbmaxjoueurparteam` int(10) NOT NULL,
  `tournoi` tinyint(1) default NULL,
  `ordre` int(10) NOT NULL,
  PRIMARY KEY  (`idLanJeux`),
  KEY `idLan` (`idLan`),
  KEY `idJeux` (`idJeux`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Contenu de la table `lanjeux`
--

INSERT INTO `lanjeux` (`idLanJeux`, `idLan`, `idJeux`, `nbmaxteam`, `nbmaxjoueur`, `nbmaxjoueurparteam`, `tournoi`, `ordre`) VALUES
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
-- Structure de la table `lanjeuxjoueurteam`
--

DROP TABLE IF EXISTS `lanjeuxjoueurteam`;
CREATE TABLE IF NOT EXISTS `lanjeuxjoueurteam` (
  `idLanJeuxJoueurTeam` int(10) unsigned NOT NULL auto_increment,
  `idLanJoueur` int(10) unsigned NOT NULL,
  `idJeux` int(10) unsigned NOT NULL,
  `idTeam` int(10) unsigned NOT NULL default '1',
  PRIMARY KEY  (`idLanJeuxJoueurTeam`),
  KEY `idLanJoueur` (`idLanJoueur`),
  KEY `idJeux` (`idJeux`),
  KEY `idTeam` (`idTeam`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

--
-- Contenu de la table `lanjeuxjoueurteam`
--

INSERT INTO `lanjeuxjoueurteam` (`idLanJeuxJoueurTeam`, `idLanJoueur`, `idJeux`, `idTeam`) VALUES
(1, 1, 0, 1),
(2, 2, 1, 1),
(3, 2, 9, 1),
(4, 2, 5, 1),
(5, 3, 0, 2),
(6, 3, 8, 2),
(7, 3, 7, 2),
(8, 3, 5, 2),
(9, 4, 0, 1),
(10, 4, 1, 1),
(11, 4, 9, 1),
(12, 4, 7, 1),
(13, 4, 4, 1),
(14, 4, 3, 1),
(15, 4, 2, 1),
(16, 4, 11, 1),
(17, 5, 0, 1),
(18, 5, 10, 1),
(19, 5, 7, 1),
(20, 5, 5, 1),
(21, 5, 3, 1),
(22, 5, 11, 1),
(23, 6, 5, 1),
(24, 6, 3, 1),
(25, 6, 1, 1),
(26, 7, 4, 1),
(27, 8, 1, 3),
(28, 8, 8, 3);

-- --------------------------------------------------------

--
-- Structure de la table `lanjoueur`
--

DROP TABLE IF EXISTS `lanjoueur`;
CREATE TABLE IF NOT EXISTS `lanjoueur` (
  `idLanJoueur` int(10) unsigned NOT NULL auto_increment,
  `idLan` int(10) NOT NULL,
  `idCompte` int(10) NOT NULL,
  `dateins` date NOT NULL,
  `paiement` int(10) NOT NULL,
  `modepaiement` int(3) NOT NULL,
  `validation` tinyint(1) default '0',
  `present` tinyint(1) default '0',
  PRIMARY KEY  (`idLanJoueur`),
  KEY `idLan` (`idLan`),
  KEY `idCompte` (`idCompte`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Contenu de la table `lanjoueur`
--

INSERT INTO `lanjoueur` (`idLanJoueur`, `idLan`, `idCompte`, `dateins`, `paiement`, `modepaiement`, `validation`, `present`) VALUES
(1, 1, 12, '2009-10-21', 0, 1, 0, 0),
(2, 1, 15, '2009-10-27', 0, 0, 0, 0),
(3, 1, 19, '2009-11-03', 0, 0, 0, 0),
(4, 1, 14, '2009-11-04', 0, 3, 0, 0),
(5, 1, 20, '2009-11-04', 0, 3, 0, 0),
(6, 1, 21, '2009-11-05', 5, 1, 1, 0),
(7, 1, 22, '2009-11-05', 0, 0, 0, 0),
(8, 1, 23, '2009-11-06', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `lecture`
--

DROP TABLE IF EXISTS `lecture`;
CREATE TABLE IF NOT EXISTS `lecture` (
  `idLecture` int(10) unsigned NOT NULL auto_increment,
  `idCompte` int(10) unsigned NOT NULL,
  `idSujet` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`idLecture`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=232 ;

--
-- Contenu de la table `lecture`
--

INSERT INTO `lecture` (`idLecture`, `idCompte`, `idSujet`) VALUES
(4, 2, 3),
(3, 1, 3),
(5, 13, 3),
(6, 3, 3),
(89, 1, 8),
(8, 15, 3),
(145, 2, 5),
(176, 1, 12),
(72, 2, 6),
(71, 2, 8),
(223, 1, 11),
(88, 1, 6),
(222, 3, 11),
(82, 15, 6),
(142, 1, 5),
(159, 2, 10),
(127, 15, 8),
(106, 5, 8),
(63, 3, 8),
(158, 2, 13),
(114, 1, 9),
(61, 3, 6),
(100, 5, 6),
(99, 3, 5),
(96, 3, 9),
(108, 5, 5),
(123, 15, 7),
(119, 3, 7),
(196, 1, 13),
(121, 1, 7),
(124, 15, 9),
(221, 2, 11),
(198, 3, 16),
(207, 1, 14),
(152, 3, 13),
(189, 15, 4),
(175, 1, 10),
(150, 3, 10),
(188, 15, 16),
(163, 2, 9),
(187, 1, 16),
(165, 5, 13),
(174, 3, 12),
(167, 5, 10),
(181, 1, 4),
(206, 1, 17),
(171, 3, 4),
(202, 3, 14),
(205, 3, 17),
(200, 3, 15),
(208, 1, 15),
(209, 2, 17),
(210, 2, 12),
(211, 2, 14),
(212, 2, 15),
(213, 2, 4),
(214, 2, 16),
(220, 5, 12),
(216, 18, 8),
(217, 18, 16),
(219, 5, 11),
(224, 15, 11),
(228, 1, 19),
(227, 1, 18),
(229, 2, 18),
(230, 2, 19),
(231, 15, 18);

-- --------------------------------------------------------

--
-- Structure de la table `lien`
--

DROP TABLE IF EXISTS `lien`;
CREATE TABLE IF NOT EXISTS `lien` (
  `idLien` int(10) unsigned NOT NULL auto_increment,
  `titre` varchar(60) NOT NULL,
  `lien` varchar(60) NOT NULL,
  `ordre` int(10) NOT NULL,
  PRIMARY KEY  (`idLien`)
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
  `idMateriel` int(10) unsigned NOT NULL auto_increment,
  `nom` varchar(40) NOT NULL,
  `type` varchar(40) NOT NULL,
  `dateachat` date NOT NULL,
  `description` longtext,
  `ordre` int(10) default NULL,
  `img` varchar(200) default NULL,
  PRIMARY KEY  (`idMateriel`)
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
  `idMentionLegale` int(10) unsigned NOT NULL auto_increment,
  `titre` varchar(40) NOT NULL,
  `description` longtext,
  `ordre` int(10) default NULL,
  PRIMARY KEY  (`idMentionLegale`)
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
  `idMessage` int(10) unsigned NOT NULL auto_increment,
  `idSujet` int(10) unsigned NOT NULL,
  `idCompte` int(10) unsigned NOT NULL,
  `date_m` datetime NOT NULL,
  `date_edition` datetime NOT NULL,
  `auteur_edition` int(10) NOT NULL,
  `annotation_edition` varchar(250) NOT NULL,
  `description` longtext NOT NULL,
  `ip` varchar(15) NOT NULL,
  PRIMARY KEY  (`idMessage`),
  KEY `idSujet` (`idSujet`),
  KEY `idCompte` (`idCompte`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=79 ;

--
-- Contenu de la table `message`
--

INSERT INTO `message` (`idMessage`, `idSujet`, `idCompte`, `date_m`, `date_edition`, `auteur_edition`, `annotation_edition`, `description`, `ip`) VALUES
(12, 3, 13, '2009-10-20 12:06:43', '0000-00-00 00:00:00', 0, '', '<p><span style="color: #000000;">Bonjour a tous,<br /><br />je souhaiterais savoir si un tournoi cs sera organis&eacute; lors de la lan Lag - T&eacute;l&eacute;thon 2009 ? Si oui combien d''&eacute;quipes y aura-t-il? et des lots sont-ils pr&eacute;vus pour les 3 premi&egrave;res &eacute;quipes?<br /><br />Merci d''avance de vos r&eacute;ponses<br /><br />cordialement loulou</span></p>', '163.173.48.11'),
(13, 3, 1, '2009-10-20 17:25:38', '0000-00-00 00:00:00', 0, '', '<p>Salut Loulou,</p>\r\n<p>Alors, pour l''instant il n''y a pas de tournoi pr&eacute; d&eacute;fini !! nous allons essayer de faire en sorte de mettre un maximum de jeux et de faire tourner afin que le plus de monde joue au jeu.</p>\r\n<p>Il se peut que des tournois soient organis&eacute;s sur certains jeux comme TrackMania, CS ou autres afin &nbsp;mettre un peu de piquant dans la lan.</p>\r\n<p>Si nous organisons des tournois, il y aura des r&eacute;compenses pour les &eacute;quipes finalistes. Il se peut &eacute;galement que les tournois soient li&eacute;s afin de g&eacute;n&eacute;rer un seul classement global sur la lan.</p>\r\n<p>Les tournois d&eacute;pendent &eacute;galement du nombre d''inscrits &agrave; la lan.</p>\r\n<p>Mais il ne faut pas oublier que la lan a un but "fun" et qu''elle est destin&eacute;e au T&eacute;l&eacute;thon.</p>\r\n<p>&nbsp;</p>', '88.165.83.147'),
(14, 3, 13, '2009-10-21 07:15:52', '0000-00-00 00:00:00', 0, '', '<p>Bonjour Sieg,</p>\r\n<p>&nbsp;</p>\r\n<p>Merci Sieg de votre r&eacute;ponse si rapide, j''attends &agrave; pr&eacute;sent l''annonce des tournois qui seront pr&eacute;sents &agrave; la lan mais si un tournoi cs est organis&eacute;, il y a de forte chances pour que nous soyons pr&eacute;sents =).</p>\r\n<p>&nbsp;</p>\r\n<p>A bientot</p>\r\n<p>&nbsp;</p>\r\n<p>cordialement,</p>\r\n<p>&nbsp;</p>\r\n<p>josh</p>', '90.2.207.43'),
(15, 3, 1, '2009-10-21 11:09:18', '0000-00-00 00:00:00', 0, '', '<p>Salut,</p>\r\n<p>Ok, je te tiendrais au courant ....</p>\r\n<p>Mais cette lan n''est pas vraiment orient&eacute;e comp&eacute;tition mais plus d&eacute;tente et fun .... &nbsp;<img title="{#wink}" src="../images/smilies/wink.gif" border="0" alt="{#wink}" /></p>\r\n<p>Une Lan avec un vrai tournoi sera organis&eacute; au printemps 2010 &nbsp; <img title="{#biggrin}" src="../images/smilies/biggrin.gif" border="0" alt="{#biggrin}" /></p>\r\n<p>Mais si nous avons beaucoup de demandes de tournoi, certains seront organis&eacute;s</p>\r\n<p>@++</p>\r\n<p>Sieg</p>', '88.165.83.147'),
(16, 4, 15, '2009-10-27 09:39:41', '0000-00-00 00:00:00', 0, '', '<p>Salut ! Vous pensez qu''il y aura assez de monde pour faire un tournoi warcraft III ? Je me rappelle y''a deux ans y''avait juste Risk.Breaker qui voulait jouer...</p>', '92.142.250.54'),
(17, 4, 1, '2009-10-27 10:34:11', '0000-00-00 00:00:00', 0, '', '<p>Salut MaRSiGnoU,</p>\r\n<p>Je ne peux te r&eacute;pondre maintenant, &nbsp;j''esp&egrave;re avoir un nombre suffisant afin de lancer des parties de Warcraft III que ce soit en normal, Dota ou green TD.</p>\r\n<p>N''h&eacute;site pas &agrave; faire tourner l''info de ton c&ocirc;t&eacute;, car les joueurs de warcraft III sont souvent cach&eacute;s &nbsp;<img title="{#sad}" src="../images/smilies/sad.gif" border="0" alt="{#sad}" /></p>\r\n<p>Mais nous croisons les doigts !!!! &nbsp;<img title="{#biggrin}" src="../images/smilies/biggrin.gif" border="0" alt="{#biggrin}" /></p>', '88.165.83.147'),
(18, 4, 2, '2009-10-27 10:54:55', '0000-00-00 00:00:00', 0, '', '<p>Lup,</p>\r\n<p>Ben d&eacute;j&agrave; une grosse partie des admins vont faire des pauses Warcraft 3 <img title="{#biggrin}" src="../images/smilies/biggrin.gif" border="0" alt="{#biggrin}" />.</p>\r\n<p>D''ailleurs si tu y joues sur le net faut que tu passes ton nom sous battlenet ^^ comme &ccedil;a on pourra s''en faire de temps en temps ! (On fait souvent du dota ou du green td mais on pourra faire des parties normales aussi).</p>\r\n<p>L&agrave; on est sur la bonne voie pour faire plus de pub que les ann&eacute;es pr&eacute;c&eacute;dentes, donc on esp&egrave;re avoir plus de monde, py on compte sur les joueurs de war 3 de risk breaker pour la lan <img title="{#devil}" src="../images/smilies/devil.gif" border="0" alt="{#devil}" />.</p>', '86.64.192.254'),
(19, 4, 15, '2009-10-27 11:43:56', '0000-00-00 00:00:00', 0, '', '<p>Normalement j''ai deux potes qui font du dota / parties normales, &ccedil;a devrait le faire.</p>\r\n<p>Sinon mon compte c''est MaRSiGnoU ;) .</p>\r\n<p>Je vais voir si je trouve d''autres personnes, mais s''il faut absolument un warcraft l&eacute;gal je pense que je vais avoir du mal :D .</p>', '92.142.250.54'),
(20, 5, 1, '2009-10-27 11:58:01', '0000-00-00 00:00:00', 0, '', '<p>Pour faire le rapprochement &agrave; ce qu''a dit MarsiGnou dans son dernier message, une version l&eacute;gale des jeux n''est pas absolument n&eacute;cessaire non ????</p>\r\n<p>il faudrait faire en sorte d''avoir tous les m&ecirc;mes versions, donc de pr&eacute;parer l''ensemble des patchs</p>', '88.165.83.147'),
(21, 5, 2, '2009-10-27 12:15:11', '0000-00-00 00:00:00', 0, '', '<p>Ben en lan, on prend pratiquement jamais les versions officielles, le warcraft 3 crack&eacute; est nikel. On a juste &agrave; mettre les patchs qu''on download sur le net avant pour avoir les versions crack&eacute;es au m&ecirc;me niveau que les versions officielles et c''est good&nbsp;<img title="{#cool.frown}" src="../images/smilies/cool.gif" border="0" alt="{#cool.frown}" /> !</p>', '86.64.192.254'),
(22, 4, 2, '2009-10-27 12:33:25', '0000-00-00 00:00:00', 0, '', '<p>Ce n''est pas obligatoire un warcraft 3 l&eacute;gal, c''est juste conseill&eacute;&nbsp;<img title="{#happy}" src="../images/smilies/happy.gif" border="0" alt="{#happy}" />.</p>\r\n<p>Il suffit juste de venir avec sa version de warcraft 3 mis &agrave; jour via les patchs que l''on peut t&eacute;l&eacute;charger sur clubic ou autre pour que les versions officielles (automatiquement mis &agrave; jour en se connectant sur le battlenet) et les versions non "officiels" soient aux m&ecirc;me num&eacute;ro de version.</p>\r\n<p>(Je rappelle que ce sont les joueurs qui sont responsables de ce qu''il y a d''install&eacute; sur leur PC !)</p>', '86.64.192.254'),
(23, 4, 1, '2009-10-27 14:44:58', '0000-00-00 00:00:00', 0, '', '<p>Afin d''&ecirc;tre spur que l''ensemble des joueurs poss&egrave;dent la m&ecirc;me version, nous mettrons &agrave; leur disposition l''ensemble des patchs de warcraft III.</p>\r\n<p>Mon compte battle.net est Si3g, on sera verra dessus &nbsp;<img title="{#biggrin}" src="../images/smilies/biggrin.gif" border="0" alt="{#biggrin}" /></p>', '88.165.83.147'),
(24, 5, 3, '2009-10-27 15:57:06', '0000-00-00 00:00:00', 0, '', '<p>Et si vraiment sa merde on peut faire tourner un cd officiel pour les aider a lancer le jeu !</p>\r\n<p>Mais comme dis antoine avec les patchs logiquement ya pas de probl&ecirc;me</p>', '195.83.155.55'),
(25, 6, 3, '2009-10-27 16:12:45', '0000-00-00 00:00:00', 0, '', '<p>Bon il faut que quelqu''un lance la partie pr&eacute;sentation donc je me sacrifie et me d&eacute;voue !</p>\r\n<p>Salut &agrave; tous, moi c''est Steevens BOURGEOIS, alias Ryzen, secr&eacute;taire et responsable partenariats de la LAG.</p>\r\n<p>J''ai 22 ans et je suis actuellement &eacute;tudiant en Licence Pro Composite (fibre de carbone, etc ...)</p>\r\n<p>Je fais partie de l''asso depuis ses d&eacute;buts avec Ash. Je pratique le Basket r&eacute;guli&egrave;rement (je fais d''ailleurs partie de l''&eacute;quipe universitaire de Compiegne), plus occasionnellement j''aime pratiquer l''airsoft.</p>\r\n<p>Mon exp&eacute;rience dans le domaine du jeu : J''ai test&eacute; tout et n''importe quoi, j''ai pas mal jouer sur internet, &agrave; savoir CS Source, WAR 3, WOW, AOE 3, ...</p>\r\n<p>C''est a peu pr&egrave;s tout ;)</p>\r\n<p>Ryzen</p>', '195.83.155.55'),
(26, 6, 1, '2009-10-27 17:18:29', '0000-00-00 00:00:00', 0, '', '<p>Bien jou&eacute; Ryzen !!!! &nbsp;&nbsp;<img title="{#biggrin}" src="../images/smilies/biggrin.gif" border="0" alt="{#biggrin}" /></p>\r\n<p>Il en fallait un, tu as raison ...</p>', '88.165.83.147'),
(27, 7, 1, '2009-10-27 17:27:42', '0000-00-00 00:00:00', 0, '', '<p>Bon vu que Ryzen a commenc&eacute;, je vais le suivre ....</p>\r\n<p>Alors je suis Sieg, alias Maxime M&eacute;hault ( .. ou l''inverse <img title="{#devil}" src="../images/smilies/devil.gif" border="0" alt="{#devil}" />) , pr&eacute;sident et p&eacute;on''noob de l''asso !!!!</p>\r\n<p>Je suis en L3 d''informatique &agrave; la facult&eacute; de Reims. J''ai rejoins Ryzen et Ash dans l''asso GNL il y a quelques ann&eacute;es.</p>\r\n<p>J''essaie de d&eacute;couvrir un maximum de jeu qu''ils soient anciens ou non .... mais j''appr&eacute;cie notamment un bon petit FPS tel que Wolfenstein ou en encore du bourrin &agrave; la UT ou Quake 3&nbsp;<img title="{#biggrin}" src="../images/smilies/biggrin.gif" border="0" alt="{#biggrin}" />. Sinon je ne crache pas sur un petit Warcraft III (Dota, Green TD, ....).</p>\r\n<p>Apr&egrave;s ... c''est PRIVE !!!</p>\r\n<p>&nbsp;</p>\r\n<p>Sieg</p>', '88.165.83.147'),
(28, 7, 15, '2009-10-27 18:21:54', '0000-00-00 00:00:00', 0, '', '<p>Moi je me demande d''o&ugrave; il vient ce pseudo quand m&ecirc;me....</p>', '92.142.250.54'),
(29, 7, 1, '2009-10-27 19:23:20', '0000-00-00 00:00:00', 0, '', '<p><img title="{#happy}" src="../images/smilies/happy.gif" border="0" alt="{#happy}" /></p>\r\n<p>alors c''est assez simple, Sieg est le nom du personnage dans le jeu "Chaos Legion" et de plus Sieg veut dire "victoire" en allemand &nbsp;donc conclusion, je suis un PGM doubl&eacute; d''un kikoo''lol !!! &nbsp;<img title="{#innocent}" src="../images/smilies/innocent.gif" border="0" alt="{#innocent}" /></p>', '88.165.83.147'),
(30, 5, 1, '2009-10-27 19:24:23', '0000-00-00 00:00:00', 0, '', '<p>Tin je suis content, mon forum tourne de la mort qui tue !!!!</p>\r\n<p>je flood un peu aussi tant que j''y suis, je pourrais pas me faire ban, je suis Admin &nbsp;<img title="{#biggrin}" src="../images/smilies/biggrin.gif" border="0" alt="{#biggrin}" /></p>', '88.165.83.147'),
(31, 8, 15, '2009-10-27 22:46:15', '0000-00-00 00:00:00', 0, '', '<p>Il fallait absolument la poster..</p>\r\n<p>http://www.youtube.com/watch?v=9Q0ZAcUfM24</p>', '92.142.250.54'),
(32, 8, 1, '2009-10-27 23:07:47', '0000-00-00 00:00:00', 0, '', '<p>que dire ..... &nbsp;euh ... &nbsp;<img title="{#waw}" src="../images/smilies/waw.gif" border="0" alt="{#waw}" /> &nbsp;i love !! &nbsp;<img title="{#biggrin}" src="../images/smilies/biggrin.gif" border="0" alt="{#biggrin}" /></p>', '88.165.83.147'),
(33, 6, 3, '2009-10-28 09:41:26', '0000-00-00 00:00:00', 0, '', '<p>H&eacute;h&eacute; ! La course au meilleur posteur est de nouveau lanc&eacute;e ^^</p>', '195.83.155.55'),
(34, 8, 3, '2009-10-28 09:43:04', '0000-00-00 00:00:00', 0, '', '<p>C''est fort ^^</p>\r\n<p>&nbsp;</p>\r\n<p>Need faire pareil &agrave; Sieg <img title="{#love}" src="../images/smilies/love.gif" border="0" alt="{#love}" /></p>', '195.83.155.55'),
(35, 5, 3, '2009-10-28 09:45:07', '0000-00-00 00:00:00', 0, '', '<p>T''es pas le seul &agrave; &ecirc;tre Admin Donc ATTENTION <img title="{#devil}" src="../images/smilies/devil.gif" border="0" alt="{#devil}" /></p>', '195.83.155.55'),
(36, 5, 2, '2009-10-28 09:50:15', '0000-00-00 00:00:00', 0, '', '<p>Au lieu de faire le mariole steevens <img title="{#shifty}" src="../images/smilies/shifty.gif" border="0" alt="{#shifty}" />&nbsp;!</p>\r\n<p>finis de remplir toutes les informations sur ton compte&nbsp;<img title="{#tongue}" src="../images/smilies/tongue.gif" border="0" alt="{#tongue}" /></p>', '86.64.192.254'),
(37, 4, 3, '2009-10-28 09:50:37', '0000-00-00 00:00:00', 0, '', '<p>Comme a dis Ash, les Admin sont tr&egrave;s friand(pas sur de l''orthographe, a bah sa fait bien pour un admin :p) de DOTA, GREEN TD, bref warcraft 3 en g&eacute;n&eacute;ral.</p>\r\n<p>Donc si nous ne sommes pas trop occup&eacute;s &agrave; r&eacute;gler moulte probl&egrave;mes ou autre chose il y a moyen pour qu''il ai du fun autour de war 3.</p>\r\n<p>@ Risk : You''ll Go to Lose Again !!&nbsp; Big Smack&nbsp; <img title="{#love}" src="../images/smilies/love.gif" border="0" alt="{#love}" /></p>', '195.83.155.55'),
(38, 5, 3, '2009-10-28 09:57:54', '0000-00-00 00:00:00', 0, '', '<p>Mais euhhhhh !!!</p>\r\n<p>Je pourrais sui j''avasi acces a l''ancien forum. j''y avais mis une expression et je m''en rapelle plus :p</p>', '195.83.155.55'),
(39, 9, 2, '2009-10-28 10:24:17', '0000-00-00 00:00:00', 0, '', '<p>Bon je me sens oblig&eacute; de faire une pr&eacute;sentation avec les autres qui commencent &agrave; flooder le forum sur chaque sujet pour dire tiens hier j''ai mang&eacute; une pomme et toi?&nbsp;<img title="{#whistling}" src="../images/smilies/whistling.gif" border="0" alt="{#whistling}" /> (dit le mec qui poste un sujet !)</p>\r\n<p>Non je d&eacute;conne <img title="{#happy}" src="../images/smilies/happy.gif" border="0" alt="{#happy}" />. Faut bien de tout pour faire un monde <img title="{#tongue}" src="../images/smilies/tongue.gif" border="0" alt="{#tongue}" />.</p>\r\n<p>Bon sinon, mon pseudo c''est .... (regarde sur la gauche c''est marqu&eacute; au dessus de l''avatar), sinon on me connait plus sous le pseudo Freeman et mon nom =&gt; Antoine Moraux (21 ans).</p>\r\n<p>Ca fait un moment que je fais des lans, ma premi&egrave;re &eacute;tait en 1847, non je d&eacute;conne, il me semble que c''&eacute;tait en 2000/2001 &agrave; Berny Rivi&egrave;re ^^ . J''ai vu que des photos trainaient sur facebook (oui j''&eacute;tais bien jeune !).</p>\r\n<p>Depuis cette p&eacute;riode, je sentais l''envie d''organiser des lans et de participer &agrave; la vie d''une asso. L''occasion se pr&eacute;senta en 2004 &nbsp;avec l''asso Golden-Nethix-Lan et nous avons organis&eacute;s plusieurs &eacute;v&eacute;nements au profit du t&eacute;l&eacute;thon.</p>\r\n<p>La vie avance et les personnes peuvent de moins en moins consacrer de temps &agrave; l''association (Attention se n''est pas un reproche <img title="{#tongue}" src="../images/smilies/tongue.gif" border="0" alt="{#tongue}" />). Donc nous avons chang&eacute; de pr&eacute;sidence, de siege social et autre mais l''envie est toujours l&agrave;. Donc longue vie &agrave; la LAG !</p>\r\n<p>Sinon, je kiff bourriner comme un porc dans les fps style quake 3 (quoi ? c''est vieux mais non ty connais rien, t''en connais beaucoup des jeux qui font 400 mo en install&eacute;s, qui se refilent en deux secondes, qui tournent sur n''importe quelle b&eacute;cane et que tout le monde s''&eacute;clate un max !) . J''aime bien aussi CS ... 1.5 (non l&agrave; je d&eacute;conne je suis plus Source maintenant !), left 4 dead, warcraft 3, age 2 ...</p>\r\n<p>Donc voil&agrave;, j''ai pas le temps raconter plus ma vie, je suis entrain de bosser et j''ai une dead line &agrave; respecter &agrave; mon taff qui est &agrave; ... midi <img title="{#waw}" src="../images/smilies/waw.gif" border="0" alt="{#waw}" />.</p>\r\n<p>A bient&ocirc;t tout le monde pour une nouvelle aventure !</p>', '86.64.192.254'),
(40, 9, 3, '2009-10-28 10:34:54', '0000-00-00 00:00:00', 0, '', '<p>On le surnomme aussi&nbsp; : ....... <strong>La femme</strong> ou <strong>la blonde</strong> du temps ou il avait les cheveux long.</p>\r\n<p>&nbsp;</p>\r\n<p>D&eacute;sol&eacute; vieux mais je ressort un p''tit dossier. Et je vais t''&eacute;viter la peine de le ressortir le mien. oui le mien &eacute;tait Pigeon car je me suis fait chopp&eacute; &agrave; boufer des graines en cours de fran&ccedil;ais en 4eme <img title="{#tongue}" src="../images/smilies/tongue.gif" border="0" alt="{#tongue}" /></p>', '195.83.155.55'),
(41, 9, 1, '2009-10-28 12:33:02', '0000-00-00 00:00:00', 0, '', '<p>Avec une blonde et un pigeon .... &nbsp; &ccedil;a donne une belle vue d''ensemble du bureau de l''asso ....<img title="{#tongue}" src="../images/smilies/tongue.gif" border="0" alt="{#tongue}" /></p>', '88.165.83.147'),
(42, 5, 1, '2009-10-28 12:34:16', '0000-00-00 00:00:00', 0, '', '<p>cqfd : Ryzen is a peon</p>', '88.165.83.147'),
(43, 9, 3, '2009-10-28 14:49:41', '0000-00-00 00:00:00', 0, '', '<p>J''avoue en plus ya une belette aussi ^^ C''est l''arche de no&eacute; cette asso <img title="{#blink}" src="../images/smilies/blink.gif" border="0" alt="{#blink}" /></p>', '195.83.155.55'),
(44, 7, 3, '2009-10-28 14:50:34', '0000-00-00 00:00:00', 0, '', '<p>T''as oubli&eacute; le peon''noob ! C''est important <img title="{#happy}" src="../images/smilies/happy.gif" border="0" alt="{#happy}" /></p>', '195.83.155.55'),
(45, 5, 3, '2009-10-28 14:51:13', '0000-00-00 00:00:00', 0, '', '<p>Non c''est bon je l''ai retrouv&eacute; !! Comme quoi un pigeon sa a une tr&egrave;s bonne m&eacute;moire !</p>', '195.83.155.55'),
(46, 10, 3, '2009-10-28 15:55:01', '2009-10-29 16:35:44', 3, '', '<p>Bon il faut pr&eacute;voir les vid&eacute;o-projecteurs.</p>\r\n<p>&nbsp;</p>\r\n<p>Moi je suis entrain de voir avec l''UTC pour en avoir un mais c''est vraiment pas sur.</p>\r\n<p>Antoine est-ce que tu pourras avoir celui que tu as d''habitude ?</p>\r\n<p>Max, est-ce que ton universit&eacute; peut t''en pr&eacute;ter un ?</p>\r\n<p>&nbsp;</p>\r\n<p>Donc pour l''instant on a <span style="font-size: x-large;"><span style="font-family: impact,chicago;"><strong>2</strong></span></span><span style="font-size: large;"><span style="font-family: impact,chicago;"><strong></strong></span></span> vid&eacute;oprojs</p>', '195.83.155.55'),
(47, 11, 5, '2009-10-28 15:58:23', '0000-00-00 00:00:00', 0, '', '<p>Bonjour a tous vu que tout le monde s''est presente je me sent obliger de le faire aussi <img title="{#biggrin}" src="../images/smilies/biggrin.gif" border="0" alt="{#biggrin}" /></p>\r\n<p>alors moi c''est Eric Barrat alias RisK.BreaKeR , que dire de plus j''aime jouer &agrave; tout les jeux video en general Anciens et Recent , mes pr&eacute;f&eacute;rence : Warcraft 3 , age of empire 2 , du CS de temps en temps ( pas trop non plus ) , un bon QUAKE 3 !!! et plein d''autre....Sinon j''aime le Cin&eacute; , les mangas , Zic pleins de chose ..</p>\r\n<p>&nbsp;</p>', '92.147.115.120'),
(48, 12, 3, '2009-10-28 16:02:11', '2009-10-30 15:57:20', 3, '', '<p>Sur cette page je listerais ce que chaque partenaire nous offre ainsi que ce qu''il demande :</p>\r\n<p>&nbsp;</p>\r\n<p><span style="text-decoration: underline;"><strong>Thermaltake :</strong></span></p>\r\n<p>Il va falloir retirer Thermaltake de nos partenaires je crois.</p>\r\n<p>En effet ils n''ont pas r&eacute;pondu &agrave; ma demande.</p>\r\n<p>&nbsp;</p>\r\n<p><span style="text-decoration: underline;"><strong>Steelseries :</strong></span></p>\r\n<p>Steelseries relanc&eacute;. J''attend la r&eacute;ponse.</p>\r\n<p>&nbsp;</p>\r\n<p><strong><span style="text-decoration: underline;">Noctua :</span></strong></p>\r\n<p>Nous avons de la part de Noctua et Coolink, des goodies ainsi que des affiches.</p>\r\n<p>&nbsp;</p>\r\n<p><span style="text-decoration: underline;"><strong>Focus :</strong></span></p>\r\n<p>Je ne suis pas sur pour focus mais il me semble qu''ils nous envoie des jeux ainssi que des affiches.</p>\r\n<p>&nbsp;</p>\r\n<p><span style="text-decoration: underline;"><strong>Carrefour :</strong></span></p>\r\n<p>&nbsp;</p>', '195.83.155.55'),
(49, 11, 3, '2009-10-28 16:04:00', '0000-00-00 00:00:00', 0, '', '<p>Yesss Notre p&eacute;on''noob a fait son apparition ^^</p>\r\n<p>&nbsp;</p>\r\n<p>Salut Eric sa fait un bail qu''on a pas caus&eacute; ensemble =&gt; tu me manques <img title="{#love}" src="../images/smilies/love.gif" border="0" alt="{#love}" /></p>', '195.83.155.55'),
(50, 13, 3, '2009-10-28 16:05:08', '0000-00-00 00:00:00', 0, '', '<p>Serait-il possible d''ajouter en bas de chaque page du forum (visible seulement par les admins) tout ce qui sont connect&eacute;s sur le forum ?</p>', '195.83.155.55'),
(51, 7, 1, '2009-10-28 16:15:37', '0000-00-00 00:00:00', 0, '', '<p>Tu lirais correctement, tu aurais vu que cette mention a &eacute;t&eacute; pr&eacute;cis&eacute; lors de ma premi&egrave;re pr&eacute;sentation.</p>\r\n<p>&nbsp;</p>\r\n<p>donc &nbsp;cqfd =&gt; tu es un p&eacute;on !!!</p>', '88.165.83.147'),
(52, 13, 1, '2009-10-28 16:16:33', '0000-00-00 00:00:00', 0, '', '<p>euh ... vas-y !! fais le !!!!!!</p>', '88.165.83.147'),
(53, 7, 3, '2009-10-28 16:18:05', '0000-00-00 00:00:00', 0, '', '<p>S''pas faux ^^</p>\r\n<p>J''ai lu en diagonale la premi&egrave;re fois :p</p>\r\n<p>Sorry !</p>', '195.83.155.55'),
(54, 13, 3, '2009-10-28 16:19:19', '2009-10-29 11:16:35', 1, '<p>J''&eacute;dite ton message pour tester le nouvel ajout de la mort qui tue</p>', '<p>C''est pas moi le pro du codage c''est vous !</p>\r\n<p>Ce sont juste des id&eacute;es apr&egrave;s vous en faites ce que vous voulez !</p>\r\n<p>****** **</p>', '195.83.155.55'),
(55, 11, 15, '2009-10-28 16:30:22', '0000-00-00 00:00:00', 0, '', '<p>Le pro de war 3 <img title="{#crying}" src="../images/smilies/crying.gif" border="0" alt="{#crying}" />...</p>\r\n<p>C&eacute;tan&eacute;jtelam&eacute;</p>', '92.142.250.54'),
(56, 13, 1, '2009-10-29 10:45:33', '2009-10-29 10:45:58', 1, '', '<p>C''est pr&eacute;vu, ne t''inqui&egrave;tes pas !!!!</p>\r\n<p>&nbsp;</p>\r\n<hr />\r\n<p>&nbsp;Je profite de ce message pour l''&eacute;diter et voir ce que &ccedil;a donne !!</p>', '88.165.83.147'),
(57, 10, 1, '2009-10-29 11:33:08', '0000-00-00 00:00:00', 0, '', '<p>Merde j''ai du oublier de faire passer le message .... &nbsp;je croyais pourtant avoir envoyer un mail &agrave; tout le monde !!!!</p>\r\n<p>J''ai demand&eacute; &agrave; mon boulot et il m''en a pr&ecirc;t&eacute; <strong><span style="font-size: xx-large;">&nbsp;2</span></strong> &nbsp;. Un assez vieux qui fait une r&eacute;solution de 800x600 que je peux garder &nbsp;<img title="{#tongue}" src="../images/smilies/tongue.gif" border="0" alt="{#tongue}" />. Et un plus r&eacute;cent que je dois rendre apr&egrave;s l''&eacute;v&egrave;nement.</p>', '88.165.83.147'),
(58, 12, 1, '2009-10-29 11:34:22', '0000-00-00 00:00:00', 0, '', '<p>Oui pour Focus, je dois les recontacter mais ils doivent nous faire parvenir des goodies et affiches.</p>', '88.165.83.147'),
(59, 10, 2, '2009-10-29 11:48:35', '0000-00-00 00:00:00', 0, '', '<p>Moi je demanderai &agrave; mon p&egrave;re comme d''habitude pour en avoir un.</p>\r\n<p>Plus on en a, mieux c''est. Car si quelqu''un &agrave; un probl&egrave;me &agrave; la derni&egrave;re minute au moins on peut assurer car on en a plus.</p>\r\n<p>Donc n''h&eacute;sites pas &agrave; demander &agrave; l''utc steevens et insistes bien pour dire que c''est pour le t&eacute;l&eacute;thon <img title="{#cool.frown}" src="../images/smilies/cool.gif" border="0" alt="{#cool.frown}" />&nbsp;.</p>', '86.64.192.254'),
(60, 10, 3, '2009-10-29 16:35:26', '0000-00-00 00:00:00', 0, '', '<p>xD tkt je compte bien ^^</p>\r\n<p>&nbsp;</p>\r\n<p>Mais bon apparement ils ont pas l''air tr&egrave;s chaud !</p>', '195.83.155.55'),
(61, 13, 3, '2009-10-29 16:37:21', '0000-00-00 00:00:00', 0, '', '<p>ok good sujet clos alors.</p>\r\n<p>&nbsp;</p>\r\n<p>En parlant de clore un sujet vous avez prevu sa ? c''est peut etre deja en place.</p>\r\n<p>Histoire que l''on se retrouve pas avec un forum bord&eacute;lique trop vite.</p>', '195.83.155.55'),
(62, 14, 3, '2009-10-29 16:47:34', '0000-00-00 00:00:00', 0, '', '<p>J''ajoute cette partie en pr&eacute;visions.</p>\r\n<p>Max d&egrave;s que tu as des news pour Carrefour ajoute ici et dans la partie Partenaires STP</p>', '195.83.155.55'),
(68, 14, 1, '2009-10-30 17:58:35', '0000-00-00 00:00:00', 0, '', '<p>Il n''y a plus de barbeQ !!!</p>\r\n<p>J''ai pr&eacute;venu Ash la denri&egrave;re fois mais j''ai oubli&eacute; de faire passer le message. La description de l aLAN a &eacute;t&eacute; modifi&eacute;.</p>\r\n<p>Un barbecue au mois de d&eacute;cembre, c''est un peu chaud et pas assez certain. On s''est repli&eacute; vers des cr&ecirc;pes, gaufres et croques monsieurs, plus simple et bien aussi</p>', '78.115.35.139'),
(63, 15, 3, '2009-10-29 16:53:41', '0000-00-00 00:00:00', 0, '', '<p>Bon voila,</p>\r\n<p>&nbsp;</p>\r\n<p>J''ai une id&eacute;e qui m''est pass&eacute; par la t&ecirc;te lorsque je m''entrainais au basket.</p>\r\n<p>Etant donn&eacute; qu''il y a des paniers de basket dans la salle, nous pourrions organiser un jeu autour de sa ! Tirs de lancer franc par exemple avec un objectif &agrave; atteindre et avec un petit truc en r&eacute;compense.</p>\r\n<p>Le tout contre un prix ridicule mais qui inciterait les gens &agrave; jouer. Pendant ce temps nous on amasse plus pour le t&eacute;l&eacute;thon.</p>\r\n<p>&nbsp;</p>\r\n<p>Vous allez me dire le ballon et les PC sa fait pas bon m&eacute;nage mais en organisant un peu la salle pour &eacute;viter tout probl&egrave;me je pense que sa pourrait &ecirc;tre possible.</p>\r\n<p>&nbsp;</p>\r\n<p>Je pense que sa peut le faire.</p>\r\n<p>&nbsp;</p>\r\n<p>Donner moi votre avis</p>\r\n<p>&nbsp;</p>', '195.83.155.55'),
(64, 4, 15, '2009-10-29 22:42:55', '0000-00-00 00:00:00', 0, '', '<p>Ok &ccedil;a marche, je suppose qu''on pourra tester quelques cr&eacute;ations si y''a des World Editeurs ici :p .</p>\r\n<p>Sur ce, je m''enferme un mois dans ma chambre pour m''entrainer &agrave; Dota, rendez-vous en D&eacute;cembre :p .</p>', '92.142.250.54'),
(65, 4, 3, '2009-10-30 14:02:37', '0000-00-00 00:00:00', 0, '', '<p>Oui bien sur !</p>', '195.83.155.55'),
(66, 16, 3, '2009-10-30 15:48:13', '2009-10-30 18:10:02', 1, '', '<p>Bonjour &agrave; tous,</p>\r\n<p>&nbsp;</p>\r\n<p>Le covoiturage est devenu en ce moment un moyen tr&egrave;s efficace pour &agrave; la fois faire des &eacute;conomies et bien sur moins polluer.</p>\r\n<p>&nbsp;</p>\r\n<p>Nous avons inclus &agrave; notre syst&ecirc;me d''inscription une map dans cette optique</p>\r\n<p>Apr&egrave;s vous &ecirc;tre inscrits vous avez la possibilit&eacute; de cliquer sur votre pseudo et ainsi de voir, sur une map de la r&eacute;gion, tous les inscrits et o&ugrave; ils habitent plus ou moins.</p>\r\n<p>&nbsp;</p>\r\n<p>Si certains veulent faire ou peuvent proposer un covoiturage, n''h&eacute;sitez pas.</p>\r\n<p>&nbsp;</p>\r\n<p><span style="text-decoration: underline;">Edit de Sieg :</span></p>\r\n<p>J''en profite pour placer un lien vers cette <a href="../lan/viewinscrits?id=1" target="_blank"><strong><span style="color: #ff0000;">partie</span></strong></a>.</p>\r\n<p>Vous avez &eacute;galement la possibilit&eacute; de voir l''itin&eacute;raire &agrave; suivre afin de vous rendre &agrave; l''&eacute;v&egrave;nement depuis le menu "<strong><span style="color: #ff0000;"><a href="../lan/indexjoueur?id=1" target="_blank"><span style="color: #ff0000;">Mes Inscriptions</span></a></span></strong>" et en cliquant sur l''&eacute;v&egrave;nement souhait&eacute;.</p>', '195.83.155.55'),
(67, 17, 3, '2009-10-30 15:49:58', '0000-00-00 00:00:00', 0, '', '<p>Dites moi les gars pourquoi avoir limit&eacute; les titres de sujet &agrave; 30 caract&egrave;res ?</p>', '195.83.155.55'),
(69, 15, 1, '2009-10-30 17:59:45', '0000-00-00 00:00:00', 0, '', '<p>Nous avons d&eacute;j&agrave; la Wii &agrave; g&eacute;rer et le DDR sans compter le coin snack alors le basket sera torp je pense. &ccedil;a sert &agrave; rien de voir trop grand, nous sommes trop peu nombreux !!!!</p>', '78.115.35.139'),
(70, 17, 1, '2009-10-31 20:38:31', '2009-10-31 20:39:09', 1, '', '<p>car normalement un sujet n''est pas long mais il est vrai que 30 caract&egrave;res est un peu court, je vais peut etre voir pour le pass&eacute; &agrave; 60 !!</p>\r\n<p>Steevens, pour ce genre de question, tu pourrais envoyer un mail, &ccedil;a sert &agrave; rien de remplir le fofo dans la partie admin par ce genre de questions</p>\r\n<p>Le forum sert pour d&eacute;battre sur des am&eacute;liorations possibles et non pour des questions simples comme celles-ci.</p>\r\n<p>Merci</p>', '78.115.39.235'),
(71, 15, 2, '2009-11-01 16:03:58', '0000-00-00 00:00:00', 0, '', '<p>Je pense que max &agrave; raison. Il faut d&eacute;j&agrave; bien g&eacute;rer tout ce qu''on a pr&eacute;vu (sachant que c''est la premi&egrave;re fois qu''on fait du DDR et de la wii pour une lan). Donc peut &ecirc;tre pour une prochaine et si bien sur nous sommes plus nombreux pour g&eacute;rer toutes les activit&eacute;s.</p>\r\n<p>N''oublions qu''il faut se concentrer sur les jeux que nous proposons d&eacute;j&agrave; pendant la lan. Suite &agrave; nos pr&eacute;c&eacute;dentes exp&eacute;riences, nous savons qu''il est tr&egrave;s difficiles de faire tourner plusieurs jeux pendant la lan.</p>', '79.82.13.205'),
(72, 15, 3, '2009-11-01 17:09:19', '0000-00-00 00:00:00', 0, '', 'J avais completement zappe wii et DDR -_-\r\n\r\nAutant pour moi.', '195.83.155.55'),
(73, 14, 3, '2009-11-01 17:10:58', '0000-00-00 00:00:00', 0, '', 'ok sa me paraissait aussi bizarre que vous ajoutiez sa en plus du barbecue.\r\n\r\nC est cool de m en avoir parle . MERCI\r\n\r\n.....', '195.83.155.55'),
(74, 17, 3, '2009-11-01 17:12:28', '2009-11-01 17:12:42', 3, '', 'T es pas content bah tu effaces ...\r\n', '195.83.155.55'),
(75, 11, 5, '2009-11-03 16:37:15', '0000-00-00 00:00:00', 0, '', '<p>Mais j''espere bien ^_^</p>', '92.131.202.49'),
(76, 18, 15, '2009-11-07 19:37:01', '0000-00-00 00:00:00', 0, '', '<p>Je voulais savoir quel jeu exactement sera jou&eacute; pour les tournois, CSS ou CS 1.6 ? Car on ne peut s''inscrire quepour CS 1.6, mais il y a un forum pour les deux, et dans la charte les r&egrave;gles sont &eacute;nonc&eacute;es pour CSS.</p>\r\n<p>&nbsp;</p>', '92.142.202.70'),
(77, 18, 1, '2009-11-08 12:10:17', '0000-00-00 00:00:00', 0, '', '<p>Salut MaRSiGnoU,</p>\r\n<p>Alors pour faire simple, il n''y a pas de tournoi officiel, donc les 2 jeux pourront &ecirc;tre jou&eacute;s, avec un certain avantage &agrave; celui qui est le plus demand&eacute;. Si il y a beaucoup de teams, il se peut qu''un petit tournoi soit organis&eacute; mais sinon le but de cette lan est que tout le monde joue ensemble, que ce soit en team ou non.</p>\r\n<p>C''est pour cela que les deux jeux peuvent &ecirc;tre jou&eacute;s et celui retenant le plus de joueurs pourra &ecirc;tre propos&eacute; en tournoi.</p>', '88.165.83.147'),
(78, 19, 1, '2009-11-08 12:13:37', '0000-00-00 00:00:00', 0, '', '<p>Avis &agrave; tout les admins (enfin surtout ceux qui viennent sur le fofo)</p>\r\n<p>Avec Xavier, nosu avons r&eacute;alis&eacute; une convention de partenariat et l''avons envoy&eacute; &agrave; diff&eacute;rents magasins. Le Carrefour Market de Fismes a r&eacute;pondu positivement &agrave; notre demande. Nous nous verrons offrir un don d''environ 300&euro; de nourriture.</p>\r\n<p>Nous allons donc pouvoir mettre &agrave; disposition des joueurs, des cr&ecirc;tes, gauffres et croque-monsieur et bien s&ucirc;r des boissons (Coca, Oasis, Perrier et quelques RedBull)</p>\r\n<p>&nbsp;</p>\r\n<p>Je demande donc &agrave; ceux qui peuvent fournir crepi&egrave;re, appareils croque-monsieur/gauffres de se faire savoir car &ccedil;a serait le bienvenue.</p>\r\n<p>&nbsp;</p>\r\n<p>Merci</p>\r\n<p>&nbsp;</p>\r\n<p>Sieg</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>', '88.165.83.147');

-- --------------------------------------------------------

--
-- Structure de la table `multimedia`
--

DROP TABLE IF EXISTS `multimedia`;
CREATE TABLE IF NOT EXISTS `multimedia` (
  `idMultimedia` int(10) unsigned NOT NULL auto_increment,
  `titre` varchar(60) NOT NULL,
  `type` varchar(40) NOT NULL,
  `date` datetime NOT NULL,
  `lien` varchar(120) default NULL,
  `description` longtext,
  `nbclick` int(10) unsigned default NULL,
  PRIMARY KEY  (`idMultimedia`)
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
  `idMultimediaCom` int(10) unsigned NOT NULL auto_increment,
  `idMultimedia` int(10) unsigned NOT NULL,
  `idCompte` int(10) unsigned NOT NULL,
  `date` date NOT NULL,
  `description` longtext,
  PRIMARY KEY  (`idMultimediaCom`),
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
  `idNews` int(10) unsigned NOT NULL auto_increment,
  `idCompte` int(10) unsigned NOT NULL,
  `idPartenaire` int(10) unsigned default NULL,
  `titre` varchar(60) NOT NULL,
  `date` datetime NOT NULL,
  `type_n` varchar(20) default NULL,
  `img` varchar(200) default NULL,
  `lien` varchar(200) default NULL,
  `description` longtext,
  PRIMARY KEY  (`idNews`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Contenu de la table `news`
--

INSERT INTO `news` (`idNews`, `idCompte`, `idPartenaire`, `titre`, `date`, `type_n`, `img`, `lien`, `description`) VALUES
(1, 0, 0, 'La LAG ', '2009-10-10 10:00:00', 'Association', NULL, NULL, '<p>\r\n<p class="Corps" style="tab-stops: 35.45pt 70.85pt 106.3pt 5.0cm 177.15pt 212.6pt 248.05pt 283.45pt 318.9pt 354.35pt 389.75pt 425.2pt 460.65pt;">Salut &agrave; tous,</p>\r\n<p class="Corps" style="tab-stops: 35.45pt 70.85pt 106.3pt 5.0cm 177.15pt 212.6pt 248.05pt 283.45pt 318.9pt 354.35pt 389.75pt 425.2pt 460.65pt;">Nous avons le plaisir de vous pr&eacute;senter notre petite prot&eacute;g&eacute;e, la <strong style="mso-bidi-font-weight: normal;">Local Arena Games</strong>. En effet, les anciens membres de l&rsquo;association <strong style="mso-bidi-font-weight: normal;">Golden Nethix Lan</strong> (GNL pour les intimes) ont d&eacute;cid&eacute;s de se regrouper sous le nom d&rsquo;une nouvelle association, la <strong style="mso-bidi-font-weight: normal;">LAG</strong> !<span style="mso-spacerun: yes;">&nbsp; </span>:D. Le si&egrave;ge social ayant chang&eacute;, les &eacute;v&eacute;nements se d&eacute;rouleront maintenant dans une salle plus grande, o&ugrave; nous pourrons accueillir plus de joueurs. Cette salle se trouve &agrave; <strong>Mont Notre Dame</strong> (02220), village situ&eacute; entre Soissons et Reims. Avec cette salle, nous avons la possibilit&eacute; de mettre en place des &laquo;&nbsp;plus&nbsp;&raquo; tels qu&rsquo;un coin restauration, ou encore des activit&eacute;s sur console (PS2, Wii, ...)</p>\r\n<p class="Corps" style="tab-stops: 35.45pt 70.85pt 106.3pt 5.0cm 177.15pt 212.6pt 248.05pt 283.45pt 318.9pt 354.35pt 389.75pt 425.2pt 460.65pt;">La LAG revient donc avec le plein de PGM ... euh ... non &hellip; plut&ocirc;t <strong style="mso-bidi-font-weight: normal;">d&rsquo;enthousiasme</strong> et esp&egrave;re vous voir nombreux lors de ses &eacute;v&eacute;nements.</p>\r\n<p class="Corps" style="tab-stops: 35.45pt 70.85pt 106.3pt 5.0cm 177.15pt 212.6pt 248.05pt 283.45pt 318.9pt 354.35pt 389.75pt 425.2pt 460.65pt;">@ bient&ocirc;t</p>\r\n<p class="Corps" style="tab-stops: 35.45pt 70.85pt 106.3pt 5.0cm 177.15pt 212.6pt 248.05pt 283.45pt 318.9pt 354.35pt 389.75pt 425.2pt 460.65pt;">L&rsquo;&eacute;quipe de la LAG</p>\r\n</p>\r\n<p>&nbsp;</p>'),
(2, 0, 0, 'LAG Téléthon 2009', '2009-10-10 11:00:00', 'Lan', NULL, '', '<p>&nbsp;Salut &agrave; tous,</p>\r\n<p class="Corps" style="tab-stops: 35.45pt 70.85pt 106.3pt 5.0cm 177.15pt 212.6pt 248.05pt 283.45pt 318.9pt 354.35pt 389.75pt 425.2pt 460.65pt;">Reprenons notre s&eacute;rieux, le premier &eacute;v&eacute;nement organis&eacute; par la LAG sera, comme &agrave; son habitude, une LAN <strong style="mso-bidi-font-weight: normal;">enti&egrave;rement</strong> au profit du t&eacute;l&eacute;thon. Cet &eacute;v&eacute;nement porte le nom de &laquo;<strong style="mso-bidi-font-weight: normal;">LAG T&eacute;l&eacute;thon 2009</strong>&raquo; et se d&eacute;roulera &agrave; la salle Poniatowsky de Mont Notre Dame (02220). Lors de cette lan, l&rsquo;association LAG sera partenaire complet du T&eacute;l&eacute;thon, en effet, une demande d&rsquo;agr&eacute;ment aupr&egrave;s de l&rsquo;AFM T&eacute;l&eacute;thon vient d&rsquo;&ecirc;tre d&eacute;pos&eacute;e. <span style="mso-spacerun: yes;">&nbsp;</span>Ainsi, nous garantissons que l&rsquo;ensemble des entr&eacute;es et des ventes seront enti&egrave;rement revers&eacute;es au profit du T&eacute;l&eacute;thon.</p>\r\n<p class="Corps" style="tab-stops: 35.45pt 70.85pt 106.3pt 5.0cm 177.15pt 212.6pt 248.05pt 283.45pt 318.9pt 354.35pt 389.75pt 425.2pt 460.65pt;">La LAG a choisi de r&eacute;aliser une lan &laquo;&nbsp;<strong style="mso-bidi-font-weight: normal;">fun</strong>&nbsp;&raquo;. En effet, aucun &laquo;vrai&raquo; tournoi ne sera organis&eacute;, nous visons des jeux plus vari&eacute;s qui offrent en mode multi-joueurs de bons moments. Les jeux choisis sont nombreux mais certains ressortent plus que d&rsquo;autres comme <strong>Left 4 Dead</strong> , <strong>CS 1.6</strong> ou m&ecirc;me <strong>TrackMania</strong>. L&rsquo;&eacute;quipe de la LAG esp&egrave;re que cette initiative vous plaira et reste &agrave; votre disposition pour toutes questions ou propositions.</p>\r\n<p class="Corps" style="tab-stops: 35.45pt 70.85pt 106.3pt 5.0cm 177.15pt 212.6pt 248.05pt 283.45pt 318.9pt 354.35pt 389.75pt 425.2pt 460.65pt;">@ bient&ocirc;t</p>\r\n<p class="Corps" style="tab-stops: 35.45pt 70.85pt 106.3pt 5.0cm 177.15pt 212.6pt 248.05pt 283.45pt 318.9pt 354.35pt 389.75pt 425.2pt 460.65pt;">L&rsquo;&eacute;quipe de la LAG</p>'),
(3, 0, 2, 'CITIES XL', '2009-10-06 12:59:04', 'Partenaire', 'CITIES_XL.jpg', 'http://www.focus-home.com/index_news.php?lang=fr&article=4891', '<p>Sortie le 8 octobre sur PC, Cities XL, le city builder d&eacute;velopp&eacute; par le studio fran&ccedil;ais Monte Cristo est un titre tr&egrave;s ambitieux qui associe adroitement jeu de gestion urbaine, jeu massivement multi-joueurs et r&eacute;seau social.<br /><br />MODE SOLO &ndash; DECRYPTAGE<br />Qui n&rsquo;a jamais pest&eacute; &agrave; la vue des fumerolles brun&acirc;tres s&rsquo;&eacute;chappant d&rsquo;une usine ? Ou d&eacute;plorant l&rsquo;absence d&rsquo;un cin&eacute;ma o&ugrave; inviter sa muse ? Contre les trac&eacute;s fantaisistes de certains carrefours, la construction d&rsquo;un stade alors qu&rsquo;une clinique suppl&eacute;mentaire ne serait pas de trop, la rar&eacute;faction des espaces verts, la hausse du co&ucirc;t de la vie, etc ? Autant de revendications l&eacute;gitimes qu&rsquo;il est d&eacute;sormais possible d''exaucer d''un clic, gr&acirc;ce &agrave; Cities XL.<br /><br />Dans la grande tradition des meilleurs jeux de gestion urbaine, Cities XL propose un mode solo o&ugrave; le r&eacute;alisme pouss&eacute; &agrave; l&rsquo;extr&ecirc;me permet de cr&eacute;er de v&eacute;ritables m&eacute;tropoles virtuelles tr&egrave;s sophistiqu&eacute;es.<br /><br />Au-del&agrave; de la d&eacute;couverte de la somme de probl&eacute;matiques que repr&eacute;sente la prise en charge de la destin&eacute;e d&rsquo;une ville, c&rsquo;est la profondeur vertigineuse de Cities XL qui interpelle et promet des heures et des heures de r&eacute;flexion et de r&eacute;alisations gratifiantes. D&eacute;passant tout ce qui a &eacute;t&eacute; produit dans le genre, tant sur le plan du r&eacute;alisme graphique que de l''ergonomie, Cities XL invite les maires virtuels &agrave; assurer dans les moindres d&eacute;tails l&rsquo;essor de leur cit&eacute;, de la premi&egrave;re pierre de leur mairie &agrave; la construction de monuments pharaoniques. Pour cela, il va notamment falloir s&rsquo;adapter aux r&eacute;alit&eacute;s du terrain et veiller &agrave; la fluidit&eacute; du r&eacute;seau routier, impulser le d&eacute;veloppement de nombreux types d&rsquo;industrie et garantir l&rsquo;accessibilit&eacute; des ressources &eacute;nerg&eacute;tiques, d&eacute;velopper le tourisme ou encore &eacute;quilibrer taxes professionnelles et imp&ocirc;ts locaux pour ne pas d&eacute;courager entreprises et salari&eacute;s. Tout cela, et bien plus encore, en tenant compte des desideratas de tous les citoyens en mati&egrave;re d&rsquo;&eacute;ducation, de sant&eacute;, de s&eacute;curit&eacute;, de loisirs, de logement et d&rsquo;&eacute;cologie.<br /><br />Pens&eacute; pour un large public, les fans de city builder trouveront pl&eacute;thore de statistiques pour ajuster au mieux leur budget en fonction des besoins des citoyens, les novices quant &agrave; eux pourront faire appel &agrave; des conseillers virtuels qui les guideront pas &agrave; pas.<br /><br />&laquo;Depuis le premier jour nous voulions &ecirc;tre certains d&rsquo;&ecirc;tre comp&eacute;titifs avec les plus ambitieux city-builders existants en terme de contenu et de fonctionnalit&eacute;s&raquo;, explique J&eacute;r&ocirc;me Gastaldi, CEO de Monte Cristo. &laquo;Nous voulons que les joueurs appr&eacute;cient d&rsquo;abord Cities XL en mode solo, et les convaincre ensuite de rejoindre l&rsquo;offre Plan&egrave;te, qui ouvre alors les portes vers une exp&eacute;rience de jeu encore plus importante et ambitieuse&raquo;.</p>\r\n<p>CARACTERISTIQUES DU MODE SOLO</p>\r\n<ul>\r\n<li>25 cartes aux paysages vari&eacute;s : des canyons aux collines verdoyantes en passant par les montagnes enneig&eacute;es, </li>\r\n<li>Pr&egrave;s de 500 b&acirc;timents bas&eacute;s sur des styles architecturaux vari&eacute;s (Europ&eacute;en, Am&eacute;ricain,&hellip;), </li>\r\n<li>De nombreuses structures civiles : 4 niveaux de richesse, 4 diff&eacute;rents types de besoins (Services, Environnement, Co&ucirc;t et Trafic) divis&eacute;s en de nombreuses sous-cat&eacute;gories (D&eacute;partement de Police et de Sapeurs-pompiers, Education, Loisir, Commerce, plusieurs type de Pollution, Taxes, Co&ucirc;t de la vie, Distance du travail&hellip;), </li>\r\n<li>Une s&eacute;lection riche d&rsquo;entreprises allant de l&rsquo;agriculture &agrave; l&rsquo;industrie lourde, en passant par les services, le tourisme, &hellip; </li>\r\n<li>Une simulation profonde mais facile d&rsquo;acc&egrave;s bas&eacute;e sur 14 ressources, &agrave; &eacute;changer avec une IA opportuniste (&eacute;lectricit&eacute;, gestion des ordures, agriculture, eau, carburant, &hellip;) </li>\r\n<li>Un ambitieux syst&egrave;me de trafic et moyens de transports incluant de nombreux types de routes (5 diff&eacute;rentes largeurs, co&ucirc;ts, qualit&eacute;s et capacit&eacute;s), autoroutes, a&eacute;roports, ports maritimes et plus encore </li>\r\n<li>Des outils de construction en temps r&eacute;el sans pr&eacute;c&eacute;dent, permettant au joueur de cr&eacute;er des routes incurv&eacute;es, de construire des zones de b&acirc;timents de diverses formes, des ponts &eacute;labor&eacute;s ou bien encore des tunnels </li>\r\n<li>Un studio de cr&eacute;ation d&rsquo;avatar et une page de profil sur le Web</li>\r\n</ul>'),
(4, 0, 1, 'V2 SteelSeries Siberia Full-size Headset', '2009-09-18 13:18:44', 'Partenaire', 'V2_SteelSeries_Siberia_Full-size_Headset.jpg', 'http://www.steelseries.com/news/press_releases/steelseries_introduces_new_siberia_v2_headset', '<p>SteelSeries, le premier fabricant de p&eacute;riph&eacute;riques de jeux et d''accessoires, a pr&eacute;sent&eacute; aujourd''hui le nouveau V2 SteelSeries Siberia Full-size Headset. En tant que successeur &agrave; la signature SteelSeries Siberia qui a lanc&eacute; en 2004, la nouvelle Sib&eacute;rie v2 offre aux joueurs et aux amateurs de musique de haut-parleurs sup&eacute;rieurs et la technologie de microphone qui offre une qualit&eacute; sonore impeccable, des capacit&eacute;s de contr&ocirc;le int&eacute;gr&eacute;, et de design pour un confort accru et am&eacute;lior&eacute; de r&eacute;duction de bruit passive.</p>\r\n<p>L''original SteelSeries Siberia Full-size Headset est devenu un succ&egrave;s &eacute;norme dans la communaut&eacute; des joueurs professionnels et &agrave; &eacute;tendre son influence dans le monde de la musique utilis&eacute;s par des musiciens professionnels dans plusieurs vid&eacute;os de grande musique profil international.&nbsp;<br />En tant que mise &agrave; niveau vers la Sib&eacute;rie originale, la V2 du sport une "invisible" syst&egrave;me de microphone r&eacute;tractable qui sort de l''oreille gauche-Cup, permettant ainsi une plus pratique et plus convivial Voyage-casque particulier pour les joueurs du tournoi.</p>\r\n<p>La Sib&eacute;rie v2 a augment&eacute; 50mm orateurs permettra d''amplifier les basses et le volume global ainsi que d''am&eacute;liorer la r&eacute;ponse en fr&eacute;quence de 10-28,000 Hz. Optimis&eacute; pour les joueurs professionnels, o&ugrave; le son d&eacute;taill&eacute; Crisp peut faire la diff&eacute;rence entre gagner ou perdre, l''ambiance sonore caract&eacute;ristiques cristallines haut, bas, et les m&eacute;diums. Les joueurs du tournoi et les joueurs de cette bataille avec les m&eacute;nages forte appr&eacute;cierez son oreille ferm&eacute;e nouvelle conception de la Coupe qui comprend des coussins rembourr&eacute;s en cuir &eacute;pais compil&eacute;s &agrave; partir de mousse isolation phonique d''augmenter l''isolation du bruit ext&eacute;rieur, particuli&egrave;rement important pour les first-person shooter (FPS) Les Jeux lorsque des pas et la grenade Pin-gouttes sont si importantes pour l''entendre.</p>\r\n<p>"Chaque &eacute;l&eacute;ment de la Sib&eacute;rie V2 a &eacute;t&eacute; optimis&eacute; pour les jeux pro-, ce qui rend ce casque un morceau pr&eacute;f&eacute;r&eacute; de l''&eacute;quipement pour les meilleurs au monde les joueurs PC concurrentiel&raquo;, a d&eacute;clar&eacute; Bruce Hawver, CEO de SteelSeries. "Ce qui est encore plus impressionnant, c''est que le kit oreillette est multifonctionnel avec sa capacit&eacute; &agrave; offrir une exp&eacute;rience audio hors pair pour les amoureux de la musique et des utilisateurs de services VoIP.</p>\r\n<p>Les sp&eacute;cifications des produits cl&eacute;s de la V2 SteelSeries Siberia Full-size Headset comprennent:</p>\r\n<ul>\r\n<li>50mm de haut-parleurs </li>\r\n<li>Imp&eacute;dance: 32 ohms </li>\r\n<li>Fr&eacute;quence: 10-28,000 Hz </li>\r\n<li>SPL @ 1kHz: 112dB </li>\r\n<li>C&acirc;ble: 1m + 2 m d''extension </li>\r\n<li>Jacks: 2 * 3,5 mm </li>\r\n<li>Microphone escamotable: 50-16,000 Hz, unidirectionnel</li>\r\n</ul>'),
(5, 0, 4, 'Noctua NH-U12P SE2', '2009-08-31 14:01:20', 'Partenaire', 'Noctua_NH-U12P_SE2.jpg', 'http://www.noctua.at/main.php?show=news_list&news_id=49&lng=fr', '<p>Noctua a pr&eacute;sent&eacute; le 31 Aout 2009 la derni&egrave;re version de son succ&egrave;s NH-U12P s&eacute;rie de premi&egrave;re qualit&eacute; calme refroidissement de processeur. Le NH-U12P nouveau SE2 prend d&eacute;sormais en charge LGA1156 &agrave; venir d''Intel Core i5 et bas&eacute;e Core i7 "Lynnfield" CPU tout en maintenant la compatibilit&eacute; avec LGA1366, 775 et les processeurs AM3. Comme la version SE1366, le NH-U12P SE2 offre un paquet de valeur haut de gamme avec Noctua NT-H1 P&acirc;te thermique et deux NF-P12 ventilateurs de 120mm.&nbsp;</p>\r\n<p>"Les utilisateurs LGA1366 aim&eacute; notre &eacute;dition sp&eacute;ciale du refroidisseur NH-U12P, mais beaucoup demand&eacute; s''ils pouvaient obtenir le pack premium, m&ecirc;me &agrave; double ventilateur pour les sockets aussi d''autres", explique Mag. Roland Mossig, Noctua PDG. "Nous avons pens&eacute; que le lancement imminent de nouveaux processeurs Intel Lynnfield serait une excellente occasion de pr&eacute;senter une nouvelle &eacute;dition sp&eacute;ciale qui soutient non seulement le nouveau socket, mais offre &eacute;galement la compatibilit&eacute; multi-socket du NH originale -U12P, ainsi le NH-U12P SE2 est n&eacute;. "&nbsp;</p>\r\n<p>S''appuyant sur le succ&egrave;s du NH-U12P originale ainsi que le NH-U12P SE1366, qui ont re&ccedil;u plus de 150 distinctions et prix de la presse internationale, le NH-U12P nouveau SE2 continue le NH-U12P s&eacute;rie ''h&eacute;ritage de superbes calme refroidissement. Comme le mod&egrave;le SE1366, le NH-U12P nouveau SE2 est livr&eacute; avec deux de renomm&eacute;e Noctua NF-fans de prime P12 pour une performance encore am&eacute;lior&eacute;e.&nbsp;</p>\r\n<p>En utilisant les plus r&eacute;centes SecuFirm2 Noctua''s &trade; multi-socket syst&egrave;me de montage, le NH-U12P SE2 n''ajoute pas seulement un soutien pour le socket LGA1156 nouvelle, mais offre &eacute;galement une compatibilit&eacute; totale avec LGA1366 d''Intel et 775 ainsi que AM2 d''AMD, AM2 + et sockets AM3. Comme les utilisateurs en sont venus &agrave; attendre des syst&egrave;mes SecuFirm2 &trade; de Noctua, le NH-U12P SE2 montage combine la fiabilit&eacute; exceptionnelle, la pression de contact optimal et facile, installation simple.&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Prix et disponibilit&eacute;</strong>&nbsp;</p>\r\n<p>Le NH-U12P SE2 sera disponible dans les magasins &agrave; la mi-Septembre au prix public conseill&eacute; de 56,90 EUR / USD 64,90.&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>'),
(7, 0, 0, 'LAG Téléthon 2009 sur JeuxVideo.com', '2009-11-03 20:53:30', 'Lan', 'LAG_Telethon_2009_sur_JeuxVideos.com.png', '', '<p>&nbsp;</p>\r\n<p class="MsoNormal">Bonjour &agrave; tous,</p>\r\n<p class="MsoNormal">Nous souhaiterions remercier le site de <a href="http://www.jeuxvideo.com/etajvbis.htm" target="_blank"><strong>JeuxVideo.com</strong></a> pour avoir publier une news concernant le prochain &eacute;v&egrave;nement que nous organisons. Il s&rsquo;agit bien s&ucirc;r de la &laquo;&nbsp;<strong><span style="color: #ff0000;">LAG T&eacute;l&eacute;thon 2009</span></strong> &raquo;, une lan enti&egrave;rement au profit du T&eacute;l&eacute;thon soutenue par "l''<span style="color: #ff0000;"><span style="color: #000000;"><strong>Association Fran&ccedil;aise contre les Myopathies</strong></span></span>" (AFM).</p>\r\n<p class="MsoNormal">Vous pouvez consulter cette news gr&acirc;ce au lien suivant&nbsp;: <a href="http://www.jeuxvideo.com/news/2009/00038300-une-lan-pour-le-telethon.htm" target="_blank"><strong><span style="color: #ff0000;">Une LAN pour le T&eacute;l&eacute;thon</span></strong></a></p>\r\n<p class="MsoNormal">@ bient&ocirc;t</p>\r\n<p class="MsoNormal">L&rsquo;&eacute;quipe de la LAG</p>\r\n<p>&nbsp;</p>');

-- --------------------------------------------------------

--
-- Structure de la table `newscom`
--

DROP TABLE IF EXISTS `newscom`;
CREATE TABLE IF NOT EXISTS `newscom` (
  `idNewsCom` int(10) unsigned NOT NULL auto_increment,
  `idNews` int(10) unsigned NOT NULL,
  `idCompte` int(10) unsigned NOT NULL,
  `date` date NOT NULL,
  `description` longtext,
  PRIMARY KEY  (`idNewsCom`),
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
  `idNewsletter` int(10) unsigned NOT NULL auto_increment,
  `idAdmin` int(10) unsigned default NULL,
  `titre` varchar(100) default NULL,
  `date` datetime default NULL,
  `img` varchar(200) default NULL,
  `description` longtext,
  `IP` varchar(30) default NULL,
  PRIMARY KEY  (`idNewsletter`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Contenu de la table `newsletter`
--

INSERT INTO `newsletter` (`idNewsletter`, `idAdmin`, `titre`, `date`, `img`, `description`, `IP`) VALUES
(21, NULL, 'LAG TÃ©lÃ©thon 2009 (Lan pour le TÃ©lÃ©thon)', '2009-10-27 00:09:15', 'affiche_4.jpg', '<p>\r\n<p class="MsoNormal">Salut &agrave; tous,</p>\r\n<p class="MsoNormal">Afin de marquer le d&eacute;but de la &laquo;&nbsp;Local Arena Games&nbsp;&raquo; anciennement &laquo;&nbsp;GNL&nbsp;&raquo;, nous organisons une LAN enti&egrave;rement au profit du t&eacute;l&eacute;thon. Cet &eacute;v&eacute;nement porte le nom de &laquo;LAG T&eacute;l&eacute;thon 2009&raquo; et se d&eacute;roulera &agrave; la salle Poniatowsky de Mont Notre Dame (02220). Afin de garantir le bien fond&eacute; de l&rsquo;&eacute;v&egrave;nement, nous avons &eacute;t&eacute; accr&eacute;dit&eacute; par l&rsquo;AFM.</p>\r\n<p class="MsoNormal">La LAG a choisi de r&eacute;aliser une lan &laquo; fun &raquo;. En effet, aucun &laquo;vrai&raquo; tournoi ne sera organis&eacute;, nous visons des jeux plus vari&eacute;s qui offrent en mode multi-joueurs de bons moments. Les jeux choisis sont nombreux mais certains ressortent plus que d&rsquo;autres comme Left 4 Dead , CS 1.6 ou m&ecirc;me TrackMania. L&rsquo;&eacute;quipe de la LAG esp&egrave;re que cette initiative vous plaira et reste &agrave; votre disposition pour toutes questions ou propositions.</p>\r\n<p class="MsoNormal">Visitez notre tout nouveau site&nbsp;: <a href="http://www.asso-lag.fr">www.asso-lag.fr</a></p>\r\n<p class="MsoNormal">@ bient&ocirc;t</p>\r\n<p class="MsoNormal">L&rsquo;&eacute;quipe de la LAG</p>\r\n</p>', '88.165.83.147'),
(22, NULL, 'LAG Téléthon 2009', '2009-10-30 18:21:09', 'LAG_Telethon_2009.jpg', '<p>Bonjour &agrave; Tous,</p>\r\n<p>Afin de marquer les d&eacute;buts de la &laquo; <strong><span style="color: #ff0000;"><span style="font-size: x-small;">Local Arena Games</span></span></strong> &raquo; &nbsp;(Association loi 1901 de jeux en r&eacute;seaux), &nbsp;<br />nous&nbsp;organisons&nbsp;une&nbsp;LAN&nbsp;(<strong>jeux&nbsp;en&nbsp;r&eacute;seaux</strong>)&nbsp;au&nbsp;profit&nbsp;du&nbsp;<strong>T&eacute;l&eacute;thon</strong>.&nbsp;Cet&nbsp;&eacute;v&egrave;nement&nbsp;porte&nbsp;le&nbsp;nom&nbsp;de&nbsp; <br />&laquo;&nbsp;<strong><span style="color: #ff0000;">LAG&nbsp;T&eacute;l&eacute;thon&nbsp;2009&nbsp;</span></strong>&raquo;&nbsp;et&nbsp;se&nbsp;d&eacute;roulera&nbsp;&agrave;&nbsp;la&nbsp;salle&nbsp;Poniatowski&nbsp;de&nbsp;<strong>Mont&nbsp;Notre&nbsp;Dame</strong>&nbsp;(situ&eacute;&nbsp;&agrave;&nbsp;<strong>20min&nbsp;de&nbsp; <br />Soissons</strong>&nbsp;et&nbsp;<strong>30min&nbsp;de&nbsp;Reims</strong>)&nbsp;(<a href="http://maps.google.fr/maps?f=q&amp;source=s_q&amp;hl=fr&amp;geocode=&amp;q=mont+notre+dame+02&amp;sll=49.293704,3.584105&amp;sspn=0.089452,0.175781&amp;ie=UTF8&amp;hq=&amp;hnear=Mont-Notre-Dame,+Aisne,+Picardie&amp;ll=49.262428,3.669434&amp;spn=0.716062,1.40625&amp;z=10" target="_blank">voir&nbsp;plan</a>).&nbsp;Cet&nbsp;&eacute;v&egrave;nement&nbsp;d&eacute;butera&nbsp;le&nbsp;<span style="color: #ff0000;"><strong>Vendredi&nbsp;4&nbsp;D&eacute;cembre</strong></span>&nbsp;2009&nbsp;&agrave;&nbsp; <br />partir&nbsp;de&nbsp;<strong>20h</strong>&nbsp;et&nbsp;se&nbsp;terminera&nbsp;le&nbsp;<strong><span style="color: #ff0000;">Samedi 5 D&eacute;cembre</span></strong>&nbsp;&agrave;&nbsp;<strong>17h</strong>.&nbsp;Cet&nbsp;&eacute;v&eacute;nement&nbsp;fait&nbsp;parti&nbsp;du&nbsp;programme&nbsp; <br />officiel&nbsp;du&nbsp;T&eacute;l&eacute;thon,&nbsp;et&nbsp;est&nbsp;accr&eacute;dit&eacute;&nbsp;par&nbsp;&nbsp;&laquo;&nbsp;l&rsquo;<strong>Association&nbsp;Fran&ccedil;aise&nbsp;contre&nbsp;les&nbsp;Myopathies</strong>&nbsp;&raquo;&nbsp;(AFM)&nbsp; <br />(<a href="http://www.afm-telethon.fr/" target="_blank">voir&nbsp;site</a>).&nbsp; <br />Lors&nbsp;de&nbsp;cet&nbsp;&eacute;v&egrave;nement,&nbsp;<strong>aucun&nbsp;tournoi&nbsp;officiel</strong>&nbsp;ne&nbsp;sera&nbsp;organis&eacute;,&nbsp;nous&nbsp;souhaitons&nbsp;seulement&nbsp;r&eacute;unir&nbsp;un&nbsp; <br />maximum&nbsp;de&nbsp;personnes&nbsp;pour&nbsp;une&nbsp;noble&nbsp;cause&nbsp;et&nbsp;que&nbsp;ces&nbsp;personnes&nbsp;passent&nbsp;une&nbsp;bonne&nbsp;soir&eacute;e&nbsp; <br />autour&nbsp;d&rsquo;un&nbsp;r&eacute;seau&nbsp;commun&nbsp;et&nbsp;de&nbsp;jeux&nbsp;vari&eacute;s.&nbsp;Une&nbsp;liste&nbsp;de&nbsp;jeux&nbsp;est&nbsp;propos&eacute;e&nbsp;avec&nbsp;de&nbsp;grands&nbsp;noms&nbsp; <br />tels que <strong>Counter Strike</strong>, <strong>Left&nbsp;4&nbsp;Dead</strong>,&nbsp;<strong>TrackMania</strong>,&nbsp;<strong>UT&nbsp;2004</strong>,&nbsp;<strong>Quake&nbsp;3</strong>&nbsp;et&nbsp;bien&nbsp;d&rsquo;autres&nbsp;encore.&nbsp;Il&nbsp;faut&nbsp;noter&nbsp;que&nbsp;cette&nbsp; <br />liste&nbsp;est&nbsp;<strong>non&nbsp;exhaustive</strong>&nbsp;et&nbsp;qu&rsquo;il&nbsp;sera&nbsp;possible&nbsp;de&nbsp;jouer&nbsp;&agrave;&nbsp;bien&nbsp;d&rsquo;autres&nbsp;jeux.&nbsp;&nbsp; <br />Afin&nbsp;d&rsquo;accompagner&nbsp;les&nbsp;joueurs&nbsp;durant&nbsp;l&rsquo;&eacute;v&egrave;nement,&nbsp;un&nbsp;<strong><span style="color: #ff0000;">coin&nbsp;restauration</span></strong>&nbsp;sera&nbsp;mis&nbsp;&agrave;&nbsp;leur&nbsp;disposition&nbsp; <br />avec<strong>&nbsp;la&nbsp;vente&nbsp;de&nbsp;boissons</strong>&nbsp;(froides&nbsp;ou&nbsp;chaudes),&nbsp;de&nbsp;<strong>cr&ecirc;pes</strong>,&nbsp;&nbsp;<strong>gaufres</strong>&nbsp;ou&nbsp;encore&nbsp;de&nbsp;<strong>croqueâ€monsieur</strong>.&nbsp; <br />Tout&nbsp;ceci&nbsp;pour&nbsp;un&nbsp;tarif&nbsp;raisonnable&nbsp;de&nbsp;<strong>5&euro;&nbsp;<span style="color: #ff0000;">minimum</span></strong>&nbsp;(&agrave;&nbsp;discr&eacute;tion)&nbsp;pour&nbsp;<strong>21&nbsp;heures&nbsp;de&nbsp;jeux</strong>&nbsp;et&nbsp;une&nbsp; <br /><strong>ambiance&nbsp;amicale</strong>.&nbsp;L&rsquo;ensemble&nbsp;des&nbsp;b&eacute;n&eacute;fices&nbsp;r&eacute;alis&eacute;s&nbsp;lors&nbsp;de&nbsp;cet&nbsp;&eacute;v&egrave;nement&nbsp;est&nbsp;<strong>revers&eacute;&nbsp;&agrave;&nbsp;l&rsquo;AFM</strong>&nbsp;qui&nbsp; <br />servira&nbsp;directement&nbsp;pour&nbsp;la&nbsp;lutte&nbsp;des&nbsp;myopathies.&nbsp; <br />N&rsquo;h&eacute;sitez&nbsp;&agrave;&nbsp;nous&nbsp;rejoindre&nbsp;ou&nbsp;posez&nbsp;vos&nbsp;questions&nbsp;sur&nbsp;notre&nbsp;forum&nbsp;&agrave;&nbsp;l&rsquo;adresse&nbsp;suivante&nbsp;:&nbsp; <br /><a href="../../" target="_blank">http://www.asso-lag.fr</a><br />@&nbsp;bient&ocirc;t&nbsp; <br />L&rsquo;&eacute;quipe&nbsp;de&nbsp;la&nbsp;LAG&nbsp; <br /><br /></p>', '78.115.35.139'),
(23, NULL, 'TEST', '2009-11-06 18:08:37', NULL, '<p>Ceci est un test, ne pas en tenir compte !!!</p>', '88.165.83.147');

-- --------------------------------------------------------

--
-- Structure de la table `newslettermail`
--

DROP TABLE IF EXISTS `newslettermail`;
CREATE TABLE IF NOT EXISTS `newslettermail` (
  `idNewsletterMail` int(10) unsigned NOT NULL auto_increment,
  `mail` varchar(100) default NULL,
  PRIMARY KEY  (`idNewsletterMail`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=151 ;

--
-- Contenu de la table `newslettermail`
--

INSERT INTO `newslettermail` (`idNewsletterMail`, `mail`) VALUES
(1, 'sieg@asso-lag.fr'),
(2, 'ash@asso-lag.fr'),
(3, 'ryzen@asso-lag.fr'),
(4, 'belette@asso-lag.fr'),
(5, 'risk.breaker@asso-lag.fr'),
(6, 'valerie.ser@gmail.com'),
(7, 'emmanuel1.semo@hotmail.fr'),
(9, 'greg1230@wanadoo.fr'),
(10, 'mat-lestat-02@hotmail.com'),
(11, 'shyfly@hotmail.fr'),
(12, 'lacremi02@hotmail.com'),
(13, 'Sethis.webmaster@gmail.com'),
(14, 'julien02370@hotmail.fr'),
(15, 'cyrlemagicien@hotmail.fr'),
(16, 'vinous02@wanadoo.fr'),
(17, 'max_k_hornet600@hotmail.fr'),
(18, 'statiix-tck-loveteck@live.fr'),
(19, 'paul_essonne@hotmail.fr'),
(20, 'babawhell@hotmail.fr'),
(21, 'gwladys.lesage@tele2.fr'),
(22, 'nisay-77@hotmail.fr'),
(23, 'phoenix.urban@hotmail.fr'),
(24, 'schwarzy90@hotmail.com'),
(25, 'emmanuel.fortin@neuf.fr'),
(26, 'ljuboja60@hotmail.com'),
(27, 'general.neo@free.fr'),
(28, 'volioz76_cz@hotmail.fr'),
(29, 'jojoturbo@mail.com'),
(30, 'bizou.max@gmail.com'),
(31, 'gis77@hotmail.fr'),
(32, 'soad021@hotmail.com'),
(33, 'ed1102@hotmail.fr'),
(34, 'poppy_hrc@live.fr'),
(35, 'gh0rgh0r@hotmail.fr'),
(36, 'jojo_261188@hotmail.com'),
(37, 'thegnou@hotmail.com'),
(38, 'Pro.Game.Css@hotmail.fr'),
(39, 'Full_metal02@hotmail.fr'),
(40, 'harryriton02@hotmail.fr'),
(41, 'juliensetzero@hotmail.fr'),
(42, 'carter173@hotmail.fr'),
(43, 'valentinooo@wanadoo.fr'),
(44, 'zangetsu02@live.fr'),
(45, 'floyde02@hotmail.fr'),
(46, 'raptorfab02@hotmail.com'),
(47, 'juillet62@hotmail.com'),
(48, 'babawhell@hotmail.fr'),
(49, 'kenshin.76@orange.fr'),
(50, 'leptitdou_45@hotmail.fr'),
(51, 'sogo-gachi@orange.fr'),
(52, 'yoco_94@hotmail.com'),
(53, 'alex_le_big_boss1@hotmail.fr'),
(54, 'might_02@hotmail.fr'),
(55, 'arn0wx6o@hotmail.fr'),
(56, 't.ranat@hotmail.fr'),
(57, 'tooban@cnglan.com'),
(58, 'jerome_goudemand@hotmail.com'),
(59, 'jerome@goudemand.net'),
(60, 'oxy.02@hotmail.fr'),
(61, 'naruto170493@hotmail.fr'),
(62, 'raza_danidan@hotmail.com'),
(63, 'adrien0210@hotmail.fr'),
(64, 'emmanuel.fortin@neuf.fr'),
(65, 'lepoutre.ludovic@free.fr'),
(66, 'benji_ca@hotmail.fr'),
(67, 'alexis7775@hotmail.fr'),
(68, 'jordan__77@live.fr'),
(69, 'guillaumegarcia@msn.com'),
(70, 'jimmy979@hotmail.fr'),
(71, 'pesboss@hotmail.fr'),
(72, 'dark_junior9@hotmai.com'),
(73, 'npierrard@gmail.com'),
(74, 'lolotte7894@hotmail.fr'),
(75, 'standmyground57@hotmail.fr'),
(76, 'illusion.sodalis@live.fr'),
(77, 'melancolie888@hotmail.fr'),
(78, 'poisson@team-ephemere.fr'),
(79, 'nicolas.taupier0759@orange.fr'),
(80, 'ZOY.css@live.fr'),
(81, 'maxxgamers59xx@hotmail.fr'),
(82, 'aniki.94@hotmail.fr'),
(83, 'delta.n1@gmail.com'),
(84, 'yopyop38@hotmail.fr'),
(85, 'dnimsgern@gmail.com'),
(86, 'gigi-02100@hotmail.fr'),
(87, 'pepino162@msn.com'),
(88, 'tonydu02300@hotmail.fr'),
(89, 'nemesis_exe@hotmail.fr'),
(90, 'slayer-mirmidon@hotmail.fr'),
(91, 'leptitdou_45@hotmail.fr'),
(92, 'yoco_94@hotmail.com'),
(93, 'nathetmika60@free.fr'),
(94, 'tpinot@laposte.net'),
(95, 'd.maxime@live.fr'),
(96, 'serial_lover78@hotmail.fr'),
(97, 'x-fl0riian@live.fr'),
(98, 'jeanjean-59@hotmail.fr'),
(99, 'djo02@hotmail.fr'),
(100, 'siriex.09@hotmail.fr'),
(101, 'ryton_93@hotmail.fr'),
(102, 'keur_2_glass@msn.com'),
(103, 'azerty_78955@hotmail.fr'),
(104, 'minioz@hotmail.fr'),
(105, 'vince21850@hotmail.fr'),
(106, 'urban_93@hotmail.fr'),
(107, 'boostercyrill@orange.fr'),
(108, 'x3Paradise57x@hotmail.fr'),
(109, 'j.i.m.S@hotmail.fr'),
(110, 'rongeur02@hotmail.com'),
(111, 'hugodaunois_23@hotmail.fr'),
(112, 'counter_78@hotmail.fr'),
(113, 'harryriton02@hotmail.fr'),
(114, 'cihan-7@hotmail.com'),
(115, 'ferret-julien@orange.fr'),
(116, 'pasqualericca@hotmail.com'),
(117, 'remondoricca9@hotmail.com'),
(118, 'fanatik59@gmail.com'),
(119, 'tabarez7@gmail.com'),
(120, 'ekxo77@live.fr'),
(121, 'sylvain.crazy@otmail.fr'),
(122, 'kevin08160@hotmail.fr'),
(123, 'boygizmo@hotmail.fr'),
(124, 'juljul147@hotmail.com'),
(125, 'besdu60@hotmail.fr'),
(126, 'pesboss@hotmail.fr'),
(127, 'jek9@msn.com'),
(128, 'zyck3r@gmail.com'),
(129, 'thomas_madaschi5@hotmail.com'),
(130, 'ogc@live.be'),
(131, 'jeremy_ogame@hotmail.fr'),
(132, 'rsdarcy@orange.fr'),
(133, 'jeremy_139@hotmail.fr'),
(134, 'rsdarcy@hotmail.fr'),
(135, 'drg95@hotmail.fr'),
(136, 'max_om_91@hotmail.fr'),
(137, 'metalhunter@hotmail.fr'),
(138, 'slarch3@hotmail.com'),
(139, 'kewin.bogoss@hotmail.fr'),
(140, 'sheepshager@hotmail.fr'),
(141, 'lag.ash@gmail.com'),
(142, 'xavier@emeutevisuelle.com'),
(143, 'maxime.me@gmail.com'),
(144, 'banane.shake@hotmail.fr'),
(145, 'fabien_bouvard@hotmail.com'),
(146, 'chezcooba@hotmail.fr'),
(147, 'caillot.jb@gmail.com'),
(148, 'craps_fmj@hotmail.fr'),
(149, 'wass.thonio@hotmail.fr'),
(150, 'maxime.me@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `newslettermailtype`
--

DROP TABLE IF EXISTS `newslettermailtype`;
CREATE TABLE IF NOT EXISTS `newslettermailtype` (
  `idNewsletterMailType` int(10) unsigned NOT NULL auto_increment,
  `idNewsletterType` int(10) unsigned NOT NULL,
  `idNewsletterMail` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`idNewsletterMailType`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=152 ;

--
-- Contenu de la table `newslettermailtype`
--

INSERT INTO `newslettermailtype` (`idNewsletterMailType`, `idNewsletterType`, `idNewsletterMail`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 2, 6),
(7, 2, 7),
(8, 3, 8),
(9, 4, 9),
(10, 4, 10),
(11, 4, 11),
(12, 4, 12),
(13, 4, 13),
(14, 4, 14),
(15, 4, 15),
(16, 4, 16),
(17, 4, 17),
(18, 4, 18),
(19, 4, 19),
(20, 4, 20),
(21, 4, 21),
(22, 4, 22),
(23, 4, 23),
(24, 4, 24),
(25, 4, 25),
(26, 4, 26),
(27, 4, 27),
(28, 4, 28),
(29, 4, 29),
(30, 4, 30),
(31, 4, 31),
(32, 4, 32),
(33, 4, 33),
(34, 4, 34),
(35, 4, 35),
(36, 4, 36),
(37, 4, 37),
(38, 4, 38),
(39, 4, 39),
(40, 4, 40),
(41, 4, 41),
(42, 4, 42),
(43, 4, 43),
(44, 4, 44),
(45, 4, 45),
(46, 4, 46),
(47, 4, 47),
(48, 4, 48),
(49, 4, 49),
(50, 4, 50),
(51, 4, 51),
(52, 4, 52),
(53, 4, 53),
(54, 4, 54),
(55, 4, 55),
(56, 4, 56),
(57, 4, 57),
(58, 4, 58),
(59, 4, 59),
(60, 4, 60),
(61, 4, 61),
(62, 4, 62),
(63, 4, 63),
(64, 4, 64),
(65, 4, 65),
(66, 4, 66),
(67, 4, 67),
(68, 4, 68),
(69, 4, 69),
(70, 4, 70),
(71, 4, 71),
(72, 4, 72),
(73, 4, 73),
(74, 4, 74),
(75, 4, 75),
(76, 4, 76),
(77, 4, 77),
(78, 4, 78),
(79, 4, 79),
(80, 4, 80),
(81, 4, 81),
(82, 4, 82),
(83, 4, 83),
(84, 4, 84),
(85, 4, 85),
(86, 4, 86),
(87, 4, 87),
(88, 4, 88),
(89, 4, 89),
(90, 4, 90),
(91, 4, 91),
(92, 4, 92),
(93, 4, 93),
(94, 4, 94),
(95, 4, 95),
(96, 4, 96),
(97, 4, 97),
(98, 4, 98),
(99, 4, 99),
(100, 4, 100),
(101, 4, 101),
(102, 4, 102),
(103, 4, 103),
(104, 4, 104),
(105, 4, 405),
(106, 4, 106),
(107, 4, 107),
(108, 4, 108),
(109, 4, 109),
(110, 4, 110),
(111, 4, 111),
(112, 4, 112),
(113, 4, 113),
(114, 4, 114),
(115, 4, 115),
(116, 4, 116),
(117, 4, 117),
(118, 4, 118),
(119, 4, 119),
(120, 4, 120),
(121, 4, 121),
(122, 4, 122),
(123, 4, 123),
(124, 4, 124),
(125, 4, 125),
(126, 4, 126),
(127, 4, 127),
(128, 4, 128),
(129, 4, 129),
(130, 4, 130),
(131, 4, 131),
(132, 4, 132),
(133, 4, 133),
(134, 4, 134),
(135, 4, 135),
(136, 4, 136),
(137, 4, 137),
(138, 4, 138),
(139, 4, 139),
(140, 4, 140),
(142, 4, 105),
(143, 2, 142),
(144, 2, 143),
(145, 2, 144),
(146, 2, 145),
(147, 2, 146),
(148, 2, 147),
(149, 2, 148),
(150, 2, 149),
(151, 2, 150);

-- --------------------------------------------------------

--
-- Structure de la table `newslettertype`
--

DROP TABLE IF EXISTS `newslettertype`;
CREATE TABLE IF NOT EXISTS `newslettertype` (
  `idNewsletterType` int(10) unsigned NOT NULL auto_increment,
  `nom` varchar(100) default NULL,
  PRIMARY KEY  (`idNewsletterType`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `newslettertype`
--

INSERT INTO `newslettertype` (`idNewsletterType`, `nom`) VALUES
(1, 'Admins'),
(2, 'Joueurs'),
(3, 'Inscription'),
(4, 'Ancien Compte');

-- --------------------------------------------------------

--
-- Structure de la table `partenaire`
--

DROP TABLE IF EXISTS `partenaire`;
CREATE TABLE IF NOT EXISTS `partenaire` (
  `idPartenaire` int(10) unsigned NOT NULL auto_increment,
  `titre` varchar(60) NOT NULL,
  `date` date NOT NULL,
  `nbclick` int(10) NOT NULL,
  `type` varchar(60) NOT NULL,
  `lien` varchar(60) NOT NULL,
  `logo` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `ordre` int(10) NOT NULL,
  PRIMARY KEY  (`idPartenaire`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `partenaire`
--

INSERT INTO `partenaire` (`idPartenaire`, `titre`, `date`, `nbclick`, `type`, `lien`, `logo`, `description`, `ordre`) VALUES
(1, 'Steelseries', '2009-10-01', 0, 'Informatique', 'http://www.steelseries.com/', 'SteelSeries.jpg', '<p>SteelSeries est un vendeur de matériels informatiques spécialisé dans les jeux vidéo (casques, claviers, souris, tapis de souris,...). Depuis sa création en 2001, SteelSeries est en coopération avec de grands joueurs professionnels et son développement devient de plus en plus important dans cet univers.</p>', 1),
(2, 'FOCUS HOME INTERACTIVE', '2009-10-01', 0, 'Informatique', 'http://www.focus-home.com/', 'Focus.jpg', '<p>Créé en 1996, Focus Home Interactive est un éditeur français indépendant basé en région parisienne. Spécialisé dans le jeu vidéo depuis 2000, Focus a multiplié les succès en lançant bon nombre de titres originaux devenus de véritables références comme le jeu d''aventure Runaway, le populaire Cycling Manager ou encore le fameux TrackMania. Reconnu pour la variété, la qualité et l''originalité de son catalogue, Focus édite et distribue désormais une partie de ses titres dans de nombreux territoires en Europe et dans le monde à travers un réseau de distributeurs performants ou encore de manière digitale pour certains produits spécifiques.</p>', 2),
(3, 'Thermaltake', '2009-10-01', 0, 'Informatique', 'http://fr.thermaltake.eu/', 'Thermaltake.jpg', '<p>La personnalité de la marque d''unique, d''agressif, de vif, et d''élégant fait de Thermaltake un expert dans la création de choses passionnantes et d''environnement fascinant pour les gamers et les passionnés. L''excellente capacité d''expertise technique et d''intégration, plus l''audace d''expérimenter sur les nouvelles possibilités donnent à Thermaltake la source d''autorité sur le marché. De plus, Thermaltake se rapproche des consommateurs et observe le comportement et la demande des utilisateurs leaders, pour concevoir des produits esthétiques et de qualité qui amélioreront considérablement les performances du système et apporteront à l''utilisateur le plus grand potentiel. Avec un design innovateur et un style unique, les produits de Thermaltake se répandent rapidement parmi les passionnés sur le marché DIY et deviennent bientôt le choix numéro un pour les passionnés de bricolage de PC dans le monde entier.</p>', 3),
(4, 'Noctua', '2009-10-24', 0, 'Informatique', 'http://www.noctua.at/main.php?show=start&setlng=fr', 'Noctua.jpg', '<p>Noctua s''est sp&eacute;cialis&eacute; dans la conception de syt&egrave;mes de refroidissement.</p>', 4),
(5, 'Coolink', '2009-10-24', 0, 'Informatique', 'http://www.coolink-europe.com/fr/start.html', 'Coolink.jpg', '<p><span style="font-size: 11px;"><span style="color: #000000;">N&eacute;e en 1996, Kolink International Corporation est une soci&eacute;t&eacute; sp&eacute;cialis&eacute;e dans le refroidissement bien connue dans le milieu industriel. Ann&eacute;e apr&egrave;s ann&eacute;e, Kolink a imagin&eacute; et cr&eacute;&eacute; de nombreux dissipateurs, distribu&eacute;s avec succ&eacute;s sous diverses marques internationales. L''exp&eacute;rience de l''&eacute;quipe R&amp;D associ&eacute;e au modernisme de centres de production &agrave; Taiwan assurent une &eacute;volution permanente, des conditions de fabrication optimales ainsi que des normes qualitatives strictes</span><span style="color: #000000;"><span style="color: #ffffff;"><span style="color: #000000;">.</span></span></span></span></p>\r\n<p><span style="font-size: 11px;"><span style="color: #000000;"><span style="color: #ffffff;"><span style="color: #000000;">Coolink, la marque de vente au d&eacute;tail de Kolink, est tr&egrave;s pr&eacute;sente sur le march&eacute; asiatique et s''est impos&eacute; avec succ&egrave;s au fil des ann&eacute;es. Gr&acirc;ce &agrave; l''&eacute;tendue de sa gamme et &agrave; son adaptation aux exigences europ&eacute;enne en mati&egrave;re d''information, Coolink-Europe peut &agrave; pr&eacute;sent s''ouvrir au march&eacute; de d&eacute;tail europ&eacute;en.</span></span></span></span></p>', 5);

-- --------------------------------------------------------

--
-- Structure de la table `souscategorie`
--

DROP TABLE IF EXISTS `souscategorie`;
CREATE TABLE IF NOT EXISTS `souscategorie` (
  `idSousCategorie` int(10) unsigned NOT NULL auto_increment,
  `idCategorie` int(10) unsigned NOT NULL,
  `titre` varchar(60) NOT NULL,
  `img` varchar(60) NOT NULL,
  `description` longtext NOT NULL,
  `visible` tinyint(4) NOT NULL,
  `admin` tinyint(4) NOT NULL,
  `ordre` int(10) NOT NULL,
  PRIMARY KEY  (`idSousCategorie`),
  KEY `idCategorie` (`idCategorie`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Contenu de la table `souscategorie`
--

INSERT INTO `souscategorie` (`idSousCategorie`, `idCategorie`, `titre`, `img`, `description`, `visible`, `admin`, `ordre`) VALUES
(1, 1, 'Taverne', '', '<p>Tout et n''importe quoi !!</p>', 1, 0, 1),
(2, 1, 'Présentation', '', '<p>Pr&eacute;sentation des joueurs</p>', 1, 0, 2),
(3, 1, 'Règles', '', '<p>Parce qu''il le faut bien !!!</p>', 1, 0, 3),
(4, 2, 'LAG Téléthon 2009', '', '<p>Tout ce qui se rapporte &agrave; la LAG T&eacute;l&eacute;thon 2009</p>', 1, 0, 1),
(5, 3, 'Warcraft III TFT', '', '<p>Tout ce qui est li&eacute; &agrave; Warcraft III TFT se pose ici</p>', 1, 0, 1),
(6, 3, 'Counter Strike 1.6', '', '<p>tout ce qui se rapporte &agrave; Counter Strike 1.6</p>', 1, 0, 2),
(7, 3, 'Counter Strike Source', '', '<p>Tout ce qui se rapporte &agrave; Counter Strike Source</p>', 1, 0, 3),
(8, 4, 'LAG Téléthon 2009', '', '<p>Parler de la lag t&eacute;l&eacute;thon 2009</p>', 1, 1, 1),
(9, 5, 'Implémentation', '', '<p>Probl&egrave;mes du &agrave; l''impl&eacute;mentation du site ou d''un module</p>', 1, 1, 1),
(10, 5, 'Amélioration', '', '<p>Id&eacute;es d''am&eacute;lioration pour le site</p>', 1, 1, 2);

-- --------------------------------------------------------

--
-- Structure de la table `staff`
--

DROP TABLE IF EXISTS `staff`;
CREATE TABLE IF NOT EXISTS `staff` (
  `idStaff` int(10) unsigned NOT NULL auto_increment,
  `nom` varchar(30) NOT NULL,
  `unik` tinyint(1) default '1',
  `ordre` int(10) NOT NULL,
  PRIMARY KEY  (`idStaff`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `staff`
--

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
  `idStaffCompte` int(10) unsigned NOT NULL auto_increment,
  `idStaff` int(10) unsigned NOT NULL,
  `idCompte` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`idStaffCompte`),
  KEY `idStaff` (`idStaff`),
  KEY `idCompte` (`idCompte`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `staffcompte`
--

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
  `idSujet` int(10) unsigned NOT NULL auto_increment,
  `idSousCategorie` int(10) unsigned NOT NULL,
  `idCompte` int(10) unsigned NOT NULL,
  `titre` varchar(60) NOT NULL,
  `img` varchar(60) NOT NULL,
  `date_s` datetime NOT NULL,
  `vu` tinyint(1) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `visible` tinyint(4) NOT NULL,
  `bloque` tinyint(1) NOT NULL,
  `nbvue` int(10) unsigned default NULL,
  PRIMARY KEY  (`idSujet`),
  KEY `idSousCategorie` (`idSousCategorie`),
  KEY `idCompte` (`idCompte`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- Contenu de la table `sujet`
--

INSERT INTO `sujet` (`idSujet`, `idSousCategorie`, `idCompte`, `titre`, `img`, `date_s`, `vu`, `ip`, `visible`, `bloque`, `nbvue`) VALUES
(3, 4, 13, 'Lag telethon 2009 - tournoi cs', '', '2009-10-20 12:06:43', 73, '163.173.48.11', 1, 0, NULL),
(4, 5, 15, 'Du monde !', '', '2009-10-27 09:39:41', 107, '92.142.250.54', 1, 0, NULL),
(5, 8, 1, 'Jeux et Lan', '', '2009-10-27 11:58:01', 42, '88.165.83.147', 1, 0, NULL),
(6, 2, 3, 'Ryzen', '', '2009-10-27 16:12:45', 27, '195.83.155.55', 1, 0, NULL),
(7, 2, 1, 'Sieg', '', '2009-10-27 17:27:42', 40, '88.165.83.147', 1, 0, NULL),
(8, 1, 15, 'Demystifier les charlatans', '', '2009-10-27 22:46:15', 20, '92.142.250.54', 1, 0, NULL),
(9, 2, 2, 'Ash', '', '2009-10-28 10:24:17', 39, '86.64.192.254', 1, 0, NULL),
(10, 8, 3, 'Vidéo-projecteurs', '', '2009-10-28 15:55:01', 11, '195.83.155.55', 1, 0, NULL),
(11, 2, 5, 'RisK.BreaKeR', '', '2009-10-28 15:58:23', 39, '92.147.115.120', 1, 0, NULL),
(12, 8, 3, 'Partenaires', '', '2009-10-28 16:02:11', 19, '195.83.155.55', 1, 0, NULL),
(13, 10, 3, 'Présent sur le forum', '', '2009-10-28 16:05:08', 29, '195.83.155.55', 1, 0, NULL),
(14, 8, 3, 'Barbecue', '', '2009-10-29 16:47:34', 11, '195.83.155.55', 1, 0, NULL),
(15, 8, 3, 'Petite Idée', '', '2009-10-29 16:53:41', 14, '195.83.155.55', 1, 0, NULL),
(16, 4, 3, 'Telethon 2009 - Covoiturage', '', '2009-10-30 15:48:13', 43, '195.83.155.55', 1, 0, NULL),
(17, 10, 3, 'titre de sujet de forum', '', '2009-10-30 15:49:58', 18, '195.83.155.55', 1, 0, NULL),
(18, 6, 15, 'CSS ou 1.6 ?', '', '2009-11-07 19:37:01', 7, '92.142.202.70', 1, 0, NULL),
(19, 8, 1, 'Coin Snack', '', '2009-11-08 12:13:37', 2, '88.165.83.147', 1, 0, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `team`
--

DROP TABLE IF EXISTS `team`;
CREATE TABLE IF NOT EXISTS `team` (
  `idTeam` int(10) unsigned NOT NULL auto_increment,
  `nom` varchar(30) NOT NULL,
  PRIMARY KEY  (`idTeam`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `team`
--

INSERT INTO `team` (`idTeam`, `nom`) VALUES
(1, 'Sans Team'),
(2, ''),
(3, 'RsM');

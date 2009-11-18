DROP TABLE IF EXISTS `tournoi`;
CREATE TABLE IF NOT EXISTS `tournoi` (
  `idTournoi` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idLan` int(10) unsigned NOT NULL,
  `idJeux` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idTournoi`),
  KEY `idLan` (`idLan`),
  KEY `idJeux` (`idJeux`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `organisation_tournoi`;
CREATE TABLE IF NOT EXISTS `organisation_tournoi` (
  `idOrganisation` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id` int(10) unsigned NOT NULL,
  `idParticipant_a` int(10) NOT NULL,
  `idParticipant_b` int(10) NOT NULL,
  `score_a` int(10) NOT NULL,
  `score_b` int(10) NOT NULL,
  `match_par_point` boolean default true,
  PRIMARY KEY (`idMatch`),
  KEY `idTournoi` (`idTournoi`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `match`;
CREATE TABLE IF NOT EXISTS `match` (
  `idMatch` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idTournoi` int(10) unsigned NOT NULL,
  `idParticipant_a` int(10),
  `idParticipant_b` int(10),
  `score_a` int(10) NOT NULL,
  `score_b` int(10) NOT NULL,
  `match_par_point` boolean default true,
  PRIMARY KEY (`idMatch`),
  KEY `idTournoi` (`idTournoi`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;



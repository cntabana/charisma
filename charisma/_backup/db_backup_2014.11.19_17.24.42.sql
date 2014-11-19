-- -------------------------------------------
SET AUTOCOMMIT=0;
START TRANSACTION;
SET SQL_QUOTE_SHOW_CREATE = 1;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
-- -------------------------------------------
-- -------------------------------------------
-- START BACKUP
-- -------------------------------------------
-- -------------------------------------------
-- TABLE `beneficaire`
-- -------------------------------------------
DROP TABLE IF EXISTS `beneficaire`;
CREATE TABLE IF NOT EXISTS `beneficaire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `photo` varchar(100) NOT NULL,
  `firstname` varchar(20) NOT NULL,
  `middlename` varchar(20) DEFAULT NULL,
  `lastname` varchar(20) NOT NULL,
  `dateofbirth` date NOT NULL,
  `sex` int(1) NOT NULL,
  `type` int(1) NOT NULL COMMENT 'conjoint 1 and enfant 2',
  `idmember` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idmember` (`idmember`),
  CONSTRAINT `beneficaire_ibfk_1` FOREIGN KEY (`idmember`) REFERENCES `members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `billing_details`
-- -------------------------------------------
DROP TABLE IF EXISTS `billing_details`;
CREATE TABLE IF NOT EXISTS `billing_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idinvoice` int(11) NOT NULL,
  `idmedical` int(11) NOT NULL,
  `quantity` int(5) NOT NULL,
  `price` int(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idinvoice` (`idinvoice`,`idmedical`),
  KEY `idmedical` (`idmedical`),
  CONSTRAINT `billing_details_ibfk_1` FOREIGN KEY (`idmedical`) REFERENCES `traitement` (`id`),
  CONSTRAINT `billing_details_ibfk_2` FOREIGN KEY (`idinvoice`) REFERENCES `invoice` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='billing of analyse or traitements';

-- -------------------------------------------
-- TABLE `billing_drug`
-- -------------------------------------------
DROP TABLE IF EXISTS `billing_drug`;
CREATE TABLE IF NOT EXISTS `billing_drug` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idinvoice` int(11) NOT NULL,
  `iddrug` int(11) NOT NULL,
  `quantity` int(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idinvoice` (`idinvoice`,`iddrug`),
  KEY `iddrug` (`iddrug`),
  CONSTRAINT `billing_drug_ibfk_1` FOREIGN KEY (`idinvoice`) REFERENCES `invoice` (`id`) ON DELETE CASCADE,
  CONSTRAINT `billing_drug_ibfk_2` FOREIGN KEY (`iddrug`) REFERENCES `drugs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `district`
-- -------------------------------------------
DROP TABLE IF EXISTS `district`;
CREATE TABLE IF NOT EXISTS `district` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `district` varchar(20) NOT NULL,
  `idprovince` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `district` (`district`),
  KEY `idprovince` (`idprovince`),
  CONSTRAINT `district_ibfk_1` FOREIGN KEY (`idprovince`) REFERENCES `province` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `doctors`
-- -------------------------------------------
DROP TABLE IF EXISTS `doctors`;
CREATE TABLE IF NOT EXISTS `doctors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(20) NOT NULL,
  `middlename` varchar(20) DEFAULT NULL,
  `lastname` varchar(20) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `qualification` varchar(30) NOT NULL,
  `nationality` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `drugs`
-- -------------------------------------------
DROP TABLE IF EXISTS `drugs`;
CREATE TABLE IF NOT EXISTS `drugs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `drug` varchar(50) NOT NULL,
  `generic` int(1) NOT NULL,
  `cash` int(5) NOT NULL,
  `availability` int(1) NOT NULL,
  `special` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `hospital`
-- -------------------------------------------
DROP TABLE IF EXISTS `hospital`;
CREATE TABLE IF NOT EXISTS `hospital` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hopitalName` varchar(50) NOT NULL,
  `address` varchar(30) DEFAULT NULL,
  `type` int(1) NOT NULL COMMENT 'hospital or pharmacy',
  `iduser` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `iduser` (`iduser`),
  CONSTRAINT `hospital_ibfk_1` FOREIGN KEY (`iduser`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `invoice`
-- -------------------------------------------
DROP TABLE IF EXISTS `invoice`;
CREATE TABLE IF NOT EXISTS `invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `idmember` int(11) NOT NULL,
  `idhospital` int(11) NOT NULL,
  `status` int(1) NOT NULL,
  `type` int(1) NOT NULL COMMENT 'analyse equal 1,traitement equal 2 and lunette equal 3',
  PRIMARY KEY (`id`),
  KEY `idmember` (`idmember`),
  KEY `idhospital` (`idhospital`),
  CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`idhospital`) REFERENCES `hospital` (`id`),
  CONSTRAINT `invoice_ibfk_2` FOREIGN KEY (`idmember`) REFERENCES `members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='analyse or traitement';

-- -------------------------------------------
-- TABLE `members`
-- -------------------------------------------
DROP TABLE IF EXISTS `members`;
CREATE TABLE IF NOT EXISTS `members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cardnumber` varchar(15) NOT NULL,
  `firstname` varchar(20) DEFAULT NULL,
  `middlename` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `issuedate` date NOT NULL,
  `expireddate` date NOT NULL,
  `birthday` date NOT NULL,
  `sex` varchar(1) NOT NULL,
  `phonenumber` varchar(20) DEFAULT NULL,
  `address` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `iddistrict` int(11) NOT NULL,
  `idsector` int(11) NOT NULL,
  `nationality` varchar(40) DEFAULT NULL,
  `status` int(1) NOT NULL COMMENT 'Active or not',
  `type` int(1) NOT NULL COMMENT 'student or teacher',
  `photo` varchar(50) NOT NULL,
  `title` varchar(7) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cardnumber` (`cardnumber`),
  KEY `iddistrict` (`iddistrict`,`idsector`),
  KEY `idsector` (`idsector`),
  CONSTRAINT `members_ibfk_1` FOREIGN KEY (`idsector`) REFERENCES `sector` (`id`),
  CONSTRAINT `members_ibfk_2` FOREIGN KEY (`iddistrict`) REFERENCES `district` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44213 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `ordonance`
-- -------------------------------------------
DROP TABLE IF EXISTS `ordonance`;
CREATE TABLE IF NOT EXISTS `ordonance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eye` varchar(30) NOT NULL,
  `type` varchar(30) NOT NULL,
  `typeofglass` varchar(30) NOT NULL,
  `vision` varchar(30) NOT NULL,
  `lunette` varchar(30) NOT NULL,
  `interpupillarydistance` float NOT NULL,
  `idinvoice` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idinvoice` (`idinvoice`),
  CONSTRAINT `ordonance_ibfk_1` FOREIGN KEY (`idinvoice`) REFERENCES `invoice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `price_history`
-- -------------------------------------------
DROP TABLE IF EXISTS `price_history`;
CREATE TABLE IF NOT EXISTS `price_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iddrug` int(11) NOT NULL,
  `ancient_price` double NOT NULL,
  `new_price` double NOT NULL,
  `old_changedate` varchar(50) NOT NULL,
  `changedate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `userid` int(11) NOT NULL,
  `last` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `iddrug` (`iddrug`),
  KEY `userid` (`userid`),
  CONSTRAINT `price_history_ibfk_1` FOREIGN KEY (`iddrug`) REFERENCES `drugs` (`id`),
  CONSTRAINT `price_history_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `province`
-- -------------------------------------------
DROP TABLE IF EXISTS `province`;
CREATE TABLE IF NOT EXISTS `province` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `province` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `province` (`province`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `sector`
-- -------------------------------------------
DROP TABLE IF EXISTS `sector`;
CREATE TABLE IF NOT EXISTS `sector` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sector` varchar(30) NOT NULL,
  `iddistrict` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `iddistrict` (`iddistrict`),
  CONSTRAINT `sector_ibfk_1` FOREIGN KEY (`iddistrict`) REFERENCES `district` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `service`
-- -------------------------------------------
DROP TABLE IF EXISTS `service`;
CREATE TABLE IF NOT EXISTS `service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `traitement`
-- -------------------------------------------
DROP TABLE IF EXISTS `traitement`;
CREATE TABLE IF NOT EXISTS `traitement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medical_act` varchar(50) NOT NULL,
  `idservice` int(11) NOT NULL,
  `type` int(1) NOT NULL COMMENT 'analyse equal 1 or traitement equal 2',
  `transfer` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `medical_act` (`medical_act`),
  KEY `idservice` (`idservice`),
  CONSTRAINT `traitement_ibfk_1` FOREIGN KEY (`idservice`) REFERENCES `service` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `users`
-- -------------------------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(20) NOT NULL,
  `middlename` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(32) NOT NULL,
  `salt` varchar(32) NOT NULL,
  `groupe` int(1) NOT NULL,
  `status` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE DATA beneficaire
-- -------------------------------------------
INSERT INTO `beneficaire` (`id`,`photo`,`firstname`,`middlename`,`lastname`,`dateofbirth`,`sex`,`type`,`idmember`) VALUES
('1','4549-','N','','N','2015-11-19','0','2','44193');
INSERT INTO `beneficaire` (`id`,`photo`,`firstname`,`middlename`,`lastname`,`dateofbirth`,`sex`,`type`,`idmember`) VALUES
('2','default.jpg','N','','N','2014-11-19','0','2','44193');



-- -------------------------------------------
-- TABLE DATA district
-- -------------------------------------------
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('1','KIST','1');



-- -------------------------------------------
-- TABLE DATA hospital
-- -------------------------------------------
INSERT INTO `hospital` (`id`,`hopitalName`,`address`,`type`,`iduser`) VALUES
('1','Nyirinkwaya','Remera','0','5');



-- -------------------------------------------
-- TABLE DATA members
-- -------------------------------------------
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34821','9561/12','ADRIEN','','NIYONKURU','2014-02-11','2014-11-05','2014-11-06','0','0788888888','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34822','9662/13','Walter','','MUSONERA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34823','9668/13','Eulade','','UTETANASE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34824','9893/13','Elie','','NTEZIYAREMYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34825','9939/13','Aloys','','MBAKURIYEMO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34826','9953/13','Jean Baptiste','','BARIMENSHI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34827','9975/13','Devotha','','MURAGIJIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34828','10001/13','Henriette','','HIRWA MAHORO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34829','10081/13','Violette','','MUHONGAYIRE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34830','10146/13','Esdras','','KAYIRANGA B','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34841','10557/13','Z&amp;eacute;phanie','','NSENGIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34842','10636/13','Jean de Dieu','','NSENGIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34843','10641/13','Salomon','','NDAYISABYE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34844','8590/12','JEAN MARIE VIANNEY','','NDAYIRAGIJE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34845','8805/12','ABEL','','TUYISINGIZE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34846','8822/12','NICODEME','','HAVUGIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34847','9019/12','EMMANUEL','','HABANABAKIZE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34848','9064/12','JEOVAN','','NKURUNZIZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34849','9227/12','ELIACQUIM','','NKUNZABIJURU ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34850','9338/12','RUTH','','MUSHIMIYIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34851','9346/12','JUDITH','','UJENEZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34852','9347/12','EGIDE','','TWAGIRAYEZU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34853','9392/12','JEAN PIERRE','','UWITONZE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34854','9488/12','JEAN LEON','','HABIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34855','9631/13','Jean Bosco','','MANIRARUTA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34856','9637/13','Samson','','NSABIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34857','9654/13','Joseph','','NIKUZWE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34858','9698/13','Eric','','MUREKAMBANZE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34859','9714/13','Fid&amp;egrave;le','','MUTUYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34860','9791/13','Eric','','TUYIZERE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34861','9820/13','Janvi&amp;egrave;re','','MUKAMUHOZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34862','9860/13','Fran&amp;ccedil;ois','','MUNYANEZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34863','9867/13','Victoire','','NSANZINTWARI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34864','9900/13','Jean Pierre','','SINDIKUBWABO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34865','9906/13','Jean Paul','','MUGEMANYI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34866','9917/13','Jean Claude','','NSHUTIYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34867','9971/13','Jean Claude','','BUREGEYA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34868','10004/13','Jean Claude','','NDIZIHIWE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34869','10026/13','Marie Claire','','MUKABIRINDA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34870','10030/13','Dieudonn&amp;eacute;','','MBONYINTWARI        ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34871','10037/13','Appoline','','ABINDAGIJE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34872','10042/13','Marie Gr&amp;acirc;c','','INGABIRE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34873','10048/13','Odile','','IRAKIZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34874','10072/13','Deogratias','','NAMBAJIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34875','10149/13','Na&amp;ocirc;me','','MWIZERWA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34876','10229/13','Adrien','','KUBWIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34877','10314/13','Immacul&amp;eacute;e','','UWIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34878','10315/13','Emerance','','DUSABEMARIYA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34879','10317/13','Alexandre','','BONERA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34880','10320/13','Jean Claude','','NIYITANGA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34891','10552/13','Eric','','UWIRAGIYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34892','10566/13','Philbert','','NIYIFASHA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34893','10569/13','Zena','','YANKURIJE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34894','10574/13','Jean Bosco','','HABAKURAMA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34895','10584/13','Gabriel','','MANIRAKIZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34896','10609/13','Jean Pierre','','UWIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34897','10621/13','Epaphrodite','','NTEZIRYAYO ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34898','10627/13','Zephanie','','NDAYAMBAJE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34899','10630/13','THOMAS','','UWIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34900','10695/13','Joyeuse','','NISHIMWE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34901','10768/13','J. Damascene','','MUTARAMBIRWA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34902','8538/12','OLIVE','','UMUKUNZI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34903','8659/12','ENIAS','','NSABIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34904','8925/12','VALERIEN','','KUBWIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34905','8959/12','JUVENAL','','UWIRINGIYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34906','9430/12','DELPHINE','','UMUTAMBARUNGU','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34907','9749/13','Viateur','','NTAGWABIRA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34908','9812/13','Syldio','','RUHIGIRA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34909','9823/13','Avite','','UWIMPAYE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34910','9866/13','Vivine','','NZAMBAZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34911','9913/13','Theodomir','','BYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34912','9937/13','Vincent','','MUSHIMIYIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34913','9957/13','Narcisse','','KURADUSENGE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34914','10007/13','Jasson','','HABIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34915','10008/13','Theoneste','','NIYITEGEKA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34916','10022/13','Jean  de Dieu','','MUNEZERO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34917','10064/13','J&amp;eacute;r&amp;e','','NIYOYANDEMYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34918','10084/13','Delphine','','MUKARUKUNDO ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34919','10278/13','Onesphore','','KANYARUGENDO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34920','10351/13','Claudine','','MUKAMBARUSHIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34931','10577/13','Judith','','NYIRANEZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34932','10583/13','Dogon','','NSHIMIYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34933','10604/13','Eric','','TWAHIRWA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34934','10697/13','Aloys','','MUGIZIKI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34935','10732/13','Jonathan','','HABIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34936','8573/12','GILBERT','','UFITABE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34937','9305/12','RICHARD','','BENIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34938','9502/12','METHUSALEM','','DUSABIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34939','9651/13','Gema','','UTETIWABO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34940','9687/13','virginie','','KAMPOGO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34941','9703/13','Valerie','','NYIRANZABAHIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34942','9725/13','Angelique','','UWERA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34943','9728/13',' D&amp;eacute;ograti','','NIYONZIMA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34944','9733/13','J. BAPTISTE','','MANIRARORA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34945','9785/13','Athanase','','MBARUBUKEYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34946','9803/13','Daniel','','NZAYISENGA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34947','9916/13','Claude','','NZABARUSHIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34948','9922/13','Jean Bosco','','NIYONZIMA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34949','9929/13','Anitha','','NYIRANDAMUTSA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34950','10010/13','Clementine','','NYIRAMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34971','9649/13','Ephrem','','NSHIMIYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34972','9702/13','Jean bosco','','NZASINGIZIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34973','9825/13','Anastasie','','NYIRANSABIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34974','9880/13','Cl&amp;eacute;mentin','','NYIRANGENDO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34975','9979/13','Martin Hubert','','IKURAMUTSE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34976','10002/13','Claire','','UZAMUKUNDA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34977','10015/13','Ferdinand','','MURAMUTSA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34978','10070/13','Fabrice','','HATANGIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34979','10077/13','Clementine','','UWAMAHORO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34980','10116/13','Marie Solange','','MUKANEZA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34981','10145/13','Clarisse','','MUKANGOBOKA TATU','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34982','10147/13','Eric','','JYAMUBANDI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34983','10161/13','Eric','','ABAYISENGA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34984','10165/13','Simon','','NZABANANIMANA       ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34985','10168/13','Vedaste','','ABAYISENGA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34986','10207/13','Sabat','','NIYONSHIMA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34987','10217/13','Jean de Dieu','','KARIMWABO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34988','10243/13','Jos&amp;eacute;phine','','BYAMUNGU ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34989','10284/13','Emmanuel','','UWIRINGIYIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34990','10356/13','Innocent','','NIZEYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34991','10423/13','Gilbert','','UWARAMUTSE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34992','10491/13','Felicien','','SEMAHORO ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34993','10493/13','Jean Damasc&amp;egra','','NSANZIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34994','10587/13','Juliette','','MUKASHYAKA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34995','10607/13','Simeon','','GAHUTU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34996','10653/13','Joseph','','BIGIRISI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34997','10663/13','Gerard','','HAVUGIMANA          ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34998','10693/13','Theogene','','PENDO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('34999','9600/12','BIENT&amp;Ocirc;T','','CALEB','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35000','9683/13','Theoneste','','KWIZERA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35001','9685/13','Victorien','','NTAMBARA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35002','9788/13','Diog&amp;egrave;ne','','UWANYAGASANI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35003','9799/13','Jean baptiste','','TWIZEYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35004','9903/13','Abraham','','BAZIMAZIKI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35005','9949/13','Marie Confiance','','MUHORAKEYE          ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35006','9966/13','F&amp;eacute;licit&a','','AKIMANIZANYE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35007','9994/13','Deborah','','UWIZEYE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35008','9998/13','Claudine','','NYIRAMINANI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35009','10005/13','Jean Bosco','','NKURIKIYUMUKIZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35010','10016/13','Christophe','','DUSABE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35021','10484/13','Redempta','','MUTATSIMPUNDU ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35022','10488/13','Diane','','UWAMAHORO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35023','10506/13','Marcelline','','UWIBAMBE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35024','10559/13','Innocente','','MUSHIKIWABO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35025','10620/13','Jean Claude','','HAKIZIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35026','10651/13','Emmanuel','','TURIKUMWE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35027','10660/13','Enock','','NDAYISABYE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35028','10771/13','Etienne','','CYUBAHIRO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35029','9705/13','Jean Claude','','MUNYANEZA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35030','9727/13','clarisse','','MUHUNDWANEMA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35031','9796/13','Marie Chantal','','KAMANZI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35032','9821/13','Febronie','','NIKUZE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35033','9859/13','Claudine','','MANIRAKIZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35034','9873/13','Jean de Dieu','','HAKIZIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35035','9961/13','Anatole','','NZIHARANIRA Ntwari','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35036','9978/13','Clementine','','UWIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35037','10078/13','Leocadie','','UWINGABIRE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35038','10080/13','Dominique','','TWAGIRAYEZU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35039','10121/13','Hassan','','SINAMENYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35040','10134/13','Cath&amp;eacute;rine','','UWANYIRIGIRA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35041','10156/13','Athanase','','UWIZEYE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35042','10180/13','Ibrahim','','UWIHOREYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35043','10183/13','Camarade','','NISENGWE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35044','10216/13','Marcel','','UWIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35045','10236/13','Innocent','','HABIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35046','10241/13','Immacul&amp;eacute;e','',' MANIRARORA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35047','10247/13','Dorine','','NIYOMWUNGERI ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35048','10254/13','Solange','','MUKAMURIGO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35049','10275/13','Edouard','','NIYIGENA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35050','10288/13','Elisaphane','','BIKORIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35061','10545/13','Jean Damasc&amp;egra','','NDABAHERANYE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35062','10565/13','Basile','','SEWADATA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35063','10581/13','JEAN BOSCO','','BIZIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35064','10617/13','VALENS','','TUYISENGE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35065','10619/13','Emmanuel','','HAKORIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35066','10624/13','Goodluck','','IRADUKUNDA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35067','10685/13','INNOCENT','','SIBOMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35068','8507/12','FRAN&amp;Ccedil;OISE','','YANKURIJE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35069','8978/12','EUGENIE','','MUKASHEMA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35070','8992/12','GERVAIS','','UWAMAHORO ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35071','8996/12','DAVID','','NIYIGENA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35072','9203/12','VINCENT','','NSENGIYUMVA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35073','9319/12','FAUSTIN','','KANYANDEKWE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35074','9566/12','SOLANGE','','KARUGWIZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35075','9610/12','GERMAINE','','BATAMURIZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35076','9645/13','Christine','','MURERWA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35077','9663/13','Jean Pierre','','KARASIRA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35078','9699/13','cizungu','','NZIGIRE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35079','9708/13','Marie Alice','','MUKAKABERA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35080','9715/13','Clementine','','IGIRUKWISHAKA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35081','9719/13','Emmanuel','','MANISHIMWE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35082','9745/13','Ancille','','BARAYAGAMBA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35083','9746/13','Ephron','','IRAGUHA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35084','9751/13','Theoneste','','SEBERA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35085','9761/13','Parfaite','','MUTUYIMANA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35086','9767/13','Jean Marie Vianney','','UWAMAHORO ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35087','9795/13','Emmanuel','','UWAMUNGU','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35088','','Genevieve','','TUYISHIMIRE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35089','9800/13','Eric','','BIZIMANA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35090','9809/13','Nadine','','IRANKUNDA  ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35091','9816/13','Oscar','','BYIRINGIRO ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35092','9853/13','Pierre','','TUYISHIME ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35093','9857/13','Daniel','','TUYIZERE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35094','9874/13','Peace','','MUHAWENIMANA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35095','9927/13','Gedeon','','BAZATSINDA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35096','9931/13','Jean Chrisostome','','SHABANI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35097','9941/13','Manass&amp;eacute;','','NTIVUGURUZWA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35098','9954/13','Jean Claude','','HARERIMANA  ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35099','9973/13','Christophe','','TUGIRUBUMWE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35100','9996/13','Yvonne','','MUSHIMIYIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35101','10032/13','Theodomir','','MBONYUMUGENZI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35102','10049/13','Ernest','','SINDAYIGAYA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35103','10089/13','Bernard','','MBONIGABA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35104','10104/13','Marthe','','MUSHIMIYIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35105','10119/13','Patient','','NKURUNZIZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35106','10124/13','Fran&amp;ccedil;oise','','MUSABYEMARIYA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35107','10185/13','Jean Marie Vianney','','TWIZEYIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35108','10204/13','Anastase','','GASHIRABAKE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35109','10224/13','Concilie','','NIYONAMBAZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35110','10227/13','Alexis','','MUDACUMURA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35141','10610/13','ERIC','','NSENGIYUMVA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35142','10612/13','Appolinaire','','MUGABO ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35143','10647/13','JEAN DON D&#039;EVE','','MBARUSHIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35144','10656/13','PATRICK','','TWIRINGIYIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35145','10668/13','David','','MIZERO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35146','10781/13','J. DAMASCENE','','SIBOMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35147','7430/11','VICTOIRE','','MPUWIGIRA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35148','8260/11','THEOGENE','','NDAGIJIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35149','8397/12','JEAN PIERRE','','NIYONAGIZE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35150','8619/12','VINCENT','','NKESHIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35151','9148/12','NO&amp;Euml;L','','NTIBAZIRIKANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35152','9161/12','VENANTIE','','NYINAWITUZE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35153','9552/12','CLAUDINE','','TUYISHIME','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35154','9587/12','EMMANUEL','','NDIKUMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35155','9684/13','David','','MASHYAKA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35156','9692/13','Rachel','','UWIZEYIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35157','9722/13','Scholastique','','MUSABYIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35158','9730/13','Emmanuel','','NTAKIRUTIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35159','9806/13','Aphrodis','','NYANDWI ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35160','9887/13','Beatrice','','UWIHOREYE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35161','9926/13','Eric Dalbert','','NSANZAMAHORO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35162','9968/13','Abdou','','MUGABONAKE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35163','9982/13','Olivier','','KARIMWABO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35164','9983/13','Gloria','','NISHIMWE  ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35165','10011/13','Jean Damasc&amp;egra','','INGABIRE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35166','10035/13','Gerardine','','MUKANYANDWI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35167','10041/13','Joseph Mukasa','','SINDAYIGAYA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35168','10057/13','Benjamin','','NDAHAYO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35169','10069/13','Anaclet Juma','','NSANZIMFURA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35170','10086/13','Jules','','NSENGIMANA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35171','10090/13','Oliva','','MUSHIMIYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35172','10091/13','Jean de Dieu','','HABYARIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35173','10107/13','Daniel','','HARERIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35174','10120/13','Thomas','','NSHIMIYUMUREMYI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35175','10172/13','Adelia','','UWIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35176','10184/13','Felix','','IZABAYO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35177','10222/13','Bertin','','NTAMUGABUMWE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35178','10231/13','Ildephonse','','TWIZERIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35179','10282/13','Fiacre','','CYIZA MBONYINSHUTI ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35180','10377/13','Venant','','NSHIMIYIMANA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35191','9840/13','B&amp;eacute;atrice','','AYINKAMIYE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35192','9884/13','Berthilde','','NYIRANZITABAKUZE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35193','9890/13','Rosalie','','MUKAMAZIMPAKA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35194','9895/13','Fran&amp;ccedil;oise','','UMUGWANEZA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35195','9897/13','Emmanuel','','NZAYISENGA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35196','9921/13','Leoncie','','MUKANDAYISENGA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35197','9950/13','Claudine','','UWINGABIYE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35198','9951/13','Marie Jos&amp;eacute','','USABAMAHORO ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35199','9995/13','Emerance','','TWIZERIMANA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35200','10082/13','Clarisse','','UMUHIRE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35211','9777/13','Henriette','','MUHORAKEYE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35212','9827/13','Th&amp;eacute;oneste','','HABUMUREMYI ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35213','9947/13','Aloys','','NZIYUMVIRA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35214','9965/13','Evariste','','NSABAYESU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35215','9974/13','Jean Baptiste','','IMANANTIHEMUKA  ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35216','9985/13','Benjamin','','NGENDABANYIKA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35217','9999/13','James','','GASANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35218','10019/13','Sosthene','','UWIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35219','10036/13','Angelique','','NIYONSENGA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35220','10166/13','Jean Marie Vianney','','GASASIRA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35241','10549/13','Vianney','','HABIYAREMYE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35242','10564/13','Beatrice','','UMUTONI ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35243','10596/13','ALICE','','NYIRANKURIZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35244','10600/13','Venuste','','NTEZIRYAYO ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35245','10629/13','Theogene','','NSHIZIRUNGU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35246','10665/13','Elyse','','NZABAHIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35247','10701/13','Claude','','NSENGIYUMVA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35248','8384/12','CLENIE','','MUKASHYAKA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35249','8463/12','AUGUSTIN','','NSENGIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35250','8587/12','JEAN BOSCO','','MUTABAZI ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35251','8836/12','ABRAHAM','','MUNGUYIKO ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35252','8877/12','J.ERIC','','ITANGISHATSE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35253','9106/12','FLORIBERT','','MBARUSHIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35254','9547/12','EMMANUEL','','IRAHARI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35255','9736/13','Jean Marie Vianney','','NDUWAYEZU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35256','9783/13','J&amp;eacute;r&amp;e','','HABUMUGISHA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35257','9784/13','Donathile','','MUKANDAYISENGA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35258','9869/13','Jean','','NSHIMIYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35259','9878/13','Bernard','','HITIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35260','9943/13','Francine','','MUJAWAYEZU ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35261','9972/13','Juvenal','','TUYISENGE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35262','10013/13','Adale','','HAKIZAYEZU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35263','10044/13','Chantal','','NIYONSABA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35264','10047/13','Eliazar','','HAGENIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35265','10083/13','Jeannette','','SIBOMANA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35266','10087/13','Jean Baptiste','','RUTARU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35267','10095/13','Beno&amp;icirc;t','','TUKAHIRWA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35268','10197/13','Marie Louise','','UWIZEYIMANA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35269','10268/13','Alphonsine','','UWIMANA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35270','10333/13','Alphonse','','DUSANGIYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35301','9891/13','Pascal','','BUREGEYA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35302','9936/13','Canisius','','NDUWAYESU ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35303','9938/13','Celestin','','BAHATI ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35304','9942/13','Claudette','','NYIRANSABIYERA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35305','9944/13','Gerard','','MANIRIHO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35306','9958/13','Sylvestre','','NSANZIMANA Nsengiman','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35307','9967/13','Emmanuel','','NZABONIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35308','9992/13','Jean Marie Vianney','','BIZIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35309','9993/13','Deo','','TUYISHIME','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35310','10009/13','Isaie','','MANIRIHOSE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35341','10640/13','PROTAIS','','SIBOMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35342','10659/13','Celestin','','HABINSHUTI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35343','7412/10','MARIE ROSE','','UWIZEYE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35344','8241/11','JEAN DE DIEU','','TWIZEYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35345','8543/12','BERTILLE','','NIYIGENA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35346','8552/12','GERARD','','HAKIZAMUNGU ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35347','8575/12','ALBERTINE','','UWINEZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35348','8608/12','OLIVE','','MUKANDORI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35349','8641/12','EMMANUEL','','HABARUREMA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35350','8726/12','ROSINE','','MUKASHYAKA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35351','8898/12','GILBERT','','UWIRINGIYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35352','9072/12','LELIQUE','','MUKAYISIRE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35353','9128/12','ORESTE','','MANIRAGUHA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35354','9215/12','JOSIANE','','MUKAMANA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35355','9261/12','CECILE','','NYIRAMAJYAMBERE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35356','9308/12','CLAUDINE','','NIRERE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35357','9406/12','SYLIVER','','KAMALI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35358','9421/12','FRAN&amp;Ccedil;OIS','','TWAHIRWA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35359','9622/12','CLEMENTINE','','MUTUYIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35360','9630/13','Alice','','MUJAWIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35361','9647/13','Aimerance','','UWIMPUHWE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35362','9652/13','Aliane','','ISHIMWE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35363','9695/13','Janvier','','NSABIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35364','9737/13','Devis','','RWAMUHIZI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35365','9743/13','Gloria','','NIYONSHIMYE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35366','9750/13','Pierre','','YANKURIJE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35367','9772/13','Didier','','AHISHAKIYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35368','9780/13','Jean Yves','','HAVUGIYAREMYE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35369','9829/13','F&amp;eacute;licien','','NIYONSENGA  ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35370','9835/13','Agnes','','UWIMBABAZI ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35371','9898/13','Elisaphan','','HAKIZIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35372','9899/13','Emmanuel','','BASABOSE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35373','9919/13','Jean Pierre','','NSHIMYUMUREMYI  ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35374','9925/13','Jovenathe','','NYIRABAGWIZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35375','10020/13','Aim&amp;eacute; Serg','','NKUNZEBOSE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35376','10023/13','Odette','','MUREKATETE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35377','10056/13','Vincent','','MWITENDE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35378','10068/13','Laurence','','NYIRABAVAKURE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35379','10085/13','Felicien','','HAVUGIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35380','10092/13','Cleophas','','AHISHAKIYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35381','10153/13','Theogene','','RWAHINYUZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35382','10174/13','Theophile','','UWIMANIMPAYE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35383','10193/13','Pelagie','','MUKANGENZI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35384','10195/13','Justin','','NSENGIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35385','10223/13','Gilbert','','NDAGIJIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35386','10232/13','Anatole','','NZIGIYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35387','10238/13','Etienne','','BIKORIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35388','10250/13','Emmanuel Honor&amp;e','','BIZIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35389','10271/13','Denis','','MUVUNYI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35390','10289/13','Edith','','MUGWANEZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35401','10553/13','Jean de la Paix','','IYATUREMYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35402','10586/13','Fran&amp;ccedil;ois','','NZEMERIRYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35403','10635/13','Janvier','','NZAMURAMBAHO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35404','10763/13','Jackson','','BIMENYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35405','7671/11','BERNARDINE','','ITANGISHAKA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35406','7840/11','ANACLET','','NZIRORERA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35407','7896/11','MARCEL','','MUTSINDASHYAKA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35408','8211/11','ETIENNE','','NABONIBO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35409','8382/12','VENUSTE','','MUNYEMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35410','8465/12','THEOGENE','','MUHIRE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35411','8469/12','FRAN&amp;Ccedil;OIS','','MUSHIMIYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35412','8567/12','FAUSTIN','','NZAVUGIKI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35413','8669/12','EDISSA','','MUKANIYONSENGA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35414','8694/12','ERIC','','NDAYISABA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35415','8697/12','JEAN DAMASCENE','','MBABARE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35416','8710/12','VICENTIE','','HARERIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35417','8717/12','JOSEPHINE','','INGABIRE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35418','8730/12','OLIVIER','','NTIRENGANYA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35419','8767/12','ATHANASE','','HAGABIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35420','8837/12','CLAUDINE','','MUKANKUNDINEZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35421','8839/12','THEODORE','','MUHAWENIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35422','8903/12','AUREA','','UMUGWANEZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35423','8986/12','EVERGISTE','','NYIRINGABO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35424','9065/12','PRISCILLE','','UWIMIGISHA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35425','9228/12','JEAN','','DARIYO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35426','9315/12','ZACHARIE','','HABIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35427','9317/12','EMMY ALFRED','','HABIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35428','9318/12','OLIVIER','','NSANZIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35429','9324/12','DAMASCENE','','GAKUNZI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35430','9413/12','JEAN DE DIEU','','UWAMUNGU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35441','9886/13','Emmanuel','','TWIZEYUMUREMYI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35442','9912/13','Alphonse','','RUZINDANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35443','9918/13','Augustin','','NSANZAMAHORO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35444','9923/13','Placide','','TUYINGANYIKI ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35445','9930/13','Eulalie','','TUYISHIME','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35446','9935/13','Marie Esther','','TUYISHIME','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35447','9969/13','Jean Bosco','','NTEZIRYAYO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35448','9986/13','Evangeline','','IRAKOZE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35449','9987/13','Marie Louise','','NIYODUSENGA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35450','9990/13','Joel','','BARAKA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35451','10040/13','Marie Grace','','UWAMAHORO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35452','10053/13','Faustin','','HANYURWIMFURA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35453','10058/13','Seraphine','','NYIRANKUNDWA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35454','10094/13','Jean Bosco','','SIBOMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35455','10111/13','Appolinaire','','HAGENIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35456','10122/13','Eric','','TUYIZERE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35457','10132/13','John','','NDAYISHIMIYE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35458','10176/13','Egide','','UWIRINGIYIMANA  ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35459','10181/13','Gratien','','NIYITEGEKA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35460','10194/13','Jean de Dieu','','NSHIMIYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35481','9759/13','Jeannette','','NYIRANTIRENGANYA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35482','9775/13','Aphrodis','','HABIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35483','9801/13','Agnes','','UMUTONI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35484','9802/13','Dioscord ','','NGENZI Mali','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35485','9865/13','Aimable','','IRANKUNDA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35486','9870/13','Marie Louise','','NIYONTEZE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35487','9920/13','Sandrine','','NIMUSENGE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35488','10263/13','Jeanne','','YANKURIJE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35489','10297/13','Edward','','MURAKE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35490','10328/13','Florence','','NIYONSABA           ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35501','8848/12','ERASTE','','HAKIZIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35502','8984/12','MADINE','','MUKANSANGA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35503','9004/12','CHANTAL','','MURAGIJEMARIYA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35504','9375/12','INNOCENT','','NGABIRANO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35505','9726/13','Thomas','','NDINDIRIYIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35506','9766/13','Claude','','MUGENZI ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35507','9770/13','Dieudonn&amp;eacute;','','MANISHIMWE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35508','9819/13','Jean Claude','','MUNYARUBEGA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35509','9879/13','Valentin','','NIZEYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35510','9908/13','Desir&amp;eacute;','','HAGENIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35511','9914/13','Boniface','','MANIRIHO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35512','9960/13','Jean de Dieu','','HAKIZIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35513','9964/13','Esperance','','TUYISHIMIRE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35514','9981/13','Th&amp;eacute;oneste','','BAGIRUBWIRA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35515','9989/13','Jean Baptiste','','NZABONIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35516','10018/13','Philemon','','NDAHIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35517','10039/13','Valentine','','UTAMURIZA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35518','10050/13','Jean Paul','','UWIZEYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35519','10054/13','Fabienne','','NYIRANSHUTI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35520','10055/13','Gerard','','HABIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35521','10100/13','Soline','','INGABIRE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35522','10105/13','Alice','','DUSABE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35523','10129/13','Providence','','ABIJURU ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35524','10138/13','Fran&amp;ccedil;oise','','ISANO Umunezero','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35525','10140/13','Marie Alice','','UWAMARIYA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35526','10151/13','Samuel','','MUSANGABATWARE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35527','10196/13','Theodette','','NYIRATWIZEYIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35528','10198/13','Annonciata','','AKIMANIZANYE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35529','10202/13','Fiona','','TUMWIHOREZE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35530','10239/13','Valens','','HAFASHIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35561','10745/13','Viateur','','MUSONERA            ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35562','8745/12','FLAVIA','','MUKANOHELI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35563','8781/12','JOB','','BYIRINGIRO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35564','8990/12','FRED','','BARIJORO  RWIGEMA   ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35565','9114/12','VESTINE','','IMPUNDU','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35566','9251/12','AIMABLE','','SIBOMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35567','9259/12','DIOCLES','','NDAYAMBAJE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35568','9638/13','Etienne','','TUGIRUMUKIZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35569','9804/13','Pascal','','GATABAZI ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35570','9984/13','Florence','','UWISUGI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35591','9850/13','Emmanuel','','UWITONZE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35592','9852/13','Joseph','','NGENDAHIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35593','9861/13','Mathieu','','NTAMBARA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35594','9901/13','Eularie','','NYIRAKABUGA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35595','9963/13','Isaie','','NYAMINANI ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35596','10024/13','Adrien','','IRADUKUNDA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35597','10074/13','Theoneste','','NIYITEGEKA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35598','10109/13','Virgile','','NTIRENGANYA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35599','10235/13','Bosco','','NKURIKIYIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35600','10251/13','Alphonsine','','UWAMAHORO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35671','8242/11','MARIE CHANTAL','','NDAMUKUNDA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35672','8343/11','THEOGENE','','KAYITAKIRE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35673','8796/12','ALPHONSE','','NYANDWI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35674','8927/12','EUGENIE','','MUKESHIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35675','9211/12','IRENE','','MUKANDAYISHIMIYE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35676','9241/12','OLIVE','','NYIRAHAKIZIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35677','9248/12','FELICIEN','','HAVUGIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35678','9385/12','ERNEST','','NGABONZIZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35679','9423/12','LIB&amp;Eacute;R&amp','','UZAMUHOZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35680','9450/12','ESPERANCE','','AKANYUZUMUGABO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35731','10591/13','Emmanuel','','UWIRAGIYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35732','10645/13','APPOLONIE','','KAMPIRE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35733','10652/13','JENNIFER','','MUSHIMIYIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35734','10655/13','FRANCOISE','','MUKAYISIRE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35735','10661/13','SPECIOSE','','MUKAKARANGWA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35736','10666/13','FRANCOISE','','USANASE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35737','10669/13','Ildephonse','','NYANDWI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35738','10670/13','SABINE','','MUKANGOGA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35739','10675/13','DENYSE','','MUKESHIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35740','10681/13','SOLANGE','','NIRERE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35741','10687/13','SANDRINE','','NUMUKOBWA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35742','10692/13','Pascal','','NYAMWASA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35743','10704/13','Christine','','MANISHIMWE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35744','10706/13','CHRISTINE','','NIYONASENZE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35745','10755/13','Felicien','','UWIRAGIYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35746','10758/13','J. Pierre','','UWITONZE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35747','10760/13','Vedaste','','DUFATANYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35748','10766/13','Deo','','KAZENGA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35749','10774/13','Erneste','','TWIZERE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35750','10775/13','Theoneste','','SIBOMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35751','10778/13','Vedaste','','NDAHIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35752','8427/12','DIEUDONN&amp;Eacute;','','NZABISENGIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35753','8704/12','VEDASTE','','BANGUWIHA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35754','8944/12','REVERIEN','','MANIRAKIZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35755','9035/12','CECILE','','NYIRASAFARI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35756','9345/12','FRANK','','RUZINDANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35757','9565/12','SYLVESTRE','','HABARUREMA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35758','9597/12','AUGUSTIN','','NZABAMWITA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35759','9617/12','CHRISTINE','','NYIRANSENGIYUMVA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35760','9625/12','ONESPHORE','','KUBWIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35841','10551/13','PRUDENCE','','NIYOMWUNGERI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35842','10555/13','Vestine','','NYIRAZUBA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35843','10582/13','Theophile','','INTIME TUYISHIME','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35844','10590/13','Faustin','','MUGANWA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35845','10597/13','Maurice','','AYIRWANDA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35846','10602/13','Emmanuel','','UWITONZE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35847','10631/13','Jean de Dieu','','UWIRINGIYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35848','10634/13','Aphrodice','','RUKUNDO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35849','10671/13','Renatha','','UWIZEYIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35850','10696/13','Kellen','','MBABAZI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35905','10167/13','Nehemie','','AYIRWANDA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','0','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35906','10199/13','Theogene','','UWIRINGIYIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','0','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35907','10210/13','Gilbert','','KAYITARE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','0','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35908','10260/13','Reagan','','NDAYISHIMIYE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','0','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35909','10277/13','Grace','','BENIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','0','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35910','10309/13','Jacques','','MURAGIJIMANA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','0','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35911','10422/13','Jean de Dieu','','UBARIJORO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','0','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35912','10428/13','Olive','','UWIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','0','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35913','10446/13','Aim&amp;eacute;e Dan','','ABANE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','0','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('35914','10518/13','Laura Benitha','','HABINSHUTI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','0','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('40981','10570/13','Innocent','','SEBAZUNGU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('40982','10594/13','Augustin','','MUNYANKINDI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('40983','10694/13','Jean Claude','','BARANZAMBIYE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('40984','8063/11','Jean Claude','','HARERIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('40985','8423/12','VENUSTE','','UWIRINGIYIMANA  ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('40986','8491/12','CHARLOTTE','','MUTESI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('40987','9132/12','JEAN PAUL','','NZABAHIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('40988','9200/12','DAVID','','KAYUMBU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('40989','9333/12','OLIVIER','','KABANDA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('40990','9391/12','ANNET','','KAKWEZI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43199','10332/13','John','','NIYONIZEYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43200','10373/13','Vincent','','MANIRAFASHA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43201','10382/13','Jean Pierre','','UWIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43202','10384/13','Valens','','NGIRINSHUTI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43203','10408/13','Moise','','NKUNDIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43204','10431/13','Samuel','','MBAZIMITIMA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43205','10457/13','Jean Damasc&amp;egra','','NTEZIYAREMYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43206','10460/13','Maurice','','IRADUKUNDA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43207','10474/13','Marc','','UWAYESU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43208','10539/13','Claudine','','BOSENIBAMWE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43239','10366/13','Christine','','TUYISUNGE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43240','10413/13','Benjamin','','KWIZERA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43241','10438/13','Anastase','','NSHIZIMPUMU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43242','10489/13','Gilbert','','NGABONZIZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43243','10498/13','Dieudonn&amp;eacute;','','HABIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43244','10507/13','Huguette','','MURERAMANZI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43245','10511/13','Anaclet','','MUTABARUKA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43246','10514/13','Noel','','MBITEZAMASO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43247','10529/13','RAHAB','','NYIRANDAGIJIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43248','10535/13','Eric','','NGABONZIZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43269','10021/13','Placide Pity','','URANGWANIBAMBE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43270','10033/13','Edson','','RUBEGA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43271','10098/13','Diane','','UWANYIRIGIRA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43272','10135/13','Jean Bosco','','HITIYAREMYE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43273','10187/13','Marie Chantal','','MUKADUSABE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43274','10218/13','Jennifer','','NIYONSABA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43275','10244/13','Alexis','','NZAYISENGA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43276','10245/13','Languide','','MUKAKIBIBI ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43277','10246/13','Jean Bosco','','BYIRINGIRO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43278','10361/13','Elys&amp;eacute;e','','NIYONKESHA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43279','10381/13','Laurence','','TUYISHIMIRE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43280','10424/13','Jean Paul','','USANZABE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43281','10472/13','Jeannine','','SABAGIRIRWA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43282','10517/13','Fran&amp;ccedil;ois','','HATEGEKIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43283','10603/13','Madeleine','','NYIRABAHUFITE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43284','10644/13','Esp&amp;eacute;rance','','IMANIZABAYO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43285','10648/13','Esperance','','UWERA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43286','10700/13','Jean Claude','','ISHIMWE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43287','10743/13','MARIE AIM&amp;Eacute','','UMUMARARUNGU','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43288','9084/12','FULGENCE','','GATERA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43329','10052/13','Anselme','','DUSHIMIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43330','10060/13','Blaise','','MWONGEREZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43331','10125/13','Egide','','TUYISHIMIRE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43332','10159/13','Alexandre','','MUTABAZI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43333','10285/13','Wellars','','NSHIMIYIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43334','10291/13','Charlotte','','UMUHOZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43335','10292/13','Manasseh','','NTEZIYAREMYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43336','10380/13','Joseline','','NISINGIZWE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43337','10464/13','Jean  Baptiste','','DUSENGUMUREMYI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43338','10470/13','Emmanuel','','NDAYISHIMIYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43369','10335/13','Innocent','','NDAGIJIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43370','10354/13','Athanase','','MUREKEZI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43371','10367/13','Josephine','','MAOMBI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43372','10398/13','Balthazar','','HABIYAMBERE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43373','10415/13','Jean Marie Thierry','','NIYIGENA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43374','10478/13','Epiphanie','','NTAMBABAZI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43375','10481/13','Genevieve','','UMWALI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43376','10492/13','Charles','','MANISHIMWE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43377','10515/13','Theogene','','NSHIMIYIMFURA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43378','10538/13','Pauline','','BYUKUSENGE  ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43429','10234/13','Jean  Claude','','HABIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43430','10237/13','Clement','','HATEGEKIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43431','10256/13','Pascal','','HARERIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43432','10266/13','Yvette','','DUSABE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43433','10273/13','Jean Bosco','','HITIYAKARE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43434','10290/13','Pacifique','','UWERA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43435','10329/13','Emile','','DUSENGE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43436','10336/13','Innocent','','YARAMBA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43437','10340/13','Alphonse','','HAKIZIMANA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43438','10346/13','Placide','','MUNYAKAYANZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43439','10359/13','Jean Damasc&amp;egra','','NKUNDABERA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43440','10363/13','Narcisse','','HABAKWIZERA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43441','10368/13','Jean Claude','','NDORAYABO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43442','10369/13','Dathive','','MUKANSHOGOZA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43443','10370/13','Daniel','','BIZIMUNGU ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43444','10374/13','Alphonsine','','MUKAGAHUTU','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43445','10375/13','Vivens','','TUYISHIME','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43446','10407/13','Alphonse','','SIBOMANA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43447','10416/13','Ancilla','','YANKURIJE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43448','10433/13','Paul','','MUTABAZI  ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43449','10439/13','Theogene','','NTAKIRUTIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43450','10456/13','Jean Bosco','','NTIRUHUNGWA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43451','10467/13','Venuste','','NIYONZIMA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43452','10533/13','JEAN BAPTISTE','','GATETE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43453','10546/13','Olivier','','BAVUGA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43454','10554/13','Enock','','MUSAZAWABO ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43455','10588/13','Narcisse','','AYIMFASHIJE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43456','10589/13','Protog&amp;egrave;ne','','UWIRINGIYIMANA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43457','10595/13','Elyse','','NDAYISENGA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43458','10605/13','Innocent','','RWAMIRAMBI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43499','10454/13','Elisabeth','','YANKURIJE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43500','10459/13','Emmanuel','','TWESIGE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43501','10525/13','SETH','','IRANKUNDA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43502','10615/13','Donatha','','GIRASO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43503','10632/13','Theogene','','HASHAKIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43504','10662/13','Alice','','UWAMAHORO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43505','8277/11','DIDIER','','SHYAKA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43506','9444/12','ALEXIS','','SIBOMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43507','9675/13','Celine','','ISHIMWE  ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43508','9760/13','Fran&amp;ccedil;ois','','MUSABYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43519','10126/13','Camille','','NIYONKURU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43520','10321/13','Simon','','NSABIYABISI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43521','10471/13','Emmanuel','','NIYIZURUGERO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43522','10528/13','Mawazo','','NYIRANDEGEYA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43523','10579/13','Emmanuel','','NTABANGANYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43524','10614/13','Valens','','TUYISUNGE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43525','9295/12','ISAIE','','NSANZIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43526','7458/11','ATHANASE','','IYAMUREMYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43527','9355/12','ERIC','','NKURIKIYINKA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43528','9653/13','Jean Pierre','','MANISHIMWE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43539','10214/13','Zacharie','','TUYISHIMIRE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43540','10358/13','Aimable','','NIYITEGEKA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43541','10420/13','Bonaventure','','NIYONSHUTI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43542','10468/13','Moise','','HAGENIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43543','10516/13','Gerard','','ZIGIRUMUGABE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43544','10667/13','NAOME','','IRAGENA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43545','8536/12','PATRICE','','MATESO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43546','9120/12','VALENS KEVEN','','NTIRENGANYA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43547','9189/12','PHILIPPE','','SEBANANI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43548','9569/12','FELIX','','BYUKUSENGE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43549','9658/13','Josiane','','MUTESI ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43550','9660/13','Aline','','UWIMANA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43551','9732/13','Devotha','','UWIDUHAYE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43552','9945/13','Erneste','','NDAYIZEYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43553','10131/13','Vincent','','HABIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43554','10139/13','Philippe','','DUSHIMIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43555','10483/13','Mary','','UWINGENEYE Uwera','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43556','10494/13','Gaspard','','GAHONGAYIRE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43557','10522/13','Ephrem','','NZABONIMPA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43558','10524/13','Marie Solange','','NIRERE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43589','10344/13','Jean Claude','','UWIHANGANYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43590','10388/13','Alphonsine','','BIHOYIKI ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43591','10393/13','Patrick','','NIYONZIMA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43592','10396/13','Severin','','DUSABIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43593','10412/13','Marie Goretti','','UWUMUKIZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43594','10421/13','Pierre Celestin','','UJENEZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43595','10440/13','Pascal','','MUNYEMBARAGA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43596','10450/13','Jean Damasc&amp;egra','','NIYOTWIRINGIYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43597','10466/13','Rebecca Chantal','','USENGA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43598','10495/13','Fran&amp;ccedil;oise','','AYINGENEYE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43599','10502/13','Evariste','','MINANI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43600','10519/13','Daniel','','RUTAYISIRE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43601','10527/13','JEAN BAPTISTE','','UWAYEZU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43602','10531/13','Vestine','','NYIRABAGENZI ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43603','10558/13','Emmanuel','','NTIRENGANYA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43604','10568/13','Sylvain','','KALISA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43605','10578/13','Seraphine','','NIYITEGEKA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43606','10643/13','Antoine','','DUSINGIZIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43607','10650/13','Marie Solange','','NYIRAZANINKA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43608','10705/13','Jean de Dieu','','HABIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43609','9124/12','THEOGENE','','NYUNGURA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43610','9438/12','EMMANUEL','','GASHIRABAKE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43611','9633/13','Marie Solange','','UWURUKUNDO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43612','9643/13','Valens','','KUBWIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43613','9664/13','Louise','','NYIRANSENGIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43614','9666/13','Oliver','','NYIRANSABIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43615','9739/13','Germaine','','MUHOZA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43616','9818/13','Methode','','NSABIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43617','9839/13','Aimable','','SHABANI ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43618','9877/13','Speciose','','UWIZEYIMANA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43639','10178/13','Leonille','','NYIRAMBARUSHIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43640','10283/13','Mardoche','','NSABIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43641','10301/13','Oliver','','TESIRE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43642','10337/13','Samuel','','NTAKIRUTIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43643','10349/13','Jean Damasc&amp;egra','','BAGENIRORA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43644','10350/13','Theodore','','HATEGEKIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43645','10357/13','Laurent','','RUGAMBA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43646','10364/13','Abdan','','GATUKU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43647','10365/13','Valerien','','DUSANGIYIJAMBO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43648','10402/13','Eric','','NSENGIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43649','10443/13','Albert','','NGARUKIYINTWALI  ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43650','10448/13','Jean d&#039;Amour','','GASAGURE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43651','10485/13','Innocent','','RUGAMBA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43652','10486/13','Rachel','','MASENGESHO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43653','10540/13','Aim&amp;eacute; Desi','','RWANDENZE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43654','10562/13','Noel','','SOURIANT ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43655','10592/13','Callixte','','KAMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43656','10618/13','Andr&amp;eacute;','','SEBANANI ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43657','10622/13','Jean Paul','','SEBANANI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43658','10638/13','Martin','','NIYOTWIRINGIRA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43709','10308/13','Theoneste','','HABIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43710','10338/13','Prisca','','MUTUYEMARIYA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43711','10342/13','Vestine','','MUKAMANA  ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43712','10385/13','Olive','','UWAMAHORO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43713','10451/13','Felix','','MAHORO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43714','10480/13','Marie Louise','','UWAMAHORO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43715','10523/13','Valentine','','MUHOZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43716','10526/13','Jean Claude','','NDAGIJIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43717','10542/13','Jean Pierre','','HABYARIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43718','10547/13','Issacar','','NTIHEMUKA  ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43779','10220/13','Felicien','','NIYOSHEMA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43780','10228/13','James','','RUKUNDO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43781','10269/13','Etienne','','TWIZEYIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43782','10293/13','Marcel','','NTAKIRUTIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43783','10323/13','Donath','','NSABIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43784','10330/13','Claudine','','NYIRABAJYINAMA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43785','10334/13','Theophile','','NIYIGABA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43786','10389/13','Esaie','','MUHAYEYEZU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43787','10406/13','Donatien','','BYIRINGIRO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43788','10409/13','Bonifride','','NIRAGIRE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43789','10411/13','Samuel','','NDORIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43790','10417/13','Egidie','','UWAMARIYA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43791','10452/13','Emmanuel','','BIZIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43792','10571/13','Alice','','NIYIGENA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43793','4477/08','JEROME','','NYIRINGABO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43794','6193/09','ESTIME','','NYAMWASA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43795','8737/12','ESPERANCE','','MUHAWENIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43796','9085/12','JONAS','','HABAMUNGU ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43797','9655/13','Fred','','KAMANZI MUCYO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43798','9711/13','Beatrice','','NIYIGENA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43809','10500/13','Maurice Grevisse','','NIYOMUGABO  ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43810','10608/13','Fred','','KAGABO ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43811','10703/13','Leoncie','','MUKANYANDWI ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43812','7625/11','JEAN DE DIEU','','NSEKANABO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43813','8396/12','FIDELE','','NTEZIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43814','8509/12','EMMANUEL','','HAVUGIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43815','8559/12','ABDURHAMANI','','MBONIGABA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43816','8632/12','GAUDENCE','','UWINGABIRE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43817','8662/12','ALEX','','KAVIRI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43818','8812/12','EMMANUEL','','MUHOZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43849','10240/13','Frodouard','','DUSHIMIRIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43850','10242/13','Louise','','MUJAWAMARIYA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43851','10258/13','Florentine','','GUMUSENGE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43852','10279/13','Marie Solange','','NYIRAHABIMANA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43853','10312/13','Jacqueline','','MUKAMUSANGWA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43854','10316/13','Valentine','','IHOGOZA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43855','10318/13','Alodia','','YUBAHWE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43856','10325/13','Innocent','','HABUMUREMYI ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43857','10343/13','Emmanuel','','HAKORIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43858','10345/13','Cyprien','','MUNYAMPUNDU ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43859','10347/13','Jeanne d&#039;Arc','','AYINGENEYE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43860','10360/13','Jean Pierre Alpha','','MUNYARUHENGERI ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43861','10371/13','Francine','','UWAMBAYINGABIRE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43862','10378/13','Concilie','','TUYISHIMIRE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43863','10391/13','Genevieve','','UMUHOZA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43864','10392/13','Alfred','','HABINSHUTI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43865','10397/13','Emmanuel','','BIZIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43866','10401/13','Marie Chantal','','MUKANDAYISENGA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43867','10419/13','Enatte','','MUKAMURIGO ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43868','10441/13','Esperance','','MBABAZI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43869','10442/13','Alphonsine','','KAMBABAZI           ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43870','10465/13','Samuel','','SIMPARINKA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43871','10509/13','Calliope','','DUKUNDIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43872','10510/13','Jean D&amp;eacute;si','','HABIYAMBERE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43873','10548/13','Vedaste','','NDUWAYEZU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43874','10550/13','Athanase','','KANYARUKIKO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43875','10560/13','Theogene','','BIZIMUNGU ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43876','10599/13','Honorine','','MUREKASENGE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43877','10637/13','Athanase','','MUHIRE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43878','10639/13','Marie Gorette','','NYIRAMUTARAMBIRWA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43889','9988/13','Jean Nepomusc&amp;eg','','MUNYANDAMUTSA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43890','10006/13','Peter Claver','','RWIBUTSO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43891','10128/13','Longin','','IRAFASHA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43892','10188/13','David','','MUNYANEZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43893','10213/13','Vianney','','NCOGOZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43894','10262/13','Jean Baptiste','','NDAGIJIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43895','10287/13','Jean Claude','','RUTIKANGA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43896','10319/13','Fabrice','','UWAYO ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43897','10418/13','Isaie','','NDAHAYO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43898','7539/11','EMMANUEL','','GASHAYIJA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43899','7547/11','ALEXANDRE','','KAGINA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43900','7630/11','JEAN CLAUDE','','NDAHIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43901','8109/11','JEAN DE DIEU','','NSENGIYUMVA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43902','9026/12','ERNEST','','MPIRANYA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43903','9564/12','JEAN DE DIEU','','MIRINDI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43904','9661/13','Theogene','','BIHOYIKI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43905','9678/13','Peter','','GAPFIZI ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43906','9688/13','Clemence','','MUKANYINDO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43907','9740/13','Jean de la Paix','','MUNYAZIKWIYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43908','9776/13','Florentine','','NZASANGAMARIYA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43919','10255/13','Jean','','JAMBO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43920','10295/13','Jean de Dieu','','TUYISHIME ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43921','10322/13','Thacienne','','UMUHIRE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43922','10327/13','Jean de Dieu','','NKURIKIYIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43923','10348/13','Fran&amp;ccedil;ois','','BIGIRIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43924','10352/13','Fran&amp;ccedil;oise','','UWINDAMUTSA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43925','10436/13','Jean Marie Vianney','','AHISHAKIYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43926','10476/13','Emmanuel','','URAMUTSE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43927','10477/13','Jean de Dieu','','MUNYANEZA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43928','10501/13','Theophile','','NKUNDABERA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43949','9701/13','Ferdinand','','TWAYIGIRA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43950','9729/13','Providence','','UWASE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43951','9754/13','Janet','','NIYONSABA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43952','9779/13','Bosco','','NZAYISENGA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43953','9782/13','Jean Baptiste','','BENIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43954','9794/13','Jacques','','HABIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43955','9807/13','MATHIEU','','TWAGIRUMUKIZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43956','9815/13','Jean Paul','','KAMANZI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43957','9828/13','Marie Claire','','UWIZEYIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43958','9847/13','Clementine','','MUSHIMIYIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43959','9851/13','Anastase','','BUGINGO ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43960','9875/13','Clementine','','UWINEZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43961','9882/13','Pascal','','NSENGIYAREMYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43962','9910/13','Fidele','','TWIBANIRE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43963','9940/13','Pacifique','','DUSHIMIRIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43964','9991/13','Seth','','NIYONKURU ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43965','9997/13','Alexis','','NGIRABATWARE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43966','10063/13','Marie Mediatrice','','ISHIMWE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43967','10088/13','Patrick','','SINGIRANKABO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43968','10099/13','Thierry','','MANIRAKIZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43969','10112/13','Solange','','UWITIJE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43970','10123/13','Jean Baptiste','','NTAWIHEBA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43971','10152/13','Basile','','HIRWA NDAGIJIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43972','10160/13','Eric','','MUSIRIKARE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43973','10201/13','Emile','','KAYITARE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43974','10212/13','Aaron','','KAMALI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43975','10233/13','Elquana','','NINDAGIRIRE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43976','10259/13','Emmanuel','','NIYONSENGA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43977','10265/13','Godfrey','','MUKOTANYI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43978','10302/13','Innocent','','TWIRINGIYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43979','10305/13','Emmanuel','','HABIYAKARE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43980','10311/13','Didas','','NDAYAMBAJE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43981','10331/13','Bonaventure','','TUYISENGE SHINGIRO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43982','10339/13','Theoneste','','MANIRAKIZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43983','10372/13','Patrick','','NDAYISHIMIYE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43984','10490/13','Godfrey','','GAHIGANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43985','10598/13','Jackson','','RWIGAMBA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43986','10672/13','Jean Claude','','NZARUBARA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43987','10756/13','Jean de Dieu','','UGIRAYEZU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43988','10764/13','Domitille','','UWIMANA   ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('43999','9519/12','YVETTE','','UWAMAHORO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44000','9531/12','A&amp;Iuml;SHA','','INGABIRE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44001','9558/12','GODELEVE','','BYUKUSENGE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44002','9559/12','MATHILDE','','UWINTIJE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44003','9568/12','AGNES','','UWIMBABAZI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44004','9586/12','JEAN BOSCO','','MUYANGO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44005','9713/13','Virginie','','MUKANDAYISENGA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44006','9762/13','Laetitia','','NIYOYIGENERA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44007','9768/13',' Jean','','NSABIMANA Amani','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44008','9771/13','Victor','','HAGABIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44009','9774/13','Jean Marie Vianney','','BARATURWANGO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44010','9810/13','Elyse','','SEBAKIGA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44011','9833/13','ANASTASE','','RUBANZABIGWI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44012','9846/13','Fran&amp;ccedil;ois','','NDAHAYO ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44013','9856/13','Audifax','','BIBUTSUHOZE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44014','9863/13','Th&amp;eacute;l&amp;','','NIYONZIMA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44015','9911/13','Basile','','MISAGO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44016','9946/13','J. Claude','','NDUWAYEZU','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44017','9962/13','Aimable','','NIBASEKE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44018','9970/13','Ismail','','NDAYISENGA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44019','10003/13','Immacul&amp;eacute;e','','KANYANGE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44020','10073/13','Jean d&#039;Amour','','BYIRINGIRO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44021','10076/13','Sosthene','','TUYISENGE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44022','10093/13','Theodore','','RUKUMBUZI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44023','10110/13','Marceline','','NIKUZE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44024','10143/13','Jean Pierre','','BIMENYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44025','10144/13','Delphine','','UWAMURERA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44026','10155/13','Fulgence','','RUTAGENGWA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44027','10158/13','Fran&amp;ccedil;oise','','NYOTA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44028','10177/13','Noel','','HAKIZIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44029','10203/13','Gaudence','','NAKURE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44030','10215/13','Alex','','MUNEZERO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44031','10294/13','Jonas','','NDIRIKIYE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44032','10298/13','Eric','','MUKESHIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44033','10299/13','Jean Paul','','MIZERO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44034','10300/13','Noella','','DUSENGE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44035','10303/13','Theoneste','','NTEZIRYAYO ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44036','10362/13','Jean Pierre','','KARINDA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44037','10387/13','Robert','','MUGABE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44038','10427/13','Etienne','','HARERIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44039','10435/13','Venuste','','HAGENIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44040','10462/13','Jean d&#039;Amour','','NZAYISENGA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44041','10469/13','Claude','','SIMBIYOBEWE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44042','10475/13','Marcel ','','TUYISENGE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44043','10504/13','MARIE JEANNE','','UWIZEYE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44044','10534/13','CHRISTINE','','UWANYIRIGIRA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44045','10536/13','RACHEL','','IRANKUNDA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44046','10537/13','Emmanuel','','NIYONSENGA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44047','10576/13','VALENTINE','','MUKAMUGANGA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44048','10580/13','CECILE','','MUSANIWABO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44079','9650/13','Theogene','','MUNYANEZA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44080','9657/13','Theogene','','TURIKUNKIKO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44081','9669/13','Laurence','','SANDE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44082','9681/13','Valens','','NSABIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44083','9691/13','Violette','','MUKESHIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44084','9694/13','Eden Garden','','NDAHIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44085','9697/13','Jean de Dieu','','NIZEYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44086','9731/13','Evariste','','MURWANASHYAKA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44087','9734/13','Jean Damasc&amp;egra','','NIYONZIMA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44088','9741/13','Alice','','MUJAWAMARIYA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44089','9748/13','Celestin','','HARERIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44090','9753/13','Vincent','','BUNANI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44091','9756/13','Joseph','','KANYABUGUFI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44092','9769/13','Joseph','','MUGEMA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44093','9778/13','Darius','','TURAMYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44094','9790/13','Solange','','NZANYWAYIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44095','9797/13','Damasc&amp;egrave;ne','','MURWANASHYAKA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44096','9805/13','Jean Marie Vianney','','NIYONSABA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44097','9814/13','Eugene','','NZAGAHIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44098','9817/13','Zebed&amp;eacute;e','','NKURIKIYUMUKIZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44099','9858/13','Jean Marie Vianney','','YANDAGIRIYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44100','9862/13','Laurent','','NKOMEJIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44101','9868/13','Jovial','','NIYOGISUBIZO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44102','9876/13','Aim&amp;eacute; Desi','','HABIYAREMYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44103','9889/13','Jeanine','','USABAMARIYA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44104','9902/13','Mathias','','TUYISENGE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44105','9904/13','Donath','','MAHORO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44106','9909/13','Jean Pierre','','SIBOMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44107','9928/13','Eugenie','','NIKUZE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44108','9948/13','Marie Josianne','','NIZEYEYEZU','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44109','9955/13','Vincent','','SEKANYAMBO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44110','9976/13','Paul','','DUSHIMIRIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44111','9977/13','Emmanuel','','NSABIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44112','10012/13','Pacifique','','NIYITEGEKA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44113','10025/13','Emilienne','','KIBERINKA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44114','10027/13','Severin','','USABYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44115','10059/13','Theoneste','','HITARUREMA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44116','10061/13','Etienne','','MANIRAFASHA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44117','10065/13','Speciose','','DUSABE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44118','10066/13','Willy Brolid','','BASEKANAYANDI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44119','10079/13','Jean Damasc&amp;eacu','','BAZARAMBIRWA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44120','10106/13','Martin','','NTWARI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44121','10113/13','Eric','','MBARUSHIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44122','10137/13','Alexiane','','NYIRAHABIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44123','10141/13','Vincent','','DUSINGIZIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44124','10150/13','Gladys','','KEZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44125','10170/13','Viateur','','AYIRWANDA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44126','10173/13','Revelien','','MASENGESHO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44127','10179/13','Placide','','HABUMUREMYI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44128','10186/13','Jean Claude','','HAKIZIMFURA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44129','10189/13','Jean de Dieu','','MPAKANIYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44130','10190/13','Etienne','','NGENDAHIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44131','10200/13','Yvette','','ABAYISENGA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44132','10219/13','Gad','','NKUSI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44133','10225/13','Peter','','NDIMURWANGO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44134','10226/13','Theodette','','UWONKUNDA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44135','10248/13','Donatha','','TUYISHIMIRE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44136','10252/13','Peter','','SANDE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44137','10257/13','Theoneste','','MANIRAFASHA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44138','10267/13','Elisabeth','','MUKANDAYISENGA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44139','10307/13','Evariste','','BIGIRIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44140','10353/13','Venant','','NIYIBIZI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44141','10355/13','Serge','','NTEZIRIZAZA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44142','10386/13','Claudine','','DUSABEYEZU','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44143','10404/13','Jeanne d&#039;Arc','','NYIRANEZA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44144','10405/13','Godeberthe','','IRADUFASHA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44145','10430/13','James','','MUSONI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44146','10437/13','Assumpta','','UWIHIRWE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44147','10444/13','Marie Grace','','MUSABYIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44148','10447/13','Aloys','','HABIYAREMYE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44149','10449/13','Phocas','','NIYIBIZI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44150','10453/13','Rosine','','UWIHOREYE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44151','10455/13','Ildebrande','','NIYONZIMA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44152','10461/13','Olivier','','NIYOYITA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44153','10463/13','Daniel','','HARERIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44154','10479/13','J. PIERRE','','TURIMUMAHORO','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44155','10499/13','IMMACUL&amp;Eacute;E','','NYIRANSABIMANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44156','10503/13','Moise','','TUYISHIME ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44157','10541/13','Agnes','','NYIRABUKEYE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44158','10544/13','Fulgence','','BIKERINKA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44169','10751/13','Fabrice','','MUVUNYI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44170','10752/13','Joachim','','TUZASENGA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44171','6722/10','Winifride','','NYIRANDUHURA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44172','8326/11','EDWARD','','BAYINGANA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44173','8402/12','JEAN MAURICE','','NTAHOBARI           ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44174','9641/13','Betty','','HAGENIMANA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44175','9672/13','Florence','','UWITONZE ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44176','9673/13','Fran&amp;ccedil;ois','','HAKUZIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44177','9676/13','Alice','','IRADUKUNDA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44178','9696/13','VICTOR','','DUSABUMUREMYI ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44179','9720/13','Lambert','','MUGISHA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44180','9747/13','Aliane','','MUKANDANGA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44181','9757/13','Jean','','BYUKUSENGE ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44182','9765/13','Emerthe','','NAMAHORO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44183','9786/13','Eric','','IRIVUZIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44184','9793/13','Jean Claude','','NIYIGABA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44185','9826/13','Ernest','','NIZEYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44186','9830/13','Dative','','UWAMAHORO','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44187','9831/13','Thomas','','HAGENIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44188','9837/13','Callixte','','NYANDWI ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44189','9872/13','Marie Gorette','','NIYIGENA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44190','9896/13','Amos','','RUTAGANDA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44191','9933/13','Jacques','','NIYITEGEKA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44192','9934/13','Viviane','','NYIRAMBONIZANYE','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44193','10000/13','Tharcille','','NIYIGENA','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44194','10102/13','Jean d&#039;Amour','','HAKIZIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44195','10115/13','Simon Pierre','','KWIHANGANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44196','10157/13','Narcisse','','NYABYENDA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44197','10169/13','Jean de Dieu','','NSHIMIYIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44198','10209/13','Jean Paul','','HAKIZIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44199','10221/13','Sylvere','','NKUNDIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44200','10230/13','Gilbert','','MUHAWENIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44201','10286/13','Jean Nepomusc&amp;eg','','NKURIYINGOMA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44202','10304/13','Oscar','','NDORIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44203','10306/13','Jean Damasc&amp;egra','','HABINSHUTI','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44204','10383/13','Dieudonn&amp;eacute;','','HAFASHIMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44205','10394/13','Charles','','BISENGIMANA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44206','10395/13','Robert','','MUGANGA ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44207','10400/13','Alexis','','NDIKUMANA','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','1','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44208','10482/13','Jean Pierre','','UWINGABIRE   ','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','0','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44209','10487/13','Jean d&#039;Amour','','SHYIRAMBERE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','0','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44210','10508/13','Fran&amp;ccedil;oise','','UZAMUKUNDA ','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','0','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44211','10512/13','Gorreth','','MBABAZI','0000-00-00','0000-00-00','0000-00-00','1','','','','1','1','','0','0','','');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('44212','10779/13','J. de Dieu','','RUTAYISIRE','0000-00-00','0000-00-00','0000-00-00','0','','','','1','1','','0','0','','');



-- -------------------------------------------
-- TABLE DATA province
-- -------------------------------------------
INSERT INTO `province` (`id`,`province`) VALUES
('1','University of Rwanda');



-- -------------------------------------------
-- TABLE DATA sector
-- -------------------------------------------
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('1','Students','1');



-- -------------------------------------------
-- TABLE DATA service
-- -------------------------------------------
INSERT INTO `service` (`id`,`service`) VALUES
('1','Service 1');
INSERT INTO `service` (`id`,`service`) VALUES
('2','Service 2');



-- -------------------------------------------
-- TABLE DATA traitement
-- -------------------------------------------
INSERT INTO `traitement` (`id`,`medical_act`,`idservice`,`type`,`transfer`) VALUES
('1','Act 1','1','1','1');
INSERT INTO `traitement` (`id`,`medical_act`,`idservice`,`type`,`transfer`) VALUES
('2','Act 2','2','2','1');



-- -------------------------------------------
-- TABLE DATA users
-- -------------------------------------------
INSERT INTO `users` (`id`,`firstname`,`middlename`,`lastname`,`username`,`password`,`salt`,`groupe`,`status`) VALUES
('5','Manager','Aloys','Manager','manager','1a4938bd29a5be4dec15f7af43200037','544a2dceae1ad7.39407031','5','1');



-- -------------------------------------------
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
COMMIT;
-- -------------------------------------------
-- -------------------------------------------
-- END BACKUP
-- -------------------------------------------

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
  CONSTRAINT `beneficaire_ibfk_1` FOREIGN KEY (`idmember`) REFERENCES `members` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1 COMMENT='billing of analyse or traitements';

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

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
  CONSTRAINT `invoice_ibfk_2` FOREIGN KEY (`idmember`) REFERENCES `members` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COMMENT='analyse or traitement';

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
  `nationality` varchar(40) DEFAULT NULL,
  `status` int(1) NOT NULL COMMENT 'Active or not',
  `type` int(1) NOT NULL COMMENT 'student or teacher',
  `photo` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `ordonance`
-- -------------------------------------------
DROP TABLE IF EXISTS `ordonance`;
CREATE TABLE IF NOT EXISTS `ordonance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eye` varchar(6) NOT NULL,
  `type` varchar(12) NOT NULL,
  `typeofglass` varchar(8) NOT NULL,
  `vision` varchar(8) NOT NULL,
  `typeoflenses` varchar(15) NOT NULL,
  `lunette` varchar(15) NOT NULL,
  `interpupillarydistance` float NOT NULL,
  `idinvoice` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idinvoice` (`idinvoice`),
  CONSTRAINT `ordonance_ibfk_1` FOREIGN KEY (`idinvoice`) REFERENCES `invoice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `service`
-- -------------------------------------------
DROP TABLE IF EXISTS `service`;
CREATE TABLE IF NOT EXISTS `service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `traitement`
-- -------------------------------------------
DROP TABLE IF EXISTS `traitement`;
CREATE TABLE IF NOT EXISTS `traitement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medical_act` varchar(50) NOT NULL,
  `idservice` int(11) NOT NULL,
  `type` int(1) NOT NULL COMMENT 'analyse equal 1 or traitement equal 2',
  `transfer` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `medical_act` (`medical_act`),
  KEY `idservice` (`idservice`),
  CONSTRAINT `traitement_ibfk_1` FOREIGN KEY (`idservice`) REFERENCES `service` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

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
  `group` int(1) NOT NULL,
  `status` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE DATA beneficaire
-- -------------------------------------------
INSERT INTO `beneficaire` (`id`,`photo`,`firstname`,`middlename`,`lastname`,`dateofbirth`,`sex`,`type`,`idmember`) VALUES
('1','6','Manzi','','Chalvi','2010-02-24','0','2','1');
INSERT INTO `beneficaire` (`id`,`photo`,`firstname`,`middlename`,`lastname`,`dateofbirth`,`sex`,`type`,`idmember`) VALUES
('3','9','uwamahoro','','Pacy','2004-07-02','1','2','1');
INSERT INTO `beneficaire` (`id`,`photo`,`firstname`,`middlename`,`lastname`,`dateofbirth`,`sex`,`type`,`idmember`) VALUES
('4','6059-Penguins.jpg','Miss Pinguins','kakadd','Stone','2014-07-01','1','1','9');



-- -------------------------------------------
-- TABLE DATA billing_details
-- -------------------------------------------
INSERT INTO `billing_details` (`id`,`idinvoice`,`idmedical`,`quantity`,`price`) VALUES
('1','1','2','1','1500');
INSERT INTO `billing_details` (`id`,`idinvoice`,`idmedical`,`quantity`,`price`) VALUES
('2','1','2','1','15000');
INSERT INTO `billing_details` (`id`,`idinvoice`,`idmedical`,`quantity`,`price`) VALUES
('3','3','1','2','1000');
INSERT INTO `billing_details` (`id`,`idinvoice`,`idmedical`,`quantity`,`price`) VALUES
('8','7','1','2','170');
INSERT INTO `billing_details` (`id`,`idinvoice`,`idmedical`,`quantity`,`price`) VALUES
('10','8','2','23','1234');
INSERT INTO `billing_details` (`id`,`idinvoice`,`idmedical`,`quantity`,`price`) VALUES
('11','9','1','1','9000');
INSERT INTO `billing_details` (`id`,`idinvoice`,`idmedical`,`quantity`,`price`) VALUES
('12','9','1','2','2000');
INSERT INTO `billing_details` (`id`,`idinvoice`,`idmedical`,`quantity`,`price`) VALUES
('13','10','3','2','14000');
INSERT INTO `billing_details` (`id`,`idinvoice`,`idmedical`,`quantity`,`price`) VALUES
('14','10','1','1','20500');
INSERT INTO `billing_details` (`id`,`idinvoice`,`idmedical`,`quantity`,`price`) VALUES
('16','2','3','1','6350');
INSERT INTO `billing_details` (`id`,`idinvoice`,`idmedical`,`quantity`,`price`) VALUES
('17','2','3','1','6350');



-- -------------------------------------------
-- TABLE DATA hospital
-- -------------------------------------------
INSERT INTO `hospital` (`id`,`hopitalName`,`address`,`type`,`iduser`) VALUES
('1','Kanimba Hospital','kigali ville','0','1');
INSERT INTO `hospital` (`id`,`hopitalName`,`address`,`type`,`iduser`) VALUES
('2','Teta','Remera','1','1');



-- -------------------------------------------
-- TABLE DATA invoice
-- -------------------------------------------
INSERT INTO `invoice` (`id`,`date`,`idmember`,`idhospital`,`status`,`type`) VALUES
('1','2014-08-05','2','1','1','2');
INSERT INTO `invoice` (`id`,`date`,`idmember`,`idhospital`,`status`,`type`) VALUES
('2','2014-08-01','2','1','1','1');
INSERT INTO `invoice` (`id`,`date`,`idmember`,`idhospital`,`status`,`type`) VALUES
('3','2014-08-05','1','1','1','3');
INSERT INTO `invoice` (`id`,`date`,`idmember`,`idhospital`,`status`,`type`) VALUES
('4','2014-08-03','5','1','1','1');
INSERT INTO `invoice` (`id`,`date`,`idmember`,`idhospital`,`status`,`type`) VALUES
('5','2014-08-07','1','1','1','1');
INSERT INTO `invoice` (`id`,`date`,`idmember`,`idhospital`,`status`,`type`) VALUES
('6','2014-08-06','1','1','1','2');
INSERT INTO `invoice` (`id`,`date`,`idmember`,`idhospital`,`status`,`type`) VALUES
('7','2014-08-05','4','2','12','1');
INSERT INTO `invoice` (`id`,`date`,`idmember`,`idhospital`,`status`,`type`) VALUES
('8','2014-08-05','8','1','1','2');
INSERT INTO `invoice` (`id`,`date`,`idmember`,`idhospital`,`status`,`type`) VALUES
('9','2014-08-12','4','1','1','1');
INSERT INTO `invoice` (`id`,`date`,`idmember`,`idhospital`,`status`,`type`) VALUES
('10','2014-08-05','1','1','1','1');
INSERT INTO `invoice` (`id`,`date`,`idmember`,`idhospital`,`status`,`type`) VALUES
('11','2014-08-13','1','1','1','3');
INSERT INTO `invoice` (`id`,`date`,`idmember`,`idhospital`,`status`,`type`) VALUES
('12','2014-08-05','1','1','1','1');



-- -------------------------------------------
-- TABLE DATA members
-- -------------------------------------------
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`nationality`,`status`,`type`,`photo`) VALUES
('1','000000000000001','Ntabana','Rudahunga','Aloys','2014-07-02','2015-07-01','1994-07-22','0','0788654321','Kigali','Rwanda','1','0','5');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`nationality`,`status`,`type`,`photo`) VALUES
('2','000000000000002','Uwamahoro','k','Denyse','2014-07-01','2016-07-01','1984-04-25','1','0788654321','Kigali','Rwanda','1','0','9i');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`nationality`,`status`,`type`,`photo`) VALUES
('3','000000000000003','Cyusa','Mucyowiraba','Leandre','2014-07-01','2014-08-01','1978-04-25','0','0788306754','kigali','Rwanda','1','0','8uy');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`nationality`,`status`,`type`,`photo`) VALUES
('4','000000000000004','Samusaza','','Peter','2014-07-01','2014-08-30','1984-07-18','0','0788654321','Kicukiro','Rwanda','0','0','8uyt');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`nationality`,`status`,`type`,`photo`) VALUES
('5','000000000000005','Nyirakamana','','Colette','2014-07-01','2014-07-31','1987-07-22','1','07886543243','Kicukiro','Rwanda','1','1','8208-');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`nationality`,`status`,`type`,`photo`) VALUES
('8','000000000000010','Kamanzi','','Peter','2014-07-01','2014-10-31','1994-07-22','0','0788306709','Kigali','Rwanda','0','1','1182-images (1).jpg');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`nationality`,`status`,`type`,`photo`) VALUES
('9','000000000000013','Andrew','','Stone','2014-07-23','2023-07-28','1994-07-22','0','0788306754','Kigali','UK','1','1','1365-Penguins.jpg');



-- -------------------------------------------
-- TABLE DATA service
-- -------------------------------------------
INSERT INTO `service` (`id`,`service`) VALUES
('1','Pediatrie');



-- -------------------------------------------
-- TABLE DATA traitement
-- -------------------------------------------
INSERT INTO `traitement` (`id`,`medical_act`,`idservice`,`type`,`transfer`) VALUES
('1','amaraso','1','1','0');
INSERT INTO `traitement` (`id`,`medical_act`,`idservice`,`type`,`transfer`) VALUES
('2','Kubaga','1','2','0');
INSERT INTO `traitement` (`id`,`medical_act`,`idservice`,`type`,`transfer`) VALUES
('3','Guhoma','1','1','0');



-- -------------------------------------------
-- TABLE DATA users
-- -------------------------------------------
INSERT INTO `users` (`id`,`firstname`,`middlename`,`lastname`,`username`,`password`,`salt`,`group`,`status`) VALUES
('1','Ntabana','Rudahunga','Aloys','ntabana','b9de10071f4b7f93505bf1075911930f','53d6a278ec1019.18518121','1','1');



-- -------------------------------------------
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
COMMIT;
-- -------------------------------------------
-- -------------------------------------------
-- END BACKUP
-- -------------------------------------------

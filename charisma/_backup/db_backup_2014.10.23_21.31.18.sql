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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COMMENT='billing of analyse or traitements';

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='analyse or traitement';

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
  CONSTRAINT `members_ibfk_1` FOREIGN KEY (`iddistrict`) REFERENCES `district` (`id`),
  CONSTRAINT `members_ibfk_2` FOREIGN KEY (`idsector`) REFERENCES `sector` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

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
-- TABLE `province`
-- -------------------------------------------
DROP TABLE IF EXISTS `province`;
CREATE TABLE IF NOT EXISTS `province` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `province` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `province` (`province`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=311 DEFAULT CHARSET=latin1;

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
  `groupe` int(1) NOT NULL,
  `status` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE DATA beneficaire
-- -------------------------------------------
INSERT INTO `beneficaire` (`id`,`photo`,`firstname`,`middlename`,`lastname`,`dateofbirth`,`sex`,`type`,`idmember`) VALUES
('3','2889-images (3).jpg','ntabana','k','Anita','1976-06-12','1','1','15');
INSERT INTO `beneficaire` (`id`,`photo`,`firstname`,`middlename`,`lastname`,`dateofbirth`,`sex`,`type`,`idmember`) VALUES
('4','8210-images.jpg','Ntabana','p','Jojo','2000-08-18','0','2','15');



-- -------------------------------------------
-- TABLE DATA billing_details
-- -------------------------------------------
INSERT INTO `billing_details` (`id`,`idinvoice`,`idmedical`,`quantity`,`price`) VALUES
('1','1','2','3','4');
INSERT INTO `billing_details` (`id`,`idinvoice`,`idmedical`,`quantity`,`price`) VALUES
('2','1','2','0','23');
INSERT INTO `billing_details` (`id`,`idinvoice`,`idmedical`,`quantity`,`price`) VALUES
('3','1','2','2','200');
INSERT INTO `billing_details` (`id`,`idinvoice`,`idmedical`,`quantity`,`price`) VALUES
('4','1','2','0','80');



-- -------------------------------------------
-- TABLE DATA billing_drug
-- -------------------------------------------
INSERT INTO `billing_drug` (`id`,`idinvoice`,`iddrug`,`quantity`) VALUES
('1','2','1','2');
INSERT INTO `billing_drug` (`id`,`idinvoice`,`iddrug`,`quantity`) VALUES
('2','3','1','12');



-- -------------------------------------------
-- TABLE DATA district
-- -------------------------------------------
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('1','Burera','1');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('2','Musanze','1');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('3','Rubavu','5');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('4','Rwamagana','3');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('5','Huye','2');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('8','Nyamagabe','2');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('11','Kayonza','3');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('13','Muhanga','2');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('15','Kicukiro','6');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('17','Nyarugenge','6');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('18','Gasabo','6');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('19','Nyanza','2');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('20','Gakenke','1');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('21','Rulindo','1');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('22','Bugesera','3');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('23','Nyagatare','3');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('24','Ngoma','3');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('25','Kirehe','3');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('26','Gatsibo','3');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('27','Gisagara','2');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('28','Kamonyi','2');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('29','Nyaruguru','2');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('30','Ruhango','2');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('31','Karongi','5');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('32','Ngororero','5');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('33','Nyabihu','5');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('34','Nyamasheke','5');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('35','Rusizi','5');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('36','Rutsiro','5');
INSERT INTO `district` (`id`,`district`,`idprovince`) VALUES
('37','Gicumbi','1');



-- -------------------------------------------
-- TABLE DATA drugs
-- -------------------------------------------
INSERT INTO `drugs` (`id`,`drug`,`generic`,`cash`,`availability`) VALUES
('1','Visine','0','5000','1');



-- -------------------------------------------
-- TABLE DATA hospital
-- -------------------------------------------
INSERT INTO `hospital` (`id`,`hopitalName`,`address`,`type`,`iduser`) VALUES
('1','Nyirinkwaya','Remera','0','5');



-- -------------------------------------------
-- TABLE DATA invoice
-- -------------------------------------------
INSERT INTO `invoice` (`id`,`date`,`idmember`,`idhospital`,`status`,`type`) VALUES
('1','2014-10-07','15','1','1','1');
INSERT INTO `invoice` (`id`,`date`,`idmember`,`idhospital`,`status`,`type`) VALUES
('2','2014-10-23','15','1','1','4');
INSERT INTO `invoice` (`id`,`date`,`idmember`,`idhospital`,`status`,`type`) VALUES
('3','2014-10-14','15','1','1','4');



-- -------------------------------------------
-- TABLE DATA members
-- -------------------------------------------
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('15','000000000000001','ntabana','Rudahunga','Aloys','2014-07-31','2014-08-06','1982-01-27','0','07654321','Kigali','ntabanacoco@gmail.com','24','1','Rwanda','0','0','3010-dd.jpg','Dr');
INSERT INTO `members` (`id`,`cardnumber`,`firstname`,`middlename`,`lastname`,`issuedate`,`expireddate`,`birthday`,`sex`,`phonenumber`,`address`,`email`,`iddistrict`,`idsector`,`nationality`,`status`,`type`,`photo`,`title`) VALUES
('16','000000000000002','Uwamahoro','Kamanzi','Denyse','2014-08-05','2014-08-23','2004-08-04','1','0788543310','Kigali','udenyse@yahoo.fr','19','78','Rwanda','1','1','4542-images (2).jpg','Miss');



-- -------------------------------------------
-- TABLE DATA province
-- -------------------------------------------
INSERT INTO `province` (`id`,`province`) VALUES
('2','Intara y\'Amajyepfo');
INSERT INTO `province` (`id`,`province`) VALUES
('3','Intara y\'Iburasirazu');
INSERT INTO `province` (`id`,`province`) VALUES
('5','Intara y’Iburengerazuba');
INSERT INTO `province` (`id`,`province`) VALUES
('1','Northern Province');
INSERT INTO `province` (`id`,`province`) VALUES
('6','Umujyi wa Kigali');



-- -------------------------------------------
-- TABLE DATA sector
-- -------------------------------------------
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('1','Gashora','22');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('2','Juru','22');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('3','Kamabuye','22');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('4','Ntarama','22');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('5','Mareba','22');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('6','Mayange','22');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('7','Musenyi','22');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('8','Mwogo','22');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('9','Ngeruka','22');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('10','Nyamata','22');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('11','Nyarugenge','22');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('12','Rilima','22');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('13','Ruhuha','22');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('14','Rweru','22');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('15','Shyara','22');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('16','Gasange','26');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('17','Gatsibo','26');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('18','Gitoki','26');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('19','Kabarore','26');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('20','Kageyo','26');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('21','Kiramuruzi','26');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('22','kKiziguro','26');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('23','Muhura','26');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('24','Murambi','26');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('25','Ngarama','26');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('26','Nyagihanga','26');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('27','Remera','26');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('28','Rugarama','26');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('29','Rwimbogo','26');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('30','Gahini','11');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('31','Kabare','11');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('32','Kabarondo','11');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('33','Mukarange','11');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('34','Murama','11');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('35','Murundi','11');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('36','Mwiri','11');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('37','Bungwe','1');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('38','Ndego','11');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('39','Nyamirama','11');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('40','Butaro','1');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('41','Cyanika','1');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('42','Rukara','11');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('43','Ruramira','11');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('44','Rwinkwavu','11');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('45','Gahara','25');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('46','cyeru','1');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('47','gahunga','1');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('48','Gatebe','1');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('49','Gatore','25');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('50','Kigina','25');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('51','Gitovu','1');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('52','Kirehe','25');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('53','Mahama','25');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('54','Kagogo','1');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('55','Mpanga','25');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('56','Kinoni','1');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('57','Musaza','25');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('58','Mushikiri','25');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('59','Nasho','25');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('60','Nyamugari','25');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('61','Nyarubuye','25');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('62','Kigarama','25');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('63','Gashanda','24');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('64','Jarama','24');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('65','Karembo','24');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('66','Kazo','24');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('67','Kibungo','24');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('68','Mugesera','24');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('69','Kinyababa','1');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('71','Kivuye','1');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('73','Nemba','1');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('76','Mutenderi','24');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('78','Rukira','24');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('79','Rukumberi','24');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('80','Rurenge','24');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('81','Sake','24');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('82','Zaza','24');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('83','Murama','24');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('84','Remera','24');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('85','Gatunda','23');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('86','Kiyombe','23');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('87','Karama','23');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('88','Karangazi','23');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('89','Katabagemu','23');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('90','Matimba','23');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('91','Mimuli','23');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('92','Mukama','23');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('93','Musheli','23');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('94','Nyagatare','23');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('95','Rukomo','23');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('96','Rwempasha','23');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('97','Rwimiyaga','23');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('98','Tabagwe','23');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('99','Fumbwe','4');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('100','Gahengeri','4');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('101','Gishari','4');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('102','Karenge','4');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('103','Kigabiro','4');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('104','Muhazi','4');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('105','Munyaga','4');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('106','Munyiginya','4');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('107','Musha','4');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('108','Muyumbu','4');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('109','Mwulire','4');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('110','Nyakariro','4');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('111','Nzige','4');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('112','Rubona','4');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('113','Rugarama','1');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('114','Rugendabari','1');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('115','Ruhunde','1');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('116','Rusarabuge','1');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('117','Rwerere','1');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('118','Busenge','20');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('119','Coko','20');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('120','Bumbogo','18');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('121','Gatsata','18');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('122','Cyabingo','20');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('123','Jali','18');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('124','Gakenke','20');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('125','Gikomero','18');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('126','Gashenyi','20');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('127','Gisozi','18');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('128','Jabana','18');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('129','Mugunga','20');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('130','Kinyinya','18');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('131','Ndera','18');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('132','Nduba','18');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('133','Rusororo','18');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('134','jinja','20');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('135','Rutunga','18');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('136','Kamubuga','20');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('137','Kacyiru','18');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('138','Kimihurura','18');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('139','Karambo','20');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('140','Kimironko','18');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('141','Kivuruga','20');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('142','Remera','18');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('143','Mataba','20');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('144','Gahanga','15');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('145','Minazi','20');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('146','Gatenga','15');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('147','Gikondo','15');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('148','Muhondo','20');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('149','Kagarama','15');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('150','Muyongwe','20');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('151','Kanombe','15');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('152','Kicukiro','15');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('153','Muzo','20');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('154','Kigarama','15');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('155','Masaka','15');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('156','Nemba','20');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('157','Niboye','15');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('158','Nyarugunga','15');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('159','Ruli','20');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('160','Rusasa','20');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('161','Rushashi','20');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('162','Bukure','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('163','Bwisige','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('164','Byumba','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('165','Cyumba','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('166','Gitega','17');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('167','Giti','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('168','Kanyinya','17');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('169','Kigali','17');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('170','Kaniga','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('171','Kimisagara','17');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('172','Mageragere','17');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('173','Muhima','17');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('174','Nyakabanda','17');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('175','Nyamirambo','17');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('176','Rwezamenyo','17');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('177','Nyarugenge','17');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('178','Bwishyura','31');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('179','Gishari','31');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('180','Gishyita','31');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('181','Gisovu','31');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('182','Gitesi','31');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('183','Kareba','31');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('184','Murambi','31');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('185','Mubuga','31');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('186','Rubengera','31');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('187','Manyagiro','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('188','Miyove','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('189','Mutuntu','31');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('190','Rugabano','31');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('191','Rwankuba','31');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('192','Ruganda','31');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('193','Twumba','31');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('194','Bwira','32');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('195','Kageyo','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('196','Mukarange','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('197','Muko','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('198','Gatumba','32');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('199','Mutete','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('200','Nyamiyaga','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('201','Hindiro','32');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('202','Nyankenke','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('203','Rubaya','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('204','Rukomo','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('205','Kabaya','32');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('206','Kageyo','32');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('207','Rushaki','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('208','Kavumu','32');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('209','Matyazo','32');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('210','Muhanda','32');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('211','Muhororo','32');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('212','Ndaro','32');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('213','Ngororero','32');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('214','Nyange','32');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('215','Rutare','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('216','Sovu','32');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('217','Ruvune','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('218','Bigogwe','33');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('219','Jenda','33');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('220','Rwamiko','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('221','Jomba','33');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('222','Shangasha','37');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('223','Kabatwa','33');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('224','Karago','33');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('225','Kintobo','33');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('226','Mukamira','33');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('227','Muringa','33');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('228','Rambura','33');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('229','Rugera','33');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('230','Busogo','2');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('231','Rurembo','33');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('232','Cyuve','2');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('233','Shyira','33');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('234','gacaca','2');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('235','Gashaki','2');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('236','Gataraga','2');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('237','Bushekeri','34');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('238','Kimonyi','2');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('239','Bushenge','34');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('240','Kinigi','2');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('241','Cyato','34');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('242','Muhoza','2');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('243','Gihombo','34');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('244','Kagano','34');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('245','Muko','2');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('246','Kanjongo','34');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('247','Karambi','34');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('248','Musanze','2');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('249','Nkotsi','2');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('250','Nyange','2');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('251','Remera','2');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('252','Rwaza','2');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('253','Shingiri','2');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('254','Karengera','34');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('255','Kirimbi','34');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('256','Macuba','34');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('257','Base','21');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('258','Mahembe','34');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('259','Burega','21');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('260','Nyabitekeri','34');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('261','Bushoki','21');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('262','Rangiro','34');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('263','Buyoga','21');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('264','Kinzuzi','21');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('265','Ruharambuga','34');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('266','Shangi','34');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('267','Bugeshi','3');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('268','Busasamana','3');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('269','Cyanzarwe','3');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('270','Gisenyi','3');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('271','Kanama','3');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('272','Kanzenze','3');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('273','Mudende','3');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('274','Nyakiliba','3');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('275','Nyamyumba','3');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('276','Nyundo','3');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('277','Rubavu','3');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('278','Rugerero','3');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('279','Bugarama','35');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('280','Butare','35');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('281','Bweyeye','35');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('282','Gikundamvura','35');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('283','Gashonga','35');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('284','Giheke','35');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('285','Gihundwe','35');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('286','Gitambi','35');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('287','Kamembe','35');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('288','Muganza','35');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('289','Muganza','35');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('290','Mururu','35');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('291','Nkanka','35');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('292','Nkombo','35');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('293','Nkungu','35');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('294','Nyakabuye','35');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('295','Nyakarenzo','35');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('296','Nzahaha','35');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('297','Rwimbogo','35');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('298','Boneza','36');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('299','Gihango','36');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('300','Kigeyo','36');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('301','Kivumu','36');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('302','Manihira','36');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('303','Mukura','36');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('304','Murunda','36');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('305','Musasa','36');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('306','Mushonyi','36');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('307','Mushubati','36');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('308','Nyabirasi','36');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('309','Ruhango','36');
INSERT INTO `sector` (`id`,`sector`,`iddistrict`) VALUES
('310','Rusebeya','36');



-- -------------------------------------------
-- TABLE DATA service
-- -------------------------------------------
INSERT INTO `service` (`id`,`service`) VALUES
('1','Pediatrie');



-- -------------------------------------------
-- TABLE DATA traitement
-- -------------------------------------------
INSERT INTO `traitement` (`id`,`medical_act`,`idservice`,`type`,`transfer`) VALUES
('1','amaraso','1','1','1');
INSERT INTO `traitement` (`id`,`medical_act`,`idservice`,`type`,`transfer`) VALUES
('2','Kubaga','1','2','0');
INSERT INTO `traitement` (`id`,`medical_act`,`idservice`,`type`,`transfer`) VALUES
('3','Guhoma','1','1','0');



-- -------------------------------------------
-- TABLE DATA users
-- -------------------------------------------
INSERT INTO `users` (`id`,`firstname`,`middlename`,`lastname`,`username`,`password`,`salt`,`groupe`,`status`) VALUES
('2','ntabana','rudahunga','aloys','ntabana','6b602402a5091e8fe887cf8fb8ccc17a','53eb85f7988296.68021078','4','1');
INSERT INTO `users` (`id`,`firstname`,`middlename`,`lastname`,`username`,`password`,`salt`,`groupe`,`status`) VALUES
('3','denyse','denyse','denyse','denyse','dc01c614585f48d8b9da3e2603812152','53eb866b1acdb0.86646370','1','1');
INSERT INTO `users` (`id`,`firstname`,`middlename`,`lastname`,`username`,`password`,`salt`,`groupe`,`status`) VALUES
('5','Manager','A','Manager','Manager','02d48601427eb7716c12d6b5abcd4d9d','53eb8c386cf393.64550391','5','1');
INSERT INTO `users` (`id`,`firstname`,`middlename`,`lastname`,`username`,`password`,`salt`,`groupe`,`status`) VALUES
('6','cyusa','','cyusa','cyusa','ae4747c46a1d3c3d915208a3bd8cb1fc','5448f4139daa52.91562004','2','1');



-- -------------------------------------------
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
COMMIT;
-- -------------------------------------------
-- -------------------------------------------
-- END BACKUP
-- -------------------------------------------

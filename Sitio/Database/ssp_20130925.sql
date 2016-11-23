-- MySQL dump 10.13  Distrib 5.5.25a, for Win32 (x86)
--
-- Host: localhost    Database: ssp
-- ------------------------------------------------------
-- Server version	5.5.25a

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `ssp`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ssp` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `ssp`;

--
-- Table structure for table `alteracion`
--

DROP TABLE IF EXISTS `alteracion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alteracion` (
  `IdAlteracion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IdContrato` int(10) unsigned NOT NULL,
  `Fecha` date NOT NULL,
  `NormaLegalAprobacion` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `AdicionalDeductivo` int(1) unsigned NOT NULL,
  `Importe` decimal(14,2) unsigned NOT NULL,
  PRIMARY KEY (`IdAlteracion`),
  KEY `fk_alteracion_contrato` (`IdContrato`),
  CONSTRAINT `fk_alteracion_contrato` FOREIGN KEY (`IdContrato`) REFERENCES `contrato` (`IdContrato`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alteracion`
--

LOCK TABLES `alteracion` WRITE;
/*!40000 ALTER TABLE `alteracion` DISABLE KEYS */;
INSERT INTO `alteracion` VALUES (1,1,'2013-09-25','1234',0,25000.00);
/*!40000 ALTER TABLE `alteracion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificacion`
--

DROP TABLE IF EXISTS `certificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificacion` (
  `IdCertificacion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IdContrato` int(10) unsigned NOT NULL,
  `Periodo` varchar(6) COLLATE utf8_spanish_ci NOT NULL,
  `NroCertificado` int(3) unsigned NOT NULL,
  `PorcentajeAvance` decimal(8,5) unsigned NOT NULL,
  `MontoAvance` decimal(14,2) unsigned NOT NULL,
  `AnticipoFinanciero` decimal(14,2) unsigned DEFAULT NULL,
  `DescuentoAnticipo` decimal(14,2) unsigned DEFAULT NULL,
  `ImporteNeto` decimal(14,2) unsigned NOT NULL,
  `FechaVtoPago` date NOT NULL,
  `RetencionMulta` decimal(14,2) unsigned DEFAULT NULL,
  `OtrosConceptos` decimal(14,2) DEFAULT NULL,
  PRIMARY KEY (`IdCertificacion`),
  KEY `fk_certificacion_contrato` (`IdContrato`),
  CONSTRAINT `fk_certificacion_contrato` FOREIGN KEY (`IdContrato`) REFERENCES `contrato` (`IdContrato`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificacion`
--

LOCK TABLES `certificacion` WRITE;
/*!40000 ALTER TABLE `certificacion` DISABLE KEYS */;
INSERT INTO `certificacion` VALUES (10,1,'201301',1,0.00000,0.00,375592.66,NULL,375592.66,'2013-09-24',NULL,NULL),(11,1,'201302',2,1.32100,24807.89,NULL,4961.58,19846.31,'2013-09-30',NULL,NULL);
/*!40000 ALTER TABLE `certificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contrato`
--

DROP TABLE IF EXISTS `contrato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contrato` (
  `IdContrato` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IdObra` int(10) unsigned NOT NULL,
  `IdProveedor` int(10) unsigned NOT NULL,
  `Numero` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `Fecha` date NOT NULL,
  `Monto` decimal(14,2) unsigned NOT NULL,
  `FechaBaseMonto` date NOT NULL,
  `NormaLegalAutorizacion` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `NormaLegalAdjudicacion` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `PlazoEjecucion` int(5) unsigned NOT NULL,
  `FechaInicio` date NOT NULL,
  `FechaFinalizacion` date NOT NULL,
  PRIMARY KEY (`IdContrato`),
  KEY `fk_contrato_obra` (`IdObra`),
  KEY `fk_contrato_proveedor` (`IdProveedor`),
  CONSTRAINT `fk_contrato_obra` FOREIGN KEY (`IdObra`) REFERENCES `obra` (`IdObra`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_contrato_proveedor` FOREIGN KEY (`IdProveedor`) REFERENCES `proveedor` (`IdProveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contrato`
--

LOCK TABLES `contrato` WRITE;
/*!40000 ALTER TABLE `contrato` DISABLE KEYS */;
INSERT INTO `contrato` VALUES (1,2,1,'1234/11','2013-09-17',1877963.30,'2013-09-20','651/11','678/11',90,'2013-09-18','2013-11-19'),(2,3,4,'3621/11','2013-09-17',150000.00,'2013-09-20','632/11','321/11',60,'2013-09-17','2013-09-17'),(3,5,7,'6211/13','2013-09-17',575000.00,'2013-09-20','666/11','667/11',30,'2013-09-17','2013-10-23'),(4,6,6,'1652/13','2013-09-18',165215.48,'2013-06-01','325/13','326/13',60,'2013-09-20','2013-11-20');
/*!40000 ALTER TABLE `contrato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contratoplazo`
--

DROP TABLE IF EXISTS `contratoplazo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contratoplazo` (
  `IdContratoPlazo` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IdContrato` int(10) unsigned NOT NULL,
  `CantidadDias` int(5) unsigned NOT NULL,
  `NuevaFechaFinalizacion` date NOT NULL,
  `NormaLegalAprobacion` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`IdContratoPlazo`),
  KEY `fk_contratoplazo_contrato` (`IdContrato`),
  CONSTRAINT `fk_contratoplazo_contrato` FOREIGN KEY (`IdContrato`) REFERENCES `contrato` (`IdContrato`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contratoplazo`
--

LOCK TABLES `contratoplazo` WRITE;
/*!40000 ALTER TABLE `contratoplazo` DISABLE KEYS */;
INSERT INTO `contratoplazo` VALUES (1,1,75,'2013-12-18','3251/13');
/*!40000 ALTER TABLE `contratoplazo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estadoobra`
--

DROP TABLE IF EXISTS `estadoobra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estadoobra` (
  `IdEstadoObra` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`IdEstadoObra`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estadoobra`
--

LOCK TABLES `estadoobra` WRITE;
/*!40000 ALTER TABLE `estadoobra` DISABLE KEYS */;
INSERT INTO `estadoobra` VALUES (1,'EN PROYECTO'),(2,'A LICITAR'),(3,'EN TRÁMITE DE LICITACIÓN'),(4,'EN TRÁMITE DE ADJUDICACIÓN'),(5,'A INICIAR'),(6,'EN EJECUCIÓN'),(7,'PARALIZADA'),(8,'FINALIZADA'),(9,'EN TRÁMITE DE RECEPCIÓN PROVISORIA'),(10,'EN GARANTÍA'),(11,'EN TRÁMITE DE RECEPCIÓN DEFINITIVA'),(12,'CON RECEPCIÓN DEFINITIVA');
/*!40000 ALTER TABLE `estadoobra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fuentefinanciamiento`
--

DROP TABLE IF EXISTS `fuentefinanciamiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fuentefinanciamiento` (
  `IdFuenteFinanciamiento` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CodigoFufi` varchar(4) COLLATE utf8_spanish_ci NOT NULL,
  `Descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`IdFuenteFinanciamiento`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fuentefinanciamiento`
--

LOCK TABLES `fuentefinanciamiento` WRITE;
/*!40000 ALTER TABLE `fuentefinanciamiento` DISABLE KEYS */;
INSERT INTO `fuentefinanciamiento` VALUES (1,'1111','RENTAS GENERALES - T.G.P.'),(2,'3615','LEY 2615 - CTA. CANON RENEGOCIACION 85%'),(3,'4373','LEY 24073 - NBI GANANCIAS - OBRAS INFRAESTRUCTURA B. SOCIAL'),(4,'5454','CONVENIO SEC. DE RECURSOS HIDRICOS DE LA NACION - PROV. NQN'),(5,'5456','FONDO FEDERAL SOLIDARIO - DECRETO P.E.N. N° 206/09'),(6,'6120','TICAP - OBRAS FINANCIADAS'),(7,'6134','TICAFO'),(8,'5368','LOTERIA Y JUEGOS DE AZAR');
/*!40000 ALTER TABLE `fuentefinanciamiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `localidad`
--

DROP TABLE IF EXISTS `localidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `localidad` (
  `IdLocalidad` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `CodigoPostal` varchar(8) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`IdLocalidad`)
) ENGINE=InnoDB AUTO_INCREMENT=425 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `localidad`
--

LOCK TABLES `localidad` WRITE;
/*!40000 ALTER TABLE `localidad` DISABLE KEYS */;
INSERT INTO `localidad` VALUES (1,'ACHICO','8315'),(2,'AGRIO BALSA','8351'),(3,'AGUADA CHACAY CO','8353'),(4,'AGUADA FLORENCIO','8340'),(5,'AGUADA SAN ROQUE','8305'),(6,'AGUAS DE LAS MULAS','8349'),(7,'ALIANZA','8373'),(8,'ALICURA','8403'),(9,'ALUMINE','8345'),(10,'ANDACOLLO','8353'),(11,'AÑELO','8305'),(12,'ANQUINCO','8353'),(13,'ARROYITO','8313'),(14,'ARROYITO CHALLACO','8313'),(15,'ARROYO BLANCO','8353'),(16,'ARROYO CAHUNCO','8347'),(17,'ARROYO QUILLEN','8341'),(18,'ARROYO RANQUILCO','8347'),(19,'ATREUCO','8371'),(20,'AUCA MAHUIDA','8305'),(21,'AUCA PAN','8373'),(22,'BAJADA COLORADA','8315'),(23,'BAJADA DE LOS MOLLES','8340'),(24,'BAJADA DEL AGRIO','8351'),(25,'BAJADA DEL MARUCHO','8340'),(26,'BALNEARIO DEL RIO AGRIO','8351'),(27,'BALSA DEL RIO AGRIO','8351'),(28,'BALSA SENILLOSA','8316'),(29,'BARDA ANGUIL','8340'),(30,'BARDA NEGRA','8340'),(31,'BARRANCAS','8353'),(32,'BATRE LAUQUEN','8353'),(33,'BELLA VISTA','8353'),(34,'BUENA ESPERANZA','8360'),(35,'BUTA CO','8353'),(36,'BUTA MALLIN','8353'),(37,'BUTA RANQUIL','8353'),(38,'BUTALON','8353'),(39,'CAEPE MALAL','8353'),(40,'CAICHIHUE','8340'),(41,'CAJON DE ALMAZA','8349'),(42,'CAJON DE LOS PATOS','8349'),(43,'CAJON DE MANZANO','8349'),(44,'CAJON DEL TORO','8347'),(45,'CAJON GRANDE','8353'),(46,'CALEUFU','8373'),(47,'CALIHUE','8347'),(48,'CAMALEONES','8353'),(49,'CAMINERA','8370'),(50,'CAMINERA TRAFUL','8403'),(51,'CAMPAMENTO SOL','8319'),(52,'CAÑADA SECA','8353'),(53,'CAÑADON DE LOS INDIOS','8375'),(54,'CAÑADON DEL INDIO','8375'),(55,'CANCHA HUINGANCO','8353'),(56,'CARRAN CURA','8315'),(57,'CARRERI','8347'),(58,'CARRI LAUQUEN','8315'),(59,'CARRI LIL','8345'),(60,'CASA DE PIEDRA','8353'),(61,'CATAN LIL','8341'),(62,'CAVIAHUE','8349'),(63,'CAYANTA','8353'),(64,'CENTENARIO','8309'),(65,'CERRO COLORADO','8347'),(66,'CERRO DE LA GRASA','8347'),(67,'CERRO DE LA PARVA','8349'),(68,'CERRO DE LOS PINOS','8373'),(69,'CERRO DEL LEON','8313'),(70,'CERRO GATO','8375'),(71,'CERRO NEGRO CHAPUA','8353'),(72,'CERRO NEGRO TRICAO','8353'),(73,'CHACABUCO','8373'),(74,'CHACAY','8347'),(75,'CHACAY CO','8353'),(76,'CHACAY MELEHUE','8353'),(77,'CHACAYCO','8340'),(78,'CHACOYAL','8373'),(79,'CHALLACO','8318'),(80,'CHANQUIL QUILLA','8345'),(81,'CHAPELCO','8370'),(82,'CHAPUA','8353'),(83,'CHAPUA ABAJO','8353'),(84,'CHARAHUILLA','8341'),(85,'CHENQUECURA','8349'),(86,'CHICHIGUAY','8373'),(87,'CHIMEHUIN','8373'),(88,'CHINA MUERTA','8316'),(89,'CHINCHINA','8373'),(90,'CHIUQUILLIHUIN','8371'),(91,'CHOCHOY MALLIN','8349'),(92,'CHORRIACA','8351'),(93,'CHOS MALAL','8353'),(94,'COCHICO','8347'),(95,'CODIHUE','8347'),(96,'COIHUECO','8351'),(97,'COLI MALAL','8351'),(98,'COLIPILI','8349'),(99,'COLLON CURA','8375'),(100,'COLLUN CO','8371'),(101,'CONFLUENCIA DEL AGUIJON','8351'),(102,'COPAHUE','8349'),(103,'CORRAL DE PIEDRA','8347'),(104,'CORRENTOSO','8407'),(105,'COSTA DEL ARROYO SALADO','8351'),(106,'COSTA LIMAY','8315'),(107,'COVUNCO','8340'),(108,'COVUNCO ABAJO','8351'),(109,'COVUNCO ARRIBA','8340'),(110,'COVUNCO CENTRO','8351'),(111,'COYUCO COCHICO','8353'),(112,'CUCHILLO CURA','8347'),(113,'CULLIN MANZANO','8401'),(114,'CURA CO','8353'),(115,'CURU  LEUVU','8353'),(116,'CUTRAL CO','8322'),(117,'EL ALAMITO','8353'),(118,'EL ARBOLITO','8407'),(119,'EL ATRAVESADO','8347'),(120,'EL BOSQUE','8349'),(121,'EL CERRITO','8370'),(122,'EL CHINGUE','8353'),(123,'EL CHOLAR','8353'),(124,'EL CURILEO','8353'),(125,'EL DORMIDO','8341'),(126,'EL DURAZNO','8353'),(127,'EL ESCORIAL','8347'),(128,'EL GATO','8341'),(129,'EL HUECU','8349'),(130,'EL MACHETE','8407'),(131,'EL MANZANO','8403'),(132,'EL OASIS','8370'),(133,'EL OVERO','8340'),(134,'EL PALAO','8347'),(135,'EL PERALITO','8351'),(136,'EL PINO ANDINO','8349'),(137,'EL PORTON','8353'),(138,'EL PORVENIR','8370'),(139,'EL SALADO','8351'),(140,'EL SALITRAL','8375'),(141,'EL SAUCE','8313'),(142,'EL TROMEN','8353'),(143,'EL TROPEZON','8340'),(144,'ESPINAZO DEL ZORRO','8341'),(145,'ESTANCIA LA PRIMAVERA','8403'),(146,'ESTANCIA NEWBERY','8401'),(147,'ESTANCIA TEQUEL MALAL','8401'),(148,'FILMATUE','8353'),(149,'FILO HUA HUM','8370'),(150,'FLORES','8353'),(151,'FORTIN 1 DE MAYO','8341'),(152,'FORTIN GUAÑACOS','8353'),(153,'FRANHUCURA','8351'),(154,'GENTE GRANDE','8379'),(155,'GOÑI CO','8340'),(156,'GUAÑACOS','8353'),(157,'HAICHOL','8347'),(158,'HARAS PATRIA','8345'),(159,'HAYCU','8349'),(160,'HUA HUM','8370'),(161,'HUALCUPEN','8349'),(162,'HUANTRAICO','8353'),(163,'HUARACO','8353'),(164,'HUARENCHENQUE','8349'),(165,'HUECHAHUE','8375'),(166,'HUECHULAFQUEN','8371'),(167,'HUILLILON','8347'),(168,'HUINCA LU','8403'),(169,'HUINGANCO','8353'),(170,'HUITRIN','8353'),(171,'HUMIGAMIO','8353'),(172,'HUNCAL','8351'),(173,'INVERNADA VIEJA','8353'),(174,'ISLA VICTORIA','8400'),(175,'JECANASCO','8353'),(176,'JUARANCO','8353'),(177,'JUNIN DE LOS ANDES','8371'),(178,'KILCA CASA','8345'),(179,'LA ANGOSTURA DE ICALMA','8345'),(180,'LA ARAUCARIA','8401'),(181,'LA ARBOLEDA','8341'),(182,'LA ARGENTINA','8349'),(183,'LA ATALAYA','8371'),(184,'LA BUITRERA','8347'),(185,'LA CIENAGA','8353'),(186,'LA CIENEGUITA','8353'),(187,'LA ESTACADA','8401'),(188,'LA FORTUNA','8370'),(189,'LA FRIA','8340'),(190,'LA ISABEL','8340'),(191,'LA LIPELA','8401'),(192,'LA NEGRA','8375'),(193,'LA OFELIA','8341'),(194,'LA PATAGONIA','8340'),(195,'LA PATRIA','8340'),(196,'LA PICAZA','8340'),(197,'LA PINTADA','8315'),(198,'LA POCHOLA','8340'),(199,'LA PORTEÑA','8347'),(200,'LA PRIMAVERA','8353'),(201,'LA RINCONADA','8375'),(202,'LA SALADA','8353'),(203,'LA SUSANA','8340'),(204,'LA TERESA','8315'),(205,'LA TERESA','8340'),(206,'LA UNION','8371'),(207,'LA VERDAD','8347'),(208,'LAGO LOLOG','8370'),(209,'LAGO ÑORQUINCO','8345'),(210,'LAGO PULMARI','8345'),(211,'LAGOTERA','8345'),(212,'LAGUNA BLANCA','8340'),(213,'LAGUNA MIRANDA','8340'),(214,'LAJA','8341'),(215,'LAPA','8341'),(216,'LAPACHAL','8341'),(217,'LAS ABEJAS','8353'),(218,'LAS BANDURRIAS','8370'),(219,'LAS BARDITAS','8340'),(220,'LAS CHACRAS','8353'),(221,'LAS COLORADAS','8341'),(222,'LAS CORTADERAS','8340'),(223,'LAS CORTADERAS','8353'),(224,'LAS LAGUNAS','8353'),(225,'LAS LAJAS','8347'),(226,'LAS LAJITAS','8347'),(227,'LAS MERCEDES','8373'),(228,'LAS OVEJAS','8353'),(229,'LAS PERLAS','8300'),(230,'LAS SALADAS','8353'),(231,'LAS TOSCAS','8347'),(232,'LAS TRES LAGUNAS','8347'),(233,'LASCAR','8370'),(234,'LEUTO CABALLO','8353'),(235,'LILEO','8353'),(236,'LIMAY CENTRO','8313'),(237,'LITRAN','8345'),(238,'LIU CULLIN','8347'),(239,'LLAMUCO','8347'),(240,'LOLOG','8370'),(241,'LOMA DE LA LATA','8300'),(242,'LONCO LUAN','8345'),(243,'LONCO MULA','8345'),(244,'LONCOPUE','8349'),(245,'LOS BOLILLOS','8353'),(246,'LOS CARRIZOS','8353'),(247,'LOS CATUTOS','8340'),(248,'LOS CHACALES','8353'),(249,'LOS CHIHUIDOS','8305'),(250,'LOS CHINITOS','8305'),(251,'LOS CISNES','8353'),(252,'LOS ENTIERROS','8353'),(253,'LOS GALPONES','8347'),(254,'LOS MENUCOS','8353'),(255,'LOS MICHES','8353'),(256,'LOS MOLLES','8353'),(257,'LOS MUCHACHOS','8340'),(258,'LOS RODILLOS','8341'),(259,'LOS SAUCES','8313'),(260,'LOS TRES CHORROS','8353'),(261,'LUBECA','8371'),(262,'LUICOCO','8353'),(263,'LUIN COCO','8353'),(264,'MACHICO','8353'),(265,'MALALCO','8341'),(266,'MALLIN BLANCO','8347'),(267,'MALLIN CHILENO','8347'),(268,'MALLIN DE LA CUEVA','8347'),(269,'MALLIN DE LAS YEGUAS','8375'),(270,'MALLIN DE LOS CABALLOS','8340'),(271,'MALLIN DE MENA','8347'),(272,'MALLIN DEL RUBIO','8347'),(273,'MALLIN DEL TORO','8349'),(274,'MALLIN QUEMADO','8347'),(275,'MAMUL MALAL','8371'),(276,'MANZANO AMARGO','8353'),(277,'MARI MENUCO','8300'),(278,'MARIANO MORENO','8351'),(279,'MAYAN MAHUIDA','8353'),(280,'MEDIA LUNA','8341'),(281,'MILLA','8353'),(282,'MINA CARRASCOSA','8353'),(283,'MINA LILEO','8353'),(284,'MOQUEHUE','8345'),(285,'MULICHINCO','8349'),(286,'NAHUEL HUAPI','8401'),(287,'NAHUEL MAPE','8371'),(288,'NAHUEVE','8353'),(289,'NALAY CULLIN','8349'),(290,'NAU NAUCO','8351'),(291,'NERECO NORTE','8353'),(292,'NEUQUEN','8300'),(293,'NIRECO','8353'),(294,'ÑIRECO SUD','8340'),(295,'NOGUEIRA','8315'),(296,'ÑORQUIN','8349'),(297,'OCTAVIO PICO','8319'),(298,'OJO DE AGUA','8340'),(299,'OJO DE AGUA','8341'),(300,'PALAU','8353'),(301,'PALITUE','8371'),(302,'PAMPA COLLON CURA','8375'),(303,'PAMPA DE LONCO LUAN','8345'),(304,'PAMPA DE TRIL','8353'),(305,'PAMPA DEL MALLEO','8373'),(306,'PAMPA DEL SALADO','8351'),(307,'PAMPA FERREIRA','8353'),(308,'PANTANITOS','8313'),(309,'PASO AGUERRE','8313'),(310,'PASO ANCHO','8347'),(311,'PASO BARDA','8353'),(312,'PASO CATA TUN','8341'),(313,'PASO COIHUE','8401'),(314,'PASO DE LOS INDIOS','8318'),(315,'PASO DE SAN IGNACIO','8375'),(316,'PEÑA COLORADA','8373'),(317,'PENINSULA HUEMUL','8400'),(318,'PICHAIHUE','8351'),(319,'PICHE PONON','8347'),(320,'PICHI NEUQUEN','8351'),(321,'PICUN LEUFU','8313'),(322,'PIEDRA DEL AGUILA','8315'),(323,'PIEDRA MALA','8371'),(324,'PIEDRA PINTADA','8315'),(325,'PIEDRAS BAYAS','8347'),(326,'PILMATUE','8351'),(327,'PILO LIL','8373'),(328,'PINO HACHADO','8347'),(329,'PINO SOLO','8347'),(330,'PLANICIE BANDERITA','8301'),(331,'PLAZA HUINCUL','8318'),(332,'PLOTTIER','8316'),(333,'PORTADA COVUNCO','8340'),(334,'PORTEZUELO GRANDE','8300'),(335,'POZO HUALICHES','8347'),(336,'PRIMEROS PINOS','8347'),(337,'PUEBLO NUEVO','8322'),(338,'PUENTE PICUN LEUFU','8340'),(339,'PUERTO ANCHORENA','8400'),(340,'PUERTO MANZANO','8407'),(341,'PUESTO HERNANDEZ  BATERIAS','8319'),(342,'PUNTA DE SIERRA','8305'),(343,'QUEBRADA HONDA','8347'),(344,'QUEMPU LEUFU','8353'),(345,'QUEMQUEMTREU','8375'),(346,'QUENTRENQUEN','8373'),(347,'QUILA QUEHUE','8371'),(348,'QUILA QUINA','8370'),(349,'QUILCA','8345'),(350,'QUILI MALAL','8351'),(351,'QUILLEN','8341'),(352,'QUILQUIHUE','8371'),(353,'QUININELIU','8341'),(354,'QUINQUIMITREO','8373'),(355,'QUINTUCO','8351'),(356,'QUITA QUINA','8370'),(357,'RAHUE','8341'),(358,'RAMICHAL','8347'),(359,'RAMON M CASTRO','8340'),(360,'RANQUELES','8349'),(361,'RANQUIL VEGA','8353'),(362,'RANQUILCO','8349'),(363,'RANQUILON','8349'),(364,'REÑILEO','8353'),(365,'RICHOIQUE','8349'),(366,'RINCON CHICO','8401'),(367,'RINCON DE EMILIO','8300'),(368,'RINCON DE LOS SAUCES','8319'),(369,'RINCON GRANDE','8401'),(370,'RIO AGRIO','8351'),(371,'RIO BARRANCAS','8353'),(372,'RUCA CHOROY ARRIBA','8345'),(373,'SAINUCO','8345'),(374,'SALQUICO','8347'),(375,'SAN BERNARDO','8315'),(376,'SAN DEMETRIO','8347'),(377,'SAN EDUARDO','8353'),(378,'SAN IGNACIO','8375'),(379,'SAN JUAN JUNIN DE LOS ANDES','8371'),(380,'SAN JUAN RAHUE','8341'),(381,'SAN MARTIN DE LOS ANDES','8370'),(382,'SAN PATRICIO DEL CHAÑAR','8305'),(383,'SAÑICO','8315'),(384,'SANTA ISABEL','8315'),(385,'SANTA ISABEL','8349'),(386,'SANTA ISABEL','8375'),(387,'SANTA MARIA','8401'),(388,'SANTO DOMINGO','8340'),(389,'SANTO TOMAS','8315'),(390,'SAUZAL BONITO','8319'),(391,'SENILLOSA','8316'),(392,'TAQUI NILEU','8340'),(393,'TAQUIMILAN','8351'),(394,'TAQUIMILLAN ABAJO','8353'),(395,'TIERRAS BLANCAS','8353'),(396,'TIHUE','8353'),(397,'TIPILIUKE','8373'),(398,'TRAHUNCURA','8351'),(399,'TRALAITUE','8349'),(400,'TRATAYEN','8305'),(401,'TRES CHORROS','8353'),(402,'TRES PICOS','8371'),(403,'TRES PIEDRAS','8340'),(404,'TRICAO MALAL','8353'),(405,'TRILI','8353'),(406,'TROMEN','8371'),(407,'TROMPUL','8370'),(408,'VACA MUERTA','8351'),(409,'VARVARCO','8353'),(410,'VILLA CURI LEUVU','8353'),(411,'VILLA EL CHOCON','8311'),(412,'VILLA LA ANGOSTURA','8407'),(413,'VILLA LAGO MELIQUINA','8370'),(414,'VILLA PEHUENIA','8345'),(415,'VILLA RAUR','8370'),(416,'VILLA RINCON CHICO','8315'),(417,'VILLA TRAFUL','8403'),(418,'VILU MALLIN','8349'),(419,'VISTA ALEGRE NORTE','8309'),(420,'VISTA ALEGRE SUR','8309'),(421,'ZAINA YEGUA','8315'),(422,'ZAPALA','8340'),(423,'ZINGONE Y CIA M','8375'),(424,'ZULEMITA','8375');
/*!40000 ALTER TABLE `localidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `IdMenu` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IdMenuContenedor` int(10) unsigned DEFAULT NULL,
  `IdPagina` int(10) unsigned DEFAULT NULL,
  `Nombre` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `Orden` smallint(5) unsigned DEFAULT NULL,
  `Target` varchar(20) COLLATE utf8_spanish_ci NOT NULL DEFAULT '_self',
  `Activo` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`IdMenu`),
  KEY `fk_menu_pagina` (`IdPagina`),
  KEY `fk_menu_menu` (`IdMenuContenedor`),
  CONSTRAINT `fk_menu_menu` FOREIGN KEY (`IdMenuContenedor`) REFERENCES `menu` (`IdMenu`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_pagina` FOREIGN KEY (`IdPagina`) REFERENCES `pagina` (`IdPagina`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,NULL,NULL,'Inicio',1,'_self',1),(2,1,3,'Página Inicial',1,'_self',1),(3,1,4,'Cambio Contraseña',2,'_self',1),(6,1,2,'Salir',3,'_self',1),(7,NULL,NULL,'Obras',3,'_self',1),(8,NULL,NULL,'Tesorería',4,'_self',1),(9,8,12,'Pagos',1,'_self',1),(11,7,5,'Registro de Obras',1,'_self',1),(12,7,11,'Certificación por Periodo',2,'_self',1),(13,NULL,NULL,'Administración',2,'_self',1),(14,13,14,'Usuarios',NULL,'_self',1),(15,13,16,'Organismos',NULL,'_self',1),(16,13,18,'Fuentes de Financiamiento',NULL,'_self',1),(17,13,20,'Tipos de Obra',NULL,'_self',1),(18,13,22,'Estados de Obra',NULL,'_self',1);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obra`
--

DROP TABLE IF EXISTS `obra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obra` (
  `IdObra` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Codigo` varchar(4) COLLATE utf8_spanish_ci NOT NULL,
  `Denominacion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `IdOrganismo` int(10) unsigned NOT NULL,
  `CreditoPresupuestarioAprobado` decimal(14,2) unsigned DEFAULT NULL,
  `Expediente` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `MemoriaDescriptiva` text COLLATE utf8_spanish_ci,
  `CantidadBeneficiarios` int(10) unsigned DEFAULT NULL,
  `PresupuestoOficial` decimal(14,2) DEFAULT NULL,
  `FechaPresupuestoOficial` date DEFAULT NULL,
  `IdTipoObra` int(10) unsigned DEFAULT NULL,
  `Latitud` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Longitud` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `IdEstadoObra` int(10) unsigned NOT NULL,
  PRIMARY KEY (`IdObra`),
  KEY `fk_obra_organismo` (`IdOrganismo`),
  KEY `fk_obra_tipoobra` (`IdTipoObra`),
  KEY `fk_obra_estadoobra` (`IdEstadoObra`),
  CONSTRAINT `fk_obra_organismo` FOREIGN KEY (`IdOrganismo`) REFERENCES `organismo` (`IdOrganismo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_obra_tipoobra` FOREIGN KEY (`IdTipoObra`) REFERENCES `tipoobra` (`IdTipoObra`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_obra_estadoobra` FOREIGN KEY (`IdEstadoObra`) REFERENCES `estadoobra` (`IdEstadoObra`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obra`
--

LOCK TABLES `obra` WRITE;
/*!40000 ALTER TABLE `obra` DISABLE KEYS */;
INSERT INTO `obra` VALUES (2,'0001','READECUACION TOMA DE AGUA POTABLE',1,2001391.00,'4865-13054/11','',5312,1886811.80,'2013-09-01',NULL,'','',6),(3,'0002','AMPLIACION RED DE AGUA',1,151521.00,'4865-13051/11','',1342,150000.00,'2013-09-17',NULL,'','',6),(5,'0001','RED ENERGIA CENTRO COMUNITARIO',2,600000.00,'5214-32100/13',NULL,500,570000.00,'2013-09-17',NULL,NULL,NULL,1),(6,'0003','SISTEMA DE IMPULSION TANQUES BARDA',1,1500000.00,'4742-12345/2013','ACA VA EL TEXTO DE LA MEMORIA DESCRIPTIVA',7500,1200000.00,'2013-09-20',NULL,'-32.41214','-21.52141',6);
/*!40000 ALTER TABLE `obra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obraestado`
--

DROP TABLE IF EXISTS `obraestado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obraestado` (
  `IdObraEstado` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IdObra` int(10) unsigned NOT NULL,
  `IdEstadoObra` int(10) unsigned NOT NULL,
  `Fecha` date NOT NULL,
  PRIMARY KEY (`IdObraEstado`),
  KEY `fk_obraestado_obra` (`IdObra`),
  KEY `fk_obraestado_estadoobra` (`IdEstadoObra`),
  CONSTRAINT `fk_obraestado_obra` FOREIGN KEY (`IdObra`) REFERENCES `obra` (`IdObra`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_obraestado_estadoobra` FOREIGN KEY (`IdEstadoObra`) REFERENCES `estadoobra` (`IdEstadoObra`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obraestado`
--

LOCK TABLES `obraestado` WRITE;
/*!40000 ALTER TABLE `obraestado` DISABLE KEYS */;
INSERT INTO `obraestado` VALUES (1,6,5,'2013-09-20'),(2,2,1,'2013-09-20'),(3,3,1,'2013-09-20'),(4,2,6,'2013-09-20'),(5,3,6,'2013-09-20'),(6,6,7,'2013-09-20'),(7,6,6,'2013-09-20');
/*!40000 ALTER TABLE `obraestado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obrafuentefinanciamiento`
--

DROP TABLE IF EXISTS `obrafuentefinanciamiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obrafuentefinanciamiento` (
  `IdObra` int(10) unsigned NOT NULL,
  `IdFuenteFinanciamiento` int(10) unsigned NOT NULL,
  PRIMARY KEY (`IdObra`,`IdFuenteFinanciamiento`),
  KEY `fk_obrafufi_fufi` (`IdFuenteFinanciamiento`),
  CONSTRAINT `fk_obrafufi_obra` FOREIGN KEY (`IdObra`) REFERENCES `obra` (`IdObra`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_obrafufi_fufi` FOREIGN KEY (`IdFuenteFinanciamiento`) REFERENCES `fuentefinanciamiento` (`IdFuenteFinanciamiento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obrafuentefinanciamiento`
--

LOCK TABLES `obrafuentefinanciamiento` WRITE;
/*!40000 ALTER TABLE `obrafuentefinanciamiento` DISABLE KEYS */;
INSERT INTO `obrafuentefinanciamiento` VALUES (2,1),(6,1),(6,2),(5,3),(6,3),(2,4),(3,5),(2,7),(5,8);
/*!40000 ALTER TABLE `obrafuentefinanciamiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obralocalidad`
--

DROP TABLE IF EXISTS `obralocalidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obralocalidad` (
  `IdObra` int(10) unsigned NOT NULL,
  `IdLocalidad` int(10) unsigned NOT NULL,
  PRIMARY KEY (`IdObra`,`IdLocalidad`),
  KEY `fk_obralocalidad_localidad` (`IdLocalidad`),
  CONSTRAINT `fk_obralocalidad_obra` FOREIGN KEY (`IdObra`) REFERENCES `obra` (`IdObra`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_obralocalidad_localidad` FOREIGN KEY (`IdLocalidad`) REFERENCES `localidad` (`IdLocalidad`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obralocalidad`
--

LOCK TABLES `obralocalidad` WRITE;
/*!40000 ALTER TABLE `obralocalidad` DISABLE KEYS */;
INSERT INTO `obralocalidad` VALUES (6,1),(6,5),(5,114),(3,194),(2,292),(5,292),(6,292);
/*!40000 ALTER TABLE `obralocalidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organismo`
--

DROP TABLE IF EXISTS `organismo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organismo` (
  `IdOrganismo` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `PrefijoCodigo` varchar(2) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`IdOrganismo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organismo`
--

LOCK TABLES `organismo` WRITE;
/*!40000 ALTER TABLE `organismo` DISABLE KEYS */;
INSERT INTO `organismo` VALUES (1,'E.P.A.S.','01'),(2,'E.P.E.N.','02'),(3,'VIALIDAD','03'),(4,'RECURSOS HIDRICOS','04');
/*!40000 ALTER TABLE `organismo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagina`
--

DROP TABLE IF EXISTS `pagina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagina` (
  `IdPagina` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Pagina` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `Descripcion` varchar(400) COLLATE utf8_spanish_ci NOT NULL,
  `Activa` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`IdPagina`),
  UNIQUE KEY `uq_pagina_pagina` (`Pagina`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagina`
--

LOCK TABLES `pagina` WRITE;
/*!40000 ALTER TABLE `pagina` DISABLE KEYS */;
INSERT INTO `pagina` VALUES (1,'Login','Login',1),(2,'Logout','Logout',1),(3,'Home','Página Principal',1),(4,'CambioPassword','Cambio de Contraseña',1),(5,'Obra.Home','Obras',1),(6,'Obra.Update','Obras ABM',1),(7,'Obra.Contrato.Home','Contratos de Obra',1),(8,'Obra.Contrato.Update','Contratos de Obra ABM',1),(9,'Obra.Contrato.Certificacion.Home','Certificaciones',1),(10,'Obra.Contrato.Certificacion.Update','Certificaciones ABM',1),(11,'Obra.Contrato.CertificacionPeriodo','Certificación por Periodo',1),(12,'Tesoreria.Pago.Home','Pagos',1),(13,'Tesoreria.Pago.Update','Pagos ABM',1),(14,'Admin.Usuario.Home','Usuarios',1),(15,'Admin.Usuario.Update','Usuarios ABM',1),(16,'Admin.Organismo.Home','Organismos',1),(17,'Admin.Organismo.Update','Organismos ABM',1),(18,'Admin.FuenteFinanciamiento.Home','Fuentes de Financiamiento',1),(19,'Admin.FuenteFinanciamiento.Update','Fuentes de Financiamiento ABM',1),(20,'Admin.TipoObra.Home','Tipos de Obra',1),(21,'Admin.TipoObra.Update','Tipos de Obra ABM',1),(22,'Admin.EstadoObra.Home','Estados de Obra',1),(23,'Admin.EstadoObra.Update','Estados de Obra ABM',1),(24,'Tesoreria.Pago.PagosByCertificado','Detalle de Pagos por Certificado',1),(25,'Obra.Contrato.Alteracion.Update','Alteraciones de Contrato ABM',1),(26,'Obra.Contrato.ContratoPlazo.Update','Plazos de Contrato ABM',1),(27,'Obra.Contrato.RecepcionContrato.Update','Recepciones de Contrato ABM',1);
/*!40000 ALTER TABLE `pagina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pago`
--

DROP TABLE IF EXISTS `pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pago` (
  `IdPago` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IdProveedor` int(10) unsigned NOT NULL,
  `Fecha` date NOT NULL,
  `OrdenPago` varchar(6) COLLATE utf8_spanish_ci NOT NULL,
  `ImporteBruto` decimal(14,2) unsigned NOT NULL,
  `Retenciones` decimal(14,2) unsigned NOT NULL,
  `ImporteNeto` decimal(14,2) unsigned NOT NULL,
  `IdOrganismo` int(10) unsigned NOT NULL,
  PRIMARY KEY (`IdPago`),
  KEY `fk_pago_proveedor` (`IdProveedor`),
  KEY `fk_pago_organismo` (`IdOrganismo`),
  CONSTRAINT `fk_pago_proveedor` FOREIGN KEY (`IdProveedor`) REFERENCES `proveedor` (`IdProveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pago_organismo` FOREIGN KEY (`IdOrganismo`) REFERENCES `organismo` (`IdOrganismo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pago`
--

LOCK TABLES `pago` WRITE;
/*!40000 ALTER TABLE `pago` DISABLE KEYS */;
INSERT INTO `pago` VALUES (6,1,'2013-09-24','012451',390592.66,1500.00,389092.66,1);
/*!40000 ALTER TABLE `pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagocertificacion`
--

DROP TABLE IF EXISTS `pagocertificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagocertificacion` (
  `IdPagoCertificacion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IdPago` int(10) unsigned NOT NULL,
  `IdCertificacion` int(10) unsigned NOT NULL,
  `Importe` decimal(14,2) unsigned NOT NULL,
  PRIMARY KEY (`IdPagoCertificacion`),
  KEY `fk_pagocertificacion_pago` (`IdPago`),
  KEY `fk_pagocertificacion_certificacion` (`IdCertificacion`),
  CONSTRAINT `fk_pagocertificacion_pago` FOREIGN KEY (`IdPago`) REFERENCES `pago` (`IdPago`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagocertificacion_certificacion` FOREIGN KEY (`IdCertificacion`) REFERENCES `certificacion` (`IdCertificacion`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagocertificacion`
--

LOCK TABLES `pagocertificacion` WRITE;
/*!40000 ALTER TABLE `pagocertificacion` DISABLE KEYS */;
INSERT INTO `pagocertificacion` VALUES (9,6,10,375592.66),(10,6,11,15000.00);
/*!40000 ALTER TABLE `pagocertificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedor` (
  `IdProveedor` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Cuit` varchar(13) COLLATE utf8_spanish_ci NOT NULL,
  `RazonSocial` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `Domicilio` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `IdLocalidad` int(10) unsigned DEFAULT NULL,
  `RepresentanteTecnico` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Telefono` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Email` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`IdProveedor`),
  KEY `fk_proveedor_localidad` (`IdLocalidad`),
  CONSTRAINT `fk_proveedor_localidad` FOREIGN KEY (`IdLocalidad`) REFERENCES `localidad` (`IdLocalidad`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,'33-70872840-9','BASAP S.A.',NULL,NULL,NULL,NULL,NULL),(2,'30-70268173-8','ZAHIDAS S.A.',NULL,NULL,NULL,NULL,NULL),(3,'30-70942913-9','LINEU S.A.',NULL,NULL,NULL,NULL,NULL),(4,'30-70863817-6','ABI S.R.L.',NULL,NULL,NULL,NULL,NULL),(5,'30-67273254-5','CODAM S.A.',NULL,NULL,NULL,NULL,NULL),(6,'30-70922270-4','OMEGA MLP S.R.L.',NULL,NULL,NULL,NULL,NULL),(7,'30-71123456-1','UTE EJEMPLO',NULL,NULL,NULL,NULL,NULL),(8,'30-12345678-3','UTE EJEMPLO 2',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recepcioncontrato`
--

DROP TABLE IF EXISTS `recepcioncontrato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recepcioncontrato` (
  `IdRecepcionContrato` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IdContrato` int(10) unsigned NOT NULL,
  `ProvisoriaDefinitiva` int(1) unsigned NOT NULL,
  `ParcialTotal` int(1) unsigned NOT NULL,
  `Fecha` date NOT NULL,
  `NormaLegalAprobacion` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`IdRecepcionContrato`),
  KEY `fk_recepcioncontrato_contrato` (`IdContrato`),
  CONSTRAINT `fk_recepcioncontrato_contrato` FOREIGN KEY (`IdContrato`) REFERENCES `contrato` (`IdContrato`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recepcioncontrato`
--

LOCK TABLES `recepcioncontrato` WRITE;
/*!40000 ALTER TABLE `recepcioncontrato` DISABLE KEYS */;
INSERT INTO `recepcioncontrato` VALUES (1,1,0,1,'2013-09-28','9652/13');
/*!40000 ALTER TABLE `recepcioncontrato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rol` (
  `IdRol` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`IdRol`),
  UNIQUE KEY `uq_rol_nombre` (`Nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'ADMINISTRADOR GENERAL'),(2,'ADMINISTRADOR ORGANISMO'),(3,'OBRAS'),(4,'TESORERIA');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rolpagina`
--

DROP TABLE IF EXISTS `rolpagina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rolpagina` (
  `IdRol` int(10) unsigned NOT NULL,
  `IdPagina` int(10) unsigned NOT NULL,
  PRIMARY KEY (`IdRol`,`IdPagina`),
  KEY `fk_rolpagina_pagina` (`IdPagina`),
  CONSTRAINT `fk_rolpagina_pagina` FOREIGN KEY (`IdPagina`) REFERENCES `pagina` (`IdPagina`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_rolpagina_rol` FOREIGN KEY (`IdRol`) REFERENCES `rol` (`IdRol`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rolpagina`
--

LOCK TABLES `rolpagina` WRITE;
/*!40000 ALTER TABLE `rolpagina` DISABLE KEYS */;
INSERT INTO `rolpagina` VALUES (1,1),(2,1),(3,1),(4,1),(1,2),(2,2),(3,2),(4,2),(1,3),(2,3),(3,3),(4,3),(1,4),(2,4),(3,4),(4,4),(2,5),(3,5),(2,6),(3,6),(2,7),(3,7),(2,8),(3,8),(2,9),(3,9),(2,10),(3,10),(2,11),(3,11),(2,12),(4,12),(2,13),(4,13),(1,14),(2,14),(1,15),(2,15),(1,16),(1,17),(1,18),(1,19),(1,20),(1,21),(1,22),(1,23),(2,24),(3,24),(4,24),(2,25),(3,25),(2,26),(3,26),(2,27),(3,27);
/*!40000 ALTER TABLE `rolpagina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoobra`
--

DROP TABLE IF EXISTS `tipoobra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoobra` (
  `IdTipoObra` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`IdTipoObra`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoobra`
--

LOCK TABLES `tipoobra` WRITE;
/*!40000 ALTER TABLE `tipoobra` DISABLE KEYS */;
INSERT INTO `tipoobra` VALUES (1,'SANEAMIENTO');
/*!40000 ALTER TABLE `tipoobra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `IdUsuario` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ApellidoNombre` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `Username` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `Password` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `IdOrganismo` int(10) unsigned DEFAULT NULL,
  `Activo` int(1) unsigned NOT NULL,
  `IdRol` int(10) unsigned NOT NULL,
  PRIMARY KEY (`IdUsuario`),
  KEY `fk_usuario_organismo` (`IdOrganismo`),
  KEY `fk_usuario_rol` (`IdRol`),
  CONSTRAINT `fk_usuario_organismo` FOREIGN KEY (`IdOrganismo`) REFERENCES `organismo` (`IdOrganismo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_rol` FOREIGN KEY (`IdRol`) REFERENCES `rol` (`IdRol`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'ADMINISTRADOR EPAS','epasadmin','3fc0a7acf087f549ac2b266baf94b8b1',1,1,2),(2,'ADMINISTRADOR GENERAL','admin','3fc0a7acf087f549ac2b266baf94b8b1',NULL,1,1),(3,'OBRAS EPAS','epasobras','3fc0a7acf087f549ac2b266baf94b8b1',1,1,3),(4,'TESORERIA EPAS','epasteso','3fc0a7acf087f549ac2b266baf94b8b1',1,1,4),(5,'ADMINISTRADOR EPEN','epenadmin','3fc0a7acf087f549ac2b266baf94b8b1',2,1,2);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ute`
--

DROP TABLE IF EXISTS `ute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ute` (
  `IdProveedor` int(10) unsigned NOT NULL,
  `IdProveedorSocio` int(10) unsigned NOT NULL,
  `PorcentajeSocio` decimal(5,2) unsigned NOT NULL,
  PRIMARY KEY (`IdProveedor`,`IdProveedorSocio`),
  KEY `fk_ute_proveedor_2` (`IdProveedorSocio`),
  CONSTRAINT `fk_ute_proveedor` FOREIGN KEY (`IdProveedor`) REFERENCES `proveedor` (`IdProveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ute_proveedor_2` FOREIGN KEY (`IdProveedorSocio`) REFERENCES `proveedor` (`IdProveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ute`
--

LOCK TABLES `ute` WRITE;
/*!40000 ALTER TABLE `ute` DISABLE KEYS */;
INSERT INTO `ute` VALUES (7,1,23.00),(7,2,54.00),(7,3,23.00),(8,1,75.00);
/*!40000 ALTER TABLE `ute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ssp'
--
/*!50003 DROP FUNCTION IF EXISTS `fnFufisxObra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `fnFufisxObra`(pIdObra INT) RETURNS varchar(1000) CHARSET latin1
BEGIN
  DECLARE vNombre VARCHAR(255);
  DECLARE vFufi VARCHAR(4);
  DECLARE vReturn VARCHAR(1000);
  DECLARE vDone INT DEFAULT 0;
  DECLARE vCurFufis CURSOR FOR select f.CodigoFufi, f.Descripcion from obrafuentefinanciamiento of inner join fuentefinanciamiento f on of.IdFuenteFinanciamiento=f.IdFuenteFinanciamiento where of.IdObra=pIdObra order by f.CodigoFufi;
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET vDone = 1;
  
  SET vReturn = '';
  SET vDone = 0;
  OPEN vCurFufis;
  
  REPEAT
    FETCH vCurFufis INTO vFufi, vNombre;
    
    IF NOT vDone THEN
      
      IF vReturn='' THEN
        SET vReturn = CONCAT(vFufi,' ',vNombre);
      ELSE
        SET vReturn = CONCAT(vReturn,'<br />', vFufi,' ',vNombre);
      END IF;
      
    END IF;
  
  UNTIL vDone END REPEAT;
	
  RETURN vReturn;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fnLocalidadesxObra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `fnLocalidadesxObra`(pIdObra INT) RETURNS varchar(1000) CHARSET latin1
BEGIN
  DECLARE vNombre VARCHAR(100);
  DECLARE vReturn VARCHAR(1000);
  DECLARE vDone INT DEFAULT 0;
  DECLARE vCurLocalidades CURSOR FOR select l.Nombre from obralocalidad ol inner join localidad l on ol.IdLocalidad=l.IdLocalidad where ol.IdObra=pIdObra order by l.Nombre;
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET vDone = 1;
  
  SET vReturn = '';
  SET vDone = 0;
  OPEN vCurLocalidades;
  
  REPEAT
    FETCH vCurLocalidades INTO vNombre;
    
    IF NOT vDone THEN
      
      IF vReturn='' THEN
        SET vReturn = vNombre;
      ELSE
        SET vReturn = CONCAT(vReturn,'<br />', vNombre);
      END IF;
      
    END IF;
  
  UNTIL vDone END REPEAT;
	
  RETURN vReturn;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-09-25 14:53:16

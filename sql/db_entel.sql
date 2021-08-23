/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ db_entel /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE db_entel;

DROP TABLE IF EXISTS canales;
CREATE TABLE `canales` (
  `id_canal` int(11) NOT NULL AUTO_INCREMENT,
  `id_tecnologia_operador` int(11) DEFAULT NULL,
  `id_equipo` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `estado` enum('A','I') NOT NULL,
  `nro_ranura` int(11) NOT NULL,
  `numero` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_canal`),
  KEY `fk_canales_tecnologia_operador1_idx` (`id_tecnologia_operador`),
  KEY `fk_canales_equipos1_idx` (`id_equipo`),
  CONSTRAINT `fk_canales_equipos1` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id_equipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_canales_tecnologia_operador1` FOREIGN KEY (`id_tecnologia_operador`) REFERENCES `tecnologias_operadores` (`id_tecnologia_operador`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1020 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS canales_claves;
CREATE TABLE `canales_claves` (
  `id_canal` int(11) NOT NULL,
  `id_registro_clave` int(11) NOT NULL,
  KEY `fk_canales_claves_canales1_idx` (`id_canal`),
  KEY `fk_canales_claves_registros_claves1_idx` (`id_registro_clave`),
  CONSTRAINT `fk_canales_claves_canales1` FOREIGN KEY (`id_canal`) REFERENCES `canales` (`id_canal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_canales_claves_registros_claves1` FOREIGN KEY (`id_registro_clave`) REFERENCES `registros_claves` (`id_registro_clave`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS credenciales_api;
CREATE TABLE `credenciales_api` (
  `id_credencial_api` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(45) NOT NULL,
  `clave` varchar(45) NOT NULL,
  `estado` enum('A','D') NOT NULL,
  PRIMARY KEY (`id_credencial_api`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS ejecuciones;
CREATE TABLE `ejecuciones` (
  `id_ejecucion` int(11) NOT NULL AUTO_INCREMENT,
  `numero_prueba` int(11) NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `estado` text NOT NULL,
  `id_prueba` int(11) NOT NULL,
  PRIMARY KEY (`id_ejecucion`),
  KEY `fk_ejecuciones_pruebas1_idx` (`id_prueba`),
  CONSTRAINT `fk_ejecuciones_pruebas1` FOREIGN KEY (`id_prueba`) REFERENCES `pruebas` (`id_prueba`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS equipos;
CREATE TABLE `equipos` (
  `id_equipo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `tipo` varchar(100) NOT NULL,
  `ranuras` int(11) NOT NULL,
  `id_sede` int(11) NOT NULL,
  `estado` enum('A','D') DEFAULT NULL,
  PRIMARY KEY (`id_equipo`),
  KEY `fk_equipos_ubicaciones1_idx` (`id_sede`),
  CONSTRAINT `fk_equipos_ubicaciones1` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`id_sede`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS errores;
CREATE TABLE `errores` (
  `id_error` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) DEFAULT NULL,
  `estado` varchar(100) DEFAULT NULL,
  `mensaje` text,
  PRIMARY KEY (`id_error`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS escenarios;
CREATE TABLE `escenarios` (
  `id_escenario` int(11) NOT NULL AUTO_INCREMENT,
  `id_ejecucion` int(11) NOT NULL,
  `id_canal_origen` int(11) NOT NULL,
  `id_destino` int(11) NOT NULL,
  `tipo` enum('C','E') NOT NULL,
  `uniqueid_en` varchar(200) NOT NULL,
  `uniqueid_sal` varchar(200) NOT NULL,
  `estado` text NOT NULL,
  `id_error` int(11) DEFAULT NULL,
  `numero_intento` int(11) DEFAULT NULL,
  `mos` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_escenario`),
  KEY `fk_escenarios_canales1_idx` (`id_canal_origen`),
  KEY `fk_escenarios_ejecucion1_idx` (`id_ejecucion`),
  KEY `fk_escenarios_error1_idx` (`id_error`),
  CONSTRAINT `fk_escenarios_canales1` FOREIGN KEY (`id_canal_origen`) REFERENCES `canales` (`id_canal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_escenarios_ejecucion1` FOREIGN KEY (`id_ejecucion`) REFERENCES `ejecuciones` (`id_ejecucion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_escenarios_error1` FOREIGN KEY (`id_error`) REFERENCES `errores` (`id_error`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=223 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS ldap_config;
CREATE TABLE `ldap_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS matrices;
CREATE TABLE `matrices` (
  `id_matriz` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `estado` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id_matriz`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS matrices_canales_destinos;
CREATE TABLE `matrices_canales_destinos` (
  `id_matriz_canal_destino` int(11) NOT NULL AUTO_INCREMENT,
  `id_matriz` int(11) NOT NULL,
  `id_canal_origen` int(11) NOT NULL,
  `id_destino` int(11) NOT NULL,
  `tipo` enum('C','E') NOT NULL,
  PRIMARY KEY (`id_matriz_canal_destino`),
  KEY `fk_escenarios_matrices1_idx` (`id_matriz`),
  KEY `fk_escenarios_canales1_idx` (`id_canal_origen`),
  CONSTRAINT `fk_escenarios_canales10` FOREIGN KEY (`id_canal_origen`) REFERENCES `canales` (`id_canal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_escenarios_matrices10` FOREIGN KEY (`id_matriz`) REFERENCES `matrices` (`id_matriz`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS modulos;
CREATE TABLE `modulos` (
  `id_modulo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) NOT NULL,
  `ruta` varchar(50) NOT NULL,
  `icono` varchar(50) NOT NULL,
  PRIMARY KEY (`id_modulo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS numeros_externos;
CREATE TABLE `numeros_externos` (
  `id_numero_externo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `comentario` text NOT NULL,
  `numero` varchar(15) NOT NULL,
  PRIMARY KEY (`id_numero_externo`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS operadores_telefonicos;
CREATE TABLE `operadores_telefonicos` (
  `id_operador_telefonico` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `codigo` varchar(45) NOT NULL,
  PRIMARY KEY (`id_operador_telefonico`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS perfiles;
CREATE TABLE `perfiles` (
  `id_perfil` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) NOT NULL,
  `descripcion` text NOT NULL,
  `estado` enum('A','D') NOT NULL,
  PRIMARY KEY (`id_perfil`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS perfiles_submodulos;
CREATE TABLE `perfiles_submodulos` (
  `id_perfil` int(11) NOT NULL,
  `id_submodulo` int(11) NOT NULL,
  KEY `fk_perfiles_modulos_perfiles1_idx` (`id_perfil`),
  KEY `fk_perfiles_modulos_submodulos1_idx` (`id_submodulo`),
  CONSTRAINT `fk_perfiles_modulos_perfiles1` FOREIGN KEY (`id_perfil`) REFERENCES `perfiles` (`id_perfil`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_perfiles_modulos_submodulos1` FOREIGN KEY (`id_submodulo`) REFERENCES `submodulos` (`id_submodulo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pruebas;
CREATE TABLE `pruebas` (
  `id_prueba` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `comentario` text NOT NULL,
  `correo` varchar(150) NOT NULL,
  `tiempo_timbrado` int(11) NOT NULL,
  `reintentos` int(11) NOT NULL,
  `tipo` enum('I','E') NOT NULL,
  `tipo_lanzamiento` varchar(70) NOT NULL,
  `activo` enum('S','N') DEFAULT NULL,
  `programacion` varchar(1) DEFAULT NULL,
  `ejecutado` enum('S','N') DEFAULT NULL,
  `fecha_lanzamiento` date DEFAULT NULL,
  `hora_lanzamiento` time DEFAULT NULL,
  `dias_lanzamiento` text,
  `id_matriz` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_prueba`),
  KEY `fk_pruebas_matrices1_idx` (`id_matriz`),
  KEY `fk_pruebas_usuarios1_idx` (`id_usuario`),
  CONSTRAINT `fk_pruebas_matrices1` FOREIGN KEY (`id_matriz`) REFERENCES `matrices` (`id_matriz`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pruebas_usuarios1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS registros_claves;
CREATE TABLE `registros_claves` (
  `id_registro_clave` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `clave` varchar(100) NOT NULL,
  `comentario` text NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_registro_clave`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS sedes;
CREATE TABLE `sedes` (
  `id_sede` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  PRIMARY KEY (`id_sede`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS submodulos;
CREATE TABLE `submodulos` (
  `id_submodulo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) NOT NULL,
  `ruta` varchar(50) NOT NULL,
  `icono` varchar(50) NOT NULL,
  `id_modulo` int(11) NOT NULL,
  PRIMARY KEY (`id_submodulo`),
  KEY `fk_submodulos_modulos1_idx` (`id_modulo`),
  CONSTRAINT `fk_submodulos_modulos1` FOREIGN KEY (`id_modulo`) REFERENCES `modulos` (`id_modulo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS tecnologias;
CREATE TABLE `tecnologias` (
  `id_tecnologia` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id_tecnologia`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS tecnologias_operadores;
CREATE TABLE `tecnologias_operadores` (
  `id_tecnologia_operador` int(11) NOT NULL AUTO_INCREMENT,
  `id_tecnologia` int(11) NOT NULL,
  `id_operador_telefonico` int(11) NOT NULL,
  PRIMARY KEY (`id_tecnologia_operador`),
  KEY `fk_tecnologia_operador_tecnologias1_idx` (`id_tecnologia`),
  KEY `fk_tecnologia_operador_operadores_telefonicos1_idx` (`id_operador_telefonico`),
  CONSTRAINT `fk_tecnologia_operador_operadores_telefonicos1` FOREIGN KEY (`id_operador_telefonico`) REFERENCES `operadores_telefonicos` (`id_operador_telefonico`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tecnologia_operador_tecnologias1` FOREIGN KEY (`id_tecnologia`) REFERENCES `tecnologias` (`id_tecnologia`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS usuarios;
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(150) NOT NULL,
  `apellidos` varchar(150) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `acceso` enum('A','D') NOT NULL,
  `clave` varchar(150) DEFAULT NULL,
  `id_perfil` int(11) NOT NULL,
  `ldap` enum('S','N') DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `fk_usuarios_perfiles1_idx` (`id_perfil`),
  CONSTRAINT `fk_usuarios_perfiles1` FOREIGN KEY (`id_perfil`) REFERENCES `perfiles` (`id_perfil`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;




INSERT INTO canales(id_canal,id_tecnologia_operador,id_equipo,nombre,estado,nro_ranura,numero) VALUES(1,2,1,NULL,'A',1,'994004054'),(2,1,1,NULL,'A',1,'984588353'),(3,3,1,NULL,'A',1,'997351846'),(4,14,1,NULL,'A',1,'918203780'),(1012,2,1,NULL,'A',1,'994004054'),(1013,5,1,NULL,'A',1,'984588353'),(1014,10,1,NULL,'A',1,'997351846'),(1015,14,1,NULL,'A',1,'918203780'),(1016,2,1,NULL,'A',1,'998379714'),(1017,14,1,NULL,'A',1,''),(1018,11,1,NULL,'A',1,''),(1019,2,1,NULL,'A',1,'');

INSERT INTO canales_claves(id_canal,id_registro_clave) VALUES(1,2),(2,2),(3,2),(4,2),(1,8),(4,8),(1,9),(2,9),(4,9);


INSERT INTO ejecuciones(id_ejecucion,numero_prueba,fecha_inicio,fecha_fin,estado,id_prueba) VALUES(41,3,'2021-02-12 16:25:00',NULL,X'46494e414c495a41444f',1),(42,3,'2021-02-13 16:25:00',NULL,X'46494e414c495a41444f',1),(43,3,'2021-02-14 16:25:00',NULL,X'46494e414c495a41444f',1),(44,3,'2021-02-15 16:25:00',NULL,X'46494e414c495a41444f',1),(45,3,'2021-02-16 16:25:00',NULL,X'46494e414c495a41444f',1),(46,3,'2021-02-17 16:25:00',NULL,X'46494e414c495a41444f',1),(47,3,'2021-02-18 16:25:00',NULL,X'46494e414c495a41444f',1),(48,3,'2021-02-19 16:25:00',NULL,X'46494e414c495a41444f',1),(49,3,'2021-02-20 16:25:00',NULL,X'46494e414c495a41444f',1),(50,3,'2021-02-21 16:25:00',NULL,X'46494e414c495a41444f',1),(51,3,'2021-02-22 16:25:00',NULL,X'46494e414c495a41444f',1),(52,3,'2021-02-23 16:25:00',NULL,X'46494e414c495a41444f',1),(53,3,'2021-02-24 16:25:00',NULL,X'46494e414c495a41444f',1),(54,3,'2021-02-25 16:25:00',NULL,X'46494e414c495a41444f',1),(55,3,'2021-02-26 16:25:00',NULL,X'46494e414c495a41444f',1),(56,3,'2021-02-27 16:25:00',NULL,X'46494e414c495a41444f',1),(57,3,'2021-02-28 16:25:00',NULL,X'46494e414c495a41444f',1),(58,3,'2021-03-01 16:25:00',NULL,X'46494e414c495a41444f',1),(59,3,'2021-03-02 16:25:00',NULL,X'46494e414c495a41444f',1),(60,3,'2021-03-03 16:25:00',NULL,X'46494e414c495a41444f',1),(61,3,'2021-03-04 16:25:00',NULL,X'46494e414c495a41444f',1),(62,3,'2021-03-05 16:25:00',NULL,X'46494e414c495a41444f',1),(63,3,'2021-03-06 16:25:00',NULL,X'46494e414c495a41444f',1),(64,3,'2021-03-07 16:25:00',NULL,X'46494e414c495a41444f',1),(65,3,'2021-03-08 16:25:00',NULL,X'46494e414c495a41444f',1),(66,3,'2021-03-09 16:25:00',NULL,X'46494e414c495a41444f',1),(67,3,'2021-03-10 16:25:00',NULL,X'46494e414c495a41444f',1),(68,3,'2021-03-11 16:25:00',NULL,X'46494e414c495a41444f',1),(69,3,'2021-03-12 16:25:00',NULL,X'46494e414c495a41444f',1),(70,3,'2021-03-13 16:25:00',NULL,X'46494e414c495a41444f',1),(71,3,'2021-03-14 16:25:00',NULL,X'46494e414c495a41444f',1),(72,3,'2021-03-15 16:25:00',NULL,X'46494e414c495a41444f',1),(73,3,'2021-03-16 16:25:00',NULL,X'46494e414c495a41444f',1),(74,3,'2021-03-17 16:25:00',NULL,X'46494e414c495a41444f',1),(75,3,'2021-03-18 16:25:00',NULL,X'46494e414c495a41444f',1),(76,3,'2021-03-19 16:25:00',NULL,X'46494e414c495a41444f',1),(77,3,'2021-03-20 16:25:00',NULL,X'46494e414c495a41444f',1),(78,3,'2021-03-21 16:25:00',NULL,X'46494e414c495a41444f',1),(79,3,'2021-03-22 16:25:00',NULL,X'46494e414c495a41444f',1),(80,3,'2021-03-23 16:25:00',NULL,X'46494e414c495a41444f',1),(81,3,'2021-03-24 16:25:00',NULL,X'46494e414c495a41444f',1),(82,3,'2021-03-25 16:25:00',NULL,X'46494e414c495a41444f',1),(83,3,'2021-03-27 16:00:10',NULL,X'46494e414c495a41444f',17),(84,3,'2021-03-28 09:00:00',NULL,X'46494e414c495a41444f',17),(85,1,'2021-03-29 23:05:30',NULL,X'46494e414c495a41444f',17),(86,1,'2021-03-30 09:00:00',NULL,X'46494e414c495a41444f',17),(87,3,'2021-03-30 17:20:20',NULL,X'46494e414c495a41444f',1),(88,1,'2021-03-31 09:49:00',NULL,X'46494e414c495a41444f',17),(89,1,'2021-03-31 10:55:10',NULL,X'46494e414c495a41444f',26),(90,1,'2021-03-31 11:00:10',NULL,X'46494e414c495a41444f',27),(91,2,'2021-03-31 11:55:10',NULL,X'46494e414c495a41444f',28),(92,2,'2021-03-31 12:18:00',NULL,X'46494e414c495a41444f',29),(93,2,'2021-03-31 16:20:10',NULL,X'46494e414c495a41444f',30),(94,1,'2021-04-01 16:28:20',NULL,X'46494e414c495a41444f',17),(95,1,'2021-04-02 12:07:40',NULL,X'46494e414c495a41444f',17);

INSERT INTO equipos(id_equipo,nombre,ip,tipo,ranuras,id_sede,estado) VALUES(1,'Base1','192.168.7.200','g',2,1,'A'),(96,'PBX_01','192.168.5.10','p',0,1,'A');

INSERT INTO errores(id_error,codigo,estado,mensaje) VALUES(1,'1',NULL,NULL),(2,'2',NULL,NULL),(3,'3',NULL,X'44657374696e6f206e6f20726573706f6e6465'),(4,'4',NULL,X'436f6e65637461646f'),(5,'5',NULL,NULL),(6,'6',NULL,NULL),(7,'7',NULL,NULL),(8,'8',NULL,NULL),(9,'9',NULL,NULL),(10,'10',NULL,NULL),(11,'11',NULL,NULL),(12,'12',NULL,NULL),(13,'13',NULL,NULL),(14,'14',NULL,NULL),(15,'15',NULL,NULL),(16,'16',NULL,X'436f727465204e6f726d616c');

INSERT INTO escenarios(id_escenario,id_ejecucion,id_canal_origen,id_destino,tipo,uniqueid_en,uniqueid_sal,estado,id_error,numero_intento,mos) VALUES(75,41,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(76,41,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(77,41,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(78,42,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(79,42,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(80,42,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(81,43,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(82,43,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(83,43,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(84,44,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(85,44,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(86,44,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(87,45,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(88,45,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(89,45,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(90,46,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(91,46,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(92,46,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(93,47,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(94,47,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(95,47,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(96,48,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(97,48,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(98,48,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(99,49,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(100,49,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(101,49,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(102,50,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(103,50,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(104,50,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(105,51,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(106,51,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(107,51,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(108,52,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(109,52,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(110,52,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(111,53,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(112,53,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(113,53,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(114,54,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(115,54,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(116,54,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(117,55,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(118,55,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(119,55,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(120,56,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(121,56,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(122,56,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(123,57,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(124,57,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(125,57,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(126,58,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(127,58,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(128,58,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(129,59,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(130,59,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(131,59,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(132,60,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(133,60,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(134,60,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(135,61,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(136,61,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(137,61,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(138,62,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(139,62,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(140,62,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(141,63,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(142,63,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(143,63,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(144,64,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(145,64,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(146,64,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(147,65,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(148,65,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(149,65,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(150,66,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(151,66,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(152,66,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(153,67,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(154,67,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(155,67,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(156,68,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(157,68,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(158,68,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(159,69,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(160,69,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(161,69,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(162,70,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(163,70,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(164,70,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(165,71,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(166,71,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(167,71,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(168,72,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(169,72,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(170,72,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(171,73,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(172,73,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(173,73,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(174,74,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(175,74,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(176,74,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(177,75,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(178,75,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(179,75,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(180,76,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(181,76,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(182,76,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(183,77,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(184,77,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(185,77,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(186,78,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(187,78,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(188,78,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(189,79,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(190,79,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(191,79,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(192,80,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(193,80,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(194,80,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(195,81,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(196,81,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(197,81,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(198,82,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(199,82,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(200,82,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(201,83,1,2,'C','','',X'50454e4449454e5445',NULL,0,NULL),(202,83,2,1,'C','','',X'50454e4449454e5445',NULL,0,NULL),(203,83,4,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(204,84,1,2,'C','','',X'50454e4449454e5445',NULL,0,NULL),(205,84,2,1,'C','','',X'50454e4449454e5445',NULL,0,NULL),(206,84,4,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(207,85,4,6,'E','','',X'50454e4449454e5445',NULL,0,NULL),(208,86,4,6,'E','','1617204938.630',X'53756363657373',NULL,0,NULL),(209,87,2,3,'E','','',X'50454e4449454e5445',NULL,0,NULL),(210,87,3,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(211,87,1,4,'E','','',X'50454e4449454e5445',NULL,0,NULL),(212,88,4,6,'E','','',X'50454e4449454e5445',NULL,0,NULL),(213,89,4,6,'E','','<unknown>',X'4661696c757265',NULL,0,NULL),(214,90,4,6,'E','','1617206409.641',X'53756363657373',NULL,0,NULL),(215,91,4,3,'E','','1617209711.643',X'53756363657373',4,0,NULL),(216,91,1,7,'E','','1617209711.644',X'53756363657373',4,0,NULL),(217,92,4,8,'E','','1617211089.647',X'53756363657373',4,0,NULL),(218,92,1,9,'E','','1617211089.648',X'53756363657373',4,0,NULL),(219,93,4,10,'E','','1617225609.651',X'53756363657373',4,0,NULL),(220,93,1,3,'E','','1617225610.652',X'53756363657373',4,0,NULL),(221,94,4,6,'E','','1617312500.657',X'53756363657373',4,0,NULL),(222,95,4,6,'E','','<unknown>',X'4661696c757265',3,0,NULL);

INSERT INTO ldap_config(id,nombre,data) VALUES(1,'conf_ldap',X'7b226e6f6d627265223a22507275656261222c226970223a223139322e3136382e372e313034222c2270756572746f223a22333839222c22616c696173223a22313233222c226e6f6d6272655f64697374696e677569646f223a22636e3d4e657763616c6c20332e302c6f753d4f5573756172696f732c6f753d5265644e657749502c64633d6e657769702c64633d7065222c227469706f5f656e6c616365223a2244433d6e657769702c44433d7065222c227573756172696f223a224e636333406e657769702e7065222c22636c617665223a2224254e495332303231227d'),(2,'conf_ldap',X'7b226163636573735f6c64617022203a20226c6f63616c227d');

INSERT INTO matrices(id_matriz,nombre,estado) VALUES(1,'Matriz de Prueba 12',1),(2,'Marzo',1),(4,'David Escalante',1),(5,'Davd-backend',1),(6,'E Matriz 31-03-2021',1),(7,'Prueba Bestsola',1),(14,'e matriz',0),(16,'TestEntel',1),(17,'cesarTest',1);

INSERT INTO matrices_canales_destinos(id_matriz_canal_destino,id_matriz,id_canal_origen,id_destino,tipo) VALUES(17,1,2,3,'E'),(18,1,3,4,'E'),(19,1,1,4,'E'),(30,2,4,6,'E'),(31,4,4,6,'E'),(32,5,4,6,'E'),(41,14,1,3,'E'),(42,16,4,10,'E'),(43,16,1,3,'E'),(44,17,1,4,'C');

INSERT INTO modulos(id_modulo,nombre,ruta,icono) VALUES(1,'Configuración General','configuracion-general','fas fa-tools'),(2,'Configuración Avanzada','configuracion-avanzada','fas fa-tools'),(3,'Generador de Pruebas','generador-pruebas','fas fa-play'),(4,'Reportes','reportes','fas fa-table'),(5,'DISA','disa','fas fa-address-card');

INSERT INTO numeros_externos(id_numero_externo,nombre,comentario,numero) VALUES(3,'Rogger',X'726f6767657220707275656261','961824774'),(4,'fidel',X'636f6d656e746172696f206e756c6c','945062208'),(5,'Wil',X'507275656261','950705943'),(6,'David Escalante',X'4e756d65726f2064652070727565626173','920802811'),(7,'Johana Palacios',X'507275656261204e45574950','977158054'),(8,'Kevin - Bestsol',X'5072756562612042657374736f6c','962213682'),(9,'Angel - Bestol',X'5072756562612042657374736f6c','931885385'),(10,'Jesus Bazan',X'50727565626120456e74656c','983434724'),(11,'Emergencias',X'313035','105');

INSERT INTO operadores_telefonicos(id_operador_telefonico,nombre,codigo) VALUES(1,'Entel','EN'),(2,'Movistar','MO'),(3,'Claro','CL'),(4,'Bitel','BI');

INSERT INTO perfiles(id_perfil,nombre,descripcion,estado) VALUES(1,'Administrador',X'7570','A'),(2,'Ejecutivo',X'536f6c6f207265706f72746573','A'),(3,'Entel',X'456e74656c2054657374','A');

INSERT INTO perfiles_submodulos(id_perfil,id_submodulo) VALUES(1,1),(1,2),(1,4),(1,7),(1,8),(1,9),(1,5),(1,6),(1,3),(1,11),(2,9),(2,10),(1,12),(1,13),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(3,9),(3,13),(3,11);

INSERT INTO pruebas(id_prueba,nombre,comentario,correo,tiempo_timbrado,reintentos,tipo,tipo_lanzamiento,activo,programacion,ejecutado,fecha_lanzamiento,hora_lanzamiento,dias_lanzamiento,id_matriz,id_usuario) VALUES(1,'Prueba 1',X'70727565626120656e20656c207365727669646f72206465206465736172726f6c6c6f','phantomzx03@gmail.com',2,3,'I','Programado','N','T','','2021-01-20','16:25:00',X'4c756e65732d4d61727465732d4d696572636f6c65732d4a75657665732d566965726e65732d53616261646f2d446f6d696e676f',1,2),(2,'Prueba 2',X'','phantomzx03@gmail.com',2,3,'I','Programado','N','U','S','2021-01-20','18:40:00',NULL,1,2),(3,'Prueba 4',X'636f6d656e746172696f20646520507275656261','phantomzx03@gmail.com',1,2,'E','Instantaneo',NULL,NULL,NULL,'2021-01-20','09:00:00',NULL,1,2),(10,'Prueba5',X'636f6d656e746172696f20646520707275656261','jzevallos@newip.pe',1,2,'E','Instantaneo',NULL,NULL,NULL,'2021-01-20','09:00:00',NULL,1,1),(12,'Prueba5',X'636f6d656e746172696f20646520707275656261','jzevallos@newip.pe',1,2,'E','Instantaneo',NULL,NULL,NULL,'2021-01-20','09:00:00',NULL,1,1),(14,'Prueba5',X'636f6d656e746172696f20646520707275656261','jzevallos@newip.pe',1,2,'E','Instantaneo',NULL,NULL,NULL,'2021-01-20','02:00:00',NULL,1,1),(15,'PRUEBA01',X'707275656261','RPADILLA@NEWIP.PE',30,2,'I','Instantaneo',NULL,NULL,NULL,'2021-01-20','09:00:00',NULL,1,2),(17,'PRUEBA EDITAR',X'5072756562617320706172612076616c6964616369c3b36e20646520726564','rogger.padilla@gmail.com',30,1,'I','Programado','S','T',NULL,'2021-01-20','09:00:00',X'4c756e65732d4d61727465732d4d696572636f6c65732d4a75657665732d566965726e65732d53616261646f2d446f6d696e676f',2,2),(19,'David Escalante',X'','davidjesus1284@gmail.com',2,2,'I','Instantaneo',NULL,NULL,NULL,'2021-01-20','09:00:00',NULL,1,2),(20,'David-numero',X'','davidjesus1284@gmail.com',2,2,'I','Instantaneo',NULL,NULL,NULL,'2021-01-20','02:00:00',NULL,2,2),(21,'David prueba nuevo',X'','davidjesus1284@gmail.com',30,2,'I','Instantaneo',NULL,NULL,NULL,'2021-01-20','09:00:00',NULL,4,2),(22,'David-programado',X'','davidjesus1284@gmail.com',30,2,'I','Programado',NULL,'U','N','2021-03-30','02:00:00',NULL,4,2),(24,'Prueba01',X'','soporte@newip.pe',30,5,'I','Instantaneo',NULL,NULL,NULL,'2021-01-20','09:00:00',NULL,4,2),(25,'David-back',X'','davidjesus1284@gmail.com',30,2,'I','Instantaneo',NULL,NULL,NULL,'2021-01-20','09:00:00',NULL,4,2),(26,'David-programado-2',X'50726f6772616d61646f','davidjesus1284@gmail.com',30,2,'I','Programado',NULL,'U','N','2021-03-31','10:55:00',NULL,4,2),(27,'David-nueva-prueba',X'','davidjesus1284@gmail.com',30,2,'I','Programado',NULL,'U','N','2021-03-31','11:00:00',NULL,5,2),(28,'Prueba 31-03-1993',X'','rogger.padilla@gmail.com',30,1,'I','Programado',NULL,'U','N','2021-03-31','11:55:00',NULL,6,2),(29,'PruebaBestsol01',X'','rogger.padilla@gmail.com',30,1,'I','Programado',NULL,'U','N','2021-03-31','12:18:00',NULL,7,2),(30,'Test01',X'','rogger.padilla@gmail.com',30,1,'I','Programado',NULL,'U','N','2021-03-31','16:20:00',NULL,16,2),(31,'lanzamientoCesar',X'','Cesar@c.com',1,1,'I','Programado',NULL,'U',NULL,'2021-04-02','20:15:00',NULL,17,1),(32,'cesartest',X'','claura@newip.pe',20,2,'I','Programado',NULL,'U','N','2021-04-02','20:27:00',NULL,17,1),(34,'cesarPruebaF',X'','claura@newip.pe',20,2,'I','Programado',NULL,'U','N','2021-04-03','10:08:00',NULL,17,1),(35,'Prueba0101',X'','rogger.padilla@gmail.com',30,1,'I','Programado',NULL,'U','N','2021-04-03','10:16:00',NULL,17,2),(36,'Prueba02',X'','rogger.padilla@gmail.com',30,5,'I','Programado',NULL,'U','N','2021-04-03','10:18:00',NULL,17,2),(37,'Prueba0303',X'','rogger.padilla@gmail.com',30,5,'I','Programado',NULL,'U','N','2021-04-03','11:08:00',NULL,17,2),(38,'Prueba05',X'','rogger.padilla@gmail.com',30,5,'I','Programado',NULL,'U','N','2021-04-03','11:02:00',NULL,17,2),(39,'Prueba10',X'','rogger.padilla@gmail.com',30,5,'I','Programado',NULL,'U','N','2021-04-03','12:03:00',NULL,17,2);

INSERT INTO registros_claves(id_registro_clave,nombre,clave,comentario,estado) VALUES(2,'Jesus Bazan','1912394',X'5573756172696f20444953412070617261204a657375732042617a616e',1),(8,'Kevin - Bestsol','554637',X'5065726d69736f206465206c6c616d616461732070617261204b6576696e2042657374736f6c',1),(9,'Test01','12345',X'507275656261',1);

INSERT INTO sedes(id_sede,nombre) VALUES(1,'Sede San Borja'),(2,'Sede Miraflores');

INSERT INTO submodulos(id_submodulo,nombre,ruta,icono,id_modulo) VALUES(1,'Gestión de usuarios','usuarios','fas fa-user',1),(2,'Gestión de perfiles','perfiles','asd',1),(3,'Tecnologías','tecnologias','asd',2),(4,'Operadores Telefonicos','operadores','asd',2),(5,'Equipos','equipos','asd',2),(6,'Números Externos','numeros-externos','asd',2),(7,'Matrices','matrices','asd',3),(8,'Lanzador de pruebas','lanzador-pruebas','asd',3),(9,'Reporte de prueba','reporte-prueba','asd',4),(10,'Informa de Calidad','informe-calidad','asd',4),(11,'Registro Clave','registro-clave','asd',5),(12,'ldap','ldap','asd',1),(13,'reporte disa','reporte-disa','asd',4);

INSERT INTO tecnologias(id_tecnologia,nombre) VALUES(1,'2G'),(2,'3G'),(3,'4G'),(4,'5G');

INSERT INTO tecnologias_operadores(id_tecnologia_operador,id_tecnologia,id_operador_telefonico) VALUES(1,1,1),(2,2,1),(3,3,1),(4,4,1),(5,1,2),(6,2,2),(7,3,2),(8,4,2),(9,1,3),(10,2,3),(11,3,3),(12,4,3),(13,1,4),(14,2,4),(15,3,4);
INSERT INTO usuarios(id_usuario,nombres,apellidos,correo,acceso,clave,id_perfil,ldap) VALUES(1,'Jose','Zevallos','jzevallos@newip.pe','A','$2b$10$uMh9XvBALz2Ab1dU80Rk6.ZaV/HrJu/mUp2DsaeR6Cs6/JwbFYC6u',1,NULL),(2,'Rogger','Padilla','rpadilla@newip.pe','A','$2b$10$uMh9XvBALz2Ab1dU80Rk6.ZaV/HrJu/mUp2DsaeR6Cs6/JwbFYC6u',1,NULL),(3,'Ejecutivo','1','informes@newip.pe','A','$2b$10$aUnx8lpdhg.tTCHciRkbHOXFMxf7NyYfkJqWPqrQQxMLzPHCIxvL.',2,NULL),(4,'test','test','ncc4','A','',1,'S'),(5,'Entel','Test','test@entel.pe','A','$2b$10$jU9Sgifb8aUM5J95AD5NR.TbRaOqS22Mn4P9QcfBRYfP/3yL9DMBi',3,NULL);







/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

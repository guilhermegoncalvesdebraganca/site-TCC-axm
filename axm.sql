CREATE DATABASE  IF NOT EXISTS `axm` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `axm`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: axm
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `almoxarife`
--

DROP TABLE IF EXISTS `almoxarife`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `almoxarife` (
  `cpf` varchar(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `telefone` varchar(15) NOT NULL,
  `email` varchar(255) NOT NULL,
  `createdAT` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `senha` varchar(20) NOT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE KEY `unique_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `almoxarife`
--

LOCK TABLES `almoxarife` WRITE;
/*!40000 ALTER TABLE `almoxarife` DISABLE KEYS */;
INSERT INTO `almoxarife` VALUES ('00000000000','Bruno Teste','31999999999','1','2025-01-14 10:29:37','2025-01-14 10:29:37','1'),('12345678900','Bruno','31999999999','12','2025-01-14 10:50:02','2025-01-14 10:50:02','1'),('12345678901','João Silva','11987654321','joao@almoxarife.com','2024-12-09 22:40:19','2025-01-14 10:29:37','senha123'),('23456789012','Maria Oliveira','21988765432','maria@almoxarife.com','2024-12-09 22:40:19','2025-01-14 10:29:37','senha456'),('34567890123','Carlos Souza','31999876543','carlos@almoxarife.com','2024-12-09 22:40:19','2025-01-14 10:29:37','senha789');
/*!40000 ALTER TABLE `almoxarife` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `cnpj` varchar(14) NOT NULL,
  `razao_social` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefone` varchar(15) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`cnpj`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES ('12345678000195','Empresa A Ltda','contato@empresaA.com','11987654321','2024-12-09 22:32:57','2024-12-09 22:32:57'),('45678901234567','Serviços C S/A','suporte@servicosC.com','11345678901','2024-12-09 22:32:57','2024-12-09 22:32:57'),('98765432000150','Comercial B Ltda','vendas@comercialB.com','11876543210','2024-12-09 22:32:57','2024-12-09 22:32:57');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrar`
--

DROP TABLE IF EXISTS `entrar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrar` (
  `id_registro` int(11) NOT NULL AUTO_INCREMENT,
  `cpf` varchar(11) NOT NULL,
  `codigo` int(11) NOT NULL,
  `qtd` int(11) NOT NULL,
  `createdAT` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_registro`),
  KEY `cpf` (`cpf`),
  KEY `codigo` (`codigo`),
  CONSTRAINT `entrar_ibfk_1` FOREIGN KEY (`cpf`) REFERENCES `almoxarife` (`cpf`),
  CONSTRAINT `entrar_ibfk_2` FOREIGN KEY (`codigo`) REFERENCES `material` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrar`
--

LOCK TABLES `entrar` WRITE;
/*!40000 ALTER TABLE `entrar` DISABLE KEYS */;
INSERT INTO `entrar` VALUES (4,'00000000000',47,4,'2025-02-05 11:28:59','2025-02-05 11:28:59'),(5,'00000000000',46,1,'2025-02-05 11:28:59','2025-02-05 11:28:59');
/*!40000 ALTER TABLE `entrar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecedores`
--

DROP TABLE IF EXISTS `fornecedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornecedores` (
  `nome_fornecedor` varchar(255) NOT NULL,
  `material` varchar(255) NOT NULL,
  `descricao` text NOT NULL,
  `imagem` text DEFAULT NULL,
  `createdAT` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `valor` decimal(10,2) NOT NULL DEFAULT 0.00,
  `link` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`nome_fornecedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedores`
--

LOCK TABLES `fornecedores` WRITE;
/*!40000 ALTER TABLE `fornecedores` DISABLE KEYS */;
INSERT INTO `fornecedores` VALUES ('Fornecedor A','Cimento','Fornecedor de cimento de alta qualidade','cimento.jpg','2024-12-31 12:24:00','2025-02-05 11:48:35',25.25,'cimento.com'),('Fornecedor B','Areia','Especialista em areia fina para construção','areia.png','2024-12-31 12:24:00','2025-02-05 11:48:35',15.20,'areia.com'),('Fornecedor C','Tijolos','Fornecimento de tijolos cerâmicos resistentes','tijolo.png','2024-12-31 12:24:00','2025-02-05 11:48:35',6.00,'https://www.youtube.com/');
/*!40000 ALTER TABLE `fornecedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material`
--

DROP TABLE IF EXISTS `material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `unidade_de_medida` varchar(50) NOT NULL,
  `createdAT` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `descricao` varchar(255) NOT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `qrcode_string` varchar(255) DEFAULT NULL,
  `limite` int(11) DEFAULT 0,
  PRIMARY KEY (`codigo`),
  KEY `fk_unidade_medida` (`unidade_de_medida`),
  CONSTRAINT `fk_unidade_medida` FOREIGN KEY (`unidade_de_medida`) REFERENCES `unidade_medida` (`nome`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material`
--

LOCK TABLES `material` WRITE;
/*!40000 ALTER TABLE `material` DISABLE KEYS */;
INSERT INTO `material` VALUES (46,'Arroz','kg','2025-01-31 18:09:34','2025-02-05 11:28:59','Arroz branco',13,'{\"nome\":\"Arroz\",\"descricao\":\"Arroz branco\",\"unidade\":\"kg\",\"aviso\":\"5\"}',5),(47,'Pneu','un','2025-01-31 18:09:52','2025-02-05 11:28:59','Pneu 295 misto',74,'{\"nome\":\"Pneu\",\"descricao\":\"Pneu 295 misto\",\"unidade\":\"un\",\"aviso\":\"4\"}',4),(48,'teste','kg','2025-02-03 17:13:40','2025-02-04 11:55:20','teste teste',5,'{\"nome\":\"teste\",\"descricao\":\"teste teste\",\"unidade\":\"kg\",\"aviso\":\"4\"}',4);
/*!40000 ALTER TABLE `material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saida`
--

DROP TABLE IF EXISTS `saida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saida` (
  `id_nota` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` int(11) NOT NULL,
  `qtd` int(11) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `createdAT` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_nota`),
  KEY `codigo` (`codigo`),
  KEY `cpf` (`cpf`),
  CONSTRAINT `saida_ibfk_1` FOREIGN KEY (`codigo`) REFERENCES `material` (`codigo`),
  CONSTRAINT `saida_ibfk_2` FOREIGN KEY (`cpf`) REFERENCES `almoxarife` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saida`
--

LOCK TABLES `saida` WRITE;
/*!40000 ALTER TABLE `saida` DISABLE KEYS */;
INSERT INTO `saida` VALUES (4,47,4,'00000000000','2025-02-04 11:26:42','2025-02-04 11:26:42'),(5,47,9,'00000000000','2025-02-04 11:27:20','2025-02-04 11:27:20'),(6,47,3,'00000000000','2025-02-04 11:28:21','2025-02-04 11:28:21'),(7,47,3,'00000000000','2025-02-04 11:28:21','2025-02-04 11:28:21'),(8,46,3,'00000000000','2025-02-04 11:33:22','2025-02-04 11:33:22');
/*!40000 ALTER TABLE `saida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidade_medida`
--

DROP TABLE IF EXISTS `unidade_medida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unidade_medida` (
  `nome` varchar(50) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidade_medida`
--

LOCK TABLES `unidade_medida` WRITE;
/*!40000 ALTER TABLE `unidade_medida` DISABLE KEYS */;
INSERT INTO `unidade_medida` VALUES ('grama','2024-12-31 11:15:10','2025-01-11 17:19:18'),('kg','2024-12-31 11:15:10','2024-12-31 11:15:10'),('m³','2024-12-31 11:15:10','2024-12-31 11:15:10'),('un','2024-12-31 11:15:10','2024-12-31 11:15:10');
/*!40000 ALTER TABLE `unidade_medida` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-05  9:01:17

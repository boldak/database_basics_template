-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`User` ;

CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nickname` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `role` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Dataverse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Dataverse` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Dataverse` (
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Access`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Access` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Access` (
  `role` VARCHAR(45) NULL,
  `User_id` INT NOT NULL,
  `Dataverse_id` INT NOT NULL,
  PRIMARY KEY (`User_id`, `Dataverse_id`),
  INDEX `fk_Acess_User1_idx` (`User_id` ASC) VISIBLE,
  INDEX `fk_Acess_Dataverse1_idx` (`Dataverse_id` ASC) VISIBLE,
  CONSTRAINT `fk_Acess_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `mydb`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Acess_Dataverse1`
    FOREIGN KEY (`Dataverse_id`)
    REFERENCES `mydb`.`Dataverse` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Dataset`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Dataset` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Dataset` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Dataverse_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Dataverse_id`),
  INDEX `fk_Dataset_Dataverse1_idx` (`Dataverse_id` ASC) VISIBLE,
  CONSTRAINT `fk_Dataset_Dataverse1`
    FOREIGN KEY (`Dataverse_id`)
    REFERENCES `mydb`.`Dataverse` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`File`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`File` ;

CREATE TABLE IF NOT EXISTS `mydb`.`File` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(5000) NULL,
  `Dataset_id` INT NOT NULL,
  `Dataset_Dataverse_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Dataset_id`, `Dataset_Dataverse_id`),
  INDEX `fk_File_Dataset1_idx` (`Dataset_id` ASC, `Dataset_Dataverse_id` ASC) VISIBLE,
  CONSTRAINT `fk_File_Dataset1`
    FOREIGN KEY (`Dataset_id` , `Dataset_Dataverse_id`)
    REFERENCES `mydb`.`Dataset` (`id` , `Dataverse_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Metadata` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Metadata` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `date` DATE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MetadataGroup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`MetadataGroup` ;

CREATE TABLE IF NOT EXISTS `mydb`.`MetadataGroup` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `File_id` INT NULL,
  `File_Dataset_id` INT NULL,
  `File_Dataset_Dataverse_id` INT NULL,
  `Dataset_id` INT NULL,
  `Dataset_Dataverse_id` INT NULL,
  `Dataverse_id` INT NULL,
  `Metadata_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_MetadataGroup_File1_idx` (`File_id` ASC, `File_Dataset_id` ASC, `File_Dataset_Dataverse_id` ASC) VISIBLE,
  INDEX `fk_MetadataGroup_Dataset1_idx` (`Dataset_id` ASC, `Dataset_Dataverse_id` ASC) VISIBLE,
  INDEX `fk_MetadataGroup_Dataverse1_idx` (`Dataverse_id` ASC) VISIBLE,
  INDEX `fk_MetadataGroup_Metadata1_idx` (`Metadata_id` ASC) VISIBLE,
  CONSTRAINT `fk_MetadataGroup_File1`
    FOREIGN KEY (`File_id` , `File_Dataset_id` , `File_Dataset_Dataverse_id`)
    REFERENCES `mydb`.`File` (`id` , `Dataset_id` , `Dataset_Dataverse_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MetadataGroup_Dataset1`
    FOREIGN KEY (`Dataset_id` , `Dataset_Dataverse_id`)
    REFERENCES `mydb`.`Dataset` (`id` , `Dataverse_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MetadataGroup_Dataverse1`
    FOREIGN KEY (`Dataverse_id`)
    REFERENCES `mydb`.`Dataverse` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MetadataGroup_Metadata1`
    FOREIGN KEY (`Metadata_id`)
    REFERENCES `mydb`.`Metadata` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
               
               
-- -----------------------------------------------------
-- Data for table `mydb`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`user` (`id`, `nickname`, `password`, `email`, `role`) VALUES (1, 'Владислав Брыль', '111', 'bril.vladislav@gmail.com', 'User');
INSERT INTO `mydb`.`user` (`id`, `nickname`, `password`, `email`, `role`) VALUES (2, 'Александр Гонтеренко', '222', 'sanya2211@ukr.net', 'Admin');
INSERT INTO `mydb`.`user` (`id`, `nickname`, `password`, `email`, `role`) VALUES (3, 'Роман Комаровский', '333', 'visibilis24@gmail.com', 'User');
INSERT INTO `mydb`.`user` (`id`, `nickname`, `password`, `email`, `role`) VALUES (4, 'Егор Корякин', '444', 'egorkor4@gmail.com', 'User');
INSERT INTO `mydb`.`user` (`id`, `nickname`, `password`, `email`, `role`) VALUES (5, 'Георгий Куцурайс', '555', 'gorik2001pro@gmail.com', 'User');
INSERT INTO `mydb`.`user` (`id`, `nickname`, `password`, `email`, `role`) VALUES (6, 'Дмитрий Кучеренко', '666', 'jmalining@gmail.com', 'User');
INSERT INTO `mydb`.`user` (`id`, `nickname`, `password`, `email`, `role`) VALUES (7, 'Май Тиен Ноанг', '777', 'tmai2218@gmail.com', 'User');
INSERT INTO `mydb`.`user` (`id`, `nickname`, `password`, `email`, `role`) VALUES (8, 'Дмитрий Прокопчук', '888', 'prokopchuk.dimon111@gmail.com', 'User');
               
COMMIT;
       
               
-- -----------------------------------------------------
-- Data for table `mydb`.`dataverse`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`dataverse` (`id`) VALUES (1);
               
COMMIT;
               
               
-- -----------------------------------------------------
-- Data for table `mydb`.`access`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`access` (`role`, `User_id`, `Dataverse_id`) VALUES ('Admin', 2, 1);
               
COMMIT;
               
       
-- -----------------------------------------------------
-- Data for table `mydb`.`dataset`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`dataset` (`id`, `Dataverse_id`) VALUES (1, 1);
INSERT INTO `mydb`.`dataset` (`id`, `Dataverse_id`) VALUES (2, 1);
INSERT INTO `mydb`.`dataset` (`id`, `Dataverse_id`) VALUES (3, 1);
               
COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`file`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`file` (id, content, Dataset_id, Dataset_Dataverse_id) VALUES (1, 'Hello World in the first file!', 1, 1);
INSERT INTO `mydb`.`file` (id, content, Dataset_id, Dataset_Dataverse_id) VALUES (2, 'Hello World in the second file!', 2, 1);
INSERT INTO `mydb`.`file` (id, content, Dataset_id, Dataset_Dataverse_id) VALUES (3, 'Hello World in the third file!', 3, 1);
               
COMMIT;
           
               
-- -----------------------------------------------------
-- Data for table `mydb`.`metadata`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`metadata` (`id`, `name`, `date`) VALUES (1, 'File 1', '2020-12-03');
INSERT INTO `mydb`.`metadata` (`id`, `name`, `date`) VALUES (2, 'Dataset 1', '2020-12-03');
               
COMMIT;          
               
               
-- -----------------------------------------------------
-- Data for table `mydb`.`metadatagroup`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`metadatagroup` (`id`, `File_id`, `File_Dataset_id`, `File_Dataset_Dataverse_id`, `Metadata_id`) VALUES (1, 1, 1, 1, 1);
INSERT INTO `mydb`.`metadatagroup` (`id`, `Dataset_id`, `Dataset_Dataverse_id`, `Metadata_id`) VALUES (2, 1, 1, 2);
               
COMMIT;                 

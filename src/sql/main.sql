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
  `Datavarse_id` INT NOT NULL,
  PRIMARY KEY (`User_id`, `Datavarse_id`),
  INDEX `fk_Acess_User1_idx` (`User_id` ASC) VISIBLE,
  INDEX `fk_Acess_Datavarse1_idx` (`Datavarse_id` ASC) VISIBLE,
  CONSTRAINT `fk_Acess_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `mydb`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Acess_Datavarse1`
    FOREIGN KEY (`Datavarse_id`)
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
-- Table `mydb`.`MetadataGroup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`MetadataGroup` ;

CREATE TABLE IF NOT EXISTS `mydb`.`MetadataGroup` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `key` VARCHAR(255) NULL,
  `value` VARCHAR(3000) NULL,
  `File_id` INT NOT NULL,
  `File_Dataset_id` INT NOT NULL,
  `File_Dataset_Dataverse_id` INT NOT NULL,
  `Dataset_id` INT NOT NULL,
  `Dataset_Dataverse_id` INT NOT NULL,
  `Dataverse_id` INT NOT NULL,
  PRIMARY KEY (`id`, `File_id`, `File_Dataset_id`, `File_Dataset_Dataverse_id`, `Dataset_id`, `Dataset_Dataverse_id`, `Dataverse_id`),
  INDEX `fk_MetadataGroup_File1_idx` (`File_id` ASC, `File_Dataset_id` ASC, `File_Dataset_Dataverse_id` ASC) VISIBLE,
  INDEX `fk_MetadataGroup_Dataset1_idx` (`Dataset_id` ASC, `Dataset_Dataverse_id` ASC) VISIBLE,
  INDEX `fk_MetadataGroup_Dataverse1_idx` (`Dataverse_id` ASC) VISIBLE,
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
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Metadata` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Metadata` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `key` VARCHAR(255) NULL,
  `value` VARCHAR(3000) NULL,
  `MetadataGroup_id` INT NOT NULL,
  `MetadataGroup_File_id` INT NOT NULL,
  `MetadataGroup_File_Dataset_id` INT NOT NULL,
  `MetadataGroup_File_Dataset_Dataverse_id` INT NOT NULL,
  `MetadataGroup_Dataset_id` INT NOT NULL,
  `MetadataGroup_Dataset_Dataverse_id` INT NOT NULL,
  `MetadataGroup_Dataverse_id` INT NOT NULL,
  PRIMARY KEY (`id`, `MetadataGroup_id`, `MetadataGroup_File_id`, `MetadataGroup_File_Dataset_id`, `MetadataGroup_File_Dataset_Dataverse_id`, `MetadataGroup_Dataset_id`, `MetadataGroup_Dataset_Dataverse_id`, `MetadataGroup_Dataverse_id`),
  INDEX `fk_Metadata_MetadataGroup1_idx` (`MetadataGroup_id` ASC, `MetadataGroup_File_id` ASC, `MetadataGroup_File_Dataset_id` ASC, `MetadataGroup_File_Dataset_Dataverse_id` ASC, `MetadataGroup_Dataset_id` ASC, `MetadataGroup_Dataset_Dataverse_id` ASC, `MetadataGroup_Dataverse_id` ASC) VISIBLE,
  CONSTRAINT `fk_Metadata_MetadataGroup1`
    FOREIGN KEY (`MetadataGroup_id` , `MetadataGroup_File_id` , `MetadataGroup_File_Dataset_id` , `MetadataGroup_File_Dataset_Dataverse_id` , `MetadataGroup_Dataset_id` , `MetadataGroup_Dataset_Dataverse_id` , `MetadataGroup_Dataverse_id`)
    REFERENCES `mydb`.`MetadataGroup` (`id` , `File_id` , `File_Dataset_id` , `File_Dataset_Dataverse_id` , `Dataset_id` , `Dataset_Dataverse_id` , `Dataverse_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

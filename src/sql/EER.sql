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
-- Table `mydb`.`Project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Project` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Project` (
  `Id` INT NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Metadata` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Metadata` (
  `key` VARCHAR(45) NULL,
  `value` VARCHAR(2500) NULL,
  `Project_Id` INT NOT NULL,
  INDEX `fk_Metadata_Project_idx` (`Project_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Metadata_Project`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `mydb`.`Project` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Account` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Account` (
  `Id` INT NOT NULL,
  `email` VARCHAR(45) NULL,
  `loginl` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `state` TINYINT NULL,
  `avatar` VARCHAR(300) NULL,
  `role` VARCHAR(45) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RawData`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`RawData` ;

CREATE TABLE IF NOT EXISTS `mydb`.`RawData` (
  `Id` INT NOT NULL,
  `data` VARCHAR(2500) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProcessedData`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ProcessedData` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ProcessedData` (
  `Id` INT NOT NULL,
  `data` VARCHAR(2500) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Access`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Access` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Access` (
  `Project_Id` INT NOT NULL,
  `Account_Id` INT NOT NULL,
  `Raw data_Id` INT NOT NULL,
  `ProcessedData_Id` INT NOT NULL,
  INDEX `fk_Access_Project1_idx` (`Project_Id` ASC) VISIBLE,
  INDEX `fk_Access_Account1_idx` (`Account_Id` ASC) VISIBLE,
  INDEX `fk_Access_Raw data1_idx` (`Raw data_Id` ASC) VISIBLE,
  INDEX `fk_Access_ProcessedData1_idx` (`ProcessedData_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Access_Project1`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `mydb`.`Project` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Access_Account1`
    FOREIGN KEY (`Account_Id`)
    REFERENCES `mydb`.`Account` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Access_Raw data1`
    FOREIGN KEY (`Raw data_Id`)
    REFERENCES `mydb`.`RawData` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Access_ProcessedData1`
    FOREIGN KEY (`ProcessedData_Id`)
    REFERENCES `mydb`.`ProcessedData` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

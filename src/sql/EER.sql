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
-- Table `mydb`.`BeatType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`BeatType` ;

CREATE TABLE IF NOT EXISTS `mydb`.`BeatType` (
  `Id` INT NOT NULL,
  `name` VARCHAR(100) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Access`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Access` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Access` (
  `role` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`role`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Instrument`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Instrument` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Instrument` (
  `Id` INT NOT NULL,
  `url` VARCHAR(300) NULL,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(200) NULL,
  `openapi` VARCHAR(200) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Instruments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Instruments` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Instruments` (
  `Id` INT NOT NULL,
  `servicenode` INT NULL,
  `next` INT NULL,
  `Instruments_Id` INT NOT NULL,
  `Instrument_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Instruments_Instruments1_idx` (`Instruments_Id` ASC) VISIBLE,
  INDEX `fk_Instruments_Instrument1_idx` (`Instrument_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Instruments_Instruments1`
    FOREIGN KEY (`Instruments_Id`)
    REFERENCES `mydb`.`Instruments` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Instruments_Instrument1`
    FOREIGN KEY (`Instrument_Id`)
    REFERENCES `mydb`.`Instrument` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProcessedData`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ProcessedData` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ProcessedData` (
  `name` VARCHAR(200) NOT NULL,
  `description` VARCHAR(500) NULL,
  `Access_role` VARCHAR(100) NOT NULL,
  `RawData_name` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`name`),
  INDEX `fk_ProcessedData_Access1_idx` (`Access_role` ASC) VISIBLE,
  INDEX `fk_ProcessedData_RawData1_idx` (`RawData_name` ASC) VISIBLE,
  CONSTRAINT `fk_ProcessedData_Access1`
    FOREIGN KEY (`Access_role`)
    REFERENCES `mydb`.`Access` (`role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProcessedData_RawData1`
    FOREIGN KEY (`RawData_name`)
    REFERENCES `mydb`.`RawData` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RawData`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`RawData` ;

CREATE TABLE IF NOT EXISTS `mydb`.`RawData` (
  `name` VARCHAR(200) NOT NULL,
  `description` VARCHAR(500) NULL,
  `entrypoint` INT NULL,
  `beats` VARCHAR(200) NULL,
  `Instruments_Id` INT NOT NULL,
  `ProcessedData_name` VARCHAR(200) NOT NULL,
  `Access_role` VARCHAR(100) NOT NULL,
  INDEX `fk_RawData_Instruments1_idx` (`Instruments_Id` ASC) VISIBLE,
  PRIMARY KEY (`name`),
  INDEX `fk_RawData_ProcessedData1_idx` (`ProcessedData_name` ASC) VISIBLE,
  INDEX `fk_RawData_Access1_idx` (`Access_role` ASC) VISIBLE,
  CONSTRAINT `fk_RawData_Instruments1`
    FOREIGN KEY (`Instruments_Id`)
    REFERENCES `mydb`.`Instruments` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RawData_ProcessedData1`
    FOREIGN KEY (`ProcessedData_name`)
    REFERENCES `mydb`.`ProcessedData` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RawData_Access1`
    FOREIGN KEY (`Access_role`)
    REFERENCES `mydb`.`Access` (`role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Beat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Beat` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Beat` (
  `Id` INT NOT NULL,
  `interval` INT NULL,
  `source` VARCHAR(300) NULL,
  `type` INT NULL,
  `BeatType_Id` INT NOT NULL,
  `Access_role` VARCHAR(100) NOT NULL,
  `RawData_name` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Beat_BeatType1_idx` (`BeatType_Id` ASC) VISIBLE,
  INDEX `fk_Beat_Access1_idx` (`Access_role` ASC) VISIBLE,
  INDEX `fk_Beat_RawData1_idx` (`RawData_name` ASC) VISIBLE,
  CONSTRAINT `fk_Beat_BeatType1`
    FOREIGN KEY (`BeatType_Id`)
    REFERENCES `mydb`.`BeatType` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Beat_Access1`
    FOREIGN KEY (`Access_role`)
    REFERENCES `mydb`.`Access` (`role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Beat_RawData1`
    FOREIGN KEY (`RawData_name`)
    REFERENCES `mydb`.`RawData` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SourceData`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`SourceData` ;

CREATE TABLE IF NOT EXISTS `mydb`.`SourceData` (
  `Id` INT NOT NULL,
  `url` VARCHAR(300) NULL,
  `apikey` VARCHAR(300) NULL,
  `Beat_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_SourceData_Beat_idx` (`Beat_Id` ASC) VISIBLE,
  CONSTRAINT `fk_SourceData_Beat`
    FOREIGN KEY (`Beat_Id`)
    REFERENCES `mydb`.`Beat` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Account` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Account` (
  `email` VARCHAR(45) NOT NULL,
  `login` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `state` TINYINT NULL,
  `avatar` VARCHAR(300) NULL,
  `role` VARCHAR(45) NULL,
  `Access_role` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`email`),
  INDEX `fk_Account_Access1_idx` (`Access_role` ASC) VISIBLE,
  CONSTRAINT `fk_Account_Access1`
    FOREIGN KEY (`Access_role`)
    REFERENCES `mydb`.`Access` (`role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

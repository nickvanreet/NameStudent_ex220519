-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`patient` (
  `patient_id` INT NOT NULL,
  `patient_lastname` VARCHAR(45) NULL,
  `patient_firstname` VARCHAR(45) NULL,
  `patient_day_of_birth` DATE NULL,
  `patient_gender` ENUM('M', 'F') NULL,
  PRIMARY KEY (`patient_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`gene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`gene` (
  `gene_id` INT NOT NULL,
  `gene_name` VARCHAR(45) NULL,
  `gene_desc` VARCHAR(255) NULL,
  PRIMARY KEY (`gene_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`mutation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mutation` (
  `mutation_id` INT NOT NULL,
  `gene_id` INT NOT NULL,
  `mutation_start` INT NULL,
  `mutation_end` INT NULL,
  `mutation_syndrome` VARCHAR(255) NULL,
  PRIMARY KEY (`mutation_id`),
  INDEX `genemutation_idx` (`gene_id` ASC) VISIBLE,
  CONSTRAINT `genemutation`
    FOREIGN KEY (`gene_id`)
    REFERENCES `mydb`.`gene` (`gene_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`diagnosis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`diagnosis` (
  `diagnosis_id` INT NOT NULL,
  `patient_id` INT NOT NULL,
  `mutation_id` INT NOT NULL,
  `diagnosis_date` DATE NULL,
  PRIMARY KEY (`diagnosis_id`),
  INDEX `patientdiagnosis_idx` (`patient_id` ASC) VISIBLE,
  INDEX `mutationdiagnosis_idx` (`mutation_id` ASC) VISIBLE,
  CONSTRAINT `patientdiagnosis`
    FOREIGN KEY (`patient_id`)
    REFERENCES `mydb`.`patient` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `mutationdiagnosis`
    FOREIGN KEY (`mutation_id`)
    REFERENCES `mydb`.`mutation` (`mutation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

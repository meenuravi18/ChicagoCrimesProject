-- Create Schema for ChicagoCrime - Run this first

DROP SCHEMA IF EXISTS `ChicagoCrime` ;

-- -----------------------------------------------------
-- Schema ChicagoCrime
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ChicagoCrime` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `ChicagoCrime` ;

-- -----------------------------------------------------
-- Table `ChicagoCrime`.`Alderman_Information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ChicagoCrime`.`Alderman_Information` (
  `Alderman_ID` INT NOT NULL,
  `Alderman_Last_Name` VARCHAR(45) NULL DEFAULT NULL,
  `Alderman_First_Name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Alderman_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ChicagoCrime`.`Crime_Types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ChicagoCrime`.`Crime_Types` (
  `Crime_ID` INT NOT NULL,
  `Crime_Category` VARCHAR(90) NULL DEFAULT NULL,
  `Crime_Rating` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Crime_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ChicagoCrime`.`FBI_Code_Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ChicagoCrime`.`FBI_Code_Categories` (
  `FBI_Code` INT NOT NULL,
  `Code_Description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`FBI_Code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ChicagoCrime`.`IUCR_Code_Descriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ChicagoCrime`.`IUCR_Code_Descriptions` (
  `IUCR_Code` INT NOT NULL,
  `Primary_Description` VARCHAR(90) NULL DEFAULT NULL,
  `Secondary_Description` VARCHAR(90) NULL DEFAULT NULL,
  PRIMARY KEY (`IUCR_Code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ChicagoCrime`.`Community_Area_Demographics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ChicagoCrime`.`Community_Area_Demographics` (
  `Community_Area_ID` INT NOT NULL,
  `Community_Area_Name` VARCHAR(45) NULL DEFAULT NULL,
  `Population_2010` VARCHAR(45) NULL DEFAULT NULL,
  `Median_Age` VARCHAR(45) NULL DEFAULT NULL,
  `Pct_White_Population` FLOAT(10,2) NULL DEFAULT NULL,
  `Pct_Black_Population` FLOAT(10,2) NULL DEFAULT NULL,
  `Pct_Asian_Population` FLOAT(10,2) NULL DEFAULT NULL,
  `Pct_Other_Race_Population` FLOAT(10,2) NULL DEFAULT NULL,
  `Unemployment_Rate` FLOAT(10,2) NULL DEFAULT NULL,
  `Pct_College_Educated` FLOAT(10,2) NULL DEFAULT NULL,
  `Pct_Owner_Occupied_Housing` FLOAT(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`Community_Area_ID`),
  INDEX `Location` (`Community_Area_ID` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ChicagoCrime`.`Police_Station_Information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ChicagoCrime`.`Police_Station_Information` (
  `District` INT NOT NULL,
  `District_Name` VARCHAR(255) NULL DEFAULT NULL,
  `Address` VARCHAR(255) NULL DEFAULT NULL,
  `City` VARCHAR(255) NULL DEFAULT NULL,
  `State` VARCHAR(255) NULL DEFAULT NULL,
  `Zipcode` INT NOT NULL,
  `Station_Website` VARCHAR(255) NULL DEFAULT NULL,
  `Station_Phone_Number` VARCHAR(255) NULL DEFAULT NULL,
  `PS_Lattitude` VARCHAR(45) NULL DEFAULT NULL,
  `PS_Longitude` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`District`),
  INDEX `Location` (`District` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ChicagoCrime`.`Zipcode_Demographics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ChicagoCrime`.`Zipcode_Demographics` (
  `Zipcode` INT NOT NULL,
  `Population_2020` INT NULL DEFAULT NULL,
  `Median_HH_Income_2020` INT NULL DEFAULT NULL,
  `Median_Age_2020` INT NULL DEFAULT NULL,
  `Percent_HH_Below_Poverty_Level` FLOAT(10,2) NULL DEFAULT NULL,
  `Percent_White_Population` FLOAT(10,2) NULL DEFAULT NULL,
  `Percent_Black_Population` FLOAT(10,2) NULL DEFAULT NULL,
  `Percent_Asian_Population` FLOAT(10,2) NULL DEFAULT NULL,
  `Percent_Other_Race_Population` FLOAT(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`Zipcode`),
  INDEX `Ward` (`Zipcode` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ChicagoCrime`.`Ward_Information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ChicagoCrime`.`Ward_Information` (
  `Ward` INT NOT NULL,
  `Alderman_ID` INT NOT NULL,
  `Address` VARCHAR(90) NULL DEFAULT NULL,
  `City` VARCHAR(90) NULL DEFAULT NULL,
  `State` VARCHAR(90) NULL DEFAULT NULL,
  `Zipcode` INT NOT NULL,
  `Ward_Phone_Number` VARCHAR(90) NULL DEFAULT NULL,
  `Ward_Email_Address` VARCHAR(90) NULL DEFAULT NULL,
  `Ward_Website` VARCHAR(100) NULL DEFAULT NULL,
  `W_Lattitude` VARCHAR(45) NULL DEFAULT NULL,
  `W_Longitude` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Ward`),
  INDEX `Ward_Alderman_FK_idx` (`Alderman_ID` ASC) VISIBLE,
  INDEX `zipcode` (`Zipcode` ASC) VISIBLE,
  CONSTRAINT `Ward_Alderman_FK`
    FOREIGN KEY (`Alderman_ID`)
    REFERENCES `ChicagoCrime`.`Alderman_Information` (`Alderman_ID`),
  CONSTRAINT `Ward_Zipcode_FK`
    FOREIGN KEY (`Zipcode`)
    REFERENCES `ChicagoCrime`.`Zipcode_Demographics` (`Zipcode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ChicagoCrime`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ChicagoCrime`.`Location` (
  `Location_ID` INT NOT NULL,
  `Block` VARCHAR(255) NULL DEFAULT NULL,
  `Location_Description` VARCHAR(255) NULL DEFAULT NULL,
  `District` INT NOT NULL,
  `Ward` INT NOT NULL,
  `Community_Area_ID` INT NOT NULL,
  `L_Lattitude` VARCHAR(255) NULL DEFAULT NULL,
  `L_Longitude` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`Location_ID`),
  INDEX `Location_idx` (`Location_ID` ASC) VISIBLE,
  INDEX `Location_Ward_FK_idx` (`Ward` ASC) VISIBLE,
  INDEX `Location_Police_FK_idx` (`District` ASC) VISIBLE,
  INDEX `Location_CommArea_FK_idx` (`Community_Area_ID` ASC) VISIBLE,
  CONSTRAINT `Location_CommArea_FK`
    FOREIGN KEY (`Community_Area_ID`)
    REFERENCES `ChicagoCrime`.`Community_Area_Demographics` (`Community_Area_ID`),
  CONSTRAINT `Location_Police_FK`
    FOREIGN KEY (`District`)
    REFERENCES `ChicagoCrime`.`Police_Station_Information` (`District`),
  CONSTRAINT `Location_Ward_FK`
    FOREIGN KEY (`Ward`)
    REFERENCES `ChicagoCrime`.`Ward_Information` (`Ward`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ChicagoCrime`.`Case_Information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ChicagoCrime`.`Case_Information` (
  `Case_Number` VARCHAR(45) NOT NULL,
  `Date` DATE NULL DEFAULT NULL,
  `Arrest` VARCHAR(45) NULL DEFAULT NULL,
  `Domestic` VARCHAR(45) NULL DEFAULT NULL,
  `FBI_Code` INT NOT NULL,
  `IUCR_Code` INT NOT NULL,
  `Crime_ID` INT NOT NULL,
  `Crime_Description` VARCHAR(255) NULL DEFAULT NULL,
  `Location_ID` INT NOT NULL,
  PRIMARY KEY (`Case_Number`),
  INDEX `Case_FBI_FK_idx` (`FBI_Code` ASC) VISIBLE,
  INDEX `Case_IUCR_FK_idx` (`IUCR_Code` ASC) VISIBLE,
  INDEX `Case_Location_FK_idx` (`Location_ID` ASC) VISIBLE,
  INDEX `Case_Crime_FK_idx` (`Crime_ID` ASC) VISIBLE,
  CONSTRAINT `Case_Crime_FK`
    FOREIGN KEY (`Crime_ID`)
    REFERENCES `ChicagoCrime`.`Crime_Types` (`Crime_ID`),
  CONSTRAINT `Case_FBI_FK`
    FOREIGN KEY (`FBI_Code`)
    REFERENCES `ChicagoCrime`.`FBI_Code_Categories` (`FBI_Code`),
  CONSTRAINT `Case_IUCR_FK`
    FOREIGN KEY (`IUCR_Code`)
    REFERENCES `ChicagoCrime`.`IUCR_Code_Descriptions` (`IUCR_Code`),
  CONSTRAINT `Case_Location_FK`
    FOREIGN KEY (`Location_ID`)
    REFERENCES `ChicagoCrime`.`Location` (`Location_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

COMMIT;
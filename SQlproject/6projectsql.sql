-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema FlightWebsite
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `FlightWebsite` ;

-- -----------------------------------------------------
-- Schema FlightWebsite
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `FlightWebsite` DEFAULT CHARACTER SET latin1 ;
USE `FlightWebsite` ;

-- -----------------------------------------------------
-- Table `FlightWebsite`.`Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FlightWebsite`.`Account` ;

CREATE TABLE IF NOT EXISTS `FlightWebsite`.`Account` (
  `Username` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NULL DEFAULT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  `AccountType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Username`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FlightWebsite`.`Aircrafts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FlightWebsite`.`Aircrafts` ;

CREATE TABLE IF NOT EXISTS `FlightWebsite`.`Aircrafts` (
  `AircraftID` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Capacity` INT(11) NOT NULL,
  PRIMARY KEY (`AircraftID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FlightWebsite`.`Airline`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FlightWebsite`.`Airline` ;

CREATE TABLE IF NOT EXISTS `FlightWebsite`.`Airline` (
  `AirlineID` CHAR(2) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `InternalID` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`AirlineID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FlightWebsite`.`Airports`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FlightWebsite`.`Airports` ;

CREATE TABLE IF NOT EXISTS `FlightWebsite`.`Airports` (
  `AirportID` CHAR(3) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `Country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`AirportID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FlightWebsite`.`Buys`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FlightWebsite`.`Buys` ;

CREATE TABLE IF NOT EXISTS `FlightWebsite`.`Buys` (
  `BuysUsername` VARCHAR(45) NOT NULL,
  `BookingFee` FLOAT NOT NULL,
  `BoughtDate` DATE NOT NULL,
  `CancelledDate` DATE NULL DEFAULT NULL,
  `BuysTicketNumber` INT(11) NULL DEFAULT NULL,
  `Class` VARCHAR(45) NULL DEFAULT NULL,
  INDEX `BuysUsername_idx` (`BuysUsername` ASC) VISIBLE,
  CONSTRAINT `BuysUsername`
    FOREIGN KEY (`BuysUsername`)
    REFERENCES `FlightWebsite`.`Account` (`Username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FlightWebsite`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FlightWebsite`.`Customer` ;

CREATE TABLE IF NOT EXISTS `FlightWebsite`.`Customer` (
  `CustomerUsername` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CustomerUsername`),
  CONSTRAINT `CustomerUsername`
    FOREIGN KEY (`CustomerUsername`)
    REFERENCES `FlightWebsite`.`Account` (`Username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FlightWebsite`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FlightWebsite`.`Employee` ;

CREATE TABLE IF NOT EXISTS `FlightWebsite`.`Employee` (
  `EmployeeUsername` VARCHAR(45) NOT NULL,
  `SSN` VARCHAR(11) NOT NULL,
  `EmployeeType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`EmployeeUsername`),
  CONSTRAINT `EmployeeUsername`
    FOREIGN KEY (`EmployeeUsername`)
    REFERENCES `FlightWebsite`.`Account` (`Username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FlightWebsite`.`CustomerRep`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FlightWebsite`.`CustomerRep` ;

CREATE TABLE IF NOT EXISTS `FlightWebsite`.`CustomerRep` (
  `CustomerRepUsername` VARCHAR(45) NOT NULL,
  INDEX `CustomerRepUsername_idx` (`CustomerRepUsername` ASC) VISIBLE,
  CONSTRAINT `CustomerRepUsername`
    FOREIGN KEY (`CustomerRepUsername`)
    REFERENCES `FlightWebsite`.`Employee` (`EmployeeUsername`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FlightWebsite`.`Flights`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FlightWebsite`.`Flights` ;

CREATE TABLE IF NOT EXISTS `FlightWebsite`.`Flights` (
  `FlightNumber` INT(11) NOT NULL,
  `isInternational` INT(11) NOT NULL,
  `DaysOfOperation` VARCHAR(45) NOT NULL,
  `PriceE` FLOAT NOT NULL,
  `PriceB` FLOAT NOT NULL,
  `PriceF` FLOAT NOT NULL,
  PRIMARY KEY (`FlightNumber`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FlightWebsite`.`DaysOP`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FlightWebsite`.`DaysOP` ;

CREATE TABLE IF NOT EXISTS `FlightWebsite`.`DaysOP` (
  `DaysFlightNumber` INT(11) NOT NULL,
  `Days` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DaysFlightNumber`, `Days`),
  CONSTRAINT `FlightNumber`
    FOREIGN KEY (`DaysFlightNumber`)
    REFERENCES `FlightWebsite`.`Flights` (`FlightNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FlightWebsite`.`Tickets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FlightWebsite`.`Tickets` ;

CREATE TABLE IF NOT EXISTS `FlightWebsite`.`Tickets` (
  `TicketNumber` INT(11) NOT NULL AUTO_INCREMENT,
  `SpecialMeal` VARCHAR(45) NULL DEFAULT NULL,
  `Fare` FLOAT NOT NULL,
  `Class` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`TicketNumber`))
ENGINE = InnoDB
AUTO_INCREMENT = 763
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FlightWebsite`.`FlightSequences`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FlightWebsite`.`FlightSequences` ;

CREATE TABLE IF NOT EXISTS `FlightWebsite`.`FlightSequences` (
  `FSFlightNumber` INT(11) NOT NULL,
  `FSTicketNumber` INT(11) NOT NULL,
  `FSOrder` INT(11) NOT NULL,
  `Seat` INT(11) NOT NULL,
  PRIMARY KEY (`FSFlightNumber`, `FSTicketNumber`),
  INDEX `FSTicketNumber_idx` (`FSTicketNumber` ASC) VISIBLE,
  CONSTRAINT `FSFlightNumber`
    FOREIGN KEY (`FSFlightNumber`)
    REFERENCES `FlightWebsite`.`Flights` (`FlightNumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FSTicketNumber`
    FOREIGN KEY (`FSTicketNumber`)
    REFERENCES `FlightWebsite`.`Tickets` (`TicketNumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FlightWebsite`.`FlyFrom`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FlightWebsite`.`FlyFrom` ;

CREATE TABLE IF NOT EXISTS `FlightWebsite`.`FlyFrom` (
  `FlyFromFlightNumber` INT(11) NOT NULL,
  `FlyFromAirportID` CHAR(3) NOT NULL,
  `Departure` DATETIME NOT NULL,
  PRIMARY KEY (`FlyFromFlightNumber`),
  INDEX `AirportID_idx` (`FlyFromAirportID` ASC) VISIBLE,
  CONSTRAINT `FlyFromAirportID`
    FOREIGN KEY (`FlyFromAirportID`)
    REFERENCES `FlightWebsite`.`Airports` (`AirportID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FlyFromFlightNumber`
    FOREIGN KEY (`FlyFromFlightNumber`)
    REFERENCES `FlightWebsite`.`Flights` (`FlightNumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FlightWebsite`.`FlyTo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FlightWebsite`.`FlyTo` ;

CREATE TABLE IF NOT EXISTS `FlightWebsite`.`FlyTo` (
  `FlyToFlightNumber` INT(11) NOT NULL,
  `FlyToAirportID` CHAR(3) NOT NULL,
  `Arrival` DATETIME NOT NULL,
  PRIMARY KEY (`FlyToFlightNumber`),
  INDEX `FlyToAirportID_idx` (`FlyToAirportID` ASC) VISIBLE,
  CONSTRAINT `FlyToAirportID`
    FOREIGN KEY (`FlyToAirportID`)
    REFERENCES `FlightWebsite`.`Airports` (`AirportID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FlyToFlightNumber`
    FOREIGN KEY (`FlyToFlightNumber`)
    REFERENCES `FlightWebsite`.`Flights` (`FlightNumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FlightWebsite`.`Have`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FlightWebsite`.`Have` ;

CREATE TABLE IF NOT EXISTS `FlightWebsite`.`Have` (
  `HaveFlightNumber` INT(11) NOT NULL,
  `HaveAircraftID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`HaveFlightNumber`),
  INDEX `HaveAircraftID_idx` (`HaveAircraftID` ASC) VISIBLE,
  CONSTRAINT `HaveAircraftID`
    FOREIGN KEY (`HaveAircraftID`)
    REFERENCES `FlightWebsite`.`Aircrafts` (`AircraftID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `HaveFlightNumber`
    FOREIGN KEY (`HaveFlightNumber`)
    REFERENCES `FlightWebsite`.`Flights` (`FlightNumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FlightWebsite`.`OperatedBy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FlightWebsite`.`OperatedBy` ;

CREATE TABLE IF NOT EXISTS `FlightWebsite`.`OperatedBy` (
  `OperatedByFlightNumber` INT(11) NOT NULL,
  `OperatedByAirlineID` CHAR(3) NOT NULL,
  PRIMARY KEY (`OperatedByFlightNumber`),
  INDEX `OperatedByAirlineID_idx` (`OperatedByAirlineID` ASC) VISIBLE,
  CONSTRAINT `OperatedByAirlineID`
    FOREIGN KEY (`OperatedByAirlineID`)
    REFERENCES `FlightWebsite`.`Airline` (`AirlineID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `OperatedByFlightNumber`
    FOREIGN KEY (`OperatedByFlightNumber`)
    REFERENCES `FlightWebsite`.`Flights` (`FlightNumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FlightWebsite`.`Owns`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FlightWebsite`.`Owns` ;

CREATE TABLE IF NOT EXISTS `FlightWebsite`.`Owns` (
  `OwnsAirlineID` CHAR(2) NOT NULL,
  `OwnsAircraftID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`OwnsAirlineID`, `OwnsAircraftID`),
  INDEX `AircraftID_idx` (`OwnsAircraftID` ASC) VISIBLE,
  CONSTRAINT `OwnsAircraftID`
    FOREIGN KEY (`OwnsAircraftID`)
    REFERENCES `FlightWebsite`.`Aircrafts` (`AircraftID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `OwnsAirlineID`
    FOREIGN KEY (`OwnsAirlineID`)
    REFERENCES `FlightWebsite`.`Airline` (`AirlineID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FlightWebsite`.`SiteAdmin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FlightWebsite`.`SiteAdmin` ;

CREATE TABLE IF NOT EXISTS `FlightWebsite`.`SiteAdmin` (
  `SiteAdminUsername` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`SiteAdminUsername`),
  CONSTRAINT `SiteAdminUsername`
    FOREIGN KEY (`SiteAdminUsername`)
    REFERENCES `FlightWebsite`.`Employee` (`EmployeeUsername`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FlightWebsite`.`Waitlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FlightWebsite`.`Waitlist` ;

CREATE TABLE IF NOT EXISTS `FlightWebsite`.`Waitlist` (
  `WaitlistUsername` VARCHAR(45) NOT NULL,
  `WaitlistFlightNumber` INT(11) NOT NULL,
  PRIMARY KEY (`WaitlistUsername`, `WaitlistFlightNumber`),
  INDEX `WaitlistFlightNumber_idx` (`WaitlistFlightNumber` ASC) VISIBLE,
  CONSTRAINT `WaitlistFlightNumber`
    FOREIGN KEY (`WaitlistFlightNumber`)
    REFERENCES `FlightWebsite`.`Flights` (`FlightNumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `WaitlistUsername`
    FOREIGN KEY (`WaitlistUsername`)
    REFERENCES `FlightWebsite`.`Customer` (`CustomerUsername`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- --------------------------------------------------------
-- Хост:                         192.168.20.31
-- Версия сервера:               5.5.44-0ubuntu0.14.04.1 - (Ubuntu)
-- ОС Сервера:                   debian-linux-gnu
-- HeidiSQL Версия:              9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Дамп структуры базы данных medical_db
CREATE DATABASE IF NOT EXISTS `medical_db` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `medical_db`;


-- Дамп структуры для таблица medical_db.appointments
CREATE TABLE IF NOT EXISTS `appointments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL DEFAULT '0',
  `date` date NOT NULL,
  `time_interval_id` tinyint(4) NOT NULL,
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_employee` (`employee_id`),
  KEY `FK_appointment_interval` (`time_interval_id`),
  KEY `FK_client` (`client_id`),
  CONSTRAINT `FK_appointment_interval` FOREIGN KEY (`time_interval_id`) REFERENCES `rt_time_interval` (`id`),
  CONSTRAINT `FK_client` FOREIGN KEY (`client_id`) REFERENCES `rt_clients` (`id`),
  CONSTRAINT `FK_employee` FOREIGN KEY (`employee_id`) REFERENCES `rt_employees` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Экспортируемые данные не выделены.


-- Дамп структуры для таблица medical_db.employment
CREATE TABLE IF NOT EXISTS `employment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `employees_id` int(11) NOT NULL DEFAULT '0',
  `time_interval_id` tinyint(4) NOT NULL,
  `availability_id` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_time_interval` (`time_interval_id`),
  KEY `FK_employees` (`employees_id`),
  KEY `FK_availability` (`availability_id`),
  CONSTRAINT `FK_availability` FOREIGN KEY (`availability_id`) REFERENCES `rt_availability` (`id`),
  CONSTRAINT `FK_employees` FOREIGN KEY (`employees_id`) REFERENCES `rt_employees` (`id`),
  CONSTRAINT `FK_time_interval` FOREIGN KEY (`time_interval_id`) REFERENCES `rt_time_interval` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Экспортируемые данные не выделены.


-- Дамп структуры для таблица medical_db.rt_availability
CREATE TABLE IF NOT EXISTS `rt_availability` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `availability` varchar(5) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Экспортируемые данные не выделены.


-- Дамп структуры для таблица medical_db.rt_clients
CREATE TABLE IF NOT EXISTS `rt_clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '0',
  `lastname` varchar(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Экспортируемые данные не выделены.


-- Дамп структуры для таблица medical_db.rt_employees
CREATE TABLE IF NOT EXISTS `rt_employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `lastname` varchar(20) DEFAULT NULL,
  `specialization_id` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_specialization_id` (`specialization_id`),
  CONSTRAINT `FK_specialization_id` FOREIGN KEY (`specialization_id`) REFERENCES `rt_specialization` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Экспортируемые данные не выделены.


-- Дамп структуры для таблица medical_db.rt_specialization
CREATE TABLE IF NOT EXISTS `rt_specialization` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Экспортируемые данные не выделены.


-- Дамп структуры для таблица medical_db.rt_time_interval
CREATE TABLE IF NOT EXISTS `rt_time_interval` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `start` time NOT NULL DEFAULT '00:00:00',
  `end` time NOT NULL DEFAULT '00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Экспортируемые данные не выделены.


-- Дамп структуры для представление medical_db.vt_appointments_info
-- Создание временной таблицы для обработки ошибок зависимостей представлений
CREATE TABLE `vt_appointments_info` (
	`id` INT(11) NOT NULL,
	`date` DATE NOT NULL,
	`employee_name` VARCHAR(20) NULL COLLATE 'utf8_general_ci',
	`employee_lastname` VARCHAR(20) NULL COLLATE 'utf8_general_ci',
	`specialization` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`client_name` VARCHAR(20) NOT NULL COLLATE 'utf8_general_ci',
	`client_lastname` VARCHAR(20) NOT NULL COLLATE 'utf8_general_ci',
	`start_appointment` TIME NOT NULL,
	`end_appointment` TIME NOT NULL
) ENGINE=MyISAM;


-- Дамп структуры для представление medical_db.vt_availability_info
-- Создание временной таблицы для обработки ошибок зависимостей представлений
CREATE TABLE `vt_availability_info` (
	`date` DATE NOT NULL,
	`name` VARCHAR(20) NULL COLLATE 'utf8_general_ci',
	`lastname` VARCHAR(20) NULL COLLATE 'utf8_general_ci',
	`start` TIME NOT NULL,
	`end` TIME NOT NULL,
	`availability` VARCHAR(50) NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;


-- Дамп структуры для представление medical_db.vt_employess_info
-- Создание временной таблицы для обработки ошибок зависимостей представлений
CREATE TABLE `vt_employess_info` (
	`id` INT(11) NOT NULL,
	`name` VARCHAR(20) NULL COLLATE 'utf8_general_ci',
	`lastname` VARCHAR(20) NULL COLLATE 'utf8_general_ci',
	`specialization` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;


-- Дамп структуры для процедура medical_db.add_appointments
DELIMITER //
CREATE DEFINER=`med`@`localhost` PROCEDURE `add_appointments`(IN `employee_id` INT, IN `date` DATE, IN `time_interval_id` INT, IN `client_id` INT)
BEGIN
	INSERT INTO `medical_db`.`appointments` (`employee_id`, `date`, `time_interval_id`, `client_id`) VALUES (employee_id, date, time_interval_id, client_id);
	UPDATE `medical_db`.`employment` SET  `availability_id` = 2 WHERE `employment`.employees_id = employee_id AND `employment`.date = date AND `employment`.time_interval_id = time_interval_id;
END//
DELIMITER ;


-- Дамп структуры для процедура medical_db.search_client
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `search_client`(IN `name` VARCHAR(50), IN `lastname` VARCHAR(50))
BEGIN
	SELECT rt_clients.id FROM rt_clients WHERE rt_clients.name = name AND rt_clients.lastname = lastname;
END//
DELIMITER ;


-- Дамп структуры для процедура medical_db.search_employees
DELIMITER //
CREATE DEFINER=`med`@`localhost` PROCEDURE `search_employees`(IN `specialization_id` INT, IN `time_interval_id` INT, IN `appointments_date` DATE)
BEGIN
	SELECT rt_employees.id, rt_employees.name, rt_employees.lastname
		FROM rt_employees
				join employment 
					On rt_employees.id = employment.employees_id
					AND employment.availability_id = 1 
					AND rt_employees.specialization_id = specialization_id
					AND employment.time_interval_id = time_interval_id
					AND `employment`.`date` = appointments_date;
END//
DELIMITER ;


-- Дамп структуры для представление medical_db.vt_appointments_info
-- Удаление временной таблицы и создание окончательной структуры представления
DROP TABLE IF EXISTS `vt_appointments_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`med`@`localhost` SQL SECURITY DEFINER VIEW `vt_appointments_info` AS select `appointments`.`id` AS `id`,`appointments`.`date` AS `date`,`rt_employees`.`name` AS `employee_name`,`rt_employees`.`lastname` AS `employee_lastname`,`rt_specialization`.`name` AS `specialization`,`rt_clients`.`name` AS `client_name`,`rt_clients`.`lastname` AS `client_lastname`,`rt_time_interval`.`start` AS `start_appointment`,`rt_time_interval`.`end` AS `end_appointment` from ((((`appointments` join `rt_employees` on((`appointments`.`employee_id` = `rt_employees`.`id`))) join `rt_specialization` on((`rt_employees`.`specialization_id` = `rt_specialization`.`id`))) join `rt_clients` on((`appointments`.`client_id` = `rt_clients`.`id`))) join `rt_time_interval` on((`appointments`.`time_interval_id` = `rt_time_interval`.`id`))) order by `appointments`.`date`;


-- Дамп структуры для представление medical_db.vt_availability_info
-- Удаление временной таблицы и создание окончательной структуры представления
DROP TABLE IF EXISTS `vt_availability_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`med`@`localhost` SQL SECURITY DEFINER VIEW `vt_availability_info` AS select `employment`.`date` AS `date`,`rt_employees`.`name` AS `name`,`rt_employees`.`lastname` AS `lastname`,`rt_time_interval`.`start` AS `start`,`rt_time_interval`.`end` AS `end`,`rt_availability`.`description` AS `availability` from (((`employment` join `rt_employees` on((`employment`.`employees_id` = `rt_employees`.`id`))) join `rt_availability` on((`employment`.`availability_id` = `rt_availability`.`id`))) join `rt_time_interval` on((`employment`.`time_interval_id` = `rt_time_interval`.`id`))) order by `employment`.`date`,`rt_employees`.`name`,`rt_time_interval`.`start`;


-- Дамп структуры для представление medical_db.vt_employess_info
-- Удаление временной таблицы и создание окончательной структуры представления
DROP TABLE IF EXISTS `vt_employess_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`med`@`localhost` SQL SECURITY DEFINER VIEW `vt_employess_info` AS select `em`.`id` AS `id`,`em`.`name` AS `name`,`em`.`lastname` AS `lastname`,`rt`.`name` AS `specialization` from (`rt_employees` `em` join `rt_specialization` `rt` on((`em`.`specialization_id` = `rt`.`id`))) order by `em`.`id`;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

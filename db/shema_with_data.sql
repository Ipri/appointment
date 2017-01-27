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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы medical_db.appointments: ~9 rows (приблизительно)
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` (`id`, `employee_id`, `date`, `time_interval_id`, `client_id`) VALUES
	(1, 1, '2017-01-24', 1, 3),
	(2, 5, '2017-01-24', 1, 1),
	(3, 11, '2017-01-25', 6, 4),
	(5, 2, '2017-01-24', 3, 2),
	(6, 9, '2017-01-25', 2, 5),
	(11, 6, '2017-01-29', 5, 4),
	(12, 6, '2017-01-29', 5, 4),
	(13, 6, '2017-01-29', 5, 4),
	(14, 6, '2017-01-29', 5, 4);
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;


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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы medical_db.employment: ~32 rows (приблизительно)
/*!40000 ALTER TABLE `employment` DISABLE KEYS */;
INSERT INTO `employment` (`id`, `date`, `employees_id`, `time_interval_id`, `availability_id`) VALUES
	(6, '2017-01-29', 1, 3, 1),
	(7, '2017-01-29', 1, 1, 1),
	(8, '2017-01-29', 1, 2, 1),
	(9, '2017-01-29', 1, 3, 2),
	(10, '2017-01-29', 1, 4, 2),
	(11, '2017-01-29', 1, 5, 1),
	(12, '2017-01-29', 1, 6, 2),
	(13, '2017-01-29', 1, 7, 2),
	(14, '2017-01-29', 1, 8, 1),
	(15, '2017-01-29', 1, 9, 2),
	(16, '2017-01-29', 1, 10, 1),
	(17, '2017-01-29', 2, 1, 2),
	(18, '2017-01-29', 2, 2, 1),
	(19, '2017-01-29', 2, 3, 2),
	(20, '2017-01-29', 2, 4, 1),
	(21, '2017-01-29', 2, 5, 1),
	(22, '2017-01-29', 2, 6, 1),
	(23, '2017-01-29', 2, 7, 2),
	(24, '2017-01-29', 2, 8, 1),
	(25, '2017-01-29', 2, 9, 1),
	(26, '2017-01-29', 2, 10, 2),
	(27, '2017-01-29', 6, 1, 1),
	(28, '2017-01-29', 6, 2, 2),
	(29, '2017-01-29', 6, 3, 2),
	(30, '2017-01-29', 6, 4, 1),
	(31, '2017-01-29', 6, 5, 2),
	(32, '2017-01-29', 6, 6, 2),
	(33, '2017-01-29', 6, 7, 1),
	(34, '2017-01-29', 6, 8, 2),
	(35, '2017-01-29', 6, 9, 1),
	(36, '2017-01-29', 6, 10, 2),
	(39, '2017-01-30', 6, 2, 1);
/*!40000 ALTER TABLE `employment` ENABLE KEYS */;


-- Дамп структуры для таблица medical_db.rt_availability
CREATE TABLE IF NOT EXISTS `rt_availability` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `availability` varchar(5) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы medical_db.rt_availability: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `rt_availability` DISABLE KEYS */;
INSERT INTO `rt_availability` (`id`, `availability`, `description`) VALUES
	(1, 'true', 'доступен\n'),
	(2, 'false', 'недоступен');
/*!40000 ALTER TABLE `rt_availability` ENABLE KEYS */;


-- Дамп структуры для таблица medical_db.rt_clients
CREATE TABLE IF NOT EXISTS `rt_clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '0',
  `lastname` varchar(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы medical_db.rt_clients: ~5 rows (приблизительно)
/*!40000 ALTER TABLE `rt_clients` DISABLE KEYS */;
INSERT INTO `rt_clients` (`id`, `name`, `lastname`) VALUES
	(1, 'Софья', 'Софина'),
	(2, 'Марфа ', 'Марфина'),
	(3, 'Денис', 'Денисов'),
	(4, 'Тарас', 'Тарасов'),
	(5, 'Киприс', 'Киприсов');
/*!40000 ALTER TABLE `rt_clients` ENABLE KEYS */;


-- Дамп структуры для таблица medical_db.rt_employees
CREATE TABLE IF NOT EXISTS `rt_employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `lastname` varchar(20) DEFAULT NULL,
  `specialization_id` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_specialization_id` (`specialization_id`),
  CONSTRAINT `FK_specialization_id` FOREIGN KEY (`specialization_id`) REFERENCES `rt_specialization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы medical_db.rt_employees: ~12 rows (приблизительно)
/*!40000 ALTER TABLE `rt_employees` DISABLE KEYS */;
INSERT INTO `rt_employees` (`id`, `name`, `lastname`, `specialization_id`) VALUES
	(1, 'Петр', 'Петров', 1),
	(2, 'Иван', 'Иванов', 2),
	(3, 'Виктор', 'Викторов', 3),
	(4, 'Сергей', 'Сергеев', 4),
	(5, 'Дмитрий', 'Дмитриев', 5),
	(6, 'Олег', 'Олегов', 6),
	(7, 'Семен', 'Семенов', 7),
	(8, 'Валентина', 'Валентинова', 8),
	(9, 'Людмила', 'Людмилова', 7),
	(10, 'Татьяна', 'Татьянова', 1),
	(11, 'Ирина', 'Иринова', 4),
	(12, 'Светлана', 'Светланова', 2);
/*!40000 ALTER TABLE `rt_employees` ENABLE KEYS */;


-- Дамп структуры для таблица medical_db.rt_specialization
CREATE TABLE IF NOT EXISTS `rt_specialization` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы medical_db.rt_specialization: ~8 rows (приблизительно)
/*!40000 ALTER TABLE `rt_specialization` DISABLE KEYS */;
INSERT INTO `rt_specialization` (`id`, `name`) VALUES
	(1, 'терапевт'),
	(2, 'отоларинголог'),
	(3, 'хирург'),
	(4, 'гастроэнтеролог'),
	(5, 'венеролог'),
	(6, 'дерматолог'),
	(7, 'невропатолог'),
	(8, 'кардиолог');
/*!40000 ALTER TABLE `rt_specialization` ENABLE KEYS */;


-- Дамп структуры для таблица medical_db.rt_time_interval
CREATE TABLE IF NOT EXISTS `rt_time_interval` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `start` time NOT NULL DEFAULT '00:00:00',
  `end` time NOT NULL DEFAULT '00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы medical_db.rt_time_interval: ~10 rows (приблизительно)
/*!40000 ALTER TABLE `rt_time_interval` DISABLE KEYS */;
INSERT INTO `rt_time_interval` (`id`, `start`, `end`) VALUES
	(1, '08:00:00', '08:50:00'),
	(2, '09:00:00', '09:50:00'),
	(3, '10:00:00', '10:50:00'),
	(4, '11:00:00', '11:50:00'),
	(5, '13:00:00', '13:50:00'),
	(6, '14:00:00', '14:50:00'),
	(7, '15:00:00', '15:50:00'),
	(8, '16:00:00', '16:50:00'),
	(9, '17:00:00', '17:50:00'),
	(10, '18:00:00', '18:50:00');
/*!40000 ALTER TABLE `rt_time_interval` ENABLE KEYS */;


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
	INSERT INTO `appointments` (`employee_id`, `date`, `time_interval_id`, `client_id`) VALUES (employee_id, date, time_interval_id, client_id);
	UPDATE `employment` SET  `availability_id` = 2 WHERE `employment`.employees_id = employee_id AND `employment`.date = date AND `employment`.time_interval_id = time_interval_id;
END//
DELIMITER ;


-- Дамп структуры для процедура medical_db.search_client
DELIMITER //
CREATE DEFINER=`med`@`localhost` PROCEDURE `search_client`(IN `name` VARCHAR(50), IN `lastname` VARCHAR(50))
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

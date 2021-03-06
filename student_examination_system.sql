CREATE DATABASE IF NOT EXISTS `student_examination_system` DEFAULT CHARSET UTF8 COLLATE UTF8_GENERAL_CI ;
USE `student_examination_system` ;

DROP TABLE IF EXISTS `student` ;

CREATE TABLE `student` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(10) NOT NULL,
    `age` INT NOT NULL,
    `sex` CHAR DEFAULT '男',
    `class_id` INT NOT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8;

INSERT INTO `student` VALUES(20190101,'张三一',18,'男',1),
(NULL,'张三二',18,'男',2),(NULL,'张三三',18,'女',1),
(NULL,'张三四',18,'男',2),(NULL,'张三五',17,'女',1);

DROP TABLE IF EXISTS `teacher`;

CREATE TABLE `teacher` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(10) NOT NULL,
    `subject_id` INT
);

INSERT INTO `teacher` VALUES(1001,'刘昊然',2002),
(NULL,'井柏然',2001),
(NULL,'倪妮',2003),
(NULL,'宋佳',2003);

DROP TABLE IF EXISTS `subject`;

CREATE TABLE `subject` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(10) NOT NULL`score``student`
);

INSERT INTO `subject` VALUES(2001,'语文'),(NULL,'数学'),(NULL,'英语');

DROP TABLE IF EXISTS `class`;

CREATE TABLE `class` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(10) NOT NULL
);

INSERT INTO `class` VALUES(1,'一班'),(2,'二班');

DROP TABLE IF EXISTS `score`;

CREATE TABLE `score` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `teacher_id` INT,
    `student_id` INT,
    `score` FLOAT NOT NULL
);

INSERT INTO `score` VALUES(NULL,1001,20190101,88),(NULL,1001,20190102,81),(NULL,1001,20190103,92),(NULL,1001,20190104,85),(NULL,1001,20190105,98),
(NULL,1002,20190101,78),(NULL,1002,20190102,84),(NULL,1002,20190103,82),(NULL,1002,20190104,80),(NULL,1002,20190105,93),
(NULL,1003,20190101,84),(NULL,1004,20190102,85),(NULL,1003,20190103,90),(NULL,1004,20190104,95),(NULL,1003,20190105,96);


DROP TABLE IF EXISTS admin;
CREATE TABLE admin(
id INT PRIMARY KEY AUTO_INCREMENT,
`user` VARCHAR(50) NOT NULL,
 `password` VARCHAR(50) NOT NULL);
 
 INSERT INTO admin VALUES(NULL,'admin','123');
 


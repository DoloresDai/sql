CREATE DATABASE IF NOT EXISTS `students` ;
USE `students`;
DROP TABLE IF EXISTS `student`;
CREATE TABLE  `student`(
`id` INT ,
`name` VARCHAR(10) ,
`age` INT ,
`sex` VARCHAR(2)
);
ALTER TABLE student MODIFY COLUMN id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE student MODIFY COLUMN `name` VARCHAR(10) NOT NULL;
ALTER TABLE student MODIFY COLUMN sex VARCHAR(1) DEFAULT '男';



INSERT  INTO `student` VALUES
(NULL,'张三',18,'男'),
(NULL,'李四',20,'女');
SELECT * FROM `student`;


DROP TABLE IF EXISTS `subject`;
CREATE TABLE `subject`(
`id` INT ,
`subject` VARCHAR(10) ,
`teacher` VARCHAR(10) ,
`description` VARCHAR(20) 
);

ALTER TABLE `subject` MODIFY COLUMN id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE `subject` MODIFY COLUMN `subject` VARCHAR(10) NOT NULL UNIQUE;
ALTER TABLE `subject` MODIFY COLUMN teacher VARCHAR(10) NOT NULL;

INSERT INTO `subject` VALUES
(1001,'语文','王老师','本次考试比较简单'),
(NULL,'数学','刘老师','本次考试比较难');
SELECT  * FROM `subject`;

DROP TABLE IF EXISTS `score`;
CREATE TABLE `score`(
`id` INT ,
`student_id` INT ,
`subject_id` INT ,
`score` DOUBLE 
);

ALTER TABLE score MODIFY COLUMN id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE score ADD FOREIGN KEY(student_id) REFERENCES student(id);
ALTER TABLE score ADD FOREIGN KEY(subject_id) REFERENCES `subject`(id);

INSERT INTO `score` VALUES
(NULL,1,1001,80),
(NULL,2,1002,60),
(NULL,1,1001,70),
(NULL,2,1002,60.5);
SELECT  * FROM `score`;

SHOW INDEX FROM score; 

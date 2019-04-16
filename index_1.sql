CREATE DATABASE IF NOT EXISTS `students` ;
USE `students`;
DROP TABLE IF EXISTS `student`;
CREATE TABLE  `student`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(10) NOT NULL,
`age` INT NOT NULL,
`sex` VARCHAR(2) DEFAULT '男'
);

INSERT  INTO `student` VALUES
('1','张三',18,'男'),
('2','李四',20,'女');
SELECT * FROM `student`;


DROP TABLE IF EXISTS `subject`;
CREATE TABLE `subject`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`subject` VARCHAR(10) NOT NULL UNIQUE,
`teacher` VARCHAR(10) NOT NULL,
`description` VARCHAR(20) 
);

INSERT INTO `subject` VALUES
('1001','语文','王老师','本次考试比较简单'),
('1002','数学','刘老师','本次考试比较难');
SELECT  * FROM `subject`;

DROP TABLE IF EXISTS `score`;
CREATE TABLE `score`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`student_id` INT NOT NULL,
`subject_id` INT NOT NULL,
`score` DOUBLE NOT NULL,
CONSTRAINT fk_student_score FOREIGN KEY(student_id) REFERENCES student(id),
CONSTRAINT fk_subject_score FOREIGN KEY(subject_id) REFERENCES `subject`(id)
);

INSERT INTO `score` VALUES
(1,'1','1001',80),
(2,'2','1002',60),
(3,'1','1001',70),
(4,'2','1002',60.5);
SELECT  * FROM `score`;

SHOW INDEX FROM score; 

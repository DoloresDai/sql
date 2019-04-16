CREATE DATABASE IF NOT EXISTS `searchData`  DEFAULT CHARSET UTF8 COLLATE UTF8_GENERAL_CI ;
USE `searchData`;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores(
`id` INT NOT NULL,
`name` VARCHAR(10) NOT NULL,
`subject` VARCHAR(10) NOT NULL,
`score` FLOAT NOT NULL
);

INSERT INTO scores VALUES
(1,'张三','语文',80),
(2,'李四','语文',90),
(3,'王五','语文',60),
(4,'王胖子','数学',59),
(5,'张王五','英语',59.9),
(6,'吴彦祖','英语',99.9),
(7,'郭德纲','数学',100),
(8,'郭敬明','数学',99),
(9,'郭靖','英语',70);

-- 查找科目为语文的所有学生及成绩
SELECT `name`,`score` FROM scores WHERE `subject`='语文';
-- 查找科目为语文的所有学生，按照成绩从高到低排列
SELECT `name` FROM scores WHERE `subject`='语文' ORDER BY score DESC;
-- 查找科目为语文的成绩最高的学生
SELECT `name` FROM scores WHERE `subject`='语文' ORDER BY score DESC LIMIT 1 ,1;
-- 查找姓郭的学生中数学学得最好的一位
SELECT `name` FROM scores WHERE `name` LIKE '郭%' AND `subject`='数学' ORDER BY score DESC LIMIT 1 , 1;
-- 查找学生总名字中带'王'并且’王‘字位于名字的第二位的学生成绩
SELECT `score` FROM scores WHERE `name` LIKE '_王%';


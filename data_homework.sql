CREATE DATABASE IF NOT EXISTS data_homework DEFAULT CHARSET UTF8 COLLATE UTF8_GENERAL_CI ;
USE data_homework;
DROP TABLE IF EXISTS student;
CREATE TABLE student(
id INT NOT NULL,
`name` VARCHAR(10) NOT NULL,
age INT NOT NULL,
Sex VARCHAR(1) NOT NULL) ;

INSERT INTO student VALUES
(1,'张三',18,'女'),
(2,'李四',20,'男'),
(3,'王五',20,'女');
SELECT * FROM student;

-- 修改id为1的学生名字为小花，性别为女。 
UPDATE student SET `name` = '小花' WHERE id = 1;
SELECT * FROM student;

-- 删除年龄为20岁并且性别为女的学生。
DELETE FROM student WHERE age = 20 AND Sex = '女';
SELECT * FROM student;

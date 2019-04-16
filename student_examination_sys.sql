CREATE DATABASE IF NOT EXISTS `student_examination_sys` DEFAULT CHARSET UTF8 COLLATE UTF8_GENERAL_CI ;

USE `student_examination_sys` ;

DROP TABLE IF EXISTS `student` ;

CREATE TABLE `student` (
  `id` VARCHAR (3) NOT NULL,
  `name` VARCHAR (10) NOT NULL,
  `age` INT NOT NULL,
  `sex` VARCHAR (2) NOT NULL
) ENGINE = INNODB DEFAULT CHARSET = UTF8 ;

INSERT INTO `student` 
VALUES
  ('001', '张三', 18, '男'),
  ('002', '李四', 20, '女'),
  ('003', '王五', 21, '男'),
  ('004', '赵六', 19, '男'),
  ('006', '春喜', 17, '女'),
  ('007', '夏依', 17, '女') ;

SELECT 
  * 
FROM
  `student` ;

DROP TABLE IF EXISTS `subject` ;

CREATE TABLE `subject` (
  `id` VARCHAR (4) NOT NULL,
  `subject` VARCHAR (10) NOT NULL,
  `teacher` VARCHAR (10) NOT NULL,
  `description` VARCHAR (20) NOT NULL
) ENGINE = INNODB DEFAULT CHARSET = UTF8 ;

INSERT INTO `subject` 
VALUES
  (
    '1001',
    '语文',
    '王老师',
    '本次考试比较简单'
  ),
  (
    '1002',
    '数学',
    '刘老师',
    '本次考试比较难'
  ) ;

SELECT 
  * 
FROM
  `subject` ;

DROP TABLE IF EXISTS `score` ;

CREATE TABLE `score` (
  `id` INT NOT NULL,
  `student_id` VARCHAR (3) NOT NULL,
  `subject_id` VARCHAR (4) NOT NULL,
  `score` DOUBLE NOT NULL
) ;

INSERT INTO `score` 
VALUES
  (1, '001', '1001', 90),
  (2, '002', '1001', 60),
  (3, '003', '1001', 70),
  (4, '004', '1001', 88),
  (5, '005', '1001', 62),
  (6, '006', '1001', 59),
  (7, '001', '1002', 70),
  (8, '002', '1002', 60.5),
  (9, '003', '1002', 76),
  (10, '004', '1002', 82),
  (11, '005', '1002', 54),
  (12, '006', '1002', 89) ;

SELECT 
  * 
FROM
  `score` ;

#查询语文成绩的最高分。
#第一种 
SELECT 
  MAX(score) AS 语文成绩最高分 
FROM
  score 
WHERE `subject_id` = 
  (SELECT 
    `id` 
  FROM
    `subject` 
  WHERE `subject` = '语文') ;
  
#第二种 
SELECT 
  MAX(score) AS 语文成绩最高分 
FROM
  score AS s,
  `subject` AS sub 
WHERE s.subject_id = sub.id 
  AND `subject` = '语文' ;

#第三种 
SELECT 
  MAX(score) AS 语文成绩最高分 
FROM
  score AS s 
  INNER JOIN `subject` AS sub 
    ON s.subject_id = sub.id 
WHERE sub.subject = '语文' ;

#查询语文成绩的平均分和所有成绩的平均分 

SELECT 
  AVG(score) AS 所有成绩平均分,
  (SELECT 
    AVG(score) 
  FROM
    score AS s,
    `subject` AS sub 
  WHERE s.subject_id = sub.id 
    AND sub.`subject` = '语文') AS 语文平均分 
FROM
  score ;

#查询学生为张三的数学成绩。 
#第一种
SELECT 
  score AS 张三数学成绩 
FROM
  score 
WHERE student_id = 
  (SELECT 
    id 
  FROM
    student 
  WHERE `name` = '张三') 
  AND `subject_id` = 
  (SELECT 
    id 
  FROM
    `subject` 
  WHERE `subject` = '数学') ;

#第二种
SELECT 
  score AS 张三数学成绩
FROM
  (SELECT 
    score,
    s.student_id 
  FROM
    score AS s 
    INNER JOIN `subject` AS sub 
      ON s.`subject_id` = sub.id 
  WHERE sub.`subject` = '数学') AS a 
  INNER JOIN `student` AS stu 
    ON a.student_id = stu.id 
WHERE stu.`name` = '张三' ;

#查询刘老师带的科目的平均分和最高分。
#第一种 
SELECT 
  AVG(score) AS 平均分,
  MAX(score) AS 最高分 
FROM
  score AS s 
  INNER JOIN `subject` AS sub 
    ON s.subject_id = sub.id 
WHERE sub.teacher = '刘老师' ;

#第二种 
SELECT 
  AVG(score) AS 平均分,
  MAX(score) AS 最高分 
FROM
  score AS s 
WHERE s.subject_id = 
  (SELECT 
    id 
  FROM
    `subject` 
  WHERE teacher = '刘老师') ;

#对男生和女生进行分组，求其平均分。 
SELECT 
  sex AS 性别,
  AVG(score) AS 平均分 
FROM
  score AS s 
  INNER JOIN student AS stu 
    ON s.student_id = stu.id 
GROUP BY sex ;


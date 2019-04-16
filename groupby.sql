分组过滤的几点异同
语法
SELECT 分组函数，查询字段，
FROM 表
WHERE 筛选条件
GROUP BY 分组的字段
ORDER BY 排序的字段
HAVING 分组函数的筛选条件

特点：
1. GROUP BY后跟分组函数查询的字段
2. 分组可以按单个字段也可以多个字段

CREATE DATABASE IF NOT EXISTS students DEFAULT CHARSET UTF8 COLLATE UTF8_GENERAL_CI ;
USE students;
DROP TABLE IF EXISTS student_info;
CREATE TABLE student_info(
`name` VARCHAR(10) NOT NULL,
id INT NOT NULL,
class_id INT NOT NULL,
chinese_score FLOAT NOT NULL
);

INSERT INTO student_info VALUES ('张三',1,1,98),('李四',2,1,89),('王五',3,1,56),('代',4,1,78),
('开发',5,2,96),('大彻',6,2,76),('到底',7,2,46),
('隔热片',8,3,78),('功夫',9,3,85),('粉丝',10,3,91),
('丰富',11,4,82),('废惹',12,4,77),('大大',13,4,76),
('光荣',14,5,95),('分隔',15,5,72),('苹果',16,5,86);
SELECT * FROM student_info;

查询班级id为1和2的学生的总个数
SELECT COUNT(*) AS 总数,class_id AS 班级
FROM student_info
WHERE class_id IN(1,2)
GROUP BY 班级;

查询每个班级语文成绩及格（分数>60）学生成绩的平均数
SELECT class_id AS 班级,ROUND(AVG(chinese_score),2) AS 语文成绩平均数
FROM student_info
WHERE chinese_score > 60
GROUP BY 班级

SELECT class_id AS 班级,ROUND(AVG(chinese_score),2) AS 原始语文成绩平均数
FROM student_info
GROUP BY 班级

查询语文成绩平均分大于75的班级
SELECT class_id AS 班级,ROUND(AVG(chinese_score),2) AS 语文成绩平均分
FROM student_info
GROUP BY 班级
HAVING 语文成绩平均分 > 75;
查询每个班级的语文成绩最高分>90的班级，并按照降序排序
SELECT class_id AS 班级,MAX(chinese_score) AS 最高分
FROM student_info
GROUP BY 班级
HAVING 最高分 > 90
ORDER BY 最高分 DESC;
查询id>1的学生的个数
SELECT COUNT(*) AS 学生个数,
FROM student_info
WHERE id > 1
GROUP BY id;
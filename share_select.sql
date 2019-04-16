CREATE DATABASE IF NOT EXISTS `student_info` DEFAULT CHARSET UTF8 COLLATE UTF8_GENERAL_CI ;

USE `student_info` ;

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
  ('005', '春喜', 17, '女'),
  ('006', '夏依', 17, '女') ;

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

/*
关于高级查询的背景介绍
连接查询
笛卡尔现象：查询时没有有效连接时，出现的m*n行数据结果
*/


# 查询score中每行数据的老师姓名
#笛卡尔现象代码：
SELECT 
  s.id as 科目,
  sub.teacher as 老师
FROM
  score as s, 
  SUBJECT AS sub ;

#建立有效连接后的代码
SELECT 
  sub.id,
  sub.teacher 
FROM
  score AS s,
  SUBJECT AS sub 
WHERE sub.id = s.subject_id ;

/*
 分类：

	按年代分类：
	sql92标准:仅仅支持内连接
	sql99标准【推荐】：支持内连接+外连接（左外和右外）+交叉连接
	
	按功能分类：
		内连接：
			等值连接
			非等值连接
			自连接
		外连接：
			左外连接
			右外连接
			全外连接
		
		交叉连接
 */
#一、sql92标准
#1、等值连接
/*
① 多表等值连接的结果为多表的交集部分
②n表连接，至少需要n-1个连接条件
③ 多表的顺序没有要求
④一般需要为表起别名
⑤可以搭配前面介绍的所有子句使用，比如排序、分组、筛选
*/
#之前的案例，就是一个等值连接
SELECT 
  sub.id,
  sub.teacher 
FROM
  score AS s,
  SUBJECT AS sub 
WHERE sub.id = s.subject_id ;

#为表起别名
/*
①提高语句的简洁度
②区分多个重名的字段

注意：如果为表起了别名，则查询的字段就不能使用原来的表名去限定
*/


#可以使用AND关键字增加筛选
#查询score表中的学生姓名，并且学生年龄要大于18
SELECT 
  score,
  stu.name,
  stu.age 
FROM
  score AS s,
  student AS stu 
WHERE s.student_id = stu.id 
  AND stu.age > 18 ;

#可以使用分组查询、排序
#查询每个科目保留两位小数的平均分，按照降序排列
SELECT 
  ROUND(AVG(score), 2) AS 平均分,
  sub.subject AS 科目 
FROM
  score AS s,
  SUBJECT AS sub 
WHERE s.subject_id = sub.id 
GROUP BY 科目
ORDER BY 平均分 DESC ;

#可以三表连接
#查询每个科目保留两位小数的平均分（要求：学生成绩及格的），按照降序排列
SELECT 
  ROUND(AVG(score), 2) AS 平均分,
  sub.subject AS 科目 
FROM
  score AS s,
  SUBJECT AS sub,
  student AS stu 
WHERE s.subject_id = sub.id 
  AND s.student_id = stu.id 
  AND s.score >= 60 
GROUP BY sub.subject 
ORDER BY 平均分 DESC ;

#2、非等值连接
DROP TABLE IF EXISTS `levels` ;

CREATE TABLE `levels` (
  low INT NOT NULL,
  high INT NOT NULL,
  LEVEL VARCHAR (1) NOT NULL
) ;

INSERT INTO `levels` 
VALUES
  (0, 60, 'D'),
  (61, 70, 'C'),
  (71, 80, 'B'),
  (81, 100, 'A') ;

SELECT 
  * 
FROM
  `levels` ;

#查询每个学生具体成绩的等级
SELECT 
  s.score,
  l.level 
FROM
  score AS s,
  levels AS l 
WHERE s.score BETWEEN l.low 
  AND l.high ;

#自连接
#挑选出语文成绩高于数学成绩的学生
SELECT 
  s1.student_id,
  s1.score AS 语文,
  s2.score AS 数学 
FROM
  score AS s1,
  score AS s2 
WHERE s1.student_id = s2.student_id 
  AND s1.score > s2.score ;

#二、sql99语法
/*
语法：
	select 查询列表
	from 表1 别名 【连接类型】
	join 表2 别名 
	on 连接条件
	【where 筛选条件】
	【group by 分组】
	【having 筛选条件】
	【order by 排序列表】
	

连接类型分类：
内连接（★）：inner
外连接
	左外(★):left 【outer】
	右外(★)：right 【outer】
交叉连接：cross 

*/
#一）内连接
/*
语法：

select 查询列表
from 表1 别名
inner join 表2 别名
on 连接条件;

分类：
等值
非等值
自连接

特点：
①添加排序、分组、筛选
②inner可以省略
③ 筛选条件放在where后面，连接条件放在on后面，提高分离性，便于阅读
④inner join连接和sql92语法中的等值连接效果是一样的，都是查询多表的交集

*/
#1、等值连接
#查询score中的老师
SELECT 
  sub.id,
  sub.teacher 
FROM
  score AS s 
  INNER JOIN `SUBJECT` AS sub 
    ON sub.id = s.subject_id ;

#可以使用AND关键字增加筛选
#查询score表中的学生姓名，并且学生年龄要大于18
SELECT 
  score,
  stu.name,
  stu.age 
FROM
  score AS s,
  student AS stu 
WHERE s.student_id = stu.id 
  AND stu.age > 18 ;

SELECT 
  score,
  stu.name,
  stu.age 
FROM
  score AS s 
  INNER JOIN student AS stu 
    ON s.student_id = stu.id 
WHERE stu.age > 18 ;

#可以使用分组查询、排序
#查询每个科目保留两位小数的平均分，按照降序排列
SELECT 
  ROUND(AVG(score), 2) AS 平均分,
  sub.subject AS 科目 
FROM
  score AS s,
  SUBJECT AS sub 
WHERE s.subject_id = sub.id 
GROUP BY sub.subject 
ORDER BY 平均分 DESC ;

SELECT 
  ROUND(AVG(score), 2) AS 平均分,
  sub.subject AS 科目 
FROM
  score AS s 
  INNER JOIN SUBJECT AS sub 
    ON s.subject_id = sub.id 
GROUP BY sub.subject 
ORDER BY 平均分 DESC ;

#可以三表连接
#查询每个科目保留两位小数的平均分（要求：学生成绩及格的），按照降序排列
SELECT 
  ROUND(AVG(score), 2) AS 平均分,
  sub.subject AS 科目 
FROM
  score AS s,
  SUBJECT AS sub,
  student AS stu 
WHERE s.subject_id = sub.id 
  AND s.student_id = stu.id 
  AND s.score >= 60 
GROUP BY sub.subject 
ORDER BY 平均分 DESC ;

SELECT 
  ROUND(AVG(score), 2) AS 平均分,
  sub.subject AS 科目 
FROM
  score AS s 
  INNER JOIN SUBJECT AS sub 
    ON s.subject_id = sub.id 
  INNER JOIN student AS stu 
    ON s.student_id = stu.id 
    where s.score >= 60 
GROUP BY sub.subject 
ORDER BY 平均分 DESC ;

#2、非等值连接
DROP TABLE IF EXISTS `levels` ;

CREATE TABLE `levels` (
  low INT NOT NULL,
  high INT NOT NULL,
  LEVEL VARCHAR (1) NOT NULL
) ;

INSERT INTO `levels` 
VALUES
  (0, 60, 'D'),
  (61, 70, 'C'),
  (71, 80, 'B'),
  (81, 100, 'A') ;

SELECT 
  * 
FROM
  `levels` ;

#查询每个学生具体成绩的等级
SELECT 
  s.score,
  l.level 
FROM
  score AS s,
  levels AS l 
WHERE s.score BETWEEN l.low 
  AND l.high ;

SELECT 
  s.score,
  l.level 
FROM
  score AS s 
  INNER JOIN levels AS l 
    ON s.score BETWEEN l.low 
    AND l.high ;

#自连接
#挑选出语文成绩高于数学成绩的学生
SELECT 
  s1.student_id,
  s1.score AS 语文,
  s2.score AS 数学 
FROM
  score AS s1,
  score AS s2 
WHERE s1.student_id = s2.student_id 
  AND s1.score > s2.score ;

SELECT 
  s1.student_id,
  s1.score AS 语文,
  s2.score AS 数学 
FROM
  score AS s1 
  INNER JOIN score AS s2 
    ON s1.student_id = s2.student_id 
WHERE s1.score > s2.score ;

#二、外连接
/*
 应用场景：用于查询一个表中有，另一个表没有的记录
 
 特点：
 1、外连接的查询结果为主表中的所有记录
	如果从表中有和它匹配的，则显示匹配的值
	如果从表中没有和它匹配的，则显示null
	外连接查询结果=内连接结果+主表中有而从表没有的记录
 2、左外连接，left join左边的是主表
    右外连接，right join右边的是主表
 3、左外和右外交换两个表的顺序，可以实现同样的效果 

 */
UPDATE 
  score 
SET
  student_id = '007' 
WHERE student_id = '001' ;
#左外连接 score主表
SELECT 
  * 
FROM
  score AS s 
  LEFT OUTER JOIN student AS stu 
    ON stu.id = s.student_id 
WHERE score > 85 ;

#右外连接 score主表
SELECT 
  * 
FROM
  student AS stu 
  RIGHT OUTER JOIN score AS s 
    ON stu.id = s.student_id 
WHERE score > 85 ;

#左外连接 student主表
SELECT 
  * 
FROM
  student AS stu 
  LEFT OUTER JOIN score AS s 
    ON stu.id = s.student_id 
WHERE score > 85 ;

#右外连接 student主表
SELECT 
  * 
FROM
  score AS s 
  RIGHT OUTER JOIN student AS stu 
    ON stu.id = s.student_id 
WHERE score > 85 ;

#交叉连接
SELECT 
  * 
FROM
  score AS s 
  CROSS JOIN student AS stu ;


#sql92和 sql99pk
/*
 功能：sql99支持的较多
 可读性：sql99实现连接条件和筛选条件的分离，可读性较高
 */
#子查询
/*
含义：
出现在其他语句中的select语句，称为子查询或内查询
外部的查询语句，称为主查询或外查询

分类：
按子查询出现的位置：
	select后面：
		仅仅支持标量子查询
	
	from后面：
		支持表子查询
	where或having后面：★
		标量子查询（单行） √
		列子查询  （多行） √
		
		行子查询
		
	exists后面（相关子查询）
		表子查询
按结果集的行列数不同：
	标量子查询（结果集只有一行一列）
	列子查询（结果集只有一列多行）
	行子查询（结果集有一行多列）
	表子查询（结果集一般为多行多列）



*/
#一、where或having后面
/*
1、标量子查询（单行子查询）
2、列子查询（多行子查询）

3、行子查询（多列多行）

特点：
①子查询放在小括号内
②子查询一般放在条件的右侧
③标量子查询，一般搭配着单行操作符使用
> < >= <= = <>

列子查询，一般搭配着多行操作符使用
in、any/some、all

④子查询的执行优先于主查询执行，主查询的条件用到了子查询的结果

*/
#1.标量子查询★
#查询语文成绩比春喜高的学生清单
#先找春喜的语文成绩
UPDATE 
  score 
SET
  student_id = '001' 
WHERE student_id = '007' ;

SELECT 
  score 
FROM
  score AS s 
  INNER JOIN student AS stu 
    ON s.student_id = stu.id 
WHERE stu.name = '春喜' 
  AND s.subject_id = '1001' ;

# 再找成绩比春喜高的学生
SELECT 
  score AS 语文,
  stu.name 
FROM
  score s 
  INNER JOIN student AS stu 
    ON s.student_id = stu.id 
WHERE s.subject_id = '1001' 
  AND score > 
  (SELECT 
    score 
  FROM
    score AS s 
    INNER JOIN student AS stu 
      ON s.student_id = stu.id 
  WHERE stu.name = '春喜' 
    AND s.subject_id = '1001') ;
    
    
#查询学生两科目平均分低于整体平均分的人
#先查询平均分
SELECT 
  AVG(score) 
FROM
  score AS s 
  INNER JOIN student AS stu 
    ON s.student_id = stu.id ;
    
#支持分组及排序查询
#再查询小于平均分的学生
SELECT 
  AVG(score) AS 平均分,
  stu.name 
FROM
  score AS s 
  INNER JOIN student AS stu 
    ON s.student_id = stu.id 
GROUP BY stu.name 
HAVING AVG(score) < 
  (SELECT 
    AVG(score) 
  FROM
    score )
    order by score desc;

#2.列子查询（多行子查询）★
#查询编号为学生为李四和王五的数学成绩
SELECT 
    stu.id, stu.name, score AS 数学
FROM
    score AS s
        INNER JOIN
    student AS stu ON s.student_id = stu.id
WHERE
    s.subject_id = '1002'
        AND stu.id IN (SELECT 
            id
        FROM
            student
        WHERE
            name IN ('李四' , '王五'));

#3、行子查询（结果集一行多列或多行多列）
#查询 编号最大的最高成绩
UPDATE 
  score 
SET
  score = 100 
WHERE id = 12 ;

SELECT 
  * 
FROM
  score ;

SELECT 
  score 
FROM
  score 
WHERE (id, score) = 
  (SELECT 
    MAX(id),
    MAX(score) 
  FROM
    score) ;

#二、select后面
/*
仅仅支持标量子查询
*/
#查询及格的学生总个数
SELECT 
  COUNT(*) 
FROM
  score AS s 
  INNER JOIN student AS stu 
    ON s.student_id = stu.id 
WHERE s.score >= 60 ;

SELECT 
  (SELECT 
    COUNT(*) 
  FROM
    score AS s 
    INNER JOIN student AS stu 
      ON s.student_id = stu.id 
  WHERE s.score >= 60) AS 学生及格总数 ;

#三、from后面
/*
将子查询结果充当一张表，要求必须起别名
*/
#查询每个老师下的及格学生个数
SELECT 
    COUNT(*) AS `mount`, sub.teacher, sub.id AS 科目
FROM
    score AS s
        INNER JOIN
    SUBJECT AS sub ON sub.id = s.subject_id
        INNER JOIN
    student AS stu ON s.student_id = stu.id
WHERE
    s.score >= 60
GROUP BY sub.id;

SELECT 
    sa.teacher AS 老师, sa.mount AS 及格数
FROM
    (SELECT 
        COUNT(*) AS `mount`, sub.teacher, sub.id AS 科目
    FROM
        score AS s
    INNER JOIN SUBJECT AS sub ON sub.id = s.subject_id
    INNER JOIN student AS stu ON s.student_id = stu.id
    WHERE
        s.score >= 60
    GROUP BY sub.id) AS sa;

#四、exists后面（相关子查询）
/*
语法：
exists(完整的查询语句)
结果：
1或0
*/
#查询是否存在不及格的学生
SELECT 
    EXISTS( SELECT 
            s.id
        FROM
            score AS s
        WHERE
            score < 60) AS 是否不及格;

#联合查询
/*
union 联合 合并：将多条查询语句的结果合并成一个结果

语法：
查询语句1
union
查询语句2
union
...


应用场景：
要查询的结果来自于多个表，且多个表没有直接的连接关系，但查询的信息一致时

特点：★
1、要求多条查询语句的查询列数是一致的！
2、要求多条查询语句的查询的每一列的类型和顺序最好一致
3、union关键字默认去重，如果使用union all 可以包含重复项

*/
# 查询编号为001的学生姓名和编号为1001的科目
SELECT 
    *
FROM
    student AS stu
WHERE
    id = '001' 
UNION SELECT 
    *
FROM
    SUBJECT AS sub
WHERE
    id = '1001';


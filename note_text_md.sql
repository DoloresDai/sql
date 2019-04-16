//LENGTH() 获取参数的字节数
SELECT LENGTH('Dolores');
//3
SELECT LENGTH('代元丽');
//9 
SHOW VARIABLES LIKE '%char%';


//CONCAT() 连接参数
//当参数中有一个为NULL时，则结果显示为NULL
SELECT CONCAT('abc',NULL);
//NULL
SELECT CONCAT('abc','a',1);
//abca1
SELECT CONCAT('I','-','am','-','Dolores.');
//I-am-Dolores.

//CONCAT_WS 指定连接符的连接函数
SELECT CONCAT_WS('-','I','am','Dolores.');
//I-am-Dolores.

//衍生一下SQL中的‘+’
不同于java中的‘+’，可以当作字符串的连接符，SQL中仅用作数值计算符
当‘+’连接的字符中全部都是数值时，则计算出他们相加后的结果
SELECT 79+90;
//169
当‘+’连接的字符中有一个是数值，另一个不是NULL的可转换成数值的字符，则计算他们转换后的结果
SELECT 79+'90'
//169
当‘+’连接的字符中，有一个是数值，但有不可转换的字符，则将不可转换字符按0处理，并计算他们相加后的结果
SELECT 79+'a';
//79
当‘+’连接的字符中存在一个NULL，则结果为NULL
SELECT 79+NULL;
//NULL


//SUBSTR / SUBSTRING 截取字符串的函数,SQL中的索引值从1开始而不是0开始
SELECT SUBSTR('abc',1);
//截取从指定位置之后的所有字符
//abc
SELECT SUBSTR('abc' FROM 1);
//重载的第二种形式，同上
//abc
SELECT SUBSTR('abc',1,1);
//截取从指定位置开始的指定长度的字符
//a

INSTR 获取指定字符串的索引值
SELECT INSTR('abc','b');
//2

LTRIM 删除字符串左边的空格
SELECT LENGTH(LTRIM('     abc    '));
//7

RTRIM 删除字符串右边的空格
SELECT LENGTH(RTRIM('     abc    '));
//8

TRIM 删除字符串两边的空格
SELECT LENGTH(TRIM('     abc    '));
//3

LPAD 在字符串左边填充指定字符
SELECT LPAD('bbbb',7,'a');
//当指定长度大于原字符串长度，则填充长度相减的指定字符
//aaabbbb
SELECT LPAD('bbbb',4,'a');
//当指定长度等于原字符串长度，则不填充
SELECT LPAD('bbbb',3,'a');
//当指定长度小于原字符串长度，则消减原字符串
//bbb

RPAD 在字符串右边填充指定字符
//同上

LEFT 获取从字符串左边开始的字符串
SELECT LEFT('abcdefg',2);
//ab

RIGHT 获取从字符串右边开始的字符串
SELECT RIGHT('abcdefg',2);
//fg

UPPER 将字符串统一转换成大写
LOWER 将字符串统一转换成小写
SELECT CONCAT(UPPER('d'),LOWER('YUANli'));
//Dyuanli

REPLACE 替换字符串
SELECT REPLACE('babababab','a','b');
//将a字符全部替换成b字符
//bbbbbbbbb

日期函数

NOW 返回当前日期和时间的函数
SELECT NOW();
//2019-03-26 11:53:38

CURDATE 返回当前日期
SELECT CURDATE();
//2019-03-26

CURTIME 返回当前时间
SELECT CURTIME();
//11:55:58

可以获取指定的部分，年、月、日、小时、分钟、秒
SELECT YEAR(NOW());
//2019
SELECT MONTH(NOW());
//3
SELECT MONTHNAME(NOW());
//March
SELECT DAY(NOW());
//26
SELECT HOUR(NOW());
//11
SELECT MINUTE(NOW());
//58
SELECT SECOND(NOW());
//4

DATEDIFF 返回两个日期之间的天数
SELECT DATEDIFF(NOW(),'2019-1-1');
//84

DATE_ADD 给日期添加指定的时间间隔
SELECT DATE_ADD('2019-1-1',INTERVAL 84 DAY);
//2019-03-26

DATE_SUB 给日期减去指定的时间间隔
SELECT DATE_SUB(NOW(),INTERVAL 84 DAY);
//2019-01-01 12:02:31

ADDDATE 增加一个日期（天，周等）,是DATE_ADD的同义词
SELECT ADDDATE('2019-1-1',84);
//2019-03-26

SUBDATE 减少一个日期（天，周等）,是DATE_SUB的同义词
SELECT SUBDATE(NOW(),84);
//2019-01-01 12:07:08

STR_TO_DATE 将字符通过指定格式转换成日期
%Y 四位的年份 
'%y' 二位的年份
%c %m 月份
%d 天数
SELECT STR_TO_DATE('2019/1/1','%Y/%c/%d')AS output;
//2019-01-01

DATE_FORMAT将日期转换成字符
SELECT DATE_FORMAT(NOW(),'%y年/%c月/%d日')；
//19年/3月/26日


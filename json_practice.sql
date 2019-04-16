CREATE TABLE json_test(
json_demo json);
SELECT JSON_TYPE('[1,"Dolores",true]');
SELECT JSON_TYPE('{"key":"value"}');
SELECT JSON_TYPE('"hello"');
SELECT JSON_TYPE('hello');

SELECT json_objectagg('ID',22);

SELECT JSON_MERGE_PRESERVE('["ABC","HELLO"]','{"name":"Dolores"}');
SELECT JSON_MERGE_PATCH('["ABC","HELLO"]','{"name":"Dolores"}');

select json_merge_patch('{"a":"b"}','true');
 SELECT JSON_MERGE_PATCH('{"name": "x"}', '{"id": 47}');

SELECT JSON_ARRAY('x') = JSON_ARRAY('X');
SELECT ISNULL(null), ISNULL(Null), ISNULL(NULL);

SELECT JSON_VALID('null'),Json_valid('Null');
SELECT JSON_VALID('null'), JSON_VALID('Null'), JSON_VALID('NULL');
SELECT JSON_VALID('true'), JSON_VALID('True'), JSON_VALID('TRUE');

CREATE TABLE facts (sentence JSON);
 INSERT INTO facts VALUES
(JSON_OBJECT("mascot", "Our mascot is a dolphin named \"Sakila\"."));

SELECT sentence->>"$.mascot" FROM facts;

CREATE TABLE t1 (c1 JSON);
INSERT INTO t1 VALUES
('{"x": 17, "x": "red"}'),
('{"x": 17, "x": "red", "x": [3, 5, 7]}');
select * from t1;

 SELECT JSON_SET('"x"', '$[1]', 'a','$[2]','B');
 SELECT JSON_SET('"x"',  'a','$[0]');

-- SQL-Comprehensive-Practice 종합실습

-- 제공된 CSV 데이터를 Import한 후 문제를 해결하세요.

SELECT * FROM professors;
SELECT * FROM students;
SELECT * FROM subjects;
SELECT * FROM enrollments;


-- SELECT / WHERE
--문제 1 학생 전체 정보를 조회하세요.
SELECT * FROM students;

-- 문제 2 학생의 이름(name), 전공(major)만 조회하세요.
SELECT name, major FROM students;

-- 문제 3 컴퓨터공학 전공 학생만 조회하세요.
SELECT 
	* 
from students
WHERE major = '컴퓨터공학';
	
-- 문제 4 3학년 학생만 조회하세요.
SELECT
	*
FROM students
WHERE grade = 3;

-- 문제 5 나이가 21세 이상인 학생을 조회하세요.
SELECT
	*
FROM students
WHERE age >= 21;

-- 문제 6 나이가 20~22세인 학생을 조회하세요.
SELECT
	*
FROM students
WHERE age between 20 and 22;

-- 문제 7 전공이 컴퓨터공학 또는 전자공학인 학생을 조회하세요.
SELECT * FROM students
WHERE major = '컴퓨터공학' or  major = '전자공학';

SELECT * FROM students
WHERE major IN ('컴퓨터공학', '전자공학')
ORDER BY age DESC;
;

-- 문제 8 이름이 '김'으로 시작하는 학생을 조회하세요.
SELECT * FROM students
WHERE name LIKE '김%';

-- SELECT * FROM students ORDER By name;

-- 문제 9 이름에 '민'이 포함된 학생을 조회하세요.
SELECT * FROM students 
WHERE name LIKE '%민%';

-- 문제 10 이름이 '훈'으로 끝나는 학생을 조회하세요.
SELECT * FROM students
WHERE name LIKE '%훈';

-- ORDER BY / LIMIT
-- 문제 11 학생을 나이가 많은 순으로 정렬하세요.
SELECT * FROM students
ORDER BY age DESC;

-- 문제 12 학생을 학년 오름차순, 나이 내림차순으로 정렬하세요.
SELECT * FROM students
ORDER BY grade ASC, age DESC;

-- 문제 13 컴퓨터공학 학생을 나이가 많은 순으로 조회하세요.
SELECT * FROM students
WHERE major = '컴퓨터공학'
ORDER BY age DESC;

-- 문제 14 가장 나이가 많은 학생 5명을 조회하세요.
SELECT * FROM students
ORDER BY age DESC
LIMIT 5;

-- 문제 15 기계공학 학생 중 나이가 어린 학생 3명을 조회하세요.
SELECT * FROM students
WHERE major = '기계공학'
ORDER BY age ASC
LIMIT 3;

-- UPDATE / DELETE

-- 문제 16 컴퓨터공학 학생의 전공을 AI공학으로 변경하세요.
UPDATE students
set major = 'AI공학'
WHERE major = '컴퓨터공학';

select * from students
where major = 'AI공학';

-- 문제 17 1학년 학생의 나이를 모두 1살 증가시키세요.
UPDATE students
SET age = age + 1
WHERE grade = 1;

select age from students
where grade = 1;

-- 문제 18 2학년 학생의 전공을 데이터사이언스로 변경하세요.
UPDATE students
SET major = '데이터사이언스'
WHERE grade = 2;

select * from students
where grade = 2;

-- 문제 19 교양 과목의 학점을 모두 3학점으로 변경하세요.
UPDATE subjects
SET credit = 3
WHERE department = '교양';

select * from subjects;

-- 문제 20 전자공학 학생을 모두 삭제하세요.
DELETE FROM students
WHERE major = '전자공학';

select * from students;

-- 함수 / CASE
-- 문제 21 학생 이름과 함께 5년 후 나이를 출력하세요.
SELECT 
	name, 
	age,
	age + 5 AS age_in_5_years 
FROM students;

SELECT 
	name, 
    age + 5 AS 나이5년후 
FROM students;

SELECT 
	name, 
    age + 5 AS "5년후 나이" 
FROM students;

-- SQL에서 컬럼 별칭(alias)을 줄 때 숫자로 시작하는 이름은 권장되지 않음.
-- 굳이 쓰려면, " " 로 묶기

-- 문제 22 학생 이름과 나이를 조회하고, 22세 이상이면 "고학년 나이", 그렇지 않으면 "저학년 나이"를 출력하세요.
SELECT 
	name,
    age,
	CASE
		WHEN age >= 22 THEN '고학년 나이'
	ELSE '저학년 나이'
	END AS 연령대
from students;

-- 문제 23 과목명과 함께 학점이 3이면 "전공과목", 2이면 "교양과목"으로 출력하세요.
UPDATE subjects
SET credit = 2
where department = '교양';

SELECT
	name,
	CASE
	WHEN credit = 3 THEN '전공과목'
	WHEN credit = 2 THEN '교양과목'
	END AS 과목유형
FROM subjects;
	
select * from subjects;
select * from students;

-- 문제 24 학생 이름과 학년을 "1학년", "2학년" 형태로 출력하세요.
select 
	name,
	grade || '학년' AS 학년
from students;

-- 집계 함수
-- 문제 25 전체 학생 수를 조회하세요.
SELECT
	count(*)
FROM students;

SELECT
	COUNT(DISTINCT name) 
FROM students;

select * from students
ORDER By name;

SELECT 
    name,
	COUNT(*) AS 인원수
FROM students
GROUP BY name;

-- 문제 26 학생의 평균 나이를 조회하세요.
SELECT
	ROUND(AVG(age), 1) AS 평균나이
FROM students;

-- 문제 27 학생의 최고 나이와 최저 나이를 조회하세요.
SELECT
	MAX(age) AS 최고나이,
	MIN(age) AS 최저나이
FROM students;


-- 문제 28 전체 과목 수와 평균 학점을 조회하세요.
SELECT
	COUNT(name),
	AVG(credit)
from subjects;

SELECT
	COUNT(distinct name),
	round(AVG(credit), 2)
from subjects;


-- 문제 29 컴퓨터공학 학생은 몇 명인지 조회하세요.
UPDATE students
SET major = '컴퓨터공학'
where major = 'AI공학';

SELECT
	count(*) AS "컴퓨터공학과 학생수"
FROM students
where major = '컴퓨터공학';

-- GROUP BY
-- 문제 30 전공별 학생 수를 조회하세요.
SELECT
	major AS 전공,
	COUNT(major) AS 전공별학생수
FROM students
GROUP BY major
;

-- 문제 31 학년별 학생 수를 조회하세요.
SELECT
	grade AS 학년,
	COUNT(*) AS 학생수
FROM students
GROUP BY grade;

-- 문제 32 교수별 담당 과목 수를 조회하세요.
SELECT * FROM professors;

SELECT
	name as 교수,
	COUNT(*) AS 교수수
FROM professors
GROUP BY name;

-- 문제 33 학과별 개설 과목 수를 조회하세요.
SELECT
	depertment as 학과,
	COUNT(*) AS 교수수
FROM subjects
GROUP BY depertment;

-- 문제 34 학과별 평균 학점을 조회하세요.
SELECT
	name as 교수,
	COUNT(*) AS 교수수
FROM professors
GROUP BY name;


-- HAVING
-- 문제 35 학생이 5명 이상인 전공만 조회하세요.


-- 문제 36 과목을 2개 이상 담당하는 교수만 조회하세요.

 
-- 문제 37 평균 학점이 3 이상인 학과만 조회하세요.



-- INNER JOIN
-- 문제 38 학생 이름과 수강 과목명을 조회하세요.
-- 출력 컬럼 • 학생명. • 과목명. • 학기.


-- 문제 39
-- 학생 이름, 전공, 과목명, 담당 교수명을 조회하세요.
-- 출력 컬럼 • 학생명. • 전공. • 과목명. • 교수명.



-- LEFT JOIN
-- 문제 40 :별: 모든 학생을 조회하되, 수강신청을 하지 않은 학생도 함께 출력하세요.
-- 출력 컬럼 • 학생명. • 과목명. • 학기. (과목이 없는 학생도 결과에 포함되어야 합니다.)



--:근육: 도전 문제
-- 도전 1 학생별 수강 과목 수를 조회하세요.


-- 도전 2 가장 많은 학생이 수강하는 과목 TOP 5를 조회하세요.


-- 도전 3 담당 과목이 없는 교수를 조회하세요.


-- 도전 4 수강 신청을 하지 않은 학생을 조회하세요.


-- 도전 5 학생별 총 신청 학점을 조회하세요.



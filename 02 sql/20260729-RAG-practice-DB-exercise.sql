-- RAG 실습용 DB 조회용

SELECT * FROM employees;
SELECT * FROM leave_balance;
SELECT * FROM leave_history;
SELECT * FROM education_history;


-- 김철수 남은 연차 알려줘


SELECT
 e.name,
 l.remaining_days
FROM employees e
JOIN leave_balance l
ON e.id=l.employee_id
WHERE e.name='김철수'
AND l.year=2026;

-> 김철수 / 7일


-- 김철수가 사용한 휴가 내역 보여줘.

-- 개발팀 직원 중 AWS 교육 받은 사람?

-- 연차 규정 기준으로 내가 다음 주 휴가 가능한가? -> RAG + SQL + 추론



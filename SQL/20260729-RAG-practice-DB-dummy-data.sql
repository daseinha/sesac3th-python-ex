-- RAG 실습용 DB 더미 데이터 입력

INSERT INTO employees
(employee_no, name, department, position, email, phone, join_date)
VALUES
('EMP001',
 '김철수',
 '개발팀',
 '대리',
 'kim.cs@company.com',
 '010-1111-2222',
 '2021-03-15'),
('EMP002',
 '이영희',
 '인사팀',
 '과장',
 'lee.hy@company.com',
 '010-2222-3333',
 '2019-07-01'),
('EMP003',
 '박민수',
 '영업팀',
 '사원',
 'park.ms@company.com',
 '010-3333-4444',
 '2024-01-10'),
('EMP004',
 '최지은',
 '마케팅팀',
 '대리',
 'choi.je@company.com',
 '010-4444-5555',
 '2022-05-20'),
('EMP005',
 '정현우',
 '개발팀',
 '과장',
 'jung.hw@company.com',
 '010-5555-6666',
 '2018-11-05');



 INSERT INTO leave_balance
(employee_id, year, total_days, used_days, remaining_days)
VALUES
(1,2026,15,8,7),
(2,2026,17,3,14),
(3,2026,15,5,10),
(4,2026,16,10,6),
(5,2026,18,7,11);


INSERT INTO leave_history
(employee_id, leave_type, start_date, end_date, days, reason, status)
VALUES
(
1,
'연차',
'2026-02-10',
'2026-02-12',
3,
'개인 여행',
'승인'
),
(
1,
'반차',
'2026-03-05',
'2026-03-05',
0.5,
'병원 방문',
'승인'
),
(
2,
'연차',
'2026-01-20',
'2026-01-22',
3,
'가족 일정',
'승인'
),
(
3,
'연차',
'2026-04-01',
'2026-04-05',
5,
'개인 휴식',
'승인'
),
(
4,
'반차',
'2026-05-10',
'2026-05-10',
0.5,
'은행 업무',
'승인'
),
(
5,
'연차',
'2026-02-01',
'2026-02-07',
5,
'해외 여행',
'승인'
);


INSERT INTO education_history
(employee_id,
 education_name,
 education_type,
 provider,
 completion_date,
 cost,
 status)
VALUES
(
1,
'Python 데이터 분석 과정',
'직무교육',
'패스트캠퍼스',
'2026-03-20',
450000,
'수료'
),
(
1,
'AWS Solutions Architect',
'자격증',
'AWS',
'2026-05-10',
300000,
'수료'
),
(
2,
'인사관리 전문가 과정',
'외부교육',
'한국HR협회',
'2026-02-15',
500000,
'수료'
),
(
3,
'영업 협상 전략 교육',
'직무교육',
'휴넷',
'2026-04-20',
250000,
'수료'
),
(
5,
'Spring Boot 심화 과정',
'기술교육',
'인프런',
'2026-06-01',
200000,
'수료'
);


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


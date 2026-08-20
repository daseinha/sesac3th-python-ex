-- p01.sql

-- 1. userinfo 테이블 생성
CREATE TABLE userinfo (
	id INT GENERATED ALWAYS AS IDENTITY,   -- id INT PK
    nickname VARCHAR(20) NOT NULL,  -- nickname: 글자 20자 까지, 필수 입력
    phone VARCHAR(11) UNIQUE, -- phone 글자 11 글자 까지, 중복 방지
    reg_date DATE DEFAULT CURRENT_DATE-- reg_date 날짜, 기본값(오늘 날짜)
);

-- 2. userinfo 테이블 CRUD
INSERT INTO userinfo (nickname, phone) 
VALUES
('alice', '0104567890'),
('bob', '0104561234'),
('charlie', '01112345678'),
('david', '01874562131'),
('eric', '01054687913');


-- 전체 조회 (중간중간 계속 실행하면서 모니터링) R
SELECT * FROM userinfo;

-- id 가 3인 사람 조회 R
SELECT * FROM userinfo WHERE id = 3;

-- 별명이 bob 인 사람을 조회 R
SELECT * FROM userinfo where nickname = 'bob';

-- 별명이 bob 인 사람의 핸드폰 번호를 01099998888 로 수정 (id로 수정) U
UPDATE userinfo
set phone = '01099998888'
WHERE id = 2;

-- 별명이 bob 인 사람 삭제 (id로 수정) D
DELETE FROM userinfo
WHERE id = 2;
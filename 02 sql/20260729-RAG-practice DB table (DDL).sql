-- RAG 실습용 DB 테이블 생성 (DDL, Date Definition Language)

-- ==========================================
-- HR Assistant Database
-- PostgreSQL
-- ==========================================


DROP TABLE IF EXISTS education_history;
DROP TABLE IF EXISTS leave_history;
DROP TABLE IF EXISTS leave_balance;
DROP TABLE IF EXISTS employees;


-- ==========================================
-- 직원 정보
-- ==========================================

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    employee_no VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50),
    position VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    join_date DATE,
    employment_status VARCHAR(20) DEFAULT '재직'
);


COMMENT ON TABLE employees IS '회사 직원 기본 정보';


-- ==========================================
-- 연차 잔여 현황
-- ==========================================

CREATE TABLE leave_balance (
    id SERIAL PRIMARY KEY,
    employee_id INT NOT NULL,
    year INT NOT NULL,
    total_days INT DEFAULT 0,
    used_days INT DEFAULT 0,
    remaining_days INT DEFAULT 0,
    FOREIGN KEY(employee_id)
        REFERENCES employees(id)
);


COMMENT ON TABLE leave_balance IS '직원별 연차 현황';


-- ==========================================
-- 휴가 신청 이력
-- ==========================================

CREATE TABLE leave_history (
    id SERIAL PRIMARY KEY,
    employee_id INT NOT NULL,
    leave_type VARCHAR(30),
    start_date DATE,
    end_date DATE,
    days INT,
    reason TEXT,
    status VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(employee_id)
        REFERENCES employees(id)
);


COMMENT ON TABLE leave_history IS '휴가 신청 기록';



-- ==========================================
-- 교육 이력
-- ==========================================

CREATE TABLE education_history (
    id SERIAL PRIMARY KEY,
    employee_id INT NOT NULL,
    education_name VARCHAR(100),
    education_type VARCHAR(50),
    provider VARCHAR(100),
    completion_date DATE,
    cost INT,
    status VARCHAR(20),
    FOREIGN KEY(employee_id)
        REFERENCES employees(id)
);


COMMENT ON TABLE education_history IS '직원 교육 이력';


SELECT * FROM employees;
SELECT * FROM leave_balance;
SELECT * FROM leave_history;
SELECT * FROM education_history;

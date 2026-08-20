-- 실습


-- ==========================================
-- 기존 테이블 삭제
-- ==========================================

DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS subjects;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS professors;

-- ==========================================
-- 교수 테이블
-- ==========================================

CREATE TABLE professors (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    department VARCHAR(30) NOT NULL
);

-- ==========================================
-- 학생 테이블
-- ==========================================

CREATE TABLE students (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    age INT NOT NULL CHECK (age >= 18),
    grade INT NOT NULL CHECK (grade BETWEEN 1 AND 4),
    major VARCHAR(30) NOT NULL
);

-- ==========================================
-- 과목 테이블
-- ==========================================

CREATE TABLE subjects (
    id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(30) NOT NULL,
    professor_id INT NOT NULL,
    credit INT NOT NULL DEFAULT 3 CHECK (credit BETWEEN 1 AND 4),
	    CONSTRAINT fk_subject_professor
        FOREIGN KEY (professor_id)
        REFERENCES professors(id)
);

-- ==========================================
-- 수강신청 테이블
-- ==========================================

CREATE TABLE enrollments (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id VARCHAR(10) NOT NULL,
    semester VARCHAR(10) NOT NULL,
    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (student_id)
        REFERENCES students(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_enrollment_subject
        FOREIGN KEY (subject_id)
        REFERENCES subjects(id)
        ON DELETE CASCADE
);


SELECT * FROM professors;
SELECT * FROM students;
SELECT * FROM subjects;
SELECT * FROM enrollments;



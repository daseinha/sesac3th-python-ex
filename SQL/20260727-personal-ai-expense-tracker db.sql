-- 개인용 AI 가계부 (개인용 AI 지출내역 트레커) DB


-- 0. 기존 테이블 있을 때, 초기화
DROP TABLE IF EXISTS paiet_expense_tags CASCADE;
DROP TABLE IF EXISTS paiet_tags CASCADE;
DROP TABLE IF EXISTS paiet_recurring_expenses CASCADE;
DROP TABLE IF EXISTS paiet_expenses CASCADE;
DROP TABLE IF EXISTS paiet_categories CASCADE;



-- 1. 카테고리 테이블
CREATE TABLE paiet_categories (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    monthly_budget NUMERIC(12, 2) DEFAULT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 카테고리 등록 (월 예산 포함)
INSERT INTO paiet_categories (name, monthly_budget) VALUES 
('식비', 300000),
('교통비', 100000),
('카페/간식', 50000),
('생필품/쇼핑', 100000),
('문화/수양', 100000),
('주거/통신', 350000),
('구독/OTT', 50000);

-- 2. 지출 내역 테이블
CREATE TABLE paiet_expenses (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    amount NUMERIC(12, 2) NOT NULL,
    category_id INT NOT NULL REFERENCES paiet_categories(id) ON DELETE CASCADE,
    memo VARCHAR(255),
    spent_at DATE NOT NULL DEFAULT CURRENT_DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. 태그 테이블
CREATE TABLE paiet_tags (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO paiet_tags (name) VALUES 
('교육등교'), ('점심'), ('장보기'), ('고정지출'), ('자기계발'), ('힐링');

-- 4. 지출-태그 매핑 테이블
CREATE TABLE paiet_expense_tags (
    expense_id INT NOT NULL REFERENCES paiet_expenses(id) ON DELETE CASCADE,
    tag_id INT NOT NULL REFERENCES paiet_tags(id) ON DELETE CASCADE,
    PRIMARY KEY (expense_id, tag_id)
);

-- 5. 반복 지출(구독) 설정 테이블
CREATE TABLE paiet_recurring_expenses (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    amount NUMERIC(12, 2) NOT NULL,
    category_id INT NOT NULL REFERENCES paiet_categories(id) ON DELETE CASCADE,
    memo VARCHAR(255),
    day_of_month INT NOT NULL CHECK (day_of_month BETWEEN 1 AND 31),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 반복 지출 등록 (기능 8용)
INSERT INTO paiet_recurring_expenses (amount, category_id, memo, day_of_month) VALUES 
(7000, (SELECT id FROM paiet_categories WHERE name='구독/OTT'), '넷플릭스 스탠더드', 25),
(13900, (SELECT id FROM paiet_categories WHERE name='구독/OTT'), '유튜브 프리미엄', 10),
(8900, (SELECT id FROM paiet_categories WHERE name='구독/OTT'), '디즈니 플러스', 15),
(7900, (SELECT id FROM paiet_categories WHERE name='구독/OTT'), '윌라 오디오북', 5);


select * from paiet_categories;
select * from paiet_expenses;
select * from paiet_tags;
select * from paiet_expense_tags;
select * from paiet_recurring_expenses;
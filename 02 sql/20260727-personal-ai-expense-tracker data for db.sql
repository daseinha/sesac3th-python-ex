-- 개인용 AI 가계부 (개인용 AI 지출내역 트레커) DB용 데이터

-- 카테고리 등록 초기 데스트용 데이터 입력 (월 예산 포함)
INSERT INTO paiet_categories (name, monthly_budget) VALUES 
('식비', 300000),
('교통비', 100000),
('카페/간식', 50000),
('생필품/쇼핑', 100000),
('문화/수양', 100000),
('주거/통신', 350000),
('구독/OTT', 50000);

-- 반복 지출 등록 테스트용 초기데이터 (기능 8용)
INSERT INTO paiet_recurring_expenses (amount, category_id, memo, day_of_month) VALUES 
(17000, (SELECT id FROM paiet_categories WHERE name='구독/OTT'), '넷플릭스 4K', 25),
(13900, (SELECT id FROM paiet_categories WHERE name='구독/OTT'), '유튜브 프리미엄', 10),
(7900, (SELECT id FROM paiet_categories WHERE name='구독/OTT'), '쿠팡 와우 멤버십', 15),
(9900, (SELECT id FROM paiet_categories WHERE name='구독/OTT'), '밀리의 서재', 5);


-- --------------------------------------------------------
-- 6. 2026년 7월 한 달 치 실제 지출 내역 데이터 (약 40건)
-- --------------------------------------------------------

INSERT INTO paiet_expenses (amount, category_id, memo, spent_at) VALUES
-- 고정비 / 통신 / 관리비
(185000, (SELECT id FROM paiet_categories WHERE name='주거/통신'), '아파트 관리비 (전기/수도 포함)', '2026-07-25'),
(42000, (SELECT id FROM paiet_categories WHERE name='주거/통신'), '도시가스 요금', '2026-07-20'),
(38000, (SELECT id FROM paiet_categories WHERE name='주거/통신'), '인터넷 및 IPTV', '2026-07-18'),
(55000, (SELECT id FROM paiet_categories WHERE name='주거/통신'), '휴대폰 알뜰폰 요금', '2026-07-15'),

-- 자동 입력된 구독 내역 (기능 8 결과물 미리보기)
(9900, (SELECT id FROM paiet_categories WHERE name='구독/OTT'), '[정기결제] 밀리의 서재', '2026-07-05'),
(13900, (SELECT id FROM paiet_categories WHERE name='구독/OTT'), '[정기결제] 유튜브 프리미엄', '2026-07-10'),
(7900, (SELECT id FROM paiet_categories WHERE name='구독/OTT'), '[정기결제] 쿠팡 와우 멤버십', '2026-07-15'),
(17000, (SELECT id FROM paiet_categories WHERE name='구독/OTT'), '[정기결제] 넷플릭스 4K', '2026-07-25'),

-- 주차별 지하철 출퇴근 교통비 (지체 없이 일괄/주간 카드대금 연동 느낌)
(16500, (SELECT id FROM paiet_categories WHERE name='교통비'), '1주차 지하철 출퇴근 합산', '2026-07-03'),
(16500, (SELECT id FROM paiet_categories WHERE name='교통비'), '2주차 지하철 출퇴근 합산', '2026-07-10'),
(16500, (SELECT id FROM paiet_categories WHERE name='교통비'), '3주차 지하철 출퇴근 합산', '2026-07-17'),
(16500, (SELECT id FROM paiet_categories WHERE name='교통비'), '4주차 지하철 출퇴근 합산', '2026-07-24'),

-- 평일 등교 점심 (1만 원 식대 맞추기 시리즈)
(8500, (SELECT id FROM paiet_categories WHERE name='식비'), '순대국밥 점심', '2026-07-01'),
(1500, (SELECT id FROM paiet_categories WHERE name='카페/간식'), 'GS25 추파춥스 사탕 (차액)', '2026-07-01'),
(9000, (SELECT id FROM paiet_categories WHERE name='식비'), '제육볶음 정식', '2026-07-02'),
(1000, (SELECT id FROM paiet_categories WHERE name='카페/간식'), 'CU 캔커피 (차액)', '2026-07-02'),
(7800, (SELECT id FROM paiet_categories WHERE name='식비'), '돈까스 카레', '2026-07-06'),
(2200, (SELECT id FROM paiet_categories WHERE name='카페/간식'), '세븐일레븐 컵라면 (차액)', '2026-07-06'),
(9500, (SELECT id FROM paiet_categories WHERE name='식비'), '김치찌개와 계란말이', '2026-07-08'),
(500, (SELECT id FROM paiet_categories WHERE name='카페/간식'), '추파춥스 1개', '2026-07-08'),

-- 평일 저녁 집밥 반찬거리 마트 구매
(12500, (SELECT id FROM paiet_categories WHERE name='식비'), '동네마트 콩나물, 두부, 제육 양념육', '2026-07-02'),
(9800, (SELECT id FROM paiet_categories WHERE name='식비'), '퇴근길 마트 계란 1판, 깻잎', '2026-07-07'),
(14000, (SELECT id FROM paiet_categories WHERE name='식비'), '동네마트 밀키트 부대찌개', '2026-07-14'),
(11000, (SELECT id FROM paiet_categories WHERE name='식비'), '퇴근길 마트 어묵, 대파, 버섯', '2026-07-21'),

-- 주말 장보기 (대형마트)
(68000, (SELECT id FROM paiet_categories WHERE name='식비'), '일요일 이마트 일주일치 식료품 장보기', '2026-07-05'),
(72500, (SELECT id FROM paiet_categories WHERE name='식비'), '토요일 홈플러스 주말 식재료 대량 구매', '2026-07-12'),
(59000, (SELECT id FROM paiet_categories WHERE name='식비'), '일요일 마트 고기 및 과일 장보기', '2026-07-19'),

-- 다이소 쇼핑
(8000, (SELECT id FROM paiet_categories WHERE name='생필품/쇼핑'), '다이소 수납함, 멀티탭', '2026-07-04'),
(5000, (SELECT id FROM paiet_categories WHERE name='생필품/쇼핑'), '다이소 청소용품, 키친타월', '2026-07-18'),

-- 문화 생활 (영화 / 책)
(15000, (SELECT id FROM paiet_categories WHERE name='문화/수양'), 'CGV 주말 영화 관람', '2026-07-11'),
(22000, (SELECT id FROM paiet_categories WHERE name='문화/수양'), '교보문고 AI 서비스 기획 서적 구입', '2026-07-16');

-- 태그 연결 데이터 (주요 항목 태그 부착)
INSERT INTO paiet_expense_tags (expense_id, tag_id) VALUES
-- 점심식사 및 차액 태그
(13, (SELECT id FROM paiet_tags WHERE name='점심지원')),
(14, (SELECT id FROM paiet_tags WHERE name='편의점차액')),
(15, (SELECT id FROM paiet_tags WHERE name='점심지원')),
(16, (SELECT id FROM paiet_tags WHERE name='편의점차액')),
-- 주말 장보기 태그
(25, (SELECT id FROM paiet_tags WHERE name='주말장보기')),
(26, (SELECT id FROM paiet_tags WHERE name='주말장보기')),
(27, (SELECT id FROM paiet_tags WHERE name='주말장보기')),
-- 서적/자기계발 태그
(31, (SELECT id FROM paiet_tags WHERE name='자기계발'));


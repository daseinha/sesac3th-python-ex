-- sub query 서브쿼리

SELECT AVG(total_amount) from sales;
-- 612862 (데이터 추가에 따라 계속 변화되는 값. 쿼리를 변수화 하는 것도 가능)

SELECT * FROM sales
WHERE
	total_amount >= (SELECT AVG(total_amount) from sales);

-- 서브쿼리를 사용할 때는 반드시 괄호 ()로 감싸야 한다.
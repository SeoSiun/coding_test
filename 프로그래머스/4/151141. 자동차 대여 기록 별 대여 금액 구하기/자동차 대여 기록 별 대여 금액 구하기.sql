-- 코드를 입력하세요
SELECT H.HISTORY_ID,
    CASE
        WHEN DATEDIFF(END_DATE, START_DATE) + 1 < 7 THEN TRUNCATE((DATEDIFF(END_DATE, START_DATE) + 1) * DAILY_FEE, 0)
        ELSE TRUNCATE((DATEDIFF(END_DATE, START_DATE) + 1) * DAILY_FEE * (1 - DISCOUNT_RATE * 0.01), 0)
        END
    AS FEE

FROM CAR_RENTAL_COMPANY_CAR C 
    JOIN CAR_RENTAL_COMPANY_RENTAL_HISTORY H 
    ON C.CAR_ID = H.CAR_ID
    JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN P
    ON C.CAR_TYPE = P.CAR_TYPE

WHERE C.CAR_TYPE = '트럭'
    AND (DATEDIFF(END_DATE, START_DATE) + 1 < 7
         OR ((DATEDIFF(END_DATE, START_DATE) + 1 BETWEEN 7 AND 29) AND DURATION_TYPE = '7일 이상')
         OR ((DATEDIFF(END_DATE, START_DATE) + 1 BETWEEN 30 AND 89) AND DURATION_TYPE = '30일 이상')
         OR ((DATEDIFF(END_DATE, START_DATE) + 1 >= 90) AND DURATION_TYPE = '90일 이상')
        )
GROUP BY H.HISTORY_ID
ORDER BY FEE DESC, H.HISTORY_ID DESC

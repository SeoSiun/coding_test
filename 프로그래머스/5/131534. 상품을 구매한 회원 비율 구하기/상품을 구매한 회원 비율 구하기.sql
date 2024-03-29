SELECT YEAR(O.SALES_DATE) YEAR, MONTH(O.SALES_DATE) MONTH, 
       COUNT(DISTINCT U.USER_ID) PUCHASED_USERS,
       ROUND(COUNT(DISTINCT U.USER_ID) / (SELECT COUNT(DISTINCT USER_ID) FROM USER_INFO WHERE YEAR(JOINED) = 2021), 1) PUCHASED_RATIO
FROM ONLINE_SALE O 
    JOIN USER_INFO U
    ON O.USER_ID = U.USER_ID AND YEAR(U.JOINED) = 2021
GROUP BY 1, 2 
ORDER BY 1 ASC, 2 ASC;
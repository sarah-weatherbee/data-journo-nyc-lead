
/* 90th PERCENTILE FORMULA 

ex:
SELECT
  height AS 'male 90% height'
FROM table
WHERE gender='male'
ORDER BY height ASC
LIMIT 1
OFFSET (SELECT
         COUNT(*)
        FROM table
        WHERE gender='male') * 9 / 10 - 1;
        
-----        
SELECT percentile_disc(0.9) WITHIN GROUP (ORDER BY score)
  FROM customer_score
 GROUP BY customer_id;
*/
-- SELECT percentile_disc(0.9) within GROUP (ORDER BY Lead_First_Draw_mg_L)
--  from
--   SOURCE_NYC_lead_levels
-- where
--   UHF_code NOT IN ("#N/A", "999")
-- group by
--   Neighb_Name,
--   Year_Coll;

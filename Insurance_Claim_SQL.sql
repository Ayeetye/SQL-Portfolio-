 -- 1 What is the most common type of collision that occurs for the insurance company?         

 SELECT 
	 COUNT(collision_type) most_common_collision
	,collision_type
FROM dbo.cleaned_insurance_claim
GROUP BY collision_type
ORDER BY 1 DESC;

  -- 2 Which top 3 states that have highest amount of incidents that occur and how many?

SELECT 
	COUNT(incident_date) as incident_counts
	,incident_state
FROM dbo.cleaned_insurance_claim
GROUP BY incident_state
ORDER BY COUNT(incident_date) DESC;

 -- 3 Which age bracket (16 - 25, 26 - 35, 36 - 45, 46 - 55+) incurs the most amount of collision?
 WITH cte AS 
 (
 SELECT 
	DISTINCT CASE WHEN age BETWEEN 16 AND 25 THEN '16 - 25' 
	WHEN age BETWEEN 26 AND 35 THEN '26 - 35' 
	WHEN age BETWEEN 36 AND 45 THEN '36 - 45'
	WHEN age BETWEEN 46 AND 55 THEN '46 - 55'
	ELSE '56+' END age
	,incident_type
	,incident_date
 FROM dbo.cleaned_insurance_claim
 GROUP BY incident_type, age, incident_date
 )
SELECT 
	DISTINCT age
	,COUNT(incident_date) as incident_count
	,incident_type
FROM cte
WHERE incident_type LIKE '%Collision%'
GROUP BY 
	incident_type
	,age
ORDER BY incident_count DESC


 -- 4 Display customers who had insurance for less than 2 years since an incident, how much was each of their total claims?

 SELECT 
	policy_number
	,incident_date
	,total_claim_amount
FROM dbo.cleaned_insurance_claim
GROUP BY 
	policy_number
	,incident_date
	,total_claim_amount
ORDER BY total_claim_amount DESC;


 -- 5 What vehicle make is the most accident prone according to the insurance claim?

 SELECT 
	DISTINCT auto_make
	,COUNT(incident_date) as total_incidents
FROM dbo.cleaned_insurance_claim
GROUP BY auto_make
ORDER BY total_incidents DESC;



-- 6 What is the total claim amount combined across all insurance policy holders paid out?

SELECT 
	TOP 1 SUM(total_claim_amount) OVER () AS sumtotal
FROM dbo.cleaned_insurance_claim

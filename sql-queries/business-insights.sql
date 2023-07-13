-- Displaying the first 20 rows from all_transactions table for initial data exploration
SELECT * 
FROM all_transactions 
LIMIT 20;

-- ************************************************

-- Query to find the top 10 products that generate the highest revenue. 
-- This helps to understand which products contribute most to the company's income.
SELECT  
	hits_product_productsku, 
	hits_product_v2productname, 
	SUM(hits_product_productrevenue) AS total_revenue
FROM 
	all_transactions
WHERE 
	hits_product_productsku IS NOT NULL
GROUP BY 
	hits_product_productsku, hits_product_v2productname
ORDER BY
	total_revenue DESC
LIMIT 10;

-- ************************************************

-- Query to find the top 10 cities that generate the highest number of transactions. 
-- This gives an overview of the geographical distribution of the company's sales.
SELECT 
	geonetwork_city, 
	COUNT(*) AS number_of_transactions
FROM
	all_transactions
WHERE 
	geonetwork_city IS NOT NULL AND geonetwork_city <> 'not available in demo dataset'
GROUP BY 
	geonetwork_city
ORDER BY 
	number_of_transactions DESC 
LIMIT 10;

-- ************************************************

-- Query to find the top 10 countries that generate the highest number of transactions. 
-- This could inform international marketing strategies.
SELECT 
	geonetwork_country, 
	COUNT(*) AS number_of_transactions
FROM
	all_transactions
WHERE 
	geonetwork_country IS NOT NULL AND geonetwork_country <> 'not available in demo dataset'
GROUP BY 
	geonetwork_country
ORDER BY 
	number_of_transactions DESC 
LIMIT 10;

-- ************************************************

-- Query to find the average time a user spends on the site. 
-- This is a useful indicator of user engagement.
SELECT 
	ROUND(AVG(totals_timeonsite), 2) AS average_time_spend_seconds,
	ROUND(AVG(totals_timeonsite) / 60, 2) AS average_time_spend_minutes
FROM
	all_transactions;

-- ************************************************

-- Query to find the top 10 products with the highest revenue per transaction. 
-- This could help identify high-value products.
SELECT
	hits_product_productsku,
	hits_product_v2productname,
	SUM(hits_product_productrevenue) / COUNT(hits_transaction_transactionid) AS revenue_per_transaction
FROM
	all_transactions 
WHERE 
	hits_product_productsku IS NOT NULL
GROUP BY
	hits_product_productsku,
	hits_product_v2productname
ORDER BY 
	revenue_per_transaction DESC 
LIMIT 10;

-- ************************************************

-- Query to find the top 10 products with the most transactions. 
-- This could help identify popular products.
SELECT
	hits_product_productsku,
	hits_product_v2productname,
	COUNT(hits_transaction_transactionid) AS number_of_transaction
FROM
	all_transactions 
INNER JOIN
	product_list pl 
ON
	all_transactions.hits_product_productsku = pl.productsku
GROUP BY 
	hits_product_productsku,
	hits_product_v2productname
ORDER BY 
	number_of_transaction DESC 
LIMIT 10;

-- ************************************************

-- Query to find which cities have the highest average transaction revenue. 
-- This could help target marketing efforts in regions with high spending power.
SELECT 
	geonetwork_city,
	ROUND(AVG(totals_totaltransactionrevenue)) AS avg_transaction_revenue
FROM 
	all_transactions 
GROUP BY
	geonetwork_city
HAVING
	COUNT(*) > 100
ORDER BY 
	avg_transaction_revenue DESC 
LIMIT 10;

-- ************************************************

-- More complex query that uses window functions to find the top 3 products (by revenue) for each city. 
-- This can provide insights into regional product preferences.
SELECT 
	city_product_rank.geonetwork_city,
	city_product_rank.hits_product_productsku,
	city_product_rank.total_revenue,
	city_product_rank.product_rank
FROM
	(
		SELECT
			geonetwork_city,
			hits_product_productsku,
			SUM(hits_product_productrevenue) AS total_revenue,
			RANK() OVER (
				PARTITION BY geonetwork_city
				ORDER BY SUM(hits_product_productrevenue) DESC
			) AS product_rank
		FROM 
			all_transactions
		WHERE 
			geonetwork_city IS NOT NULL AND geonetwork_city NOT IN ('not available in demo dataset', '(not set)')
		GROUP BY
			geonetwork_city,
			hits_product_productsku
	) AS city_product_rank
WHERE 
	city_product_rank.product_rank <= 3;

-- ************************************************


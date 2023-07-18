-- Displaying the first 20 rows from transaction_records table for initial data exploration
SELECT * 
FROM transaction_records 
LIMIT 20;

-- ************************************************

-- Query to find the top 10 products that generate the highest revenue. 
-- This helps to understand which products contribute most to the company's income.
SELECT  
	sku_product, 
	product_name_v2, 
	SUM(product_revenue) AS total_revenue
FROM 
	transaction_records
WHERE 
	sku_product IS NOT NULL
GROUP BY 
	sku_product, product_name_v2
ORDER BY
	total_revenue DESC
LIMIT 10;

-- ************************************************

-- Query to find the top 10 cities that generate the highest number of transactions. 
-- This gives an overview of the geographical distribution of the company's sales.
SELECT 
	geo_network_city, 
	COUNT(*) AS number_of_transactions
FROM
	transaction_records
WHERE 
	geo_network_city IS NOT NULL AND geo_network_city <> 'not available in demo dataset'
GROUP BY 
	geo_network_city
ORDER BY 
	number_of_transactions DESC 
LIMIT 10;

-- ************************************************

-- Query to find the top 10 countries that generate the highest number of transactions. 
-- This could inform international marketing strategies.
SELECT 
	geo_network_country, 
	COUNT(*) AS number_of_transactions
FROM
	transaction_records
WHERE 
	geo_network_country IS NOT NULL AND geo_network_country <> 'not available in demo dataset'
GROUP BY 
	geo_network_country
ORDER BY 
	number_of_transactions DESC 
LIMIT 10;

-- ************************************************

-- Query to find the average time a user spends on the site. 
-- This is a useful indicator of user engagement.
SELECT 
	ROUND(AVG(time_spent), 2) AS average_time_spend_seconds,
	ROUND(AVG(time_spent) / 60, 2) AS average_time_spend_minutes
FROM
	transaction_records;

-- ************************************************

-- Query to find the top 10 products with the highest revenue per transaction. 
-- This could help identify high-value products.
SELECT
	sku_product,
	product_name_v2,
	SUM(product_revenue) / COUNT(transaction_id) AS revenue_per_transaction
FROM
	transaction_records 
WHERE 
	sku_product IS NOT NULL
GROUP BY
	sku_product,
	product_name_v2
ORDER BY 
	revenue_per_transaction DESC 
LIMIT 10;

-- ************************************************

-- Query to find the top 10 products with the most transactions. 
-- This could help identify popular products.
SELECT
	sku_product,
	product_name_v2,
	COUNT(transaction_id) AS number_of_transaction
FROM
	transaction_records 
INNER JOIN
	product_list pl 
ON
	transaction_records.sku_product = pl.sku_product
GROUP BY 
	sku_product,
	product_name_v2
ORDER BY 
	number_of_transaction DESC 
LIMIT 10;

-- ************************************************

-- Query to find which cities have the highest average transaction revenue. 
-- This could help target marketing efforts in regions with high spending power.
SELECT 
	geo_network_city,
	ROUND(AVG(transaction_revenue)) AS avg_transaction_revenue
FROM 
	transaction_records 
GROUP BY
	geo_network_city
HAVING
	COUNT(*) > 100
ORDER BY 
	avg_transaction_revenue DESC 
LIMIT 10;

-- ************************************************

-- More complex query that uses window functions to find the top 3 products (by revenue) for each city. 
-- This can provide insights into regional product preferences.
SELECT 
	city_product_rank.geo_network_city,
	city_product_rank.sku_product,
	city_product_rank.total_revenue,
	city_product_rank.product_rank
FROM
	(
		SELECT
			geo_network_city,
			sku_product,
			SUM(product_revenue) AS total_revenue,
			RANK() OVER (
				PARTITION BY geo_network_city
				ORDER BY SUM(product_revenue) DESC
			) AS product_rank
		FROM 
			transaction_records
		WHERE 
			geo_network_city IS NOT NULL AND geo_network_city NOT IN ('not available in demo dataset', '(not set)')
		GROUP BY
			geo_network_city,
			sku_product
	) AS city_product_rank
WHERE 
	city_product_rank.product_rank <= 3;

-- ************************************************


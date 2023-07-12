-- Displaying the first 20 rows from all_transactions table for initial data exploration
select * 
from all_transactions 
limit 20;

-- ************************************************

-- Query to find the top 10 products that generate the highest revenue. 
-- This helps to understand which products contribute most to the company's income.
select  
	hits_product_productsku, 
	hits_product_v2productname, 
	SUM(hits_product_productrevenue) as total_revenue
from 
	all_transactions
where 
	hits_product_productsku is not null
group by 
	hits_product_productsku, hits_product_v2productname
order by
	total_revenue desc
limit 10;

-- ************************************************

-- Query to find the top 10 cities that generate the highest number of transactions. 
-- This gives an overview of the geographical distribution of the company's sales.
select 
	geonetwork_city, 
	COUNT(*) as number_of_transactions
from
	all_transactions
where 
	geonetwork_city is not null and geonetwork_city <> 'not available in demo dataset'
group by 
	geonetwork_city
order by 
	number_of_transactions desc 
limit 10;

-- ************************************************

-- Query to find the top 10 countries that generate the highest number of transactions. 
-- This could inform international marketing strategies.
select 
	geonetwork_country, 
	COUNT(*) as number_of_transactions
from
	all_transactions
where 
	geonetwork_country is not null and geonetwork_country <> 'not available in demo dataset'
group by 
	geonetwork_country
order by 
	number_of_transactions desc 
limit 10;

-- ************************************************

-- Query to find the average time a user spends on the site. 
-- This is a useful indicator of user engagement.
select 
	ROUND(AVG(totals_timeonsite), 2) as average_time_spend_seconds,
	ROUND(AVG(totals_timeonsite) / 60, 2) as average_time_spend_minutes
from
	all_transactions;

-- ************************************************

-- Query to find the top 10 products with the highest revenue per transaction. 
-- This could help identify high-value products.
select
	hits_product_productsku,
	hits_product_v2productname,
	SUM(hits_product_productrevenue) / COUNT(hits_transaction_transactionid) as revenue_per_transaction
from
	all_transactions 
where 
	hits_product_productsku is not null
group by
	hits_product_productsku,
	hits_product_v2productname
order by 
	revenue_per_transaction desc 
limit 10;

-- ************************************************

-- Query to find the top 10 products with the most transactions. 
-- This could help identify popular products.
select
	hits_product_productsku,
	hits_product_v2productname,
	COUNT(hits_transaction_transactionid) as number_of_trasaction
from
	all_transactions 
inner join
	product_list pl 
on
	all_transactions.hits_product_productsku = pl.productsku
group by 
	hits_product_productsku,
	hits_product_v2productname
order by 
	number_of_trasaction desc 
limit 10;

-- ************************************************

-- Query to find which cities have the highest average transaction revenue. 
-- This could help target marketing efforts in regions with high spending power.
select 
	geonetwork_city,
	ROUND(AVG(totals_totaltransactionrevenue)) as avg_transaction_revenue
from 
	all_transactions 
group by
	geonetwork_city
having
	COUNT(*) > 100
order by 
	avg_transaction_revenue desc 
limit 10;

-- ************************************************

-- More complex query that uses window functions to find the top 3 products (by revenue) for each city. 
-- This can provide insights into regional product preferences.
select 
	city_product_rank.geonetwork_city,
	city_product_rank.hits_product_productsku,
	city_product_rank.total_revenue,
	city_product_rank.product_rank
from
	(
		select
			geonetwork_city,
			hits_product_productsku,
			SUM(hits_product_productrevenue) as total_revenue,
			RANK() over (
				partition by geonetwork_city
				order by SUM(hits_product_productrevenue) desc
			) as product_rank
		from 
			all_transactions
		where 
			geonetwork_city is not null and geonetwork_city not in ('not available in demo dataset', '(not set)')
		group by
			geonetwork_city,
			hits_product_productsku
	) as city_product_rank
where 
	city_product_rank.product_rank <= 3;

-- ************************************************


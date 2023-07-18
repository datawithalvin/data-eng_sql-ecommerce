-- Creating the 'all_products' table
-- This table contains information about the different products available, including SKU, name, quantity ordered, 
-- stock level, restocking lead time, sentiment score and sentiment magnitude
CREATE TABLE product_information (
  sku_product VARCHAR(100) PRIMARY KEY,    -- Unique identifier for each product
  product_name VARCHAR(255),               -- Name of the product
  ordered_qty INT NOT NULL CHECK (ordered_qty >= 0),             -- Quantity of the product ordered
  stock_lvl INT NOT NULL CHECK (stock_lvl >= 0),                  -- Current stock level of the product
  restocking_lead_time INT NOT NULL CHECK (restocking_lead_time >= 0),          -- Lead time for restocking the product
  sentiment_score REAL,             -- Sentiment score of the product
  sentiment_magnitude REAL          -- Magnitude of the sentiment score
);


-- Creating the 'product_list' table
-- This table links product SKU to the product name. It's like a lookup table for product names based on SKU
CREATE TABLE product_list (
  sku_product VARCHAR(100) PRIMARY KEY,    -- Unique identifier for each product
  product_name_v2 VARCHAR(255)              -- Version 2 of the product name
);


-- Creating the 'session_records' table
-- This table records all transactions, including information about visitors, hits, totals and geography
CREATE TABLE transaction_records (
  id_unique_visitor VARCHAR(255),                            -- Unique identifier for each visitor
  channel_group VARCHAR(100),                          -- Channel through which the visitor reached the website
  hits_time VARCHAR(255),                                -- Time of the hit
  geo_network_country VARCHAR(255),                       -- Country from where the visit originated
  geo_network_city VARCHAR(255),                          -- City from where the visit originated
  total_transaction_revenue REAL,                   -- Total revenue from the transaction
  number_of_transactions INT,                               -- Total number of transactions
  time_spent INT,                                 -- Total time spent on the site
  page_views INT,                                  -- Total number of page views
  date DATE,                                             -- Date of the visit
  id_visit VARCHAR(255),                                           -- Unique identifier for each visit
  hits_type VARCHAR(100),                                -- Type of the hit
  product_refund_amount REAL,                 -- Refund amount for the product
  product_qty INT,                      -- Quantity of the product
  product_price REAL,                        -- Price of the product
  product_revenue REAL,                      -- Revenue from the product
  sku_product VARCHAR(100),                  -- SKU of the product
  product_name_v2 VARCHAR(255),               -- Version 2 of the product name
  product_category_v2 VARCHAR(255),           -- Version 2 of the product category
  product_variant VARCHAR(255),              -- Variant of the product
  item_currency_code VARCHAR(10),                    -- Currency code for the item
  item_qty INT,                            -- Quantity of the item
  item_revenue REAL,                            -- Revenue from the item
  transaction_revenue REAL,              -- Revenue from the transaction
  transaction_id VARCHAR(255),                    -- Unique identifier for the transaction
  page_title VARCHAR(255),                      -- Title of the page
  page_search_keyword VARCHAR(255),                  -- Search keyword used on the page
  page_path_lvl_1 VARCHAR(255)                  -- Path of the page
);


-- Check if the tables have already been created and if the columns are in the correct data types
SELECT 
	table_name, column_name, data_type 
FROM 
	information_schema.columns
WHERE 
	table_schema = 'public'
ORDER BY 
	table_name, ordinal_position;
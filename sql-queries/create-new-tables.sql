-- Creating the 'products' table
-- This table contains information about the different products available, including SKU, name, quantity ordered, 
-- stock level, restocking lead time, sentiment score and sentiment magnitude
CREATE TABLE products (
  SKU VARCHAR(100) PRIMARY KEY,    -- Unique identifier for each product
  Name VARCHAR(255),               -- Name of the product
  OrderedQuantity INT,             -- Quantity of the product ordered
  StockLevel INT,                  -- Current stock level of the product
  RestockingLeadTime INT,          -- Lead time for restocking the product
  SentimentScore REAL,             -- Sentiment score of the product
  SentimentMagnitude REAL          -- Magnitude of the sentiment score
);


-- Creating the 'product_list' table
-- This table links product SKU to the product name. It's like a lookup table for product names based on SKU
CREATE TABLE product_list (
  productSKU VARCHAR(100) PRIMARY KEY,    -- Unique identifier for each product
  v2ProductName VARCHAR(255)              -- Version 2 of the product name
);


-- Creating the 'alltransactions' table
-- This table records all transactions, including information about visitors, hits, totals and geography
CREATE TABLE all_transactions (
  fullVisitorId VARCHAR(255),                            -- Unique identifier for each visitor
  channelGrouping VARCHAR(100),                          -- Channel through which the visitor reached the website
  hits_time VARCHAR(255),                                -- Time of the hit
  geoNetwork_country VARCHAR(255),                       -- Country from where the visit originated
  geoNetwork_city VARCHAR(255),                          -- City from where the visit originated
  totals_totalTransactionRevenue REAL,                   -- Total revenue from the transaction
  totals_transactions INT,                               -- Total number of transactions
  totals_timeOnSite INT,                                 -- Total time spent on the site
  totals_pageviews INT,                                  -- Total number of page views
  date DATE,                                             -- Date of the visit
  visitId VARCHAR(255),                                           -- Unique identifier for each visit
  hits_type VARCHAR(100),                                -- Type of the hit
  hits_product_productRefundAmount REAL,                 -- Refund amount for the product
  hits_product_productQuantity INT,                      -- Quantity of the product
  hits_product_productPrice REAL,                        -- Price of the product
  hits_product_productRevenue REAL,                      -- Revenue from the product
  hits_product_productSKU VARCHAR(100),                  -- SKU of the product
  hits_product_v2ProductName VARCHAR(255),               -- Version 2 of the product name
  hits_product_v2ProductCategory VARCHAR(255),           -- Version 2 of the product category
  hits_product_productVariant VARCHAR(255),              -- Variant of the product
  hits_item_currencyCode VARCHAR(10),                    -- Currency code for the item
  hits_item_itemQuantity INT,                            -- Quantity of the item
  hits_item_itemRevenue REAL,                            -- Revenue from the item
  hits_transaction_transactionRevenue REAL,              -- Revenue from the transaction
  hits_transaction_transactionId VARCHAR(255),                    -- Unique identifier for the transaction
  hits_page_pageTitle VARCHAR(255),                      -- Title of the page
  hits_page_searchKeyword VARCHAR(255),                  -- Search keyword used on the page
  hits_page_pagePathLevel1 VARCHAR(255)                  -- Path of the page
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

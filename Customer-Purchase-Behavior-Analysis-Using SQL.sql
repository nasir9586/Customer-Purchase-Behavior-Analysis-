---------------------------------------Sales Analysis-----------------------------------------------------

CREATE TABLE customer_data (
    customer_id VARCHAR(20),
    customer_tenure INT,
    customer_location VARCHAR(50),
    customer_type VARCHAR(20),
    order_id VARCHAR(20),
    order_date DATE,
    order_value DECIMAL(10,2),
    payment_method VARCHAR(20),
    order_frequency INT,
    discount_applied INT,
    return_status VARCHAR(5),
    product_category VARCHAR(50),
    product_sku VARCHAR(20),
    size VARCHAR(10),
    inventory_status VARCHAR(20),
    source VARCHAR(50),
    engagement_score INT
);

COPY customer_data
FROM 'C:/Users/Nasir/Downloads/SAADAA_assessment_data.csv'
DELIMITER ','
CSV HEADER;

Select * from customer_data;

--------------------------- Customer Behavior Analysis --------------------------------------------

--- What is the average order value per customer type?
SELECT customer_type, AVG(order_value) AS avg_order_value
FROM transactions
GROUP BY customer_type;

--- Q2: Which customers have placed the highest number of orders?
SELECT customer_id, COUNT(order_id) AS total_orders
FROM transactions
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 10;

--- Q3: What is the lifetime value (LTV) of each customer?
SELECT customer_id, SUM(order_value) AS total_spent
FROM transactions
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

-------------------------------- Sales Performance Analysis --------------------------------------------------

--- Q4: Which product categories generate the highest revenue?
SELECT product_category, SUM(order_value) AS total_revenue
FROM transactions
GROUP BY product_category
ORDER BY total_revenue DESC;

--- Q5: What are the seasonal trends in sales?
SELECT MONTH(order_date) AS month, SUM(order_value) AS total_sales
FROM transactions
GROUP BY month
ORDER BY total_sales DESC;


--------------------------------- Marketing Effectiveness Analysis --------------------------------------------

--- Q6: Which marketing source drives the highest sales?
SELECT source, COUNT(order_id) AS total_orders, SUM(order_value) AS total_sales
FROM transactions
GROUP BY source
ORDER BY total_sales DESC;

--- Q7: What is the average engagement score by marketing channel?
SELECT source, AVG(engagement_score) AS avg_engagement
FROM transactions
GROUP BY source
ORDER BY avg_engagement DESC;


----------------------------------- Return Analysis ----------------------------------------------------

--- Q8: How does discount percentage affect return rates?
SELECT discount_applied, 
       COUNT(CASE WHEN return_status = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS return_rate
FROM transactions
GROUP BY discount_applied
ORDER BY return_rate DESC;

--- Q9: Which product categories have the highest return rates?
SELECT product_category, 
       COUNT(CASE WHEN return_status = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS return_rate
FROM transactions
GROUP BY product_category
ORDER BY return_rate DESC;

-------------------------------- Inventory Optimization -------------------------------------------------

---Q10: SELECT product_sku, product_category, COUNT(order_id) AS sales_count, inventory_status
FROM transactions
WHERE inventory_status = 'In Stock'
GROUP BY product_sku, product_category, inventory_status
ORDER BY sales_count DESC
LIMIT 10;

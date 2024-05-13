-- Exploratory Data Analysis for Dashboard Performance Analytics Kimia Farma Business Year 2020-2023
SELECT
    branch_name,
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT customer_name) AS total_customers,
    MIN(date) AS earliest_date,
    MAX(date) AS latest_date,
    AVG(price) AS average_price,
    AVG(discount_percentage) AS average_discount_percentage,
    AVG(gross_profit_percentage) AS average_gross_profit_percentage,
    SUM(nett_sales) AS total_net_sales,
    SUM(nett_profit) AS total_net_profit,
    AVG(rating_transaction) AS average_transaction_rating,
    AVG(rating_branch) AS average_branch_rating, 
FROM `rakamin-kf-analytics-423018.kimia_farma.kf_table_of_analysis`
GROUP BY branch_name
ORDER BY total_net_sales DESC;
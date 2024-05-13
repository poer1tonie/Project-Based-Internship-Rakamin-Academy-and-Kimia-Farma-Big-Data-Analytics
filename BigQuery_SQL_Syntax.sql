-- Create a New Table of Analysis in the Kimia Farma Database
CREATE TABLE `kimia_farma.kf_table_of_analysis` AS
SELECT
    ft.transaction_id,
    ft.date,
    ft.branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    ft.rating AS rating_transaction,
    ft.customer_name,
    ft.product_id,
    p.product_name,
    ft.price,
    ft.discount_percentage,
    CASE 
        WHEN ft.price <= 50000 THEN 0.1
        WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
        WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.2
        WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
        ELSE 0.3
    END AS gross_profit_percentage,
    (ft.price * (1 - (ft.discount_percentage / 100))) AS nett_sales,
    (ft.price * (1 - (ft.discount_percentage / 100)) * 
    CASE 
        WHEN ft.price <= 50000 THEN 0.1
        WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
        WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.2
        WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
        ELSE 0.3
    END) AS nett_profit,
    kc.rating AS rating_branch
FROM `kimia_farma.kf_final_transaction` ft
JOIN `kimia_farma.kf_kantor_cabang` kc ON ft.branch_id = kc.branch_id
JOIN `kimia_farma.kf_product` p ON ft.product_id = p.product_id;
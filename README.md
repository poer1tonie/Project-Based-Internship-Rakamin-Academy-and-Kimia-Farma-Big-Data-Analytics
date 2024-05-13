## 📂 **About The Program**
As a Big Data Analytics Intern at Kimia Farma, my tasks will encompass a series of challenges that require a deep understanding of data and analytical skills. One of my main projects is to evaluate Kimia Farma's business performance from 2020 to 2023. Through the narrative built from the analysis findings, I can highlight important insights into sales performance, including areas requiring further attention and potential growth opportunities. The prepared infographics and data visualizations provide clear and easily understandable understanding of the analysis findings, facilitating interpretation and decision-making.

## 📂 **About Kimia Farma**
Kimia Farma is the first pharmaceutical industry company in Indonesia, founded by the Dutch East Indies government in 1817. The company's original name was NV Chemicalien Handle Rathkamp & Co. Based on the policy of nationalization of former Dutch companies in the early independence period, in 1958, the Republic of Indonesia government merged several pharmaceutical companies into PNF (State Pharmaceutical Company) Bhinneka Kimia Farma. Then on August 16, 1971, the legal form of PNF was changed to a Limited Liability Company, so the company's name was changed to PT Kimia Farma (Persero).

## 📂 **Objective**
The objective of the project is to evaluate the business performance of Kimia Farma from 2020 to 2023. Required to complete a series of challenges that involve importing data sets into BigQuery, creating analytical tables, and building a dashboard in Google Looker Studio.

## 📂 **Challenges**
- **Challenge 1**: Importing data sets into BigQuery. Import four data sets provided by Kimia Farma.
- **Challenge 2**: Creating analytical tables in BigQuery. Create a new table in BigQuery that combines the data from the four imported datasets.
- **Challenge 3**: Creating a performance dashboard in Google Looker Studio. Create a dashboard in Google Looker Studio that visualizes the data from the analytical table you created in BigQuery.

## 📂 **Importing Dataset to BigQuery**
### Dataset
The provided dataset consists of the following tables: <br>
-  kf_final_transaction.csv 
-  kf_inventory.csv  
-  kf_kantor_cabang.csv
-  kf_product.csv

## 📂 **Design Datamart**
### Aggregate Table
An aggregate table is a table created by gathering and calculating data from the base tables. This aggregate table contains more concise information and is used for analyzing data more quickly and efficiently. The results of this table will be used as a source for creating sales dashboard reports. The following are the mandatory columns in this table: <br>

* transaction_id: Transaction ID
* date: Date of transaction
* branch_id: Kimia Farma branch ID
* branch_name: Name of Kimia Farma branch
* city: City of Kimia Farma branch
* province: Province of Kimia Farma branch
* rating_branch: Customer rating of the Kimia Farma branch
* customer_name: Name of the customer conducting the transaction
* product_id: Drug product code
* product_name: Name of the drug
* actual price: Drug price
* discount_percentage: Percentage of discount given on the drug
* gross_profit_percentage: Percentage of profit expected from the drug
* nett_sales: Price after discount
* nett_profit: Profit obtained by Kimia Farma
* transaction_rating: Customer rating of the transaction conducted

## 📂 **SQL Syntax**
Google BigQuery Link : https://console.cloud.google.com/bigquery?sq=784164172648:d66c1687344e4fc386f20e6a5f78b53f

This SQL syntax is used to create a new table named `kf_table_of_analysis` in the database `kimia_farma`. The new table is populated with data selected from existing tables (`kf_final_transaction`, `kf_kantor_cabang`, and `kf_product`).
#### 1. Create New Table
```SQL
CREATE TABLE `kimia_farma.kf_table_of_analysis` 
```
This line creates a new table named `kf_table_of_analysis` in the `kimia_farma` database.
#### 2. Data Selection and Transformation
```SQL
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
```
This `SELECT` statement fetches data from the specified tables (`kf_final_transaction`, `kf_kantor_cabang`, and `kf_product`). It selects specific columns from these tables and performs transformations on some columns:
* It calculates `gross_profit_percentage` based on the `price` column.
* It calculates `nett_sales` by subtracting the discount from the `price`.
* It calculates `nett_profit` based on `nett_sales` and `gross_profit_percentage`.

#### 3. Data Joins
```SQL
FROM `kimia_farma.kf_final_transaction` ft
JOIN `kimia_farma.kf_kantor_cabang` kc ON ft.branch_id = kc.branch_id
JOIN `kimia_farma.kf_product` p ON ft.product_id = p.product_id;
```
This part specifies the tables to be joined (`kf_final_transaction`, `kf_kantor_cabang`, and `kf_product`) and the conditions for joining them. It joins `kf_final_transaction` with `kf_kantor_cabang` on `branch_id` and `kf_final_transaction` with `kf_product` on `product_id`.

#### 📂 **Exploratory Data Analysis for Dashboard Performance Analytics Kimia Farma Business Year 2020-2023**
Google BigQuery Link : https://console.cloud.google.com/bigquery?sq=784164172648:30103ada7f424273b1d45c0a411fcfed

```SQL
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
```
This query provides the following insights:
* Total number of transactions.
* Total number of customers per branch.
* Earliest and latest transaction dates.
* Average price, discount percentage, and gross profit percentage.
* Total net sales and net profit.
* Average transaction and branch ratings.

## 📂 **Data Visualization**
This dashboard you're creating is based on the analysis table you've previously built in BigQuery, so you need to connect that table to Google Looker Studio. You can design the dashboard according to your creativity, but it should include:

* Dashboard Title
* Dashboard Summary
* Filter Control
* Snapshot Data
* Year-over-Year Revenue Comparison for Kimia Farma
* Top 10 Total Transactions by Province Branch
* Top 10 Nett Sales by Province Branch
* Top 5 Branches with the Highest Ratings but Lowest Transaction Ratings
* Indonesia's Geo Map for Total Profit by Province
* And other analyses you can explore.

Google Looker Dashboard Link: https://lookerstudio.google.com/reporting/22617c03-62d3-4d3b-87b4-e30c755a2515
![image](https://github.com/poer1tonie/Project-Based-Internship-Rakamin-Academy-dan-Kimia-Farma-Big-Data-Analytics/assets/165170405/daa54314-f868-4861-a502-c4dd1bf763fd)








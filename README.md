# Retail_Sales_SQL
## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure
### 1. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

- ```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;


### 1. Data Exploration & Cleaning
# total sales ----------------
select count(*) as total_sales from retailsale;

# total unique customers ----------------
select count(distinct customer_id) as total_customer from retailsale;

#catagories----------------
select distinct category  from retailsale;

#***********************************************************************************************************************
#SQL query to retrieve all columns for sales made on '2022-11-05
select * from retailsale where sale_date = '2022-11-05';

#SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
select * from retailsale 
        where year(sale_date) = '2022'
        and month(sale_date) = '11'
        and category = 'clothing'
	    and quantity >= 4;

#SQL query to calculate the total sales (total_sale) for each category.       
select category, sum(total_sale) as total_sales from retailsale 
         group by category;  
         
#SQL query to find the average age of customers who purchased items from the 'Beauty' category.         
select category, avg(age) as avg_age from retailsale 
where category = 'beauty'
group by category;       

#SQL query to find all transactions where the total_sale is greater than 1000.
select * from retailsale where total_sale > 1000;

#SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category, gender, count(transaction_id) as transactions from retailsale 
             group by category, gender
             order by category;

#SQL query to calculate the average sale for each month. Find out best selling month in each year             
select year(sale_date) as years, month(sale_date) as months, 
       round(avg(total_sale),2) as avg_sale 
                             from retailsale
                             group by years,months
                             order by avg_sale desc
                             limit 2;

#SQL query to find the top 5 customers based on the highest total sales 							
select customer_id, sum(total_sale) as total_sales  from retailsale
                  group by customer_id
                 order by total_sales desc
                 limit 5;                            

#SQL query to find the number of unique customers who purchased items from each category.							
 select category, 
     count(distinct customer_id) as customers 
                 from retailsale 
                 group by category
                 order by customers desc;
  
#SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)  
 with cte as          
(select *,
      case when hour(sale_time) < 12 then 'Morning'
           WHEN HOUR(sale_time) >= 12 AND HOUR(sale_time) < 17 THEN 'Afternoon'
           when hour(sale_time) >= 17 then 'Evening' 
           else 'no shift'
           end as Shifts
           from retailsale) 
                    select shifts, count(transaction_id) as total_orders 
                    from cte group by shifts
                    order by total_orders desc;     

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.



create database retail_sale;
use retail_sale;
select * from retailsale;


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
				                                         
#*******************************************************************************************************************************************

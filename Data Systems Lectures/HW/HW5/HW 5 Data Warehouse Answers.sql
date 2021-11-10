# Homework 4 SQL
# Sahib Bajwa

# Question 1
SELECT dim_customer.CustomerName, dim_customer.Gender, dim_salesperson.SalesPersonName, dim_salesperson.City FROM fact_productsales
	INNER JOIN dim_salesperson ON fact_productsales.SalesPersonID = dim_salesperson.SalesPersonID
    INNER JOIN dim_customer ON fact_productsales.CustomerID = dim_customer.CustomerID
    INNER JOIN dim_date ON fact_productsales.SalesDateKey = dim_date.DateKey
    WHERE dim_date.MONTHNAME = 'September' AND dim_date.YEAR = '2015' AND fact_productsales.SalesPrice > 20 AND fact_productsales.Quantity > 8;
    
# Question 2
SELECT dim_store.StoreName, dim_store.City, dim_product.ProductName FROM fact_productsales
	INNER JOIN dim_store ON fact_productsales.StoreID = dim_store.StoreID
    INNER JOIN dim_product ON fact_productsales.ProductID = dim_product.ProductKey
    INNER JOIN dim_date ON fact_productsales.SalesDateKey = dim_date.DateKey
    WHERE fact_productsales.ProductCost < 50 AND dim_store.City = 'Boulder' AND dim_date.MONTHNAME = 'March' AND dim_date.YEAR = '2017';
    
# Question 3
SELECT dim_salesperson.SalesPersonName FROM fact_productsales
	INNER JOIN dim_salesperson ON fact_productsales.SalesPersonID = dim_salesperson.SalesPersonID
    INNER JOIN dim_date ON fact_productsales.SalesDateKey = dim_date.DateKey
    WHERE dim_date.YEAR = '2017'
    GROUP BY dim_salesperson.SalesPersonName
    ORDER BY SUM(fact_productsales.SalesPrice * fact_productsales.Quantity) DESC LIMIT 0, 2;
    
# Question 4
SELECT dim_customer.CustomerName, SUM(fact_productsales.SalesPrice * fact_productsales.Quantity) AS Total_Revenue FROM fact_productsales
	INNER JOIN dim_customer ON fact_productsales.CustomerID = dim_customer.CustomerID
    INNER JOIN dim_date ON fact_productsales.SalesDateKey = dim_date.DateKey
	WHERE dim_date.YEAR = '2017'
    GROUP BY dim_customer.CustomerName
    ORDER BY Total_Revenue DESC LIMIT 0, 1;
    
# Question 5
SELECT dim_store.StoreName, SUM(fact_productsales.SalesPrice) as Total_Sales_Price FROM fact_productsales
	INNER JOIN dim_store ON fact_productsales.StoreID = dim_store.StoreID
    INNER JOIN dim_date ON fact_productsales.SalesDateKey = dim_date.DateKey
    WHERE dim_date.YEAR > 2010 AND dim_date.YEAR < 2017
    GROUP BY dim_store.StoreName
    ORDER BY dim_store.StoreName ASC; 
    
# Question 6
SELECT dim_store.StoreName, dim_product.ProductName, 
	(SUM(fact_productsales.SalesPrice * fact_productsales.Quantity) - SUM(fact_productsales.ProductCost * fact_productsales.Quantity)) AS Total_Profits
	FROM fact_productsales
    INNER JOIN dim_store ON fact_productsales.StoreID = dim_store.StoreID
    INNER JOIN dim_product ON fact_productsales.ProductID = dim_product.ProductKey
    INNER JOIN dim_date ON fact_productsales.SalesDateKey = dim_date.DateKey
    WHERE dim_product.ProductName LIKE '%Jasmine Rice%' AND dim_date.YEAR = '2010'
    GROUP BY dim_store.StoreName;
    
# Question 7
SELECT dim_store.StoreName, dim_date.QUARTER, SUM(fact_productsales.SalesPrice * fact_productsales.Quantity) AS Total_Revenue
	FROM fact_productsales
    INNER JOIN dim_store ON fact_productsales.StoreID = dim_store.StoreID
    INNER JOIN dim_date ON fact_productsales.SalesDateKey = dim_date.DateKey
    WHERE dim_date.YEAR = '2016' AND dim_store.StoreName = 'ValueMart Boulder'
    GROUP BY dim_date.QUARTER
    ORDER BY dim_date.QUARTER ASC;

# Question 8
SELECT dim_customer.CustomerName, SUM(fact_productsales.SalesPrice) AS Total_Sales_Price
	FROM fact_productsales
    INNER JOIN dim_customer ON fact_productsales.CustomerID = dim_customer.CustomerID
    WHERE dim_customer.CustomerName = 'Melinda Gates' OR dim_customer.CustomerName = 'Harrison Ford'
    GROUP BY dim_customer.CustomerName;
    
# Question 9
SELECT dim_store.StoreName, fact_productsales.SalesPrice, fact_productsales.Quantity
	FROM fact_productsales
    INNER JOIN dim_store ON fact_productsales.StoreID = dim_store.StoreID
    INNER JOIN dim_date ON fact_productsales.SalesDateKey = dim_date.DateKey
    WHERE dim_date.YEAR = '2017' AND dim_date.MONTHNAME = 'March' AND dim_date.DAYOFMONTH = '12';
    
# Question 10
SELECT dim_salesperson.SalesPersonName, SUM(fact_productsales.SalesPrice * fact_productsales.Quantity) AS Total_Revenue
	FROM fact_productsales
    INNER JOIN dim_salesperson ON fact_productsales.SalesPersonID = dim_salesperson.SalesPersonID
    GROUP BY dim_salesperson.SalesPersonID
    ORDER BY Total_Revenue DESC LIMIT 0, 1;
    
# Question 11
SELECT dim_product.ProductName
	FROM fact_productsales
    INNER JOIN dim_product ON fact_productsales.ProductID = dim_product.ProductKey
    GROUP BY dim_product.ProductKey
    ORDER BY (SUM(fact_productsales.SalesPrice * fact_productsales.Quantity) - SUM(fact_productsales.ProductCost * fact_productsales.Quantity)) DESC LIMIT 0, 3;

# Question 12
SELECT dim_date.YEAR, dim_date.MONTHNAME, SUM(fact_productsales.SalesPrice * fact_productsales.Quantity) AS Total_Revenue
	FROM fact_productsales
    INNER JOIN dim_date ON fact_productsales.SalesDateKey = dim_date.DateKey
    WHERE dim_date.YEAR = '2017' AND (dim_date.MONTHNAME = 'January' OR dim_date.MONTHNAME = 'February' OR dim_date.MONTHNAME = 'March')
    GROUP BY dim_date.MONTHNAME;
    
# Question 13
SELECT dim_product.ProductName, round(avg(fact_productsales.ProductCost), 2) AS Average_Product_Cost, round(avg(fact_productsales.SalesPrice), 2) AS Average_Sales_Price
	FROM fact_productsales
    INNER JOIN dim_product ON fact_productsales.ProductID = dim_product.ProductKey
    INNER JOIN dim_date ON fact_productsales.SalesDateKey = dim_date.DateKey
    WHERE dim_date.YEAR = '2017'
    GROUP BY dim_product.ProductKey;
    
# Question 14
SELECT dim_customer.CustomerName, round(avg(fact_productsales.SalesPrice), 2) AS Average_Sales_Price, round(avg(fact_productsales.Quantity), 2) as Average_Quantity
	FROM fact_productsales
    INNER JOIN dim_customer ON fact_productsales.CustomerID = dim_customer.CustomerID
    WHERE dim_customer.CustomerName = 'Melinda Gates';
    
# Question 15
SELECT dim_store.StoreName, round(max(fact_productsales.SalesPrice), 2) AS Maximum_Sales_Price, round(min(fact_productsales.SalesPrice), 2) AS Minimum_Sales_Price
	FROM fact_productsales
    INNER JOIN dim_store ON fact_productsales.StoreID = dim_store.StoreID
    WHERE dim_store.City = 'Boulder';
    
# Homework 4 SQL
# Sahib Bajwa

# Question 1
SELECT CompanyName, Country FROM hwsuppliers WHERE Country = 'Japan' OR Country = 'Germany';

# Question 2
SELECT ProductName, QuantityPerUnit, UnitPrice FROM hwproducts WHERE UnitPrice > 4 AND UnitPrice < 7;
# Select ProductName, QuantityPerUnit, UnitPrice FROM hwproducts;

# Question 3
SELECT CompanyName, ContactTitle, City FROM hwcustomers WHERE (Country = 'USA' AND City = 'Portland') OR (Country = 'Canada' AND City = 'Vancouver');

# Question 4
SELECT ContactName, ContactTitle FROM hwsuppliers WHERE SupplierID > 5 OR SupplierID <= 8 ORDER BY ContactName DESC;

# Question 5
SELECT ProductName, UnitPrice FROM hwproducts WHERE UnitPrice IN (SELECT MIN(UnitPrice) FROM hwproducts);
# SELECT ProductName, UnitPrice FROM hwproducts WHERE UnitPrice IN (SELECT UnitPrice FROM hwproducts) ORDER BY UnitPrice ASC;

# Question 6
SELECT ShipCountry, count(ShipCountry) FROM hworders WHERE ShipCountry != 'USA' AND OrderDate > '2015-04-05' AND OrderDate < '2015-05-05';

# Question 7
SELECT FirstName, LastName, date_format(HireDate, "%m/%d/%Y") AS Date FROM hwemployees WHERE Country != 'USA' AND (YEAR(curdate()) - YEAR(HireDate) >= 5);

# Question 8
SELECT ProductName, (UnitsInStock * UnitPrice) AS InventoryValue FROM hwproducts WHERE (UnitsInStock * UnitPrice) > 3000 AND (UnitsInStock * UnitPrice) < 4000;

# Question 9
SELECT ProductName, UnitsInStock, ReorderLevel FROM hwproducts WHERE ProductName LIKE 'S%' AND UnitsInStock > 0 AND UnitsInStock <= ReorderLevel;

# Question 10
SELECT ProductName, UnitPrice FROM hwproducts WHERE QuantityPerUnit LIKE '%box%' AND Discontinued = 1;

# Question 11
SELECT ProductName, (UnitsInStock * UnitPrice) AS InventoryValue FROM hwproducts INNER JOIN hwsuppliers ON hwproducts.SupplierID = hwproducts.SupplierID WHERE Country = 'Japan';

# Question 12
SELECT Country, Count(*) as CountryCount FROM hwcustomers GROUP BY Country HAVING Count(*) > 8;

# Question 13
SELECT ShipCountry, ShipCity, Count(*) as OrderCount FROM hworders WHERE ShipCountry = 'Austria' OR ShipCountry = 'Argentina' GROUP BY ShipCountry;

# Question 14
SELECT hwsuppliers.CompanyName, hwproducts.ProductName FROM hwsuppliers INNER JOIN hwproducts ON hwsuppliers.SupplierID = hwproducts.SupplierId WHERE hwsuppliers.Country = 'Spain';

# Question 15
SELECT AVG(UnitPrice) FROM hwproducts WHERE ProductName LIKE '%T';

# Question 16
SELECT Count(*) as OrderCount, hwemployees.FirstName, hwemployees.LastName, hwemployees.Title FROM hworders INNER JOIN hwemployees ON hworders.EmployeeID = hwemployees.EmployeeID GROUP BY hwemployees.FirstName HAVING Count(*) > 120;

# Question 17
SELECT Count(*) as OrderCount, hwcustomers.CompanyName, hwcustomers.Country FROM hworders INNER JOIN hwcustomers ON hworders.CustomerID = hwcustomers.CustomerID GROUP BY hwcustomers.CompanyName HAVING Count(*) IS NULL OR Count(*) = 0;
#SELECT CompanyName, Country, hworders.OrderID FROM hwcustomers INNER JOIN hworders ON hwcustomers.CustomerID = hworders.CustomerID;
# I cannot find a CompanyName that does not have an OrderId, so I assume there is no company that has no orders on file.

# Question 18
SELECT ProductName, hwcategories.CategoryName FROM hwproducts INNER JOIN hwcategories ON hwproducts.CategoryID = hwcategories.CategoryID WHERE UnitsInStock = 0 GROUP BY ProductName;

# Question 19
SELECT ProductName, QuantityPerUnit, hwsuppliers.Country FROM hwproducts INNER JOIN hwsuppliers ON hwproducts.SupplierID = hwsuppliers.SupplierID WHERE (QuantityPerUnit LIKE '%pkg%' OR QuantityPerUnit LIKE '%pkgs%' OR QuantityPerUnit LIKE '%jars%') AND hwsuppliers.Country = 'Japan';

# Question 20
# hwcustomers (CompanyName, Country) ||| hworders (ShipName) ||| hworderdetails (Unit Price, Quantity, Discount)
SELECT hwcustomers.CompanyName, ShipName, (UnitPrice * Quantity * Discount) AS TotalValue
	FROM hworders
	INNER JOIN hwcustomers ON hworders.CustomerID = hwcustomers.CustomerID
    INNER JOIN hworderdetails ON hworders.OrderID = hworderdetails.OrderID
    WHERE hwcustomers.Country = 'Mexico';
    
# Question 21
SELECT ProductName, hwsuppliers.Region FROM hwproducts INNER JOIN hwsuppliers ON hwproducts.SupplierID = hwsuppliers.SupplierID WHERE ProductName LIKE 'L%' AND hwsuppliers.Region <> '';

# Question 22
SELECT ShipCountry, ShipName, CONCAT(monthname(OrderDate), " ", year(OrderDate)) AS OrderDate FROM hworders WHERE ShipCity = 'Versailles' AND NOT EXISTS (SELECT * FROM hwcustomers WHERE hwcustomers.CustomerId = hworders.CustomerID);

# Question 23
SELECT ProductName, UnitsInStock,
	RANK() OVER (
		ORDER BY UnitsInStock DESC
	) AS 'Rank'
	FROM hwproducts WHERE ProductName LIKE 'F%';

# Question 24
SELECT ProductName, UnitPrice,
	RANK() OVER(
		ORDER BY UnitPrice DESC
	) AS 'Rank'
	FROM hwproducts WHERE ProductID >= 1 AND ProductID <= 5;
    
# Question 25
SELECT FirstName, LastName, Country, date_format(BirthDate, "%m/%d/%Y") as 'Date Of Birth',
	RANK() OVER (
		PARTITION BY Country
		ORDER BY BirthDate DESC
	) AS 'Rank'
    FROM hwemployees WHERE year(BirthDate) > 1984;
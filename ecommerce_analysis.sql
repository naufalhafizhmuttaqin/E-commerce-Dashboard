-- =====================================================
-- E-COMMERCE SALES ANALYSIS
-- Author : Naufal Hafizh Muttaqin
-- Dataset : Cleaned_Dataset.csv
-- Database : ecommerce_db
-- Table : cleaned_dataset
-- =====================================================

-- =====================================================
-- DATABASE SETUP
-- =====================================================

-- Create database (Skip if already created)
CREATE DATABASE IF NOT EXISTS ecommerce_db;

-- Use database
USE ecommerce_db;

-- =====================================================
-- BASIC QUERIES
-- =====================================================

-- 1. Display all records
SELECT *
FROM cleaned_dataset;

-- 2. Preview first 10 records
SELECT *
FROM cleaned_dataset
LIMIT 10;

-- 3. Count total transactions
SELECT COUNT(*) AS TotalTransactions
FROM cleaned_dataset;

-- 4. Count unique customers
SELECT COUNT(DISTINCT CustomerID) AS TotalCustomers
FROM cleaned_dataset;

-- 5. Display product categories
SELECT DISTINCT Category
FROM cleaned_dataset;

-- 6. Display payment methods
SELECT DISTINCT PaymentMethod
FROM cleaned_dataset;

-- 7. Display order status
SELECT DISTINCT OrderStatus
FROM cleaned_dataset;

-- 8. Display provinces
SELECT DISTINCT Province
FROM cleaned_dataset;

-- =====================================================
-- FILTERING DATA
-- =====================================================

-- 9. Display delivered orders
SELECT *
FROM cleaned_dataset
WHERE OrderStatus = 'Delivered';

-- 10. Display orders paid using Credit Card
SELECT *
FROM cleaned_dataset
WHERE PaymentMethod = 'Credit Card';

-- 11. Display orders with quantity greater than 3
SELECT *
FROM cleaned_dataset
WHERE Quantity > 3;

-- 12. Display orders with discount greater than 0
SELECT *
FROM cleaned_dataset
WHERE Discount > 0;

-- 13. Display orders from Jakarta
SELECT *
FROM cleaned_dataset
WHERE City = 'Jakarta';

-- 14. Display completed orders with discount
SELECT *
FROM cleaned_dataset
WHERE OrderStatus = 'Delivered'
AND Discount > 0;

-- 15. Display orders sorted by Total Price (Highest)
SELECT *
FROM cleaned_dataset
ORDER BY TotalPrice DESC;

-- 16. Display Top 10 Highest Transactions
SELECT *
FROM cleaned_dataset
ORDER BY TotalPrice DESC
LIMIT 10;

-- =====================================================
-- AGGREGATE FUNCTIONS
-- =====================================================

-- 17. Calculate Total Revenue
SELECT
    SUM(TotalPrice) AS TotalRevenue
FROM cleaned_dataset;

-- 18. Calculate Average Order Value
SELECT
    AVG(TotalPrice) AS AverageOrderValue
FROM cleaned_dataset;

-- 19. Find Highest Transaction
SELECT
    MAX(TotalPrice) AS HighestTransaction
FROM cleaned_dataset;

-- 20. Find Lowest Transaction
SELECT
    MIN(TotalPrice) AS LowestTransaction
FROM cleaned_dataset;

-- 21. Calculate Total Quantity Sold
SELECT
    SUM(Quantity) AS TotalItemsSold
FROM cleaned_dataset;

-- =====================================================
-- GROUP BY & HAVING
-- =====================================================

-- 22. Total Revenue by Category
SELECT
    Category,
    SUM(TotalPrice) AS TotalRevenue
FROM cleaned_dataset
GROUP BY Category
ORDER BY TotalRevenue DESC;

-- 23. Total Revenue by City
SELECT
    City,
    SUM(TotalPrice) AS TotalRevenue
FROM cleaned_dataset
GROUP BY City
ORDER BY TotalRevenue DESC;

-- 24. Total Orders by Payment Method
SELECT
    PaymentMethod,
    COUNT(*) AS TotalOrders
FROM cleaned_dataset
GROUP BY PaymentMethod
ORDER BY TotalOrders DESC;

-- 25. Total Quantity Sold by Product
SELECT
    Product,
    SUM(Quantity) AS TotalQuantitySold
FROM cleaned_dataset
GROUP BY Product
ORDER BY TotalQuantitySold DESC;

-- 26. Average Order Value by Category
SELECT
    Category,
    AVG(TotalPrice) AS AverageOrderValue
FROM cleaned_dataset
GROUP BY Category
ORDER BY AverageOrderValue DESC;

-- 27. Cities with Revenue Greater Than 100000
SELECT
    City,
    SUM(TotalPrice) AS TotalRevenue
FROM cleaned_dataset
GROUP BY City
HAVING SUM(TotalPrice) > 100000
ORDER BY TotalRevenue DESC;

-- =====================================================
-- CASE WHEN
-- =====================================================

-- 28. Classify Orders Based on Total Price
SELECT
    OrderID,
    TotalPrice,
    CASE
        WHEN TotalPrice >= 500 THEN 'High Value'
        WHEN TotalPrice >= 200 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS OrderCategory
FROM cleaned_dataset;

-- 29. Categorize Discount Status
SELECT
    OrderID,
    Discount,
    CASE
        WHEN Discount > 0 THEN 'Discount Applied'
        ELSE 'No Discount'
    END AS DiscountStatus
FROM cleaned_dataset;

-- =====================================================
-- DATE ANALYSIS
-- =====================================================

-- 30. Monthly Revenue
SELECT
    DATE_FORMAT(OrderDate, '%Y-%m') AS OrderMonth,
    SUM(TotalPrice) AS MonthlyRevenue
FROM cleaned_dataset
GROUP BY DATE_FORMAT(OrderDate, '%Y-%m')
ORDER BY OrderMonth;

-- 31. Monthly Orders
SELECT
    DATE_FORMAT(OrderDate, '%Y-%m') AS OrderMonth,
    COUNT(*) AS TotalOrders
FROM cleaned_dataset
GROUP BY DATE_FORMAT(OrderDate, '%Y-%m')
ORDER BY OrderMonth;

-- =====================================================
-- WINDOW FUNCTIONS
-- =====================================================

-- 32. Rank Products by Revenue
SELECT
    Product,
    SUM(TotalPrice) AS Revenue,
    RANK() OVER(
        ORDER BY SUM(TotalPrice) DESC
    ) AS RevenueRank
FROM cleaned_dataset
GROUP BY Product;

-- 33. Rank Cities by Revenue
SELECT
    City,
    SUM(TotalPrice) AS Revenue,
    DENSE_RANK() OVER(
        ORDER BY SUM(TotalPrice) DESC
    ) AS RevenueRank
FROM cleaned_dataset
GROUP BY City;

-- =====================================================
-- BUSINESS QUESTIONS
-- =====================================================

-- 34. Top 10 Best Selling Products
SELECT
    Product,
    SUM(Quantity) AS QuantitySold
FROM cleaned_dataset
GROUP BY Product
ORDER BY QuantitySold DESC
LIMIT 10;

-- 35. Top Referral Sources
SELECT
    ReferralSource,
    COUNT(*) AS TotalOrders
FROM cleaned_dataset
GROUP BY ReferralSource
ORDER BY TotalOrders DESC;

-- 36. Revenue by Province
SELECT
    Province,
    SUM(TotalPrice) AS TotalRevenue
FROM cleaned_dataset
GROUP BY Province
ORDER BY TotalRevenue DESC;

-- 37. Delivered Orders Percentage
SELECT
    OrderStatus,
    COUNT(*) AS TotalOrders,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM cleaned_dataset),2) AS Percentage
FROM cleaned_dataset
GROUP BY OrderStatus;
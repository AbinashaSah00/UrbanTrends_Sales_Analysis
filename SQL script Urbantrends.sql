Show databases;
create database freelance_projects;
use freelance_projects;
show tables;
select * from urbantrends_sales_jan2023_mar2024 limit 10;
-- Check data types and null counts
SELECT 
    COUNT(*) AS Total_Rows,
    COUNT(Date) AS Non_Null_Dates,
    COUNT(Category) AS Non_Null_Category,
    COUNT(Product) AS Non_Null_Product,
    COUNT(Customer) AS Non_Null_Customer,
    COUNT(Region) AS Non_Null_Region,
    COUNT(Sales_Rep) AS Non_Null_Sales_Rep,
    COUNT(Quantity) AS Non_Null_Quantity,
    COUNT(Unit_Price) AS Non_Null_Unit_Price,
    COUNT(Total_Amount) AS Non_Null_Total_Amount,
    COUNT(Returned) AS Non_Null_Returned
FROM urbantrends_sales_jan2023_mar2024;
-- Convert text to DATE format if needed
SELECT 
    STR_TO_DATE(`Date`, '%Y-%m-%d') AS Sale_Date,
    `Category`,
    `Product`,
    `Customer`,
    `Region`,
    `Sales_Rep`,
    `Quantity`,
    `Unit_Price`,
    `Total_Amount`,
    `Returned`
FROM urbantrends_sales_jan2023_mar2024;

SELECT *,
    -- Step 1: Recalculate the total from Quantity and Unit Price
    ROUND(Quantity * Unit_Price, 2) AS Calculated_Total,

    -- Step 2: Compare calculated total with existing Total_Amount
    CASE 
        WHEN ROUND(Quantity * Unit_Price, 2) <> Total_Amount THEN 'Mismatch'
        ELSE 'OK'
    END AS Total_Check

FROM urbantrends_sales_jan2023_mar2024;

-- Cleaned version of data
CREATE VIEW CleanedUrbanTrends AS
SELECT
    DATE(`Date`) AS Sale_Date,
    TRIM(LOWER(Category)) AS Category,
    TRIM(Product) AS Product,
    TRIM(Customer) AS Customer,
    TRIM(Region) AS Region,
    TRIM(Sales_Rep) AS Sales_Rep,
    Quantity,
    Unit_Price,
    ROUND(Quantity * Unit_Price, 2) AS Total_Amount,
    Returned
FROM urbantrends_sales_jan2023_mar2024
WHERE Quantity > 0 AND Unit_Price > 0;

select * from CleanedUrbanTrends limit 10;



-- ============================================================
--  Queries.sql (SQL Server / SSMS Version)
--  Vehicle Service Management System
--  File 3 of 3 — Run this file THIRD (after Insert_Data.sql)
--  Contains all 20 SQL queries for the DBMS project
-- ============================================================

USE VehicleServiceDB;
GO

-- ============================================================
-- SECTION A: SIMPLE SELECT QUERIES
-- ============================================================

-- ------------------------------------------------------------
-- Query 1: Show all customers
-- Simple SELECT to retrieve all customer records
-- ------------------------------------------------------------
SELECT Customer_ID, First_Name, Last_Name, Phone, Email
FROM Customer
ORDER BY First_Name;
GO

-- ------------------------------------------------------------
-- Query 2: Show all vehicles with their owner name
-- Uses JOIN to combine Vehicle and Customer tables
-- ------------------------------------------------------------
SELECT V.Registration_No,
       V.Make, V.Model, V.Year, V.Vehicle_Type,
       C.First_Name, C.Last_Name, C.Phone
FROM Vehicle V
JOIN Customer C ON V.Customer_ID = C.Customer_ID
ORDER BY C.First_Name;
GO

-- ------------------------------------------------------------
-- Query 3: Show all appointments with complete details
-- Joins 5 tables together to show one full picture
-- ------------------------------------------------------------
SELECT A.Appointment_ID,
       A.Appointment_Date,
       A.Appointment_Time,
       A.Status,
       CONCAT(C.First_Name, ' ', C.Last_Name) AS Customer_Name,
       V.Registration_No,
       V.Make, V.Model,
       S.Service_Name,
       CONCAT(M.First_Name, ' ', M.Last_Name) AS Mechanic_Name
FROM Appointment A
JOIN Customer     C ON A.Customer_ID = C.Customer_ID
JOIN Vehicle      V ON A.Vehicle_ID  = V.Vehicle_ID
JOIN Service_Type S ON A.Service_ID  = S.Service_ID
JOIN Mechanic     M ON A.Mechanic_ID = M.Mechanic_ID
ORDER BY A.Appointment_Date;
GO

-- ------------------------------------------------------------
-- Query 4: Count how many vehicles each customer owns
-- Uses LEFT JOIN so customers with 0 vehicles also appear
-- GROUP BY groups all vehicles under their owner
-- ------------------------------------------------------------
SELECT C.Customer_ID,
       CONCAT(C.First_Name, ' ', C.Last_Name) AS Customer_Name,
       COUNT(V.Vehicle_ID) AS Total_Vehicles
FROM Customer C
LEFT JOIN Vehicle V ON C.Customer_ID = V.Customer_ID
GROUP BY C.Customer_ID, C.First_Name, C.Last_Name
ORDER BY Total_Vehicles DESC;
GO

-- ------------------------------------------------------------
-- Query 5: Show only pending appointments
-- WHERE filters rows - only Pending status will show
-- ------------------------------------------------------------
SELECT A.Appointment_ID,
       A.Appointment_Date,
       CONCAT(C.First_Name, ' ', C.Last_Name) AS Customer,
       V.Registration_No,
       V.Make, V.Model,
       S.Service_Name
FROM Appointment A
JOIN Customer     C ON A.Customer_ID = C.Customer_ID
JOIN Vehicle      V ON A.Vehicle_ID  = V.Vehicle_ID
JOIN Service_Type S ON A.Service_ID  = S.Service_ID
WHERE A.Status = 'Pending';
GO

-- ============================================================
-- SECTION B: AGGREGATE FUNCTION QUERIES
-- ============================================================

-- ------------------------------------------------------------
-- Query 6: Overall revenue summary
-- SUM, AVG, MAX, MIN are all aggregate functions
-- ------------------------------------------------------------
SELECT
    COUNT(Invoice_ID)  AS Total_Bills_Generated,
    SUM(Total_Amount)  AS Total_Revenue_Collected,
    AVG(Total_Amount)  AS Average_Bill_Amount,
    MAX(Total_Amount)  AS Highest_Bill,
    MIN(Total_Amount)  AS Lowest_Bill
FROM Invoice;
GO

-- ------------------------------------------------------------
-- Query 7: How many services each mechanic completed
-- HAVING filters groups - only mechanics with 1+ services show
-- ------------------------------------------------------------
SELECT CONCAT(M.First_Name, ' ', M.Last_Name) AS Mechanic_Name,
       M.Specialization,
       COUNT(SR.Record_ID)  AS Services_Done,
       SUM(SR.Labor_Cost)   AS Total_Labour_Earned
FROM Mechanic M
JOIN Service_Record SR ON M.Mechanic_ID = SR.Mechanic_ID
WHERE SR.Status = 'Completed'
GROUP BY M.Mechanic_ID, M.First_Name, M.Last_Name, M.Specialization
HAVING COUNT(SR.Record_ID) >= 1
ORDER BY Services_Done DESC;
GO

-- ------------------------------------------------------------
-- Query 8: Month wise revenue report
-- Groups invoices by year and month to show monthly earnings
-- ------------------------------------------------------------
SELECT YEAR(Invoice_Date)  AS Year,
       MONTH(Invoice_Date) AS Month,
       COUNT(Invoice_ID)   AS Invoices_Generated
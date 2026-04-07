-- ============================================================
--  DDL_Script.sql (SQL Server / SSMS Version)
--  Vehicle Service Management System
--  File 1 of 3 — Run this file FIRST
--  This file creates the database and all 8 tables
-- ============================================================

-- Step 1: Create and select the database
CREATE DATABASE VehicleServiceDB;
GO

USE VehicleServiceDB;
GO

-- ============================================================
-- Table 1: Customer
-- Stores personal details of every customer
-- ============================================================
CREATE TABLE Customer (
    Customer_ID       INT          IDENTITY(1,1) PRIMARY KEY,
    First_Name        VARCHAR(50)  NOT NULL,
    Last_Name         VARCHAR(50)  NOT NULL,
    Phone             VARCHAR(15)  NOT NULL,
    Email             VARCHAR(100) UNIQUE,
    Address           VARCHAR(200),
    Registration_Date DATE         DEFAULT CAST(GETDATE() AS DATE)
);
GO

-- ============================================================
-- Table 2: Vehicle
-- Stores vehicle details linked to a customer
-- ============================================================
CREATE TABLE Vehicle (
    Vehicle_ID      INT         IDENTITY(1,1) PRIMARY KEY,
    Customer_ID     INT         NOT NULL,
    Registration_No VARCHAR(20) NOT NULL UNIQUE,
    Make            VARCHAR(50),
    Model           VARCHAR(50),
    Year            INT,
    Vehicle_Type    VARCHAR(30),
    Color           VARCHAR(30),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);
GO

-- ============================================================
-- Table 3: Mechanic
-- Stores details of mechanics working at the service center
-- ============================================================
CREATE TABLE Mechanic (
    Mechanic_ID      INT         IDENTITY(1,1) PRIMARY KEY,
    First_Name       VARCHAR(50) NOT NULL,
    Last_Name        VARCHAR(50) NOT NULL,
    Specialization   VARCHAR(100),
    Experience_Years INT,
    Phone            VARCHAR(15),
    Shift_Timing     VARCHAR(50)
);
GO

-- ============================================================
-- Table 4: Service_Type
-- Stores different types of services offered
-- ============================================================
CREATE TABLE Service_Type (
    Service_ID     INT           IDENTITY(1,1) PRIMARY KEY,
    Service_Name   VARCHAR(100)  NOT NULL,
    Description    VARCHAR(MAX),
    Base_Cost      DECIMAL(10,2),
    Duration_Hours INT
);
GO

-- ============================================================
-- Table 5: Appointment
-- Booking table - links Customer, Vehicle, Mechanic, Service
-- ============================================================
CREATE TABLE Appointment (
    Appointment_ID   INT         IDENTITY(1,1) PRIMARY KEY,
    Customer_ID      INT         NOT NULL,
    Vehicle_ID       INT         NOT NULL,
    Mechanic_ID      INT,
    Service_ID       INT         NOT NULL,
    Appointment_Date DATE        NOT NULL,
    Appointment_Time TIME        NOT NULL,
    Status           VARCHAR(20) DEFAULT 'Pending',
    Notes            VARCHAR(MAX),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Vehicle_ID)  REFERENCES Vehicle(Vehicle_ID),
    FOREIGN KEY (Mechanic_ID) REFERENCES Mechanic(Mechanic_ID),
    FOREIGN KEY (Service_ID)  REFERENCES Service_Type(Service_ID)
);
GO

-- ============================================================
-- Table 6: Spare_Part
-- Tracks inventory of spare parts at the service center
-- ============================================================
CREATE TABLE Spare_Part (
    Part_ID           INT           IDENTITY(1,1) PRIMARY KEY,
    Part_Name         VARCHAR(100)  NOT NULL,
    Category          VARCHAR(50),
    Quantity_In_Stock INT           DEFAULT 0
                      CHECK (Quantity_In_Stock >= 0),
    Unit_Price        DECIMAL(10,2),
    Reorder_Level     INT           DEFAULT 10,
    Supplier_Name     VARCHAR(100)
);
GO

-- ============================================================
-- Table 7: Service_Record
-- Tracks what work was done after appointment is confirmed
-- ============================================================
CREATE TABLE Service_Record (
    Record_ID      INT           IDENTITY(1,1) PRIMARY KEY,
    Appointment_ID INT           NOT NULL,
    Service_ID     INT           NOT NULL,
    Mechanic_ID    INT           NOT NULL,
    Start_Date     DATE,
    End_Date       DATE,
    Description    VARCHAR(MAX),
    Status         VARCHAR(20)   DEFAULT 'In Progress',
    Labor_Cost     DECIMAL(10,2),
    Parts_Used     VARCHAR(200),
    Parts_Cost     DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID),
    FOREIGN KEY (Service_ID)     REFERENCES Service_Type(Service_ID),
    FOREIGN KEY (Mechanic_ID)    REFERENCES Mechanic(Mechanic_ID)
);
GO

-- ============================================================
-- Table 8: Invoice
-- Final bill generated after service is completed
-- ============================================================
CREATE TABLE Invoice (
    Invoice_ID     INT           IDENTITY(1,1) PRIMARY KEY,
    Record_ID      INT           NOT NULL,
    Customer_ID    INT           NOT NULL,
    Invoice_Date   DATE          DEFAULT CAST(GETDATE() AS DATE),
    Labor_Cost     DECIMAL(10,2),
    Parts_Cost     DECIMAL(10,2),
    Tax            DECIMAL(10,2),
    Total_Amount   DECIMAL(10,2),
    Payment_Status VARCHAR(20)   DEFAULT 'Pending'
                   CHECK (Payment_Status IN ('Paid', 'Pending')),
    Payment_Mode   VARCHAR(30),
    FOREIGN KEY (Record_ID)   REFERENCES Service_Record(Record_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);
GO

-- ============================================================
-- All 8 tables created successfully!
-- Run Insert_Data.sql next to fill in sample data
-- ============================================================
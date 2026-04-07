
-- ============================================================
-- Insert data into Customer table (5 customers)
-- ============================================================
SET IDENTITY_INSERT Customer ON;
INSERT INTO Customer (Customer_ID, First_Name, Last_Name, Phone, Email, Address, Registration_Date) VALUES
(1, 'Raj',   'Sharma', '9876543210', 'raj@gmail.com',   'Mumbai', '2024-01-15'),
(2, 'Priya', 'Patel',  '8765432109', 'priya@gmail.com', 'Pune',   '2024-02-20'),
(3, 'Amit',  'Joshi',  '7654321098', 'amit@gmail.com',  'Nashik', '2024-03-10'),
(4, 'Sneha', 'Desai',  '6543210987', 'sneha@gmail.com', 'Thane',  '2024-04-05'),
(5, 'Rahul', 'Mehta',  '9123456780', 'rahul@gmail.com', 'Nagpur', '2024-05-12');
SET IDENTITY_INSERT Customer OFF;
GO

-- ============================================================
-- Insert data into Vehicle table (6 vehicles)
-- Note: Customer 1 (Raj) owns 2 vehicles - shows 1:Many relation
-- ============================================================
SET IDENTITY_INSERT Vehicle ON;
INSERT INTO Vehicle (Vehicle_ID, Customer_ID, Registration_No, Make, Model, Year, Vehicle_Type, Color) VALUES
(1, 1, 'MH04AB1234', 'Maruti',  'Swift',  2020, 'Car',  'White'),
(2, 1, 'MH04CD5678', 'Honda',   'City',   2019, 'Car',  'Silver'),
(3, 2, 'MH12EF9012', 'Hyundai', 'Creta',  2021, 'SUV',  'Blue'),
(4, 3, 'MH15GH3456', 'Tata',    'Nexon',  2022, 'SUV',  'Black'),
(5, 4, 'MH20IJ7890', 'Toyota',  'Innova', 2018, 'MPV',  'White'),
(6, 5, 'MH31KL2345', 'Honda',   'Activa', 2021, 'Bike', 'Red');
SET IDENTITY_INSERT Vehicle OFF;
GO

-- ============================================================
-- Insert data into Mechanic table (4 mechanics)
-- Each mechanic has a different specialization
-- ============================================================
SET IDENTITY_INSERT Mechanic ON;
INSERT INTO Mechanic (Mechanic_ID, First_Name, Last_Name, Specialization, Experience_Years, Phone, Shift_Timing) VALUES
(1, 'Suresh', 'Kumar', 'Engine Specialist',      8,  '9811122233', 'Morning'),
(2, 'Ramesh', 'Yadav', 'Tyre and Suspension',    5,  '9822233344', 'Evening'),
(3, 'Vijay',  'Patil', 'Electrical and Battery', 10, '9833344455', 'Morning'),
(4, 'Ganesh', 'More',  'General Service',        3,  '9844455566', 'Evening');
SET IDENTITY_INSERT Mechanic OFF;
GO

-- ============================================================
-- Insert data into Service_Type table (5 service types)
-- ============================================================
SET IDENTITY_INSERT Service_Type ON;
INSERT INTO Service_Type (Service_ID, Service_Name, Description, Base_Cost, Duration_Hours) VALUES
(1, 'Oil Change',          'Engine oil and filter replacement',  500.00,  1),
(2, 'Tyre Replacement',    'Replace one or more worn out tyres', 2000.00, 2),
(3, 'Engine Check',        'Full engine diagnostic and tune-up', 1500.00, 3),
(4, 'Battery Replacement', 'Replace old or dead car battery',    3000.00, 1),
(5, 'Full Service',        'Complete bumper to bumper service',  5000.00, 6);
SET IDENTITY_INSERT Service_Type OFF;
GO

-- ============================================================
-- Insert data into Spare_Part table (5 parts)
-- ============================================================
SET IDENTITY_INSERT Spare_Part ON;
INSERT INTO Spare_Part (Part_ID, Part_Name, Category, Quantity_In_Stock, Unit_Price, Reorder_Level, Supplier_Name) VALUES
(1, 'Engine Oil 5W-30', 'Lubricants', 100, 350.00,  20, 'AutoParts India'),
(2, 'Oil Filter',       'Filters',     80, 150.00,  15, 'AutoParts India'),
(3, 'MRF Tyre 185/65', 'Tyres',        20, 2500.00,  5, 'SpeedParts Co.'),
(4, 'Car Battery 45Ah', 'Electrical',  15, 3500.00,  5, 'SpeedParts Co.'),
(5, 'Brake Pads Set',   'Brakes',      40, 800.00,  10, 'AutoParts India');
SET IDENTITY_INSERT Spare_Part OFF;
GO

-- ============================================================
-- Insert data into Appointment table (5 appointments)
-- Appointment 5 is still Pending - not yet completed
-- ============================================================
SET IDENTITY_INSERT Appointment ON;
INSERT INTO Appointment (Appointment_ID, Customer_ID, Vehicle_ID, Mechanic_ID, Service_ID, Appointment_Date, Appointment_Time, Status, Notes) VALUES
(1, 1, 1, 1, 1, '2025-03-01', '10:00', 'Completed', 'Please check engine noise'),
(2, 2, 3, 2, 2, '2025-03-05', '11:00', 'Completed', 'Front tyres are very worn'),
(3, 3, 4, 3, 4, '2025-03-10', '09:00', 'Completed', 'Battery not holding charge'),
(4, 4, 5, 1, 5, '2025-03-15', '14:00', 'Completed', 'Annual full service due'),
(5, 5, 6, 2, 1, '2025-03-20', '10:00', 'Pending',   'Routine oil change');
SET IDENTITY_INSERT Appointment OFF;
GO

-- ============================================================
-- Insert data into Service_Record table (4 records)
-- Only 4 because Appointment 5 is still Pending
-- ============================================================
SET IDENTITY_INSERT Service_Record ON;
INSERT INTO Service_Record (Record_ID, Appointment_ID, Service_ID, Mechanic_ID, Start_Date, End_Date, Description, Status, Labor_Cost, Parts_Used, Parts_Cost) VALUES
(1, 1, 1, 1,
 '2025-03-01', '2025-03-01',
 'Oil and filter changed, engine noise resolved',
 'Completed', 300.00, 'Engine Oil x2, Oil Filter x1', 850.00),

(2, 2, 2, 2,
 '2025-03-05', '2025-03-05',
 'Replaced front two tyres',
 'Completed', 500.00, 'MRF Tyre x2', 5000.00),

(3, 3, 4, 3,
 '2025-03-10', '2025-03-10',
 'Old battery replaced with new 45Ah battery',
 'Completed', 400.00, 'Car Battery x1', 3500.00),

(4, 4, 5, 1,
 '2025-03-15', '2025-03-16',
 'Full service done including oil change, brake check, and engine tune-up',
 'Completed', 1500.00, 'Engine Oil x1, Brake Pads x1', 1150.00);
SET IDENTITY_INSERT Service_Record OFF;
GO

-- ============================================================
-- Insert data into Invoice table (4 invoices)
-- Tax is calculated at 18% GST
-- Invoice 4 is still Pending payment
-- ============================================================
SET IDENTITY_INSERT Invoice ON;
INSERT INTO Invoice (Invoice_ID, Record_ID, Customer_ID, Invoice_Date, Labor_Cost, Parts_Cost, Tax, Total_Amount, Payment_Status, Payment_Mode) VALUES
(1, 1, 1, '2025-03-01',  300.00,  850.00,  207.00, 1357.00, 'Paid',    'Cash'),
(2, 2, 2, '2025-03-05',  500.00, 5000.00,  990.00, 6490.00, 'Paid',    'Card'),
(3, 3, 3, '2025-03-10',  400.00, 3500.00,  702.00, 4602.00, 'Paid',    'UPI'),
(4, 4, 4, '2025-03-16', 1500.00, 1150.00,  477.00, 3127.00, 'Pending', 'Cash');
SET IDENTITY_INSERT Invoice OFF;
GO

-- ============================================================
-- Sample data inserted into all 8 tables successfully!
-- Run Queries.sql next to test all 20 queries
-- ============================================================
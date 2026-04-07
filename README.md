# Vehicle Service Management System
## DBMS Course Project — AY 2025-26

---

## About the Project

This project is a database design for a **Vehicle Service Management System**.
It manages customers, their vehicles, service appointments, mechanics, spare parts,
and billing — all through a relational database built in MySQL.

---

## Files in This Repository

| File               | Description                                      |
|--------------------|--------------------------------------------------|
| `DDL_Script.sql`   | Creates the database and all 8 tables            |
| `Insert_Data.sql`  | Inserts sample data into all 8 tables            |
| `Queries.sql`      | Contains all 20 SQL queries for the project      |
| `VSMS_DBMS_Report.docx` | Complete project report                    |
| `README.md`        | This file — project description and instructions |

---

## Database Tables (8 Tables)

1. **Customer** — Personal details of service center customers
2. **Vehicle** — Vehicle details linked to customers
3. **Mechanic** — Mechanics working at the service center
4. **Service_Type** — Types of services offered (Oil Change, Tyre, etc.)
5. **Appointment** — Service booking records
6. **Service_Record** — Actual work done during a service
7. **Spare_Part** — Inventory of spare parts
8. **Invoice** — Final bill generated after service completion

---

## How to Run

**Step 1** — Install MySQL Community Server from [mysql.com](https://www.mysql.com/downloads/)

**Step 2** — Install MySQL Workbench from the same website

**Step 3** — Open MySQL Workbench and connect to localhost

**Step 4** — Open `DDL_Script.sql` and click **Execute** (creates all tables)

**Step 5** — Open `Insert_Data.sql` and click **Execute** (fills sample data)

**Step 6** — Open `Queries.sql` and run each query one by one

---

## Software Used

- MySQL Community Server 8.0
- MySQL Workbench 8.0
- ERDPlus (for ER Diagram)
- MongoDB Atlas (for self-learning NoSQL)

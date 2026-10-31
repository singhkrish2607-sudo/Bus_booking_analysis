# 🚌 Bus Booking Data Analysis --- MySQL

A practical **Bus Booking & Cancellation System** project built with
**MySQL 8.0+**.\
The project uses a relational bus-booking database with realistic
synthetic data and a collection of SQL business-analysis queries.

The goal is to demonstrate how SQL can be used to analyze **bookings,
passengers, routes, buses, seats, payments, cancellations, coupons,
occupancy, revenue, and operational performance**.

------------------------------------------------------------------------

## 📌 Project Overview

This project contains:

-   A complete MySQL database schema for a bus-booking platform
-   Realistic synthetic booking and operational data
-   An Entity Relationship (ER) diagram
-   19 SQL business-analysis problems
-   Queries using joins, aggregations, conditional logic, CTEs, date
    functions, and `UNION ALL`
-   Business-oriented questions designed to turn raw transactional data
    into useful insights

The database is designed as a **single-company bus operator system** and
contains **24 tables**.

------------------------------------------------------------------------

## 🗂️ Project Files

``` text
Bus-Booking-Data-Analysis/
│
├── booking full script(1).sql
│   └── Database schema + seed data
│
├── Analysis Queries.sql
│   └── 19 SQL business-analysis queries
│
├── Bus Booking ER Digram.png
│   └── Entity Relationship Diagram
│
└── README.md
    └── Project documentation
```

> For GitHub, you may rename the files to cleaner names such as
> `bus_booking_schema.sql`, `analysis_queries.sql`, and
> `bus_booking_er_diagram.png`.

------------------------------------------------------------------------

## 🛠️ Tech Stack

  Technology            Purpose
  --------------------- --------------------------------------
  **MySQL 8.0+**        Database management and SQL analysis
  **SQL**               Data querying and business analysis
  **MySQL Workbench**   Database execution and visualization
  **ER Diagram**        Understanding table relationships

------------------------------------------------------------------------

## 🗄️ Database Structure

The database is organized into several functional areas.

### 1. Location & Route Management

-   `Cities`
-   `Terminals`
-   `Routes`
-   `Route_stops`

### 2. Fleet Management

-   `Bus_types`
-   `Buses`
-   `Seat_layout`
-   `Bus_amenities`
-   `Drivers`

### 3. Trip & Seat Management

-   `Trips`
-   `Trip_seats`

### 4. Customer & Passenger Management

-   `Users`
-   `Passengers`

### 5. Booking & Payment Management

-   `Bookings`
-   `Booking_passengers`
-   `Payments`
-   `Cancellations`
-   `Refunds`

### 6. Marketing & Customer Engagement

-   `Coupons`
-   `Booking_coupons`
-   `Notifications`
-   `Reviews_ratings`

### 7. Administration

-   `Admin_users`
-   `Operators`

------------------------------------------------------------------------

## 🔗 Entity Relationship Diagram

The ER diagram shows how the major entities are connected through
primary keys and foreign keys.

![Bus Booking ER Diagram](Bus%20Booking%20ER%20Digram.png)

------------------------------------------------------------------------

## 📊 Data Coverage

The supplied SQL script contains synthetic but realistic bus-booking
data based on Indian cities, terminals, routes, buses, passengers,
bookings, payments, and related operations.

The seed-data section describes a data period from **October 1, 2025 to
December 31, 2025**.

The database includes examples involving:

-   Indian cities and bus terminals
-   AC and Non-AC buses
-   Seater, Sleeper, and Semi-Sleeper buses
-   Window and aisle seats
-   Lower and upper decks
-   Ladies-reserved seats
-   UPI, Card, NetBanking, and Wallet payments
-   Confirmed, cancelled, pending, and failed bookings
-   Coupons and discounts
-   Cancellations and refunds
-   Trip reviews and ratings

------------------------------------------------------------------------

# 🔍 Business Analysis Questions

The `Analysis Queries.sql` file contains 18 business questions.

### Booking & Customer Analysis

1.  **Booking Status Analysis**\
    Count confirmed, cancelled, and failed bookings.

2.  **Booking Time Analysis**\
    Identify the hours of the day when the most bookings are made.

3.  **Top Customers by Spending**\
    Analyze customers by booking activity and total amount paid.

4.  **Fare per Kilometre**\
    Compare average trip fares with route distance.

5.  **Passenger ID Proof Analysis**\
    Identify commonly used ID proof types and passengers without ID
    proof.

------------------------------------------------------------------------

### Bus & Operations Analysis

6.  **Bus Amenities Analysis**\
    Compare amenities such as WiFi, CCTV, charging points, and snacks
    across bus types.

7.  **Monthly Booking & Revenue Analysis**\
    Compare confirmed bookings, seats sold, and money earned by month.

8.  **Top Revenue-Generating Routes**\
    Find routes generating the most money from confirmed bookings and
    compare average seat prices.

9.  **Payment Method Analysis**\
    Compare UPI, Card, NetBanking, and Wallet payments along with
    success and failure rates.

10. **Fleet Status & Bus Age Analysis**\
    Analyze buses by type and status and calculate average bus age.

11. **Route Trip Performance**\
    Compare completed and cancelled trips and their average fares for
    each route.

12. **Coupon Performance**\
    Measure coupon usage and total discounts, including unused coupons.

13. **Cancellation Analysis**\
    Analyze cancellation reasons and identify whether cancellations were
    made by users, admins, or the system.

------------------------------------------------------------------------

### Customer & Operational Insights

14. **Customer Demographics**\
    Analyze users by gender and age groups.

15. **Driver License Renewal Analysis**\
    Identify drivers whose licenses are approaching expiry and may
    require renewal.

16. **Route Occupancy Analysis**\
    Calculate average occupancy for completed trips.

17. **Day-of-Week Demand Analysis**\
    Compare occupancy, average fare, and revenue per trip across days of
    the week.

18. **Seat Preference & Sales Analysis**\
    Compare sales rates for:

    -   Window vs. aisle seats
    -   Lower vs. upper deck
    -   Ladies-reserved vs. normal seats

19. **Identifying "Ghost Capacity" (High-Demand Routes with Low Realized Occupancy)**

------------------------------------------------------------------------

# 🧠 SQL Concepts Demonstrated

This project covers several important SQL concepts used in real-world
data analysis:

-   `SELECT`
-   `WHERE`
-   `JOIN`
-   `LEFT JOIN`
-   `GROUP BY`
-   `HAVING`
-   `ORDER BY`
-   `LIMIT`
-   Aggregate functions:
    -   `COUNT()`
    -   `SUM()`
    -   `AVG()`
-   `CASE WHEN`
-   `COALESCE()`
-   `NULLIF()`
-   `ROUND()`
-   Date and time functions:
    -   `HOUR()`
    -   `DAYNAME()`
    -   `DAYOFWEEK()`
    -   `DATE_FORMAT()`
    -   `TIMESTAMPDIFF()`
    -   `DATE_ADD()`
-   Common Table Expressions (`CTE`)
-   `UNION ALL`
-   Conditional aggregation
-   Foreign-key based relational analysis

------------------------------------------------------------------------

# ▶️ How to Run the Project

## 1. Install MySQL

Use **MySQL 8.0 or later**.

You can run the project using:

-   MySQL Workbench
-   MySQL Command Line Client
-   Another MySQL-compatible SQL client

## 2. Create the Database

Open:

``` text
booking full script(1).sql
```

Run the complete script from top to bottom.

The script creates:

``` sql
bus_booking_db
```

and then creates the required tables and loads the supplied seed data.

## 3. Select the Database

``` sql
USE bus_booking_db;
```

## 4. Run the Analysis Queries

Open:

``` text
Analysis Queries.sql
```

Run the queries individually to examine the results of each business
question.

------------------------------------------------------------------------

# 📈 Example Business Insights

The queries are designed to answer practical questions such as:

-   When are customers most likely to book?
-   Which routes generate the most revenue?
-   Which payment methods have higher failure rates?
-   Which bus types have better amenities?
-   Which routes have higher occupancy?
-   Which days show stronger travel demand?
-   Which coupons are being used frequently?
-   Which cancellation reasons occur most often?
-   Which seat types are sold more frequently?
-   Which drivers may need license renewal?

These questions demonstrate how SQL can move beyond simple data
retrieval toward **business-oriented data analysis**.

------------------------------------------------------------------------

# 🎯 Project Objective

The main objective of this project is to practice using SQL for
**real-world business analysis**.

Instead of analyzing isolated tables, the project requires joining
multiple related tables to answer operational and customer-focused
questions.

For example:

``` text
Bookings
    ↓
Trips
    ↓
Routes
    ↓
Buses
    ↓
Seat Layout
```

and:

``` text
Bookings
    ↓
Booking Passengers
    ↓
Passengers
    ↓
Users
```

This makes the project useful for demonstrating practical skills in:

**Database Management → SQL → Data Analysis → Business Insights**

------------------------------------------------------------------------

# 🚀 Possible Future Improvements

The project can be extended by adding:

-   Power BI dashboard for booking and revenue KPIs
-   Monthly revenue and occupancy dashboards
-   Route-level performance dashboards
-   Customer segmentation
-   Demand forecasting
-   Cancellation prediction
-   Revenue forecasting
-   Advanced seat-pricing analysis
-   Automated SQL reporting
-   Python-based exploratory data analysis
-   Machine learning models for demand prediction

------------------------------------------------------------------------

## 👨‍💻 Author

**Krish Singh**

B.Sc. Mathematics \| SQL \| Python \| Data Analysis \| Machine Learning

------------------------------------------------------------------------

## ⭐ Project Focus

> **Turning relational bus-booking data into actionable business
> insights using SQL.**

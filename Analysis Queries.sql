-- Bussiness insites 
show tables;
-- problem 1: Out of all bookings, how many are confirmed, cancelled and failed?
select booking_status, count(*) from bookings
group by booking_status;

-- problem 2: When Do Customers Book Tickets?
-- Find the hours of the day (0 to 23) when most bookings are made.
select hour(booking_date) as Booking_hours, 
count(*) as booking_count
from bookings
group by hour(booking_date)
order by booking_count desc;

-- Problem 3: Top 10 Customers by Spending
-- List the 10 customers who paid the most in confirmed bookings, 
-- with their name, number of bookings and total amount paid.
select u.full_name, 
	count(b.booking_id) as number_of_booking,
    sum(b.total_fare) as total_amount
from users u
join bookings b
on b.user_id = u.user_id
group by u.user_id, u.full_name
order by number_of_booking desc;

-- Problem 4: Fare per Kilometre by Route
-- Divide the average trip fare by the route distance. 
-- Which route is the most expensive per km, and which is the cheapest?
select r.route_code, r.route_name , 
		r.distance_km, 
	round(avg(t.fare),2) as average_trip_fare,
    round(avg(t.fare / r.distance_km),2) as fare_per_km
from routes r
join trips t
on t.route_id = r.route_id
group by r.route_code, r.route_name , r.distance_km  
order by fare_per_km desc;

-- Problem 5: ID Proof Types
-- Which ID proof do passengers use most (Aadhaar, PAN, Passport and so on)? 
-- How many passengers gave no ID proof?
SELECT 
    COALESCE(NULLIF(TRIM(id_proof_type), ''), 'No ID Proof') AS id_proof,
    COUNT(*) AS passenger_count
FROM passengers
GROUP BY COALESCE(NULLIF(TRIM(id_proof_type), ''), 'No ID Proof')
ORDER BY passenger_count DESC;

-- Problem 6: Amenities on Each Bus Type
-- How many buses of each type have WiFi, 
-- CCTV, charging points and etc? Which bus type is best equipped?
select bt.type_name, ba.amenity_name,
count(b.bus_id) as number_of_buses
from bus_amenities ba
join buses b
on b.bus_id = ba.bus_id
join bus_types bt
on bt.bus_type_id = b.bus_type_id
group by bt.type_name,ba.amenity_name
order by number_of_buses desc;

-- Problem 7: For each month, count the confirmed bookings, 
-- the seats sold and the money earned.

select date_format(t.departure_date, '%Y-%m') as travel_month,
count(b.booking_id) as confirmed_booking,
count(bp.booking_passenger_id) as seat_slot,
sum(bp.fare) as earn_money
from trips t
join bookings b
on b.trip_id = t.trip_id
join booking_passengers bp
on bp.booking_id = b.booking_id
where booking_status = "Confirmed"
group by date_format(t.departure_date, '%Y-%m')
order by travel_month ;

-- Problem 8: Which 5 routes earn the most money from confirmed bookings? 
-- Also show the average price paid per seat on each route.
select r.route_name , 
count(b.booking_id) as confirmed_booking,
count(bp.booking_passenger_id) as seat_slot,
sum(bp.fare) as earn_total_money,
avg(bp.fare)
from routes r
join trips t
on t.route_id = r.route_id
join bookings b
on b.trip_id = t.trip_id
join booking_passengers bp
on bp.booking_id = b.booking_id
where booking_status = "Confirmed"
group by r.route_name
order by earn_total_money
limit 5;
		
        
-- problem 9: 
-- How many payments were made by UPI, Card, NetBanking and Wallet? 
-- what percent of each method's payments were successful and failed?
select payment_method,
count(*) as payment_count,
sum(
    case 
		WHEN payment_status = "success" THEN 1 
		else 0
	end ) as successful_payments,
round(sum(case 
	WHEN payment_status = "success" THEN 1 
		else 0
        end )* 100.0/count(*),
        2) as success_percentage,
Round(sum(case 
	WHEN payment_status = "failed" THEN 1 
		else 0
        end )* 100.0/count(*),
        2) as failed_percentage
from payments
group by payment_method
order by failed_percentage desc;


-- Problem 10: 
-- Count our buses by bus type and by status (active, maintenance, retired). 
-- Show the average age of each bus type.
-- Take 2026 as the current year and use the manufacture year.
select bt.type_name,
 b.status,
 count(b.bus_id) as bus_count,
 round(avg(2026 - manufacture_year),2) as avgerage_bus_age
from buses b
join bus_types bt
on bt.bus_type_id = b.bus_type_id
group by bt.type_name, b.status
order by bt.type_name, b.status;
 
-- Problem 11: For each route, 
-- how many trips were completed and how many were cancelled?
-- Also show the average trip fare of each route.

select r.route_name ,
 sum(case
 when t.status = "completed" then 1
 else 0
 end ) as completed_trips,
  sum(case
 when t.status = "cancelled" then 1
 else 0
 end ) as cancelled_trips,
 round(avg(t.fare),2) as avgerag_fare
from trips t
join routes r
on r.route_id = t.route_id
group by route_name
order by route_name;


-- problem 12: For every coupon, 
-- show how many times it was used, the total discount given and
-- also list the coupons that nobody used.
select c.coupon_code,
count(bc.booking_coupon_id) as coupon_count,
coalesce(sum(bc.discount_applied),0) as total_discount
from coupons c
left join booking_coupons bc
on bc.coupon_id = c.coupon_id
group by coupon_code
order by coupon_count desc;


-- Problem 13: 
-- List the cancellation reasons from most common to least common. 
-- Split each count by who cancelled: user, admin or system.
select cancelled_by ,
 cancellation_reason, 
count(*) as cancellation_count
from cancellations 
group by cancelled_by, cancellation_reason
order by cancellation_count;

-- Problem 14: 
-- Count how many users are male, female and other.
-- Then put users into age groups (18-25, 26-35, 36-50, 51 and above) and
-- count each group.
select Gender , 
count(*) as users_count,
case
	when (timestampdiff(YEAR, date_of_birth, curdate()))between 18 and 25 
    then "18-25"  
    when (timestampdiff(YEAR, date_of_birth, curdate()))between 26 and 35 
    then "26-35"
    when (timestampdiff(YEAR, date_of_birth, curdate()))between 36 and 50 
    then "36-50"
    else "above"
end as age_group
from users 
group by gender, age_group
order by Users_count desc;

-- problem 15: 
-- List all drivers with their experience and licence expiry date. 
-- Add a flag for drivers whose licence expires within 6 months 
-- after 31 Dec 2026, so the operations team can renew it in time.

select full_name, experience_years, license_expiry,
case 
	when license_expiry between "2026-12-31" and 
    date_add("2026-12-31", Interval 6 month) 
    then "License renew soon"
    else "NO renewal need"
end as renewal_flag
from drivers  
order by license_expiry desc ;

-- Problem 16: For each route, 
-- calculate the average occupancy:
-- seats sold divided by total seats, times 100.
--  Use only completed trips. Which routes run mostly empty?

select route_code , route_name ,
round(avg(
(b.total_seats - t.available_seats)*100.0/b.total_seats
),2) as avgerage_occupancy

from buses b
join trips t
on t.bus_id = b.bus_id 
join routes r
on r.route_id = t.route_id
where t.status = "completed"
group by route_code, route_name
having avgerage_occupancy > 50
order by avgerage_occupancy desc;


-- - Problem 17: Day-of-Week Demand Pattern
-- For each day of the week, 
-- show the average occupancy, average fare and revenue per trip. 
-- On which days should the company raise prices or add extra buses?
SELECT
    DAYNAME(t.departure_date) AS day_of_week,

    ROUND(
        AVG(
            COALESCE(bk.total_seats, 0) * 100.0
            / b.total_seats
        ),
        2
    ) AS average_occupancy,

    ROUND(
        AVG(bk.total_fare / NULLIF(bk.total_seats, 0)),
        2
    ) AS average_fare,

    ROUND(
        SUM(COALESCE(bk.total_fare, 0))
        / COUNT(DISTINCT t.trip_id),
        2
    ) AS revenue_per_trip

FROM Trips t
JOIN Buses b
    ON t.bus_id = b.bus_id

LEFT JOIN Bookings bk
    ON t.trip_id = bk.trip_id
    AND bk.booking_status = 'confirmed'

WHERE t.status = 'completed'

GROUP BY
    DAYOFWEEK(t.departure_date),
    DAYNAME(t.departure_date)

ORDER BY DAYOFWEEK(t.departure_date);

-- Problem 18:
-- Compare how often these seats get sold: 
-- window vs aisle, lower deck vs upper deck, and ladies-reserved vs normal seats.
with seat_sales as (
SELECT ts.trip_seat_id, sl.seat_position, sl.deck, sl.is_ladies_seat,
        CASE
            WHEN b.booking_status = 'confirmed' THEN 1
            ELSE 0
        END AS sold
FROM Trip_seats ts
JOIN Seat_layout sl
	ON ts.seat_id = sl.seat_id
LEFT JOIN Booking_passengers bp
	ON ts.trip_seat_id = bp.trip_seat_id
LEFT JOIN Bookings b
	ON bp.booking_id = b.booking_id
)
-- windows vs aisle
select "windows vs aisle" as comparision ,
seat_position as seat_type,
count(*) as seat_instance, 
sum(sold) as seat_sold,
round(sum(sold)*100.0/count(*), 2) as seat_rate
from  seat_sales
where seat_position is not null
group by seat_position

union all

-- lower deck vs upper deck
select "lower deck vs upper deck" as comparision ,
deck as seat_type ,
count(*) as seat_instance, 
sum(sold) as seat_sold,
round(sum(sold)*100.0/count(*), 2) as seat_rate
from  seat_sales
where deck is not null
group by deck

union all

-- ladies-reserved vs normal
select "ladies-reserved vs normal" as comparision ,
case 
	when is_ladies_seat = 1 then "ladies seat"
    else "normal seat"
end as seat_type ,
count(*) as seat_instance, 
sum(sold) as seat_sold,
round(sum(sold)*100.0/count(*), 2) as seat_rate
from  seat_sales
where is_ladies_seat is not null
group by is_ladies_seat;


-- Problem 19: 
-- Identifying "Ghost Capacity" (High-Demand Routes with Low Realized Occupancy)
-- Business problem: Some routes look popular on paper because they get lots of bookings, 
-- but last-minute cancellations leave buses running at 50% capacity—costing fuel and
-- driver hours while turning away other potential passengers. 

WITH trip_summary AS (
    SELECT 
        t.trip_id,
        t.route_id,
        t.available_seats,
        COUNT(b.booking_id) AS total_bookings,
        COALESCE(SUM(b.total_seats), 0) AS gross_seats_booked,
        COALESCE(SUM(CASE WHEN b.booking_status = 'cancelled' THEN b.total_seats ELSE 0 END), 0) AS cancelled_seats,
        COALESCE(SUM(CASE WHEN b.booking_status = 'confirmed' THEN b.total_seats ELSE 0 END), 0) AS confirmed_seats,
        COALESCE(SUM(CASE WHEN b.booking_status = 'confirmed' THEN b.total_fare ELSE 0 END), 0) AS net_revenue,
        COALESCE(SUM(CASE WHEN b.booking_status = 'cancelled' THEN b.total_fare ELSE 0 END), 0) AS lost_revenue
    FROM Trips t
    LEFT JOIN Bookings b ON t.trip_id = b.trip_id
    WHERE t.status = 'completed'
    GROUP BY t.trip_id, t.route_id, t.available_seats
),
route_performance AS (
    SELECT 
        r.route_id,
        r.route_code,
        r.route_name,
        COUNT(ts.trip_id) AS completed_trips,
        SUM(ts.gross_seats_booked) AS gross_seats_booked,
        SUM(ts.cancelled_seats) AS cancelled_seats,
        SUM(ts.confirmed_seats) AS net_occupied_seats,
        SUM(ts.confirmed_seats + ts.available_seats) AS total_seat_capacity,
        SUM(ts.net_revenue) AS net_revenue,
        SUM(ts.lost_revenue) AS lost_revenue
    FROM Routes r
    JOIN trip_summary ts ON r.route_id = ts.route_id
    GROUP BY r.route_id, r.route_code, r.route_name
)
SELECT 
    route_code,
    route_name,
    completed_trips,
    gross_seats_booked,
    cancelled_seats,
    net_occupied_seats,
    ROUND((cancelled_seats * 100.0) / NULLIF(gross_seats_booked, 0), 2) AS seat_cancellation_rate_pct,
    ROUND((net_occupied_seats * 100.0) / NULLIF(total_seat_capacity, 0), 2) AS realized_occupancy_pct,
    ROUND(net_revenue, 2) AS net_revenue,
    ROUND(lost_revenue, 2) AS lost_revenue
FROM route_performance
ORDER BY seat_cancellation_rate_pct DESC;

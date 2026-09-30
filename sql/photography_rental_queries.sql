--  Photography Equipment Rental Database - Sample Data

-- Every statement in this script will use photography_rental as its database
USE photography_rental;

/* Displays the tables in photography_rental
   Confirm all 9 tables exist before inserting any data
*/
SHOW TABLES;

/* STEP 0 - RESET
   Empties all 9 tables and resets every AUTO_INCREMENT counter to 1,
   so this script always starts clean and can be run more than once.
   Foreign key checks are paused so the tables can be emptied in any order.
*/
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE repair_order_unit;
TRUNCATE TABLE payment;
TRUNCATE TABLE rental_item;
TRUNCATE TABLE rental;
TRUNCATE TABLE equipment_unit;
TRUNCATE TABLE repair_order;
TRUNCATE TABLE equipment_model;
TRUNCATE TABLE employee;
TRUNCATE TABLE customer;
SET FOREIGN_KEY_CHECKS = 1;

/* STEP 1 - CUSTOMERS
   Customers are inserted first because every rental points to a customer.
   Example: a rental for Usher can't be recorded until Usher exists in this table.
   MySQL assigns customer_id 1-10 automatically in this order (Usher = 1, BTS = 10).

   Sample data rules (all contact details are fictional):
   - Names: my favorite music artists
   - Phone: the artist's Spotify monthly listeners (as of September 2026), padded with zeros to 10 digits
   - Email: artist name @ their record label
   - Address: their record label's address
*/
INSERT INTO customer (name, phone, email, mailing_address) VALUES
('Usher', '479-792-4700', 'usher@gamma.com', '8560 W Sunset Blvd, Los Angeles, CA 90069'),
('Kanye West', '710-764-1200', 'kanyewest@yzy.com', '1755 Broadway, New York, NY 10019'),
('Ariana Grande', '941-457-5200', 'arianagrande@republicrecords.com', '1755 Broadway, New York, NY 10019'),
('Michael Jackson', '889-547-0900', 'michaeljackson@epicrecords.com', '25 Madison Ave, New York, NY 10010'),
('Justin Bieber', '114-947-2380', 'justinbieber@defjam.com', '1755 Broadway, New York, NY 10019'),
('Burna Boy', '463-775-2700', 'burnaboy@atlanticrecords.com', '1633 Broadway, New York, NY 10019'),
('The Notorious B.I.G.', '270-884-3500', 'notoriousbig@badboyrecords.com', '1633 Broadway, New York, NY 10019'),
('Jon Bellion', '430-000-0000', 'jonbellion@beautifulmindrecords.com', '345 N Maple Dr, Beverly Hills, CA 90210'),
('One Direction', '452-131-7100', 'onedirection@columbiarecords.com', '25 Madison Ave, New York, NY 10010'),
('BTS', '313-718-7800', 'bts@bighitmusic.com', '42 Hangang-daero, Yongsan-gu, Seoul, South Korea');
-- To verify, display all 10 customers
SELECT * FROM customer;

/* STEP 2 - EMPLOYEES
   Rentals and returned items point to employees.
   Example: LeBron James can't be recorded as checking out a rental until he exists here.
   MySQL assigns employee_id 1-10 automatically in this order (LeBron James = 1).
   Sample data rule: employee names are my favorite NBA players.
*/
INSERT INTO employee (name) VALUES
('LeBron James'), ('Michael Jordan'), ('Kevin Durant'),
('Stephen Curry'), ('Paul George'), ('Kobe Bryant'), ('Kyrie Irving'),
('Russell Westbrook'), ('Shaquille O''Neal'), ('Hakeem Olajuwon');
-- To verify, display all 10 employees
SELECT * FROM employee;

/* STEP 3 - EQUIPMENT MODELS
   Every equipment unit points to a model.
   Example: serial number CR5-00121 can't be recorded as a Canon EOS R5
   until the EOS R5 model exists here.
   MySQL assigns model_id 1-6 automatically in this order (Canon EOS R5 = 1).
   The rental_rate is the daily price, shared by every unit of that model.
*/
INSERT INTO equipment_model (manufacturer, model_name, category, description, rental_rate) VALUES
('Canon', 'EOS R5', 'Camera Body', '45MP full-frame mirrorless camera with 8K video', 89.00),
('Sony', 'A7 IV', 'Camera Body', '33MP full-frame mirrorless camera', 69.00),
('Canon', 'RF 24-70mm f/2.8L', 'Lens', 'Standard zoom lens for Canon RF mount', 45.00),
('Sony', 'FE 70-200mm f/2.8 GM II', 'Lens', 'Telephoto zoom lens for Sony E mount', 55.00),
('Godox', 'AD600 Pro', 'Lighting', '600W battery-powered studio strobe', 35.00),
('Manfrotto', '055 Carbon Fiber', 'Tripod', 'Carbon fiber tripod with ball head', 15.00);
-- To verify, display all 6 equipment models
SELECT * FROM equipment_model;

/* STEP 4 - REPAIR ORDERS
   Repair order units point to repair orders.
   Example: a repair for the Sony A7 IV can't be recorded until its repair order exists here.
   MySQL assigns repair_order_id 1-3 automatically in this order.
   Dates use MySQL's required format: 'YYYY-MM-DD'.
*/
INSERT INTO repair_order (repair_date) VALUES
('2026-03-17'),
('2026-05-13'),
('2026-07-04');
-- To verify, display all 3 repair orders
SELECT * FROM repair_order;

/* STEP 5 - EQUIPMENT UNITS
   Each unit points to a model.
   Example: unit CR5-00121 has model_id 1, so the Canon EOS R5 must already exist.
   MySQL assigns unit_id 1-10 automatically (CR5-00121 = 1).
   Units 2, 6, and 10 are 'Rented' (still out); unit 4 is 'In Repair'.
*/
INSERT INTO equipment_unit (serial_number, unit_condition, availability_status, model_id) VALUES
('CR5-00121', 'Good', 'Available', 1),
('CR5-00122', 'Good', 'Rented', 1),
('SA7-30451', 'Good', 'Available', 2),
('SA7-30452', 'Fair', 'In Repair', 2),
('CRF-24701', 'Good', 'Available', 3),
('CRF-24702', 'Good', 'Rented', 3),
('SFE-70201', 'Good', 'Available', 4),
('GAD-60011', 'Good', 'Available', 5),
('GAD-60012', 'Fair', 'Available', 5),
('MAN-05501', 'Good', 'Rented', 6);
-- To verify, display all 10 equipment units
SELECT * FROM equipment_unit;

/* STEP 6 - RENTALS
   Each rental points to a customer and an employee.
   Example: rental 1 has customer_id 1 (Usher) and checkout_employee_id 1 (LeBron James).
   MySQL assigns rental_number 1-5 automatically.
   Rental 5 is still out (due 2026-09-30), so its units are marked 'Rented'.
*/
INSERT INTO rental (checkout_date, due_date, customer_id, checkout_employee_id) VALUES
('2026-02-10', '2026-02-13', 1, 1),
('2026-03-12', '2026-03-15', 3, 2),
('2026-05-08', '2026-05-11', 6, 3),
('2026-06-29', '2026-07-02', 2, 4),
('2026-09-26', '2026-09-30', 7, 5);
-- To verify, display all 5 rentals
SELECT * FROM rental;

/* STEP 7 - RENTAL ITEMS
   Each item points to a rental, a unit, and an employee.
   No AUTO_INCREMENT: the key (rental_number + line_number) is entered manually.
   Example: rental 4's items came back on different days to different employees.
   Rental 5's return fields are NULL because the gear is still out.
*/
INSERT INTO rental_item (rental_number, line_number, condition_at_checkout, condition_at_return, return_date, unit_id, checkin_employee_id) VALUES
(1, 1, 'Good', 'Good', '2026-02-13', 1, 2),
(1, 2, 'Good', 'Good', '2026-02-13', 5, 2),
(2, 1, 'Good', 'Damaged - cracked LCD screen', '2026-03-16', 4, 3),
(2, 2, 'Good', 'Good', '2026-03-15', 7, 3),
(3, 1, 'Good', 'Good', '2026-05-11', 8, 1),
(3, 2, 'Good', 'Damaged - flash tube not firing', '2026-05-11', 9, 1),
(3, 3, 'Good', 'Damaged - sticky zoom ring', '2026-05-11', 7, 1),
(4, 1, 'Good', 'Good', '2026-07-02', 3, 4),
(4, 2, 'Good', 'Damaged - shutter malfunction', '2026-07-03', 4, 5),
(5, 1, 'Good', NULL, NULL, 2, NULL),
(5, 2, 'Good', NULL, NULL, 6, NULL),
(5, 3, 'Good', NULL, NULL, 10, NULL);
-- To verify, display all 12 rental items
SELECT * FROM rental_item;

/* STEP 8 - PAYMENTS
   Each payment points to a rental; payment is collected at checkout.
   Example: rentals 2 and 4 each have two payments (split payments).
   MySQL assigns receipt_number 1-7 automatically.
*/
INSERT INTO payment (payment_date, payment_type, amount, rental_number) VALUES
('2026-02-10', 'Card', 402.00, 1),
('2026-03-12', 'Cash', 100.00, 2),
('2026-03-12', 'Card', 272.00, 2),
('2026-05-08', 'Card', 375.00, 3),
('2026-06-29', 'Card', 207.00, 4),
('2026-06-29', 'Card', 207.00, 4),
('2026-09-26', 'Card', 596.00, 5);
-- To verify, display all 7 payments
SELECT * FROM payment;

/* STEP 9 - REPAIR ORDER UNITS
   Each row points to a repair order and a unit (junction table for the M:N relationship).
   No AUTO_INCREMENT: the key (repair_order_id + unit_id) is entered manually.
   Example: repair order 2 covers two units; unit 4 appears on repair orders 1 and 3.
   Cost is NULL for repair order 3 because the estimate isn't in yet.
*/
INSERT INTO repair_order_unit (repair_order_id, unit_id, cost, reason) VALUES
(1, 4, 180.00, 'Cracked LCD screen replaced'),
(2, 9, 95.00, 'Flash tube replaced'),
(2, 7, 120.00, 'Zoom ring cleaned and recalibrated'),
(3, 4, NULL, 'Shutter malfunction - awaiting repair estimate');
-- To verify, display all 4 repair order units
SELECT * FROM repair_order_unit;



/* PART 2 - SAMPLE QUERIES
   Photography Equipment Rental Database - Sample Queries
   Every statement in this script will use photography_rental as its database
*/

/* QUERY 1 - AVAILABLE EQUIPMENT
   Question: What gear is available to rent right now?
*/
SELECT eu.unit_id, em.manufacturer, em.model_name, eu.serial_number  -- columns to display
FROM equipment_unit eu                                               -- start with the units
JOIN equipment_model em ON eu.model_id = em.model_id                 -- add each unit's model details
WHERE eu.availability_status = 'Available'                           -- keep only units on the shelf
ORDER BY em.category, em.model_name;                                 -- sort by category, then model
-- Answer: 6 units are available: 2 camera bodies, 2 lenses, and 2 strobes, but no tripod.

/* QUERY 2 - GEAR CURRENTLY OUT
   Question: What gear is currently out, who has it, and when is it due?
*/
SELECT r.rental_number, c.name AS customer, em.model_name,           -- columns to display
       eu.serial_number, r.due_date                                  
FROM rental r                                                        -- start with the rentals
JOIN customer c         ON r.customer_id = c.customer_id             -- add who rented it
JOIN rental_item ri     ON ri.rental_number = r.rental_number        -- add each item on the rental
JOIN equipment_unit eu  ON ri.unit_id = eu.unit_id                   -- add the physical unit
JOIN equipment_model em ON eu.model_id = em.model_id                 -- add the model name
WHERE ri.return_date IS NULL;                                        -- keep only items not yet returned
-- Answer: 3 items are out with The Notorious B.I.G. on rental 5 (camera, lens, and tripod), due 2026-09-30.

/* QUERY 3 - LATE RETURNS
   Question: Which items came back late, and by how many days?
*/
SELECT r.rental_number, c.name AS customer, em.model_name,           -- columns to display
       r.due_date, ri.return_date,                                   
       DATEDIFF(ri.return_date, r.due_date) AS days_late             -- days between due and return
FROM rental_item ri                                                  -- start with the returned items
JOIN rental r           ON ri.rental_number = r.rental_number        -- add the rental's due date
JOIN customer c         ON r.customer_id = c.customer_id             -- add who rented it
JOIN equipment_unit eu  ON ri.unit_id = eu.unit_id                   -- add the physical unit
JOIN equipment_model em ON eu.model_id = em.model_id                 -- add the model name
WHERE ri.return_date > r.due_date;                                   -- keep only items returned after the due date
-- Answer: The same Sony A7 IV (unit 4) came back 1 day late twice, on Ariana Grande's and Kanye West's rentals.

/* QUERY 4 - PAYMENTS PER RENTAL
   Question: How much was paid on each rental, and in how many payments?
*/
SELECT r.rental_number, c.name AS customer,                          -- columns to display
       COUNT(p.receipt_number) AS num_payments,                      -- count the payments per rental
       SUM(p.amount) AS total_paid                                   -- add up the amounts per rental
FROM rental r                                                        -- start with the rentals
JOIN customer c ON r.customer_id = c.customer_id                     -- add who rented it
JOIN payment p  ON p.rental_number = r.rental_number                 -- add each payment on the rental
GROUP BY r.rental_number, c.name                                     -- combine payments into one row per rental
ORDER BY total_paid DESC;                                            -- largest total first
-- Answer: All 5
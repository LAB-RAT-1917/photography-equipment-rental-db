# Photography Equipment Rental Database

Database Design and Programming – Individual Project

## Overview
A MySQL database for a single-location photography equipment rental shop. It tracks customers, employees, equipment models and individual units, rentals, payments, and repairs. The project includes a hand-drawn Chen ER diagram, a UML diagram from MySQL Workbench, sample data, and ten business queries.

## Repository Structure
| Folder | Contents |
| --- | --- |
| `diagrams/` | `chen_er_diagram.jpeg` (hand-drawn Chen ER diagram) and `uml_eer_diagram.png` (UML diagram from MySQL Workbench) |
| `sql/` | `photography_rental_schema.sql`, `photography_rental_data.sql`, and `photography_rental_queries.sql` |
| `model/` | `photography_rental.mwb` (MySQL Workbench model) |
| `docs/` | `Photography_Rental_Project_Report.pdf` (final report) |

## How to Run
1. Open MySQL Workbench and connect to your local MySQL server.
2. Run `sql/photography_rental_schema.sql` to create the database and its 9 tables.
3. Run `sql/photography_rental_data.sql` to load the sample data. It empties the tables first, so it can be run more than once.
4. Run `sql/photography_rental_queries.sql` to answer the 10 business questions. Each query ends with its expected answer.

## Tools
- MySQL 8.0
- MySQL Workbench 8.0

– Database Design and Programming, Fall 2026

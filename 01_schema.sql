-- Schema for the 'railway' table (UK Train Rides dataset)
-- Source: https://www.kaggle.com/datasets/farheenshaukat/uk-train-rides
--
-- Note: this table was originally created via MySQL Workbench's
-- Table Data Import Wizard, then had its columns renamed to clean
-- snake_case. This file documents the resulting structure so the
-- project can be reproduced from scratch.

CREATE DATABASE IF NOT EXISTS uk_rail;
USE uk_rail;

DROP TABLE IF EXISTS railway;

CREATE TABLE railway (
    transaction_id       VARCHAR(64) PRIMARY KEY,
    date_of_purchase     DATE,
    time_of_purchase     TIME,
    purchase_type        VARCHAR(20),
    payment_method        VARCHAR(30),
    railcard              VARCHAR(30),
    ticket_class          VARCHAR(20),
    ticket_type           VARCHAR(20),
    price                 DECIMAL(10,2),
    departure_station     VARCHAR(100),
    arrival_destination   VARCHAR(100),
    date_of_journey       DATE,
    departure_time        TIME,
    arrival_time          TIME,
    actual_arrival_time   TIME NULL,
    journey_status        VARCHAR(20),
    reason_for_delay      VARCHAR(100),
    refund_request        VARCHAR(5)
);

-- After creating the table, import data/railway.csv using
-- Workbench's Table Data Import Wizard (right-click the table ->
-- Table Data Import Wizard), then run:
--
-- CREATE INDEX idx_route ON railway (departure_station, arrival_destination);
--
-- This index is required for query 03 to run at a reasonable speed.

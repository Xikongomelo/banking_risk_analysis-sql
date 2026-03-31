-- =============================================================================
--  BANKING CUSTOMER RISK ANALYSIS — SQL Project
--  Author: Max
--
--  WHAT THIS PROJECT DOES:
--  We simulate a bank's internal database and answer real business questions
--  that a PwC consultant would ask on behalf of a banking client:
--
--  1. Which customers are highest risk?
--  2. What does our loan portfolio look like?
--  3. Which customer segments drive the most revenue?
--  4. Are there any suspicious transaction patterns?
--
--  DATABASE STRUCTURE (4 tables):
--  customers    — Who are our customers? (demographics)
--  accounts     — What accounts do they hold? (balance, type)
--  loans        — What loans have been issued? (amount, status)
--  transactions — What money movements have occurred?
--
--  HOW TO RUN THIS:
--  Copy and paste this entire file into sqliteonline.com
--  Run it section by section using the instructions below.
-- =============================================================================


-- =============================================================================
--  STEP 1 — CREATE OUR TABLES
--
--  In SQL, a TABLE is like a spreadsheet tab.
--  CREATE TABLE defines the structure — what columns exist and what type
--  of data each column holds.
--
--  Common data types:
--  INTEGER — whole numbers (1, 2, 100)
--  REAL    — decimal numbers (1.5, 99.99)
--  TEXT    — words and sentences ('John', 'Active')
-- =============================================================================

-- Drop tables if they already exist (so we can re-run cleanly)
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS customers;

-- TABLE 1: Customers
-- Every customer has a unique ID, name, age, job, and risk profile
CREATE TABLE customers (
    customer_id   INTEGER PRIMARY KEY,  -- Unique identifier for each customer
    first_name    TEXT NOT NULL,
    last_name     TEXT NOT NULL,
    age           INTEGER,
    gender        TEXT,
    city          TEXT,
    occupation    TEXT,
    credit_score  INTEGER,              -- Higher = more creditworthy (300–850)
    risk_category TEXT                  -- 'Low', 'Medium', 'High'
);

-- TABLE 2: Accounts
-- A customer can have multiple accounts (savings, cheque, etc.)
CREATE TABLE accounts (
    account_id    INTEGER PRIMARY KEY,
    customer_id   INTEGER,              -- Links back to customers table
    account_type  TEXT,                 -- 'Savings', 'Cheque', 'Fixed Deposit'
    balance       REAL,
    status        TEXT,                 -- 'Active', 'Dormant', 'Closed'
    opened_date   TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- TABLE 3: Loans
-- Tracks all loans issued by the bank
CREATE TABLE loans (
    loan_id       INTEGER PRIMARY KEY,
    customer_id   INTEGER,
    loan_type     TEXT,                 -- 'Personal', 'Home', 'Vehicle', 'Business'
    loan_amount   REAL,
    interest_rate REAL,
    term_months   INTEGER,
    status        TEXT,                 -- 'Active', 'Paid Off', 'Defaulted'
    issue_date    TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- TABLE 4: Transactions
-- Every deposit, withdrawal, or transfer
CREATE TABLE transactions (
    transaction_id   INTEGER PRIMARY KEY,
    account_id       INTEGER,
    transaction_type TEXT,              -- 'Deposit', 'Withdrawal', 'Transfer'
    amount           REAL,
    transaction_date TEXT,
    description      TEXT,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);


-- =============================================================================
--  STEP 2 — POPULATE THE TABLES WITH DATA
--
--  INSERT INTO adds rows of data into a table.
--  Think of it like typing data into a spreadsheet row by row.
--  We're creating 20 customers with realistic South African names and cities.
-- =============================================================================

-- Insert Customers
INSERT INTO customers VALUES
(1,  'Sipho',    'Dlamini',   34, 'Male',   'Johannesburg', 'Engineer',       720, 'Low'),
(2,  'Ayesha',   'Patel',     28, 'Female', 'Durban',        'Teacher',        680, 'Low'),
(3,  'Thabo',    'Nkosi',     45, 'Male',   'Pretoria',      'Accountant',     750, 'Low'),
(4,  'Lerato',   'Mokoena',   31, 'Female', 'Cape Town',     'Nurse',          620, 'Medium'),
(5,  'Johan',    'van Wyk',   52, 'Male',   'Johannesburg',  'Manager',        800, 'Low'),
(6,  'Zanele',   'Khumalo',   27, 'Female', 'Soweto',        'Student',        540, 'High'),
(7,  'Pieter',   'Botha',     41, 'Male',   'Pretoria',      'Lawyer',         780, 'Low'),
(8,  'Nomsa',    'Zulu',      38, 'Female', 'Durban',        'Social Worker',  590, 'High'),
(9,  'Ravi',     'Naidoo',    29, 'Male',   'Durban',        'Developer',      710, 'Low'),
(10, 'Fatima',   'Adams',     33, 'Female', 'Cape Town',     'Doctor',         760, 'Low'),
(11, 'Bongani',  'Sithole',   47, 'Male',   'Johannesburg',  'Contractor',     580, 'High'),
(12, 'Chantal',  'du Plessis',25, 'Female', 'Stellenbosch',  'Intern',         510, 'High'),
(13, 'Kagiso',   'Tau',       36, 'Male',   'Pretoria',      'Analyst',        700, 'Medium'),
(14, 'Priya',    'Govender',  30, 'Female', 'Durban',        'Pharmacist',     730, 'Low'),
(15, 'Willem',   'Erasmus',   55, 'Male',   'Cape Town',     'Director',       820, 'Low'),
(16, 'Thandeka', 'Mthembu',   22, 'Female', 'Soweto',        'Unemployed',     480, 'High'),
(17, 'Ashraf',   'Hendricks', 44, 'Male',   'Cape Town',     'Business Owner', 670, 'Medium'),
(18, 'Mpho',     'Sekhabi',   39, 'Female', 'Pretoria',      'HR Manager',     690, 'Medium'),
(19, 'Deon',     'Loots',     48, 'Male',   'Johannesburg',  'Consultant',     740, 'Low'),
(20, 'Lindiwe',  'Mahlangu',  26, 'Female', 'Soweto',        'Cashier',        530, 'High');

-- Insert Accounts
INSERT INTO accounts VALUES
(101, 1,  'Cheque',        15200.50, 'Active',  '2018-03-15'),
(102, 1,  'Savings',       42000.00, 'Active',  '2018-03-15'),
(103, 2,  'Savings',       8500.00,  'Active',  '2020-07-01'),
(104, 3,  'Fixed Deposit', 95000.00, 'Active',  '2019-01-10'),
(105, 3,  'Cheque',        22000.00, 'Active',  '2019-01-10'),
(106, 4,  'Savings',       3200.00,  'Active',  '2021-04-20'),
(107, 5,  'Cheque',        67000.00, 'Active',  '2015-09-05'),
(108, 5,  'Fixed Deposit', 150000.00,'Active',  '2015-09-05'),
(109, 6,  'Savings',       450.00,   'Dormant', '2022-01-12'),
(110, 7,  'Cheque',        88000.00, 'Active',  '2016-06-20'),
(111, 8,  'Savings',       1200.00,  'Active',  '2021-11-03'),
(112, 9,  'Cheque',        19500.00, 'Active',  '2020-02-28'),
(113, 10, 'Savings',       55000.00, 'Active',  '2019-08-14'),
(114, 11, 'Cheque',        2800.00,  'Active',  '2020-05-17'),
(115, 12, 'Savings',       300.00,   'Dormant', '2023-01-05'),
(116, 13, 'Cheque',        12000.00, 'Active',  '2019-10-22'),
(117, 14, 'Savings',       38000.00, 'Active',  '2018-12-01'),
(118, 15, 'Fixed Deposit', 220000.00,'Active',  '2010-04-30'),
(119, 16, 'Savings',       120.00,   'Dormant', '2023-03-01'),
(120, 17, 'Cheque',        24500.00, 'Active',  '2017-07-19'),
(121, 18, 'Savings',       16000.00, 'Active',  '2020-09-10'),
(122, 19, 'Cheque',        51000.00, 'Active',  '2016-11-25'),
(123, 20, 'Savings',       800.00,   'Active',  '2022-08-14');

-- Insert Loans
INSERT INTO loans VALUES
(201, 1,  'Home',     850000.00, 9.5,  240, 'Active',    '2020-06-01'),
(202, 2,  'Personal', 25000.00,  14.5, 36,  'Active',    '2022-03-15'),
(203, 3,  'Vehicle',  180000.00, 11.0, 60,  'Active',    '2021-01-20'),
(204, 4,  'Personal', 15000.00,  16.0, 24,  'Active',    '2023-02-01'),
(205, 5,  'Home',     1200000.00,8.5,  240, 'Active',    '2018-05-10'),
(206, 6,  'Personal', 8000.00,   19.5, 12,  'Defaulted', '2022-07-01'),
(207, 7,  'Business', 500000.00, 10.5, 120, 'Active',    '2019-09-15'),
(208, 8,  'Personal', 12000.00,  18.0, 24,  'Defaulted', '2021-04-01'),
(209, 9,  'Vehicle',  95000.00,  12.0, 60,  'Active',    '2022-11-01'),
(210, 10, 'Home',     950000.00, 9.0,  240, 'Active',    '2020-03-20'),
(211, 11, 'Personal', 20000.00,  17.5, 36,  'Defaulted', '2021-08-01'),
(212, 12, 'Personal', 5000.00,   21.0, 12,  'Defaulted', '2023-01-10'),
(213, 13, 'Vehicle',  120000.00, 11.5, 60,  'Active',    '2021-07-15'),
(214, 14, 'Home',     780000.00, 9.25, 240, 'Paid Off',  '2015-01-01'),
(215, 15, 'Business', 2000000.00,8.0,  120, 'Active',    '2017-03-01'),
(216, 16, 'Personal', 3000.00,   22.0, 6,   'Defaulted', '2023-04-01'),
(217, 17, 'Business', 350000.00, 11.0, 84,  'Active',    '2020-01-15'),
(218, 18, 'Personal', 30000.00,  13.5, 48,  'Active',    '2022-06-01'),
(219, 19, 'Vehicle',  210000.00, 10.5, 72,  'Active',    '2021-12-01'),
(220, 20, 'Personal', 4000.00,   20.0, 12,  'Defaulted', '2023-05-01');

-- Insert Transactions (sample transactions per account)
INSERT INTO transactions VALUES
(301, 101, 'Deposit',    5000.00,  '2024-01-05', 'Salary deposit'),
(302, 101, 'Withdrawal', 1200.00,  '2024-01-08', 'Grocery store'),
(303, 101, 'Withdrawal', 850.00,   '2024-01-15', 'Fuel'),
(304, 102, 'Deposit',    2000.00,  '2024-01-10', 'Transfer from cheque'),
(305, 103, 'Deposit',    3500.00,  '2024-01-05', 'Salary deposit'),
(306, 103, 'Withdrawal', 500.00,   '2024-01-20', 'ATM withdrawal'),
(307, 107, 'Deposit',    25000.00, '2024-01-05', 'Salary deposit'),
(308, 107, 'Withdrawal', 5000.00,  '2024-01-12', 'School fees'),
(309, 109, 'Withdrawal', 200.00,   '2024-01-03', 'ATM withdrawal'),
(310, 110, 'Deposit',    35000.00, '2024-01-05', 'Salary deposit'),
(311, 110, 'Withdrawal', 12000.00, '2024-01-18', 'Home renovation'),
(312, 111, 'Deposit',    1500.00,  '2024-01-05', 'Salary deposit'),
(313, 111, 'Withdrawal', 800.00,   '2024-01-10', 'Rent'),
(314, 112, 'Deposit',    8000.00,  '2024-01-05', 'Salary deposit'),
(315, 114, 'Withdrawal', 1500.00,  '2024-01-07', 'ATM withdrawal'),
(316, 114, 'Withdrawal', 2000.00,  '2024-01-14', 'ATM withdrawal'),
(317, 114, 'Withdrawal', 2800.00,  '2024-01-21', 'ATM withdrawal'),
(318, 119, 'Withdrawal', 100.00,   '2024-01-02', 'ATM withdrawal'),
(319, 120, 'Deposit',    15000.00, '2024-01-05', 'Business income'),
(320, 121, 'Deposit',    6000.00,  '2024-01-05', 'Salary deposit'),
(321, 122, 'Deposit',    18000.00, '2024-01-05', 'Salary deposit'),
(322, 122, 'Withdrawal', 3500.00,  '2024-01-10', 'Investment transfer'),
(323, 123, 'Deposit',    2000.00,  '2024-01-05', 'Salary deposit'),
(324, 123, 'Withdrawal', 1900.00,  '2024-01-06', 'Rent'),
(325, 115, 'Withdrawal', 300.00,   '2024-01-04', 'ATM withdrawal');


-- =============================================================================
--  STEP 3 — BASIC QUERIES (WARM UP)
--
--  SELECT is the most fundamental SQL command.
--  It says: "show me these columns FROM this table"
--
--  WHERE filters rows — like Excel's filter button
--  ORDER BY sorts results
--  LIMIT restricts how many rows come back
-- =============================================================================

-- Query 1: See all customers
-- The * means "give me ALL columns"
SELECT * FROM customers;

-- Query 2: Show only high-risk customers
-- WHERE filters to rows where risk_category equals 'High'
SELECT
    customer_id,
    first_name || ' ' || last_name AS full_name,   -- || joins text together
    age,
    occupation,
    credit_score,
    risk_category
FROM customers
WHERE risk_category = 'High'
ORDER BY credit_score ASC;   -- ASC = lowest score first (most risky)

-- Query 3: Customers with credit score below 600 (subprime)
SELECT
    first_name || ' ' || last_name AS full_name,
    city,
    credit_score,
    occupation
FROM customers
WHERE credit_score < 600
ORDER BY credit_score ASC;


-- =============================================================================
--  STEP 4 — AGGREGATION QUERIES
--
--  Aggregation = summarising many rows into one number.
--  Common aggregate functions:
--  COUNT()  — how many rows?
--  SUM()    — add up all values
--  AVG()    — calculate the average
--  MAX()    — find the largest value
--  MIN()    — find the smallest value
--
--  GROUP BY splits data into groups before aggregating.
--  Think: "for EACH city, what is the average credit score?"
-- =============================================================================

-- Query 4: How many customers in each risk category?
SELECT
    risk_category,
    COUNT(*) AS number_of_customers,
    ROUND(AVG(credit_score), 0) AS avg_credit_score,
    MIN(credit_score) AS lowest_score,
    MAX(credit_score) AS highest_score
FROM customers
GROUP BY risk_category
ORDER BY avg_credit_score DESC;

-- Query 5: Average credit score by city
SELECT
    city,
    COUNT(*) AS customers,
    ROUND(AVG(credit_score), 0) AS avg_credit_score
FROM customers
GROUP BY city
ORDER BY avg_credit_score DESC;

-- Query 6: Total loan portfolio by loan type
-- This tells the bank: where is our money deployed?
SELECT
    loan_type,
    COUNT(*)                          AS number_of_loans,
    ROUND(SUM(loan_amount), 2)        AS total_value,
    ROUND(AVG(loan_amount), 2)        AS avg_loan_size,
    ROUND(AVG(interest_rate), 2)      AS avg_interest_rate
FROM loans
GROUP BY loan_type
ORDER BY total_value DESC;


-- =============================================================================
--  STEP 5 — LOAN DEFAULT ANALYSIS
--
--  This is the most important analysis for a bank.
--  How much money is at risk due to defaulted loans?
--
--  CASE WHEN is SQL's version of IF/ELSE:
--  CASE
--    WHEN condition THEN result
--    WHEN condition THEN result
--    ELSE default_result
--  END
-- =============================================================================

-- Query 7: Loan status breakdown — how much has defaulted?
SELECT
    status,
    COUNT(*)                     AS number_of_loans,
    ROUND(SUM(loan_amount), 2)   AS total_amount,
    ROUND(AVG(loan_amount), 2)   AS avg_amount
FROM loans
GROUP BY status
ORDER BY total_amount DESC;

-- Query 8: Default rate by loan type
-- Which loan type has the highest default rate?
SELECT
    loan_type,
    COUNT(*) AS total_loans,

    -- Count only defaulted loans using CASE WHEN
    SUM(CASE WHEN status = 'Defaulted' THEN 1 ELSE 0 END) AS defaults,

    -- Calculate default rate as a percentage
    ROUND(
        SUM(CASE WHEN status = 'Defaulted' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        1
    ) AS default_rate_pct,

    ROUND(SUM(CASE WHEN status = 'Defaulted' THEN loan_amount ELSE 0 END), 2) AS defaulted_amount
FROM loans
GROUP BY loan_type
ORDER BY default_rate_pct DESC;


-- =============================================================================
--  STEP 6 — JOINS
--
--  A JOIN combines two tables using a shared column.
--  This is one of the most important SQL skills.
--
--  Think of it like a VLOOKUP in Excel — you're saying:
--  "match the customer_id in the loans table with the
--   customer_id in the customers table, and bring me
--   columns from BOTH tables."
--
--  INNER JOIN — only rows that exist in BOTH tables
--  LEFT JOIN  — all rows from the left table, matching rows from right
-- =============================================================================

-- Query 9: Join customers with their loans
-- Who took out loans, and what is their risk profile?
SELECT
    c.first_name || ' ' || c.last_name  AS customer_name,
    c.city,
    c.credit_score,
    c.risk_category,
    l.loan_type,
    l.loan_amount,
    l.interest_rate,
    l.status AS loan_status
FROM customers c                          -- 'c' is an alias — shorthand for customers
INNER JOIN loans l ON c.customer_id = l.customer_id  -- match on customer_id
ORDER BY l.loan_amount DESC;

-- Query 10: High-risk customers who have ACTIVE loans
-- This is a watch list — customers the bank should monitor closely
SELECT
    c.first_name || ' ' || c.last_name  AS customer_name,
    c.credit_score,
    c.occupation,
    c.city,
    l.loan_type,
    l.loan_amount,
    l.interest_rate
FROM customers c
INNER JOIN loans l ON c.customer_id = l.customer_id
WHERE c.risk_category = 'High'
  AND l.status = 'Active'
ORDER BY l.loan_amount DESC;

-- Query 11: Full customer financial profile
-- Join all 3 tables: customers + accounts + loans
SELECT
    c.first_name || ' ' || c.last_name  AS customer_name,
    c.credit_score,
    c.risk_category,
    a.account_type,
    ROUND(a.balance, 2)                  AS account_balance,
    l.loan_type,
    l.loan_amount,
    l.status                             AS loan_status
FROM customers c
LEFT JOIN accounts a ON c.customer_id = a.customer_id
LEFT JOIN loans   l ON c.customer_id = l.customer_id
ORDER BY c.credit_score DESC;


-- =============================================================================
--  STEP 7 — TRANSACTION MONITORING (FRAUD/RISK FLAGS)
--
--  Banks monitor transactions for unusual patterns.
--  A common red flag: multiple large withdrawals in a short period.
--
--  Here we identify accounts with suspicious withdrawal behaviour —
--  this is the kind of query a PwC risk consultant would write
--  when reviewing a bank's transaction monitoring system.
-- =============================================================================

-- Query 12: Total transaction activity per account
SELECT
    a.account_id,
    c.first_name || ' ' || c.last_name  AS customer_name,
    a.account_type,
    COUNT(t.transaction_id)             AS total_transactions,
    ROUND(SUM(CASE WHEN t.transaction_type = 'Deposit'
                   THEN t.amount ELSE 0 END), 2)    AS total_deposits,
    ROUND(SUM(CASE WHEN t.transaction_type = 'Withdrawal'
                   THEN t.amount ELSE 0 END), 2)    AS total_withdrawals
FROM accounts a
INNER JOIN customers    c ON a.customer_id    = c.customer_id
LEFT  JOIN transactions t ON a.account_id     = t.account_id
GROUP BY a.account_id
ORDER BY total_withdrawals DESC;

-- Query 13: FLAG accounts where withdrawals exceed deposits
-- This could indicate financial stress or overdraft risk
SELECT
    c.first_name || ' ' || c.last_name  AS customer_name,
    c.risk_category,
    a.account_type,
    ROUND(a.balance, 2)                 AS current_balance,

    ROUND(SUM(CASE WHEN t.transaction_type = 'Withdrawal'
                   THEN t.amount ELSE 0 END), 2) AS total_withdrawn,

    ROUND(SUM(CASE WHEN t.transaction_type = 'Deposit'
                   THEN t.amount ELSE 0 END), 2) AS total_deposited,

    -- Risk flag using CASE WHEN
    CASE
        WHEN SUM(CASE WHEN t.transaction_type = 'Withdrawal'
                      THEN t.amount ELSE 0 END) >
             SUM(CASE WHEN t.transaction_type = 'Deposit'
                      THEN t.amount ELSE 0 END)
        THEN 'FLAGGED — Withdrawals exceed deposits'
        ELSE 'Normal'
    END AS risk_flag

FROM customers c
INNER JOIN accounts     a ON c.customer_id = a.customer_id
LEFT  JOIN transactions t ON a.account_id  = t.account_id
GROUP BY a.account_id
HAVING total_withdrawn > 0   -- Only show accounts with withdrawal activity
ORDER BY risk_flag DESC;


-- =============================================================================
--  STEP 8 — BUSINESS SUMMARY (EXECUTIVE VIEW)
--
--  The final query is what you'd put in a slide for the bank's CFO.
--  A single clean summary of the bank's portfolio health.
-- =============================================================================

-- Query 14: Bank portfolio health summary
SELECT 'Total Customers'          AS metric, COUNT(*)                                      AS value FROM customers
UNION ALL
SELECT 'High Risk Customers',       COUNT(*)       FROM customers WHERE risk_category = 'High'
UNION ALL
SELECT 'Total Loans Issued',        COUNT(*)       FROM loans
UNION ALL
SELECT 'Active Loans',              COUNT(*)       FROM loans WHERE status = 'Active'
UNION ALL
SELECT 'Defaulted Loans',           COUNT(*)       FROM loans WHERE status = 'Defaulted'
UNION ALL
SELECT 'Total Loan Book (R)',        ROUND(SUM(loan_amount), 0) FROM loans
UNION ALL
SELECT 'Total Defaulted Amount (R)', ROUND(SUM(loan_amount), 0) FROM loans WHERE status = 'Defaulted'
UNION ALL
SELECT 'Total Deposits on Book (R)', ROUND(SUM(balance), 0)     FROM accounts WHERE status = 'Active';

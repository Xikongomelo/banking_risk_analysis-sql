# Banking Customer Risk Analysis
### SQL Portfolio Project | SQLite

---

## Overview

This project simulates a bank's internal database and uses SQL to answer real business questions relevant to financial risk consulting. It covers the full range of SQL skills — from basic queries to multi-table joins and transaction monitoring logic.

This is exactly the type of data work PwC ARQ consultants perform for banking clients: understanding portfolio risk, identifying high-risk customers, and flagging unusual transaction behaviour.

---

## Database Structure

```
customers     — 20 customers with demographics and credit scores
accounts      — 23 accounts (savings, cheque, fixed deposit)
loans         — 20 loans across personal, home, vehicle, business
transactions  — 25 transactions with deposits and withdrawals
```

---

## Queries & Business Questions Answered

| Query | Business Question |
|---|---|
| 1–3 | Who are our customers? Which are high-risk? |
| 4–5 | What is the average credit score by city and risk band? |
| 6 | Where is the bank's loan money deployed? |
| 7–8 | How much of the loan book has defaulted? By loan type? |
| 9–10 | Which high-risk customers have active loans? (Watch list) |
| 11 | Full customer financial profile across all tables |
| 12–13 | Transaction monitoring — which accounts are flagged? |
| 14 | Executive summary — portfolio health at a glance |

---

## SQL Concepts Demonstrated

- `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`
- `GROUP BY` with `COUNT`, `SUM`, `AVG`, `MAX`, `MIN`
- `CASE WHEN` for conditional logic and flagging
- `INNER JOIN` and `LEFT JOIN` across multiple tables
- `UNION ALL` for combining result sets
- String concatenation and `ROUND()` for formatting
- Subqueries and derived metrics (default rate %)

---

## How to Run

**Option 1 — Browser (No install needed):**
1. Go to [sqliteonline.com](https://sqliteonline.com)
2. Click **SQLite** on the left panel
3. Copy and paste the full contents of `banking_risk_analysis.sql`
4. Click **Run** (or press Ctrl + Enter)

**Option 2 — DB Browser for SQLite (Desktop):**
1. Download from [sqlitebrowser.org](https://sqlitebrowser.org)
2. Open → New Database → name it `banking.db`
3. Go to **Execute SQL** tab
4. Paste and run the script

---

## Key Findings

- **6 out of 20 customers** are classified as high risk (credit score below 580)
- **Personal loans** have the highest default rate — all defaults are in this category
- **Flagged accounts** show withdrawal activity exceeding deposits — financial stress indicators
- The bank's total loan book is concentrated in **home and business loans** by value
- High-risk customers with active loans represent the primary **credit concentration risk**

---

## Context

Built as a portfolio project demonstrating SQL for financial risk analytics — directly relevant to data roles in banking, insurance, and financial consulting. Covers database design, querying, aggregation, joins, and business-oriented risk flagging logic.

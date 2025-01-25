# SQL Project 2 - Retention Analysis

Through this case study, I aim to demonstrate my skills in utilizing SQL to perform retention and revenue analysis.

## Table Creation
Table 1: retention
- This table stores each user's sign-up date along with their last login date for retention analysis
(Please see [project2-1_table_creation_retention](https://github.com/Yeonjujung09/8-weeks-SQL-challenge/blob/main/project2-1_creating_table_for_signup.sql) for more details)

| user_id  |sign_up | last_login |
| ---------| ----------| ------|
| 1| 2019-01-01| 2019-06-03|
| 2| 2019-01-01| 2019-11-02|
| 3| 2019-01-01| 2019-01-23|
| 4| 2019-01-01| 2019-04-19|
| 5| 2019-01-01| 2019-06-25|

Table 2: payment
- This table includes payment transaction records from December 2019 for revenue analysis
(Please see [project2-1_table_creation_payment](https://github.com/Yeonjujung09/8-weeks-SQL-challenge/blob/main/project2-2_table_creation_payment.sql) for more details)

| payment_id  |items | amount | buy_date | user_id
| ---------| ----------| ------| --------| -------|
| 1| itemE| 20000| 2019-12-01 | 70 |
| 2| itemB| 5000| 2019-12-01 | 1153 |
| 3| itemA| 3000| 2019-12-01 | 1210 |
| 4| itemA| 3000| 2019-12-01 | 1242 |
| 5| iteamE| 20000| 2019-12-01 | 975 |

## Outcome
- Using the results from Retention_Analysis, I created a visualization as shown in the screenshot below.
<img width="854" alt="Retention_Analysis" src="https://github.com/user-attachments/assets/692afb82-309d-4832-8fdc-8dbc14c1eea5" />

- Using the results from Revenue_Analysis, I generated a visualization and performed revenue predictions, as illustrated in the screenshot below.
<img width="618" alt="Revenue_Analysis" src="https://github.com/user-attachments/assets/a6c446d1-6ad1-4c2a-b0b5-97113a30a4c3" />


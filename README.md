# SQL Project 2 - Retention Analysis

Through this case study, I aim to demonstrate my skills in utilizing SQL to perform retention analysis.

## Overview
### Given tables
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

Table 2: retention
- This table includes payment transaction records from December 2019 for revenue analysis
(Please see [project2-1_table_creation_payment](https://github.com/Yeonjujung09/8-weeks-SQL-challenge/blob/main/project2-2_table_creation_payment.sql) for more details)

| payment_id  |items | amount | buy_date | user_id
| ---------| ----------| ------| --------| -------|
| 1| itemE| 20000| 2019-12-01 | 70 |
| 2| itemB| 5000| 2019-12-01 | 1153 |
| 3| itemA| 3000| 2019-12-01 | 1210 |
| 4| itemA| 3000| 2019-12-01 | 1242 |
| 5| iteamE| 20000| 2019-12-01 | 975 |

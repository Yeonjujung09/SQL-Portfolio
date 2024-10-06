# SQL Portfolio 1 - Create a new payments table

Through this case study, I aim to demonstrate my skills in utilizing SQL to extract, manipulate, and prepare data from multiple sources. I'll take you through the steps I followed to solve the Payment Challenge in the [Foodie-Fi](https://8weeksqlchallenge.com/case-study-3/) case study.

## Overview
### Given tables
Table 1: plans
| plan_id  |plan_name | price |
| ---------| ----------| ------|
| 0| trial| 0|
| 1| basic monthly| 9.90|
| 2| pro monthly| 19.90|
| 3| pro annual| 199|
| 4| churn| null|
- After the initial 7-day free trial, the pro monthly subscription plan will automatically continue unless they cancel, downgrade to basic, or upgrade to an annual pro plan at any point during the trial.
- When customers cancel their Foodie-Fi service, they will have a churn plan record with a null price but their plan will continue until the end of the billing period.

Table 2: subscriptions
| customer_id  |plan_id | start_date |
| -------------| -------| -----------|
| 1| 0| 2020-08-01|
| 1| 1| 2020-08-08|
| 2| 0| 2020-09-20|
| 2| 3| 2020-09-27|
| 11| 0| 2020-11-19|
| 11| 4| 2020-11-26|
- If customers downgrade from a pro plan or cancel their subscription - the higher plan will remain in place until the period is over - the start_date in the subscriptions table will reflect the date that the actual plan changes.
- When customers upgrade their account from a basic plan to a pro or annual pro plan - the higher plan will take effect straight away.
- When customers churn - they will keep their access until the end of their current billing period but the start_date will be technically the day they decide to cancel their service.

### Desired outcome
The Foodie-Fi team needs a new `payments` table for the year 2020 that includes amounts paid by each customer in the `subscriptions` table with the following requirements:
- monthly payments always occur on the same day of month as the original `start_date` of any monthly paid plan
- upgrades from basic to monthly or pro plans are reduced by the current paid amount in that month and start immediately
- upgrades from pro monthly to pro annual are paid at the end of the current billing period and also start at the end of the month period
- once a customer churns they will no longer make payments.
Example outputs for this table might look like the following:
|customer_id|plan_id|plan_name|payment_date|amount|payment_order|
|-----------|-------|---------|------------|------|-------------|
|1|1|basic monthly|2020-08-08|9.90|1|
|1|1|basic monthly|2020-09-08|9.90|2|
|1|1|basic monthly|2020-10-08|9.90|3|
|1|1|basic monthly|2020-11-08|9.90|4|
|1|1|basic monthly|2020-12-08|9.90|5|

## Exploration
### Step 1 - Identify what types of plan transitions there are
    WITH lead_plans AS (
    SELECT
        customer_id
        ,plan_id
        ,start_date
        ,LEAD(plan_id) OVER (PARTITION BY customer_id ORDER BY start_date) AS lead_plan_id
        ,LEAD(start_date) OVER (PARTITION BY customer_id ORDER BY start_date) AS lead_start_date
    FROM subscriptions
    WHERE DATE_PART('year', start_date) = 2020
    AND plan_id != 0
    )
    SELECT
        plan_id
        ,lead_plan_id
        ,COUNT(*) AS transition_count
    FROM lead_plans
    GROUP BY plan_id, lead_plan_id
    ORDER BY plan_id, lead_plan_id

I used the `LEAD` window function on both `plan_id` and `start_date` columns to figure out what is the following plan that a customer switches to.
Also, I removed the first row where customers are on a free trial as all customers start on a free trial.
I assumed that any record where the `lead_plan_id` and `lead_start_date` values are missing is the "last" or latest record for that specific customer in 2020.

### Installing

A step by step series of examples that tell you how to get a development
environment running

Say what the step will be

    Give the example

And repeat

    until finished

End with an example of getting some data out of the system or using it
for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Sample Tests

Explain what these tests test and why

    Give an example

### Style test

Checks if the best practices and the right coding style has been used.

    Give an example

## Deployment

Add additional notes to deploy this on a live system

## Built With

  - [Contributor Covenant](https://www.contributor-covenant.org/) - Used
    for the Code of Conduct
  - [Creative Commons](https://creativecommons.org/) - Used to choose
    the license

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code
of conduct, and the process for submitting pull requests to us.

## Versioning

We use [Semantic Versioning](http://semver.org/) for versioning. For the versions
available, see the [tags on this
repository](https://github.com/PurpleBooth/a-good-readme-template/tags).

## Authors

  - **Billie Thompson** - *Provided README Template* -
    [PurpleBooth](https://github.com/PurpleBooth)

See also the list of
[contributors](https://github.com/PurpleBooth/a-good-readme-template/contributors)
who participated in this project.

## License

This project is licensed under the [CC0 1.0 Universal](LICENSE.md)
Creative Commons License - see the [LICENSE.md](LICENSE.md) file for
details

## Acknowledgments

  - Hat tip to anyone whose code is used
  - Inspiration
  - etc

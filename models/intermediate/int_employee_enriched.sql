with

employees as (
    select * from {{ ref('stg_raw__employees') }}
),

enriched as (
    select
    *,
    case
        when monthly_income < 3000  then '1. <3K'
        when monthly_income < 6000  then '2. 3K-6K'
        when monthly_income < 10000 then '3. 6K-10K'
        else                             '4. 10K+'
    end as compensation_band,   
    case
        when tenure_years < 1  then '1. <1 year'
        when tenure_years < 3  then '2. 1-2 years'
        when tenure_years < 5  then '3. 3-4 years'
        when tenure_years < 10 then '4. 5-9 years'
        else                        '5. 10+ years'
    end as tenure_band, 
    case
        when age < 30 then '1. <30'
        when age < 40 then '2. 30-39'
        when age < 50 then '3. 40-49'
        else               '4. 50+'
    end as age_band

    from employees
)

select * from enriched
with

employees as (
    select * from {{ ref('stg_raw__employees') }}
),

performance_reviews as (
    select * from {{ ref('stg_raw__performance_reviews') }}
),

joined as (
    select
        e.employee_id,
        e.age,
        e.gender,
        e.marital_status,
        e.education_field,
        e.education_level,
        e.department,
        e.job_role,
        e.job_level,
        e.is_attrition,
        e.monthly_income,
        e.monthly_rate,
        e.daily_rate,
        e.hourly_rate,
        e.percent_salary_hike,
        e.stock_option_level,
        e.over_time,
        e.job_satisfaction,
        e.environment_satisfaction_label,
        e.work_life_balance_label,
        e.relationship_satisfaction_label,
        e.job_involvement_label,
        e.tenure_years,
        e.years_in_role,
        e.years_since_promotion,
        e.years_with_curr_manager,
        e.total_working_years,
        e.num_companies_worked,
        e.training_times_last_year,
        e.distance_from_home,

        r.review_id,
        r.review_period,
        r.review_type,
        r.performance_rating,
        r.rating_label,
        r.goal_completion_percent,
        r.manager_feedback_score


    from employees e
    left join performance_reviews r
        on e.employee_id = r.employee_id
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

    from joined
)

select * from enriched
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
)

select * from joined
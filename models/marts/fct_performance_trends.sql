with

source as (
    select * from {{ ref('int_employee_performance') }}
),

trended as (
    select
        -- grouping dimensions
        department,
        job_role,
        tenure_band,
        compensation_band,
        age_band,
        review_period,
        review_type,

        -- aggregations
        round(avg(performance_rating),2) as avg_performance_rating,
        round(avg(goal_completion_percent),2) as avg_goal_completion_percent,
        round(avg(manager_feedback_score),2) as avg_manager_feedback_score

    from source
    group by 1, 2, 3, 4, 5, 6, 7
)

select * from trended
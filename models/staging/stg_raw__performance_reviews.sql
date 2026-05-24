with 

source as (

    select * from {{ source('raw', 'performance_reviews') }}

),

renamed as (

    select
        -- Identifiers
        reviewid as review_id,
        employeenumber as employee_id,
        -- Review info
        reviewperiod as review_period,
        reviewtype as review_type,
        -- Performance metrics
        performancerating as performance_rating,
        ratinglabel as rating_label,
        goalcompletionpct as goal_completion_percent,
        managerfeedbackscore as manager_feedback_score

    from source

)

select * from renamed
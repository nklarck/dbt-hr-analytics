with

source as (
    select * from {{ ref('int_employee_enriched') }}
),

aggregated as (
    select
        -- grouping dimensions
        department,
        job_role,
        tenure_band,
        compensation_band,
        age_band,

        -- counts
        count(distinct employee_id) as total_employees,
        sum(case when is_attrition then 1 else 0 end) as termed_employees,
        sum(case when not is_attrition then 1 else 0 end) as active_employees,

        -- rate
        round(
            sum(case when is_attrition then 1 else 0 end) / count(distinct employee_id) * 100
        , 2)                                       as attrition_rate_percent

    from source
    group by 1, 2, 3, 4, 5
)

select * from aggregated
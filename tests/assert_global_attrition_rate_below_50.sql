select 1
from (
    select
        round(
            sum(termed_employees) / sum(total_employees) * 100
        , 2) as global_attrition_rate
    from {{ ref('fct_attrition') }}
)
where global_attrition_rate > 50
with 

source as (

    select * from {{ source('raw', 'employees') }}

),

renamed as (

    select
        -- identifiers
        employeenumber as employee_id,

        -- demographics
        age,
        gender,
        maritalstatus as marital_status,
        educationfield as education_field,
        education,
        -- Education: 1=Below College, 2=College, 3=Bachelor, 4=Master, 5=Doctor
        case education
            when 1 then 'Below College'
            when 2 then 'College'
            when 3 then 'Bachelor'
            when 4 then 'Master'
            when 5 then 'Doctor'
        end as education_level,

        -- job info
        department,
        jobrole as job_role,
        joblevel as job_level,
        businesstravel as business_travel,

        -- flags
        attrition,
        case when attrition = 'Yes' then true else false end as is_attrition,
        overtime as over_time,

        -- compensation
        monthlyincome as monthly_income,
        monthlyrate as monthly_rate,
        dailyrate as daily_rate,
        hourlyrate as hourly_rate,
        percentsalaryhike as percent_salary_hike,
        stockoptionlevel as stock_option_level,

        -- satisfaction scores
        jobsatisfaction as job_satisfaction,
        environmentsatisfaction as environment_satisfaction,
        -- EnvironmentSatisfaction: 1=Low, 2=Medium, 3=High, 4=Very High
        case environmentsatisfaction
            when 1 then 'Low'
            when 2 then 'Medium'
            when 3 then 'High'
            when 4 then 'Very High'
        end as environment_satisfaction_label,
        worklifebalance as work_life_balance,
        -- WorkLifeBalance: 1=Bad, 2=Good, 3=Better, 4=Best
        case worklifebalance
            when 1 then 'Bad'
            when 2 then 'Good'
            when 3 then 'Better'
            when 4 then 'Best'
        end as work_life_balance_label,
        relationshipsatisfaction as relationship_satisfaction,
        -- RelationshipSatisfaction: 1=Low, 2=Medium, 3=High, 4=Very High
        case relationshipsatisfaction
            when 1 then 'Low'
            when 2 then 'Medium'
            when 3 then 'High'
            when 4 then 'Very High'
        end as relationship_satisfaction_label,
        jobinvolvement as job_involvement,
        -- JobInvolvement: 1=Low, 2=Medium, 3=High, 4=Very High
        case jobinvolvement
            when 1 then 'Low'
            when 2 then 'Medium'
            when 3 then 'High'
            when 4 then 'Very High'
        end as job_involvement_label,

        -- performance
        performancerating as performance_rating,
        -- PerformanceRating: 1=Low, 2=Good, 3=Excellent, 4=Outstanding
        case performancerating
            when 1 then 'Low'
            when 2 then 'Good'
            when 3 then 'Excellent'
            when 4 then 'Outstanding'
        end as performance_rating_label,
        -- tenure
        yearsatcompany as tenure_years,
        yearsincurrentrole as years_in_role,
        yearssincelastpromotion as years_since_promotion,
        yearswithcurrmanager as years_with_curr_manager,
        totalworkingyears as total_working_years,
        numcompaniesworked as num_companies_worked,
        trainingtimeslastyear as training_times_last_year,

        -- other
        distancefromhome as distance_from_home

    from source

)

select * from renamed
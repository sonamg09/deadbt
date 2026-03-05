with 

source as (

    select * from {{ source('employee', 'EMPLOYEE_RAW') }}

),

renamed as (

    select
        empid,
        name,
        salary,
        hiredate,
        address

    from source

)

select * from renamed
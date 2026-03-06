{{
    config
    (
        materialized='incremental',
        incremental_strategy='delete+insert',
        unique_key='PRODUCT_ID'
    )
}}

WITH product_src AS (
    select
    PRODUCT_ID,
    PRODUCT_NAME,
    PRODUCT_PRICE,
    CREATED_AT,
    CURRENT_TIMESTAMP AS INSERT_DTS
    FROM {{source('product', 'PRODUCT_SRC')}}

    {% if is_incremental()%}
        where CREATED_AT > (SELECT MAX(INSERT_DTS) FROM {{this}})
    {%endif%}
)

select * from product_src
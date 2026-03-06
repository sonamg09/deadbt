{{
    config
    (
        materialized='ephemeral'
    )
}}

WITH base_orders AS (
    select
        ORDER_ID,
        ORDER_DATE,
        CUSTOMER_ID,
        CASE WHEN CUSTOMER_NAME IS NULL THEN 'NA' ELSE UPPER(CUSTOMER_NAME) END AS CUSTOMER_NAME,
        CREATED_AT
    FROM {{source('orders','BASE_ORDERS')}}
    where ORDER_DATE is not null
)

select * from base_orders;
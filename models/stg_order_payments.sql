with
src_orders as (
    select * from {{ ref('stg_orders') }}
),
src_payments as (
    select * from {{ ref('stg_payments') }}
)
select
    src_orders.order_id,
    src_orders.order_date,
    src_orders.customer_id,
    src_payments.payment_id,
    src_payments.amount / 100 as amount_usd,
    src_payments.current_status as payment_status
    
from src_orders
left join src_payments
    on src_orders.order_id = src_payments.order_id
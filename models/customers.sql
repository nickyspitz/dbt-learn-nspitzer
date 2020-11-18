with 
customers as (
    select * from {{ ref('stg_customers') }}
),
order_payments as (
    select * from {{ ref('stg_order_payments') }}
),

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        coalesce(count(order_id),0) as number_of_orders,
        sum(case when payment_status = 'success' then amount_usd else 0 end) as total_lifetime_value_usd

    from order_payments

    group by 1

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,

        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        customer_orders.total_lifetime_value_usd,
        customer_orders.number_of_orders

    from customers

    left join customer_orders using (customer_id)

)

select * from final
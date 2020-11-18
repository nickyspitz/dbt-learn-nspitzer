select
    id as payment_id,
    orderid as order_id,
    created as created_at,
    status as current_status,
    amount
from {{ source('stripe', 'payments') }}
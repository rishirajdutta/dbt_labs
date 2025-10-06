select 
o.order_id
, o.customer_id 
, coalesce(p.amount, 0) as payment_amount
from stg_jaffle_shop__orders o 
left join stg_jaffle_shop__customers c 
on o.customer_id = c.customer_id 
left join stg_stripe__payments p 
on o.order_id = p.order_id
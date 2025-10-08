-- For every order the sum of total payment should never be a negative value 

with asserted_payments as (
    select * from {{ ref('stg_stripe__payments') }}
)


select 
order_id
, sum(payment_amount) as order_total 
from asserted_payments 
group by order_id 
having sum(payment_amount) < 0
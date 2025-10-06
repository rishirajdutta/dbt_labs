select 
id
, orderid as order_id 
, paymentmethod as payment_method
, status 
, amount/100 as amount 
, created 
, _batched_at as dwh_updated_ts
from raw.stripe.payment
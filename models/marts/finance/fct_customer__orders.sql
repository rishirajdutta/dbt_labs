-- Import CTEs

with 
paid_orders as (
    select * from {{ ref('int_orders') }}
),

customers as (
    select * from {{ ref('stg_jaffle_shop__customers') }}
),

-- Logical CTEs

customer_order_history as 
(

    select 
        paid_orders.*,
        customers.full_name,
        customers.last_name,
        customers.first_name,
    
    --- Customer Level Aggregations 

        min(paid_orders.order_date) over(partition by customers.customer_id)  as customer_first_order_date,
        
        min(paid_orders.valid_order_date) over(partition by customers.customer_id)  as customer_first_non_returned_order_date,
        
        max(paid_orders.valid_order_date) over(partition by customers.customer_id)  as customer_most_recent_non_returned_order_date,
        
        coalesce(count(*) over(partition by customers.customer_id), 0) as customer_order_count,
        
        coalesce(sum(paid_orders.non_returned_order_flg) over(partition by customers.customer_id),0) as customer_non_returned_order_count,
        
        coalesce(sum(paid_orders.order_value_dollars) over(partition by customers.customer_id), 0) as customer_total_lifetime_value,
        
        array_agg(distinct paid_orders.order_id) over(partition by customers.customer_id) as order_ids

    from  paid_orders inner join customers 
    on paid_orders.customer_id = customers.customer_id

),

avg_customer_orders as (

    select 
    *,
    round(customer_total_lifetime_value/nullif(customer_non_returned_order_count, 0), 2) as avg_non_returned_order_value
    from customer_order_history

),

-- select * from avg_customer_orders where customer_id = '71'
final as 
(
select 
    order_id,
    customer_id,
    last_name,
    first_name,
    customer_first_order_date as first_order_date,
    customer_order_count as order_count,
    customer_total_lifetime_value as total_lifetime_value,
    order_value_dollars,
    order_status,
    payment_status

from avg_customer_orders  

)

select * from final 
-- where customer_id = '30'





with orders as (
    select * from {{ ref ('stg_jaffle_shop__orders')}}
),

successful_payments as (
    select * from {{ ref ('stg_stripe__payments')}}
    where payment_status != 'fail'
),

orders_total as 
(
    select 
    order_id 
    , payment_status 
    , sum(payment_amount) as order_value_dollars
    from successful_payments 
    group by order_id, payment_status
),

orders_total_joined as 
(
    select 
    orders.*
    , case 
            when order_status not in ('returned','return_pending') 
            then order_date 
    end as valid_order_date
    , case 
            when order_status not in ('returned','return_pending') 
            then 1 else 0 
        end as non_returned_order_flg
    , orders_total.payment_status
    , orders_total.order_value_dollars
    from orders left join orders_total
    on orders_total.order_id = orders.order_id 
)

select * from orders_total_joined




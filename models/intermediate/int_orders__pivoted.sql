with successful_payments as  (

    select * from {{ ref('stg_stripe__payments') }}
    where payment_status = 'success'

),

pivoted as (
    select 
    order_id
    {%- set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] -%}
    {% for payment_mode in payment_methods %}
        , sum(case when payment_method = '{{ payment_mode }}' then payment_amount else 0 end) as {{ payment_mode }}_amount
    {% endfor %}
    from successful_payments 
    group by order_id 
)

select * from pivoted

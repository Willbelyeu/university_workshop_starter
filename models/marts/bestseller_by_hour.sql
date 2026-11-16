with int_item_hours as (
    select * 
    from {{ ref('int_item_hours') }}
),

hourly_counts as (
    select
        product_sku as sku,
        hr,
        count(*) as item_count,
        sum(order_subtotal) as total_sales
    from int_item_hours
    group by
        hr,
        product_sku
),

product_details as (
    select distinct
        product_sku as sku,
        product_name,
        product_type,
        product_description
    from int_item_hours
)

select
    hc.hr,
    pd.product_type as type,
    hc.item_count as count,
    pd.product_name as name,
    pd.product_description as description
from hourly_counts hc
join product_details pd
    on hc.sku = pd.sku
qualify rank() over (
    partition by hc.hr, pd.product_type
    order by hc.item_count desc
) = 1
order by
    hc.hr,
    pd.product_type
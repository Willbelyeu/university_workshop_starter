with int_item_hours as (
    select *    from {{ ref('int_item_hours') }} 
)

SELECT
    product_sku as sku,
    hr,
    count(*) as item_count,
    sum(int_item_hours.order_subtotal) as total_sales
from int_item_hours
group by
    hr,
    product_sku
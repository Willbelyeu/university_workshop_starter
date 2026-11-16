with int_item_hours as (
    select *    from {{ ref('int_item_hours') }} 
)

SELECT
    product_sku as sku,
    hr,
    product_name,
    product_type,
    product_description,

from int_item_hours
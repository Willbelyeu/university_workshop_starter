with products as (
    select * from {{ ref('stg_jaffle_shop__raw_products') }}

),
items as (
    select * from {{ ref('stg_jaffle_shop__raw_items') }}
),
orders as (
    select * from {{ ref('stg_jaffle_shop__raw_orders') }}
)

select
    products.product_sku as product_sku,
    products.product_name as product_name,
    products.product_type as product_type,
    products.product_price as product_price,
    products.product_description as product_description,
    items.item_id as item_id,
    orders.ordered_at as ordered_at,
    orders.order_date as order_date,
    orders.order_subtotal as order_subtotal,
    -- Note: %l adds a leading space for single-digit hours, so wrap in TRIM():
    extract(hour from orders.ordered_at) as hr
from products
join items on products.product_sku = items.product_sku
join orders on items.order_id = orders.order_id

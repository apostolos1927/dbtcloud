{{ config(materialized='table') }}
select
  product_id,
  {{ surrogate_key(['product_id','sku']) }} as product_sk,
  sku, name, category, price, created_ts,
  current_timestamp() as loaded_at
from {{ ref('bronze__products') }};

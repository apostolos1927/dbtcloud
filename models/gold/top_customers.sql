{{ config(materialized='table') }}
select
  c.customer_sk, c.customer_id,
  concat(c.first_name,' ',c.last_name) as customer_name,
  sum(o.total_amount) as lifetime_spend
from {{ ref('fct_orders') }} o
join {{ ref('customers_snapshot') }} c on o.customer_id = c.customer_id and c.dbt_valid_to is null
group by c.customer_sk, c.customer_id, c.first_name, c.last_name
order by lifetime_spend desc;

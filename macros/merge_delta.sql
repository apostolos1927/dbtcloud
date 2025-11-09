{% macro delta_merge(target_relation, source_relation, target_key, update_columns) -%}
{% set key_expr = " AND ".join([ 't.' ~ col ~ ' = s.' ~ col for col in target_key ]) %}
{% set update_expr = ", ".join([ 't.' ~ col ~ ' = s.' ~ col for col in update_columns ]) %}
MERGE INTO {{ target_relation }} t
USING {{ source_relation }} s
ON {{ key_expr }}
WHEN MATCHED THEN UPDATE SET {{ update_expr }}
WHEN NOT MATCHED THEN INSERT *
;
{%- endmacro %}

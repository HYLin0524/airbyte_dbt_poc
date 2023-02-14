{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_poke",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pokemon_ab1') }}
select
    cast({{ adapter.quote('next') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('next') }},
    cast(count as {{ dbt_utils.type_bigint() }}) as count,
    results,
    cast(previous as {{ dbt_utils.type_string() }}(1024)) as previous,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pokemon_ab1') }}
-- pokemon
where 1 = 1


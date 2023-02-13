{{ config(
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pokemon_moves_version_4move_learn_method_ab1') }}
select
    _airbyte_version_group_details_hashid,
    cast(url as {{ dbt_utils.type_string() }}(1024)) as url,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('name') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pokemon_moves_version_4move_learn_method_ab1') }}
-- move_learn_method at pokemon/moves/version_group_details/move_learn_method
where 1 = 1


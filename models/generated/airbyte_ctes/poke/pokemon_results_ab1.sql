{{ config(
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pokemon') }}
{{ unnest_cte(ref('pokemon'), 'pokemon', 'results') }}
select
    _airbyte_pokemon_hashid,
    {{ json_extract_scalar(unnested_column_value('results'), ['url'], ['url']) }} as url1,
    {{ json_extract_scalar(unnested_column_value('results'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pokemon') }} as table_alias
-- results at pokemon/results
{{ cross_join_unnest('pokemon', 'results') }}
where 1 = 1
and results is not null


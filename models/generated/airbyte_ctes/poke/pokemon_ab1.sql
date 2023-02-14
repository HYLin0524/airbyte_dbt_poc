{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_poke",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('poke', '_airbyte_raw_pokemon') }}
select
    {{ json_extract_scalar('_airbyte_data', ['next'], ['next']) }} as {{ adapter.quote('next') }},
    {{ json_extract_scalar('_airbyte_data', ['count'], ['count']) }} as count,
    {{ json_extract_array('_airbyte_data', ['results'], ['results']) }} as results,
    {{ json_extract_scalar('_airbyte_data', ['previous'], ['previous']) }} as previous,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('poke', '_airbyte_raw_pokemon') }} as table_alias
-- pokemon
where 1 = 1


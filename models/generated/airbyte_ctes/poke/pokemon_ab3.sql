{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_poke",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pokemon_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('next'),
        'count',
        array_to_string('results'),
        'previous',
    ]) }} as _airbyte_pokemon_hashid,
    tmp.*
from {{ ref('pokemon_ab2') }} tmp
-- pokemon
where 1 = 1


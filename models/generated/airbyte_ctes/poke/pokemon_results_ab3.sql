{{ config(
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pokemon_results_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_pokemon_hashid',
        'url',
        adapter.quote('name'),
    ]) }} as _airbyte_results_hashid,
    tmp.*
from {{ ref('pokemon_results_ab2') }} tmp
-- results at pokemon/results
where 1 = 1


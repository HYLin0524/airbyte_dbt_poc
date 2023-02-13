{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "poke",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='pokemon_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pokemon_ab3') }}
select
    id,
    {{ adapter.quote('name') }},
    forms,
    moves,
    {{ adapter.quote('order') }},
    stats,
    {{ adapter.quote('types') }},
    height,
    weight,
    species,
    sprites,
    abilities,
    held_items,
    {{ adapter.quote('is_default') }},
    game_indices,
    base_experience,
    location_area_encounters,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_pokemon_hashid
from {{ ref('pokemon_ab3') }}
-- pokemon from {{ source('poke', '_airbyte_raw_pokemon') }}
where 1 = 1


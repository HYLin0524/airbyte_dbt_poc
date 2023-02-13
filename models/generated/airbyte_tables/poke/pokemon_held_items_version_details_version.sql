{{ config(
    schema = "poke",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='pokemon_held_items_ve_4n_details_version_scd'
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
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pokemon_held_items_ve_4n_details_version_ab3') }}
select
    _airbyte_version_details_hashid,
    url,
    {{ adapter.quote('name') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_version_hashid
from {{ ref('pokemon_held_items_ve_4n_details_version_ab3') }}
-- version at pokemon/held_items/version_details/version from {{ ref('pokemon_held_items_version_details') }}
where 1 = 1

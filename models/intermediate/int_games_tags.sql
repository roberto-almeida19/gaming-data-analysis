with source as (

    select
        app_id,
        {{ split_list_column('tags') }} as tag_list
    from {{ ref('stg_games') }}

)

-- no distinct: the position in the source list must be preserved
select
    app_id,
    unnest(tag_list) as tag,
    generate_subscripts(tag_list, 1) as tag_position
from source

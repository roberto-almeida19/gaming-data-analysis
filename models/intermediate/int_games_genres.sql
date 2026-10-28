with source as (

    select * from {{ ref('stg_games') }}

)

-- distinct: the source sometimes repeats the same value within a list
select distinct
    app_id,
    unnest({{ split_list_column('genres') }}) as genre
from source

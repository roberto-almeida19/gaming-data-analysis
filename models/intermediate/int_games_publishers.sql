with source as (

    select * from {{ ref('stg_games') }}

),

exploded as (

    -- a lista usa ',' sem espaço como separador; ', ' (com espaço) faz parte
    -- do nome (ex.: 'KRAFTON, Inc.'). Protege essa vírgula antes do split.
    select
        app_id,
        trim(replace(
            unnest(string_split(replace(publishers, ', ', chr(31)), ',')),
            chr(31), ', '
        )) as publisher
    from source
    where publishers is not null
      and publishers <> ''

)

-- distinct: a fonte às vezes repete o mesmo publisher ('Eid Games,Eid Games')
select distinct app_id, publisher
from exploded
where publisher <> ''

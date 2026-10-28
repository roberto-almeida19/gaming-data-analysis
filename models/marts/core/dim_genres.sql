with game_genres as (

    select * from {{ ref('int_games_genres') }}

),

genres as (

    select
        genre                       as genre_name,
        count(distinct app_id)      as game_count
    from game_genres
    group by genre

)

select
    md5(lower(genre_name))          as genre_id,     -- stable surrogate key
    genre_name,
    game_count
from genres

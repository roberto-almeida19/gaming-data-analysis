-- Horror share of all game releases per year, 2014-2024.
with games as (

    select release_year, is_horror
    from {{ ref('fct_games') }}
    where release_year between 2014 and 2024

),

by_year as (

    select
        release_year,
        count(*)                                        as total_games,
        count(*) filter (where is_horror)               as horror_games

    from games
    group by release_year

)

select
    release_year,
    total_games,
    horror_games,
    100.0 * horror_games / total_games                  as horror_share_pct

from by_year
order by release_year

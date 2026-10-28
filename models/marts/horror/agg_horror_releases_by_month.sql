-- Seasonality: releases per calendar month across 2014-2024.
with games as (

    select release_month, is_horror
    from {{ ref('fct_games') }}
    where release_year between 2014 and 2024

),

by_month as (

    select
        release_month,
        count(*) filter (where is_horror)               as horror_games,
        count(*)                                        as all_games

    from games
    group by release_month

)

select
    release_month,
    horror_games,
    100.0 * horror_games / sum(horror_games) over ()    as horror_share_of_horror_pct,
    all_games,
    100.0 * all_games / sum(all_games) over ()          as catalog_share_pct

from by_month
order by release_month

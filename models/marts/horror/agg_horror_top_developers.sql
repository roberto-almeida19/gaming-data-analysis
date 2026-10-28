-- Horror games and estimated revenue per developer, 2014-2024, ranked.
with horror_games as (

    select app_id, est_revenue_usd
    from {{ ref('fct_games') }}
    where is_horror
      and release_year between 2014 and 2024

),

by_developer as (

    select
        studios.developer,
        count(*)                                        as horror_games,
        sum(horror_games.est_revenue_usd)               as horror_est_revenue_usd

    from horror_games
    inner join {{ ref('int_games_developers') }} as studios
        on studios.app_id = horror_games.app_id
    group by studios.developer

)

select
    developer,
    horror_games,
    horror_est_revenue_usd,
    row_number() over (
        order by horror_games desc, horror_est_revenue_usd desc, developer asc
    )                                                   as rank

from by_developer
order by rank

-- Horror games and estimated revenue per publisher, 2014-2024, ranked.
with horror_games as (

    select app_id, est_revenue_usd
    from {{ ref('fct_games') }}
    where is_horror
      and release_year between 2014 and 2024

),

by_publisher as (

    select
        studios.publisher,
        count(*)                                        as horror_games,
        sum(horror_games.est_revenue_usd)               as horror_est_revenue_usd

    from horror_games
    inner join {{ ref('int_games_publishers') }} as studios
        on studios.app_id = horror_games.app_id
    group by studios.publisher

)

select
    publisher,
    horror_games,
    horror_est_revenue_usd,
    row_number() over (
        order by horror_games desc, horror_est_revenue_usd desc, publisher asc
    )                                                   as rank

from by_publisher
order by rank

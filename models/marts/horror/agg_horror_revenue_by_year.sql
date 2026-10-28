-- Horror share of estimated revenue per year, 2014-2024.
with games as (

    select release_year, is_horror, est_revenue_usd
    from {{ ref('fct_games') }}
    where release_year between 2014 and 2024

),

by_year as (

    select
        release_year,
        sum(est_revenue_usd)                                    as total_est_revenue_usd,
        coalesce(sum(est_revenue_usd) filter (where is_horror), 0)
                                                                as horror_est_revenue_usd

    from games
    group by release_year

)

select
    release_year,
    total_est_revenue_usd,
    horror_est_revenue_usd,
    100.0 * horror_est_revenue_usd / nullif(total_est_revenue_usd, 0)
                                                                as horror_revenue_share_pct

from by_year
order by release_year

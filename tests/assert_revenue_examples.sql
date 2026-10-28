-- Returns rows (failures) unless Phasmophobia has the expected estimated
-- revenue, and for free games with revenue or any negative revenue.
select 'phasmophobia_revenue_mismatch' as failure
where not exists (
    select 1 from {{ ref('fct_games') }}
    where app_id = 739630
      and abs(est_revenue_usd - 13.99 * 15000000) <= 0.01
)

union all

select 'free_game_with_revenue'
from {{ ref('fct_games') }}
where price_usd = 0 and est_revenue_usd <> 0

union all

select 'negative_revenue'
from {{ ref('fct_games') }}
where est_revenue_usd < 0

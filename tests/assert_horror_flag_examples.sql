-- Returns rows (failures) unless the reference games have the expected
-- is_horror value, and for any game with null/empty tags flagged as horror.
select 'phasmophobia_not_horror' as failure
where not exists (
    select 1 from {{ ref('fct_games') }} where app_id = 739630 and is_horror
)

union all

select 'lethal_company_not_horror'
where not exists (
    select 1 from {{ ref('fct_games') }} where app_id = 1966720 and is_horror
)

union all

select 'helldivers_2_is_horror'
where not exists (
    select 1 from {{ ref('fct_games') }} where app_id = 553850 and not is_horror
)

union all

select 'path_of_exile_2_is_horror'
where not exists (
    select 1 from {{ ref('fct_games') }} where app_id = 2694490 and not is_horror
)

union all

select 'empty_tags_flagged_horror'
from {{ ref('fct_games') }} as f
inner join {{ ref('stg_games') }} as s using (app_id)
where f.is_horror
  and (s.tags is null or trim(s.tags) = '')

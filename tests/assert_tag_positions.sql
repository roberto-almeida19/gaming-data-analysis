-- Returns rows (failures) unless the known reference games have Horror at the
-- expected positions, and for any non-positive tag_position.
select 'phasmophobia_horror_not_position_1' as failure
where not exists (
    select 1 from {{ ref('int_games_tags') }}
    where app_id = 739630 and tag = 'Horror' and tag_position = 1
)

union all

select 'lethal_company_horror_not_position_2'
where not exists (
    select 1 from {{ ref('int_games_tags') }}
    where app_id = 1966720 and tag = 'Horror' and tag_position = 2
)

union all

select 'tag_position_below_1'
from {{ ref('int_games_tags') }}
where tag_position < 1

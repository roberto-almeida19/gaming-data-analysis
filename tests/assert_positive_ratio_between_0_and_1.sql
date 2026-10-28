-- Returns rows (failures) where positive_ratio is outside [0, 1].
select app_id, positive_ratio
from {{ ref('fct_games') }}
where positive_ratio < 0 or positive_ratio > 1

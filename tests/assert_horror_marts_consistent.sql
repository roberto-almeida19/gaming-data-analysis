-- Returns rows (failures) when the horror marts are inconsistent:
-- percentages out of 0-100, wrong row counts, month shares not summing
-- to 100, or yearly horror counts not matching fct_games.
with checks as (

    select 'pct_out_of_range_releases_by_year' as failure
    from {{ ref('agg_horror_releases_by_year') }}
    where horror_share_pct not between 0 and 100

    union all

    select 'pct_out_of_range_revenue_by_year'
    from {{ ref('agg_horror_revenue_by_year') }}
    where horror_revenue_share_pct not between 0 and 100

    union all

    select 'pct_out_of_range_releases_by_month'
    from {{ ref('agg_horror_releases_by_month') }}
    where horror_share_of_horror_pct not between 0 and 100
       or catalog_share_pct not between 0 and 100

    union all

    select 'releases_by_year_not_11_rows'
    from {{ ref('agg_horror_releases_by_year') }}
    having count(*) <> 11

    union all

    select 'revenue_by_year_not_11_rows'
    from {{ ref('agg_horror_revenue_by_year') }}
    having count(*) <> 11

    union all

    select 'releases_by_month_not_12_rows'
    from {{ ref('agg_horror_releases_by_month') }}
    having count(*) <> 12

    union all

    select 'month_horror_share_not_100'
    from {{ ref('agg_horror_releases_by_month') }}
    having abs(sum(horror_share_of_horror_pct) - 100) > 0.01

    union all

    select 'month_catalog_share_not_100'
    from {{ ref('agg_horror_releases_by_month') }}
    having abs(sum(catalog_share_pct) - 100) > 0.01

    union all

    select 'yearly_horror_count_mismatch'
    from (
        select
            (select sum(horror_games) from {{ ref('agg_horror_releases_by_year') }}) as marts_count,
            (select count(*) from {{ ref('fct_games') }}
             where is_horror and release_year between 2014 and 2024) as fct_count
    )
    where marts_count <> fct_count

)

select * from checks

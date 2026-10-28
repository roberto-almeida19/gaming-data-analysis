-- Fails if a company suffix leaked out as a studio name (comma-protection
-- broken), or if known names containing ', ' were split apart.
with names as (

    select app_id, developer as name from {{ ref('int_games_developers') }}
    union all
    select app_id, publisher as name from {{ ref('int_games_publishers') }}

),

suffix_as_name as (

    select app_id, name, 'suffix used as name' as reason
    from names
    where name in ('Inc.', 'Inc', 'LLC', 'Ltd.', 'Ltd', '')

),

missing_publisher as (

    select 2696400 as app_id, 'KRAFTON, Inc.' as name, 'missing publisher' as reason
    where not exists (
        select 1 from {{ ref('int_games_publishers') }}
        where app_id = 2696400 and publisher = 'KRAFTON, Inc.'
    )

),

missing_developer as (

    select 3406700 as app_id, 'CyberStep, Inc.' as name, 'missing developer' as reason
    where not exists (
        select 1 from {{ ref('int_games_developers') }}
        where app_id = 3406700 and developer = 'CyberStep, Inc.'
    )

)

select * from suffix_as_name
union all
select * from missing_publisher
union all
select * from missing_developer

with source as (

    select * from {{ ref('stg_games') }}

),

exploded as (

    select
        app_id,
        trim(unnest(string_split(genres, ','))) as genre
    from source
    where genres is not null
      and genres <> ''

)

select * from exploded
where genre <> ''

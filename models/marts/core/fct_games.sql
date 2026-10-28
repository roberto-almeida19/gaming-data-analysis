with games as (

    select * from {{ ref('stg_games') }}

),

enriched as (

    select
        app_id,
        game_name,
        strptime(release_date, '%b %d, %Y')::date               as release_date,
        year(strptime(release_date, '%b %d, %Y'))               as release_year,

        -- preço
        price_usd,
        price_usd = 0                                           as is_free,
        discount_pct,
        dlc_count,

        -- donos (faixa → min/max)
        split_part(estimated_owners, ' - ', 1)::integer         as owners_min,
        split_part(estimated_owners, ' - ', 2)::integer         as owners_max,

        -- recepção
        positive_reviews,
        negative_reviews,
        positive_reviews + negative_reviews                     as total_reviews,
        positive_reviews / nullif(positive_reviews + negative_reviews, 0)
                                                                as positive_ratio,
        nullif(metacritic_score, 0)                             as metacritic_score,

        -- engajamento
        peak_ccu,
        median_playtime_forever_min,
        median_playtime_2weeks_min,
        achievements_count,
        recommendations_count,

        -- plataformas
        is_windows_supported,
        is_mac_supported,
        is_linux_supported,
        is_windows_supported::int + is_mac_supported::int + is_linux_supported::int
                                                                as platform_count

    from games

)

select * from enriched

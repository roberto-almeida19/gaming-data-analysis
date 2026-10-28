with source as (

    select * from {{ ref('raw_games') }}

),

renamed as (

    select
        -- ids
        "AppID"                         as app_id,

        -- description
        "Name"                          as game_name,
        "Release date"                  as release_date,
        "Estimated owners"              as estimated_owners,
        "Required age"                  as required_age,
        "About the game"                as about_the_game,
        "Supported languages"           as supported_languages,
        "Full audio languages"          as full_audio_languages,
        "Reviews"                       as reviews,
        "Notes"                         as notes,
        "Developers"                    as developers,
        "Publishers"                    as publishers,
        "Categories"                    as categories,
        "Genres"                        as genres,
        "Tags"                          as tags,

        -- price
        "Price"                         as price_usd,
        "Discount"                      as discount_pct,
        "DLC count"                     as dlc_count,

        -- platforms
        "Windows"                       as is_windows_supported,
        "Mac"                           as is_mac_supported,
        "Linux"                         as is_linux_supported,

        -- metrics
        "Peak CCU"                      as peak_ccu,
        "Metacritic score"              as metacritic_score,
        "User score"                    as user_score,
        "Positive"                      as positive_reviews,
        "Negative"                      as negative_reviews,
        "Score rank"                    as score_rank,
        "Achievements"                  as achievements_count,
        "Recommendations"               as recommendations_count,
        "Average playtime forever"      as avg_playtime_forever_min,
        "Average playtime two weeks"    as avg_playtime_2weeks_min,
        "Median playtime forever"       as median_playtime_forever_min,
        "Median playtime two weeks"     as median_playtime_2weeks_min,

        -- urls and media
        "Header image"                  as header_image_url,
        "Website"                       as website_url,
        "Support url"                   as support_url,
        "Support email"                 as support_email,
        "Metacritic url"                as metacritic_url,
        "Screenshots"                   as screenshots,
        "Movies"                        as movies

    from source

)

select * from renamed

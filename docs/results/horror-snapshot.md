# Horror snapshot

Snapshot of the marts in `dev.duckdb` on 2026-10-27; each table lists the query that produced it. Values are unrounded (percentages 0-100).

## Horror releases and share by year

Query: `select * from agg_horror_releases_by_year order by release_year`

|release_year|total_games|horror_games|horror_share_pct|
|---|---|---|---|
|2014|1523|82|5.384110308601445|
|2015|2515|151|6.003976143141153|
|2016|4141|230|5.554213957981164|
|2017|5922|271|4.576156703816278|
|2018|7461|344|4.610642005093151|
|2019|7243|336|4.638961756178379|
|2020|8804|518|5.883689232167197|
|2021|11067|528|4.770940634318244|
|2022|12288|635|5.167643229166667|
|2023|14598|780|5.343197698314838|
|2024|20033|1433|7.1531972245794435|

## Horror estimated revenue and share by year (USD)

Query: `select * from agg_horror_revenue_by_year order by release_year`

|release_year|total_est_revenue_usd|horror_est_revenue_usd|horror_revenue_share_pct|
|---|---|---|---|
|2014|2004658000.0|155740150.0|7.768913699992717|
|2015|2609048300.0|160174350.0|6.139186844490384|
|2016|3975161450.0|444165600.0|11.173523530723513|
|2017|3166355500.0|310536100.0|9.807366860733104|
|2018|4562543150.0|319219700.0|6.996529994461532|
|2019|3585587550.0|231344050.0|6.452054141029132|
|2020|5775050950.0|449356750.0|7.781000616107119|
|2021|9320499950.0|389501800.0|4.178979690890937|
|2022|6030967400.0|381491350.0|6.3255415706607865|
|2023|6699824900.0|526899100.0|7.864371201701107|
|2024|16104728500.0|490526350.0|3.0458529617559216|

## Top 10 developers by horror games (rank as stored in the mart)

Query: `select * from agg_horror_top_developers where rank <= 10 order by rank`

|developer|horror_games|horror_est_revenue_usd|rank|
|---|---|---|---|
|Anamik Majumdar|20|259200.0|1|
|Chilla's Art|19|3382700.0|2|
|Vidas Salavejus|19|2773850.0|3|
|David Szymanski|12|13544450.0|4|
|Euphoric Brothers|9|2591550.0|5|
|Playstige Interactive|9|703700.0|6|
|VikTor|9|365750.0|7|
|Yai Gameworks|9|199650.0|8|
|CAPCOM Co., Ltd.|8|315200000.0|9|
|Notovia|8|4907550.0|10|

## Top 10 publishers by horror games (rank as stored in the mart)

Query: `select * from agg_horror_top_publishers where rank <= 10 order by rank`

|publisher|horror_games|horror_est_revenue_usd|rank|
|---|---|---|---|
|Anamik Majumdar|20|259200.0|1|
|Chilla's Art|18|3332800.0|2|
|Vidas Salavejus|17|2101100.0|3|
|SA Industry|17|1455300.0|4|
|tinyBuild|15|12440100.0|5|
|PLAYISM|14|13993800.0|6|
|DreadXP|14|10888000.0|7|
|Piece Of Voxel|13|353750.0|8|
|Gamirror Games|11|22167600.0|9|
|Conglomerate 5|10|329800.0|10|

## Horror releases by calendar month (October is the peak)

Query: `select * from agg_horror_releases_by_month order by release_month`

|release_month|horror_games|horror_share_of_horror_pct|all_games|catalog_share_pct|
|---|---|---|---|---|
|1|346|6.51846269781462|6373|6.666666666666667|
|2|373|7.027128862094951|7103|7.430304932266332|
|3|366|6.895252449133384|7606|7.956483079658978|
|4|390|7.347400150715901|7421|7.762958313719337|
|5|374|7.045968349660889|8120|8.494168105026414|
|6|366|6.895252449133384|7202|7.533866834039437|
|7|443|8.345892991710626|8057|8.428265076625346|
|8|441|8.308214016578749|8473|8.863434280035566|
|9|442|8.327053504144688|8404|8.79125477273916|
|10|834|15.712132629992464|9361|9.792353156545845|
|11|476|8.967596081386587|8907|9.317432920131806|
|12|457|8.60964581763376|8568|8.962811862545113|

## Top 10 horror games by estimated revenue, 2014-2024 (with top-5 tags)

Query: `select game_name, release_year, est_revenue_usd, top-5 tags (int_games_tags, tag_position <= 5) from fct_games where is_horror and release_year between 2014 and 2024 order by est_revenue_usd desc limit 10`

|game_name|release_year|est_revenue_usd|top5_tags|
|---|---|---|---|
|Dead by Daylight|2016|279650000.0|Horror,Multiplayer,Survival Horror,Online Co-Op,Co-op|
|Phasmophobia|2020|209850000.0|Horror,Online Co-Op,Multiplayer,Psychological Horror,Co-op|
|The Forest|2018|160650000.0|Open World Survival Craft,Survival,Open World,Horror,Crafting|
|Little Nightmares|2017|149925000.0|Horror,Atmospheric,Adventure,Singleplayer,Puzzle-Platformer|
|Sons Of The Forest|2024|139350000.0|Survival,Open World,Multiplayer,Co-op,Survival Horror|
|Resident Evil 4|2023|119925000.0|Horror,Action,Survival Horror,Third-Person Shooter,Singleplayer|
|Lethal Company|2023|112350000.0|Online Co-Op,Horror,First-Person,Co-op,Survival Horror|
|The Callisto Protocol™|2022|89985000.0|Horror,Sci-fi,Survival Horror,Third-Person Shooter,Space|
|Resident Evil 2|2019|74925000.0|Zombies,Survival Horror,Horror,Singleplayer,Remake|
|Layers of Fear (2016)|2016|69965000.0|Horror,Psychological Horror,Atmospheric,Walking Simulator,First-Person|

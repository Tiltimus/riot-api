{-# LANGUAGE OverloadedStrings #-}

module Web.Riot.Endpoint where

import           Control.Lens
import           Data.Text
import           Data.Maybe
import           Data.Text.Encoding
import           Network.Wreq
import           Web.Riot.Platform
import           Web.Riot.Locale
import           Web.Riot.LOL.QueueType
import           Web.Riot.LOL.Tier
import           Prelude                 hiding ( concat )

hostname :: Platform -> Text
hostname platform =
  concat ["https://", pack $ show platform, ".api.riotgames.com"]

cdn :: Text
cdn = "http://ddragon.leagueoflegends.com"

data Endpoint
  -- Account
  = GET_ACCOUNT_BY_PUUID          Text
  | GET_ACCOUNT_BY_TAGLINE        Text Text
  | GET_ACCOUNT_BY_GAME           Text Text
  -- Champion Mastery 
  | GET_MASTERY_BY_SUMMONER_ID    Text
  | GET_MASTERY_BY_ID_WITH_CHAMP  Text Int
  | GET_MASTERY_SCORE_BY_ID       Text
  -- Champion Rotation 
  | GET_CHAMPION_ROTATION
  -- Clash 
  | GET_CLASH_PLAYER_BY_ID        Text
  | GET_CLASH_TEAM                Text
  | GET_CLASH_TOURNAMENTS
  | GET_CLASH_TOURNAMENTS_BY_TEAM Text
  | GET_CLASH_TOURNAMENT_BY_ID    Text
  -- Leagues
  | GET_ALL_CHALLENGER_LEAGUES    Text
  | GET_ENTRIES_BY_SUMMONER       Text
  | GET_ENTRIES_BY_QUEUE_TIER_DIV QueueType Division Tier  (Maybe Int)
  | GET_ALL_GRANDMASTER_LEAGUES   Text
  | GET_LEAGUE_BY_LEAGUE_ID       Text
  | GET_ALL_MASTER_LEAGUES        Text
  -- Status
  | GET_STATUS
  -- Summoner  
  | GET_SUMMONER_BY_NAME          Text
  | GET_SUMMONER_BY_ACCOUNT       Text
  | GET_SUMMONER_BY_PUUID         Text
  | GET_SUMMONER_BY_ID            Text
  -- Matches       
  | GET_MATCH_BY_ID               Int
  | GET_MATCH_TIMELINE_BY_ID      Int
  | GET_MATCHREFS_BY_ACCOUNT      Text [Int] [Int] (Maybe Int) (Maybe Int) (Maybe Int) (Maybe Int)
  -- Spectator
  | GET_ACTIVE_GAME_BY_ID         Text
  | GET_FEATURED_GAMES
  -- Static Data
  | GET_SEASONS
  | GET_QUEUES
  | GET_GAME_MODES
  | GET_GAME_TYPES
  | GET_VERSIONS
  | GET_LANGUAGES
  | GET_CHAMPIONS                 Text Locale
  | GET_CHAMPION_BY_NAME          Text Locale Text
  | GET_ITEMS                     Text Locale
  | GET_SUMMONERS                 Text Locale
  | GET_PROFILE_ICONS             Text Locale

endpointToUrlAndOptions :: Endpoint -> Text -> Platform -> (Text, Options)
endpointToUrlAndOptions endpoint apikey platform = case endpoint of
  -- Account
  (GET_ACCOUNT_BY_PUUID puuid) ->
    ( concat [hostname platform, "/riot/account/v1/accounts/by-puuid/", puuid]
    , withKey
    )
  (GET_ACCOUNT_BY_TAGLINE gameName tagLine) ->
    ( concat
      [ hostname platform
      , "/riot/account/v1/accounts/by-riot-id/"
      , gameName
      , "/"
      , tagLine
      ]
    , withKey
    )
  (GET_ACCOUNT_BY_GAME game puuid) ->
    ( concat
      [ hostname platform
      , "/riot/account/v1/active-shards/by-game/"
      , game
      , "/by-puuid/"
      , puuid
      ]
    , withKey
    )
  -- Champion Mastery
  (GET_MASTERY_BY_SUMMONER_ID id) ->
    ( concat
      [ hostname platform
      , "/lol/champion-mastery/v4/champion-masteries/by-summoner/"
      , id
      ]
    , withKey
    )
  (GET_MASTERY_BY_ID_WITH_CHAMP id champion) ->
    ( concat
      [ hostname platform
      , "/lol/champion-mastery/v4/champion-masteries/by-summoner/"
      , id
      , "/by-champion/"
      , pack $ show champion
      ]
    , withKey
    )
  (GET_MASTERY_SCORE_BY_ID id) ->
    ( concat
      [hostname platform, "/lol/champion-mastery/v4/scores/by-summoner/", id]
    , withKey
    )
  -- Champion Rotation
  GET_CHAMPION_ROTATION ->
    (hostname platform `append` "/lol/platform/v3/champion-rotations", withKey)
  -- Clash
  (GET_CLASH_PLAYER_BY_ID id) ->
    ( concat [hostname platform, "/lol/clash/v1/players/by-summoner/", id]
    , withKey
    )
  (GET_CLASH_TEAM id) ->
    (concat [hostname platform, "/lol/clash/v1/teams/", id], withKey)
  GET_CLASH_TOURNAMENTS ->
    (hostname platform `append` "/lol/clash/v1/tournaments", withKey)
  (GET_CLASH_TOURNAMENTS_BY_TEAM id) ->
    ( concat [hostname platform, "/lol/clash/v1/tournaments/by-team/", id]
    , withKey
    )
  (GET_CLASH_TOURNAMENT_BY_ID id) ->
    (concat [hostname platform, "/lol/clash/v1/tournaments/", id], withKey)
  -- Leagues
  (GET_ALL_CHALLENGER_LEAGUES id) ->
    ( concat
      [hostname platform, "/lol/league/v4/challengerleagues/by-queue/", id]
    , withKey
    )
  (GET_ENTRIES_BY_SUMMONER id) ->
    ( concat [hostname platform, "/lol/league/v4/entries/by-summoner/", id]
    , withKey
    )
  (GET_ENTRIES_BY_QUEUE_TIER_DIV queue division tier page) ->
    ( concat
      [ hostname platform
      , "/lol/league/v4/entries/"
      , pack $ show queue
      , "/"
      , pack $ show tier
      , "/"
      , pack $ show division
      ]
    , withKey & param "page" .~ [fromMaybe "" (page >>= (Just . pack . show))]
    )
  (GET_ALL_GRANDMASTER_LEAGUES id) ->
    ( concat
      [hostname platform, "/lol/league/v4/grandmasterleagues/by-queue/", id]
    , withKey
    )
  (GET_LEAGUE_BY_LEAGUE_ID id) ->
    (concat [hostname platform, "/lol/league/v4/leagues/", id], withKey)
  (GET_ALL_MASTER_LEAGUES id) ->
    ( concat [hostname platform, "/lol/league/v4/masterleagues/by-queue/", id]
    , withKey
    )
  -- Status
  GET_STATUS ->
    (hostname platform `append` "/lol/status/v4/platform-data", withKey)
  -- Summoners
  (GET_SUMMONER_BY_NAME name) ->
    ( concat [hostname platform, "/lol/summoner/v4/summoners/by-name/", name]
    , withKey
    )
  (GET_SUMMONER_BY_ACCOUNT account) ->
    ( concat
      [hostname platform, "/lol/summoner/v4/summoners/by-account/", account]
    , withKey
    )
  (GET_SUMMONER_BY_PUUID puuid) ->
    ( concat [hostname platform, "/lol/summoner/v4/summoners/by-puuid/", puuid]
    , withKey
    )
  (GET_SUMMONER_BY_ID id) ->
    (concat [hostname platform, "/lol/summoner/v4/summoners/", id], withKey)
  -- Matches
  (GET_MATCH_BY_ID id) ->
    ( concat [hostname platform, "/lol/match/v4/matches/", pack $ show id]
    , withKey
    )
  (GET_MATCH_TIMELINE_BY_ID id) ->
    ( concat
      [hostname platform, "/lol/match/v4/timelines/by-match/", pack $ show id]
    , withKey
    )
  (GET_MATCHREFS_BY_ACCOUNT account champions queues beginTime endTime beginIndex endIndex)
    -> ( concat
         [hostname platform, "/lol/match/v4/matchlists/by-account/", account]
       , withKey
         &  param "champion"
         .~ Prelude.map (pack . show) champions
         &  param "queue"
         .~ Prelude.map (pack . show) queues
         &  param "endTime"
         .~ [fromMaybe "" (endTime >>= (Just . pack . show))]
         &  param "beginTime"
         .~ [fromMaybe "" (beginTime >>= (Just . pack . show))]
         &  param "endIndex"
         .~ [fromMaybe "" (endIndex >>= (Just . pack . show))]
         &  param "beginIndex"
         .~ [fromMaybe "" (beginIndex >>= (Just . pack . show))]
       )
  -- Spectator
  (GET_ACTIVE_GAME_BY_ID id) ->
    ( concat
      [hostname platform, "/lol/spectator/v4/active-games/by-summoner/", id]
    , withKey
    )
  GET_FEATURED_GAMES ->
    (hostname platform `append` "/lol/spectator/v4/featured-games", withKey)
  -- Static Data
  GET_SEASONS ->
    ("http://static.developer.riotgames.com/docs/lol/seasons.json", defaults)
  GET_QUEUES ->
    ("http://static.developer.riotgames.com/docs/lol/queues.json", defaults)
  GET_GAME_MODES ->
    ("http://static.developer.riotgames.com/docs/lol/gameModes.json", defaults)
  GET_GAME_TYPES ->
    ("http://static.developer.riotgames.com/docs/lol/gameTypes.json", defaults)
  GET_VERSIONS  -> (cdn `append` "/api/versions.json", defaults)
  GET_LANGUAGES -> (cdn `append` "/cdn/languages.json", defaults)
  (GET_CHAMPIONS version locale) ->
    ( concat [cdn, "/cdn/", version, "/data/", pack $ show locale, "/champion.json"]
    , defaults
    )
  (GET_CHAMPION_BY_NAME version locale champion) ->
    ( concat [cdn, "/cdn/", version, "/data/", pack $ show locale, "/champion/", champion, ".json"]
    , defaults
    )
  (GET_ITEMS version locale) ->
    (concat [cdn, "/cdn/", version, "/data/", pack $ show locale, "/item.json"], defaults)
  (GET_SUMMONERS version locale) ->
    ( concat [cdn, "/cdn/", version, "/data/", pack $ show locale, "/summoner.json"]
    , defaults
    )
  (GET_PROFILE_ICONS version locale) ->
    ( concat [cdn, "/cdn/", version, "/data/", pack $ show locale, "/profileicon.json"]
    , defaults
    )
  where withKey = defaults & header "X-Riot-Token" .~ [encodeUtf8 apikey]

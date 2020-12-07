{-# LANGUAGE OverloadedStrings         #-}
{-# LANGUAGE AllowAmbiguousTypes       #-}
{-# LANGUAGE DataKinds                 #-}
{-# LANGUAGE DuplicateRecordFields     #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE GADTs                     #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE OverloadedLabels          #-}
{-# LANGUAGE PartialTypeSignatures     #-}
{-# LANGUAGE Rank2Types                #-}
{-# LANGUAGE ScopedTypeVariables       #-}
{-# LANGUAGE UndecidableInstances      #-}

module Web.Riot.LOL
  ( module Web.Riot.LOL.Types
  , getAccountByPuuid
  , getAccountByTagLine
  , getAccountByGame
  , getMasteryBySummonerId
  , getMasteryByIdWithChampionId
  , getMasteryScoreById
  , getChampionRotation
  , getSummonerByName
  , getSummonerByAccount
  , getSummonerByPuuid
  , getSummonerById
  , getMatchById
  , getMatchRefsByAccount
  , getAllMatchReferences
  , getMatchTimelineById
  , getClashBySummonerId
  , getClashTeamById
  , getTournaments
  , getTournamentByTeam
  , getTournamentById
  , getChallengerLeagues
  , getLeagueEntriesBySummoner
  , getLeagueEntries
  , getGrandMasterLeagues
  , getLeagueById
  , getMasterLeagues
  , getStatus
  , getActiveGame
  , getFeaturedGames
  , getSeasons
  , getQueues
  , getGameModes
  , getGameTypes
  , getVersions
  , getLanguages
  , getChampions
  , getItems
  , getSpells
  , getProfileIcons
  , getChampionByName
  )
where

import           Control.Lens
import           Data.Text
import           Data.Aeson
import           Web.Riot.LOL.Types
import           Web.Riot.RiotT
import           Web.Riot.Request
import           Web.Riot.Endpoint
import           Web.Riot.Config

-- Account

getAccountByPuuid :: Text -> RiotT Account
getAccountByPuuid puuid = request $ GET_ACCOUNT_BY_PUUID puuid

getAccountByTagLine :: Text -> Text -> RiotT Account
getAccountByTagLine gameName tagLine =
  request $ GET_ACCOUNT_BY_TAGLINE gameName tagLine

getAccountByGame :: Text -> Text -> RiotT Account
getAccountByGame game puuid = request $ GET_ACCOUNT_BY_GAME game puuid

-- Champion Mastery

getMasteryBySummonerId :: Text -> RiotT [ChampionMastery]
getMasteryBySummonerId id = request $ GET_MASTERY_BY_SUMMONER_ID id

getMasteryByIdWithChampionId :: Text -> Int -> RiotT ChampionMastery
getMasteryByIdWithChampionId id champion =
  request $ GET_MASTERY_BY_ID_WITH_CHAMP id champion

getMasteryScoreById :: Text -> RiotT Int
getMasteryScoreById id = request $ GET_MASTERY_SCORE_BY_ID id

-- Champion Rotation

getChampionRotation :: RiotT ChampionRotation
getChampionRotation = request GET_CHAMPION_ROTATION

-- Clash

getClashBySummonerId :: Text -> RiotT [ClashPlayer]
getClashBySummonerId id = request $ GET_CLASH_PLAYER_BY_ID id

getClashTeamById :: Text -> RiotT ClashTeam
getClashTeamById id = request $ GET_CLASH_TEAM id

getTournaments :: RiotT [Tournament]
getTournaments = request GET_CLASH_TOURNAMENTS

getTournamentByTeam :: Text -> RiotT Tournament
getTournamentByTeam id = request $ GET_CLASH_TOURNAMENTS_BY_TEAM id

getTournamentById :: Text -> RiotT Tournament
getTournamentById id = request $ GET_CLASH_TOURNAMENT_BY_ID id

-- Leagues

getChallengerLeagues :: Text -> RiotT LeagueList
getChallengerLeagues queue = request $ GET_ALL_CHALLENGER_LEAGUES queue

getLeagueEntriesBySummoner :: Text -> RiotT LeagueEntries
getLeagueEntriesBySummoner id = request $ GET_ENTRIES_BY_SUMMONER id

getLeagueEntries :: Text -> Text -> Text -> Maybe Int -> RiotT LeagueEntries
getLeagueEntries queue tier division page =
  request $ GET_ENTRIES_BY_QUEUE_TIER_DIV queue tier division page

getGrandMasterLeagues :: Text -> RiotT LeagueList
getGrandMasterLeagues queue = request $ GET_ALL_GRANDMASTER_LEAGUES queue

getLeagueById :: Text -> RiotT LeagueList
getLeagueById id = request $ GET_LEAGUE_BY_LEAGUE_ID id

getMasterLeagues :: Text -> RiotT LeagueList
getMasterLeagues queue = request $ GET_ALL_MASTER_LEAGUES queue

-- Status

getStatus :: RiotT PlatformData
getStatus = request GET_STATUS

-- Summoner

getSummonerByName :: Text -> RiotT Summoner
getSummonerByName name = request $ GET_SUMMONER_BY_NAME name

getSummonerByAccount :: Text -> RiotT Summoner
getSummonerByAccount account = request $ GET_SUMMONER_BY_ACCOUNT account

getSummonerByPuuid :: Text -> RiotT Summoner
getSummonerByPuuid puuid = request $ GET_SUMMONER_BY_PUUID puuid

getSummonerById :: Text -> RiotT Summoner
getSummonerById id = request $ GET_SUMMONER_BY_ID id

-- Matches

getMatchById :: Int -> RiotT Match
getMatchById id = request $ GET_MATCH_BY_ID id

getMatchRefsByAccount
  :: Text
  -> [Int]
  -> [Int]
  -> Maybe Int
  -> Maybe Int
  -> Maybe Int
  -> Maybe Int
  -> RiotT MatchReferences
getMatchRefsByAccount account champions queues beginTime endTime beginIndex endIndex
  = request $ GET_MATCHREFS_BY_ACCOUNT account
                                       champions
                                       queues
                                       beginTime
                                       endTime
                                       beginIndex
                                       endIndex

getAllMatchReferences
  :: Text
  -> [Int]
  -> [Int]
  -> Maybe Int
  -> Maybe Int
  -> Maybe Int
  -> Maybe Int
  -> RiotT [MatchReference]
getAllMatchReferences account champions queues beginTime endTime beginIndex endIndex
  = do
    matchRefs <- getMatchRefsByAccount account
                                       champions
                                       queues
                                       beginTime
                                       endTime
                                       beginIndex
                                       endIndex
    let totalGames = matchRefs ^. #totalGames
        begin      = matchRefs ^. #beginIndex
        end        = matchRefs ^. #endIndex
        matches    = matchRefs ^. #matches
    if totalGames <= end
      then return matches
      else do
        newMatchRefs <- getAllMatchReferences account
                                              champions
                                              queues
                                              beginTime
                                              endTime
                                              (Just (begin + 100))
                                              (Just (end + 100))
        return $ matches ++ newMatchRefs

getMatchTimelineById :: Int -> RiotT MatchTimeline
getMatchTimelineById id = request $ GET_MATCH_TIMELINE_BY_ID id

-- Spectator

getActiveGame :: Text -> RiotT CurrentGameInfo
getActiveGame id = request $ GET_ACTIVE_GAME_BY_ID id

getFeaturedGames :: RiotT FeaturedGames
getFeaturedGames = request GET_FEATURED_GAMES

-- Static Data

getSeasons :: RiotT Seasons
getSeasons = request GET_SEASONS

getQueues :: RiotT Queues
getQueues = request GET_QUEUES

getGameModes :: RiotT GameModes
getGameModes = request GET_GAME_MODES

getGameTypes :: RiotT GameTypes
getGameTypes = request GET_GAME_TYPES

getVersions :: RiotT [Text]
getVersions = request GET_VERSIONS

getLanguages :: RiotT [Text]
getLanguages = request GET_LANGUAGES

getChampions :: RiotT Champions
getChampions = do
  locale  <- getLocale
  version <- versionToUse
  request $ GET_CHAMPIONS version locale

getChampionByName :: Text -> RiotT Champions
getChampionByName name = do
  locale  <- getLocale
  version <- versionToUse
  request $ GET_CHAMPION_BY_NAME version locale name

getItems :: RiotT Items
getItems = do
  locale  <- getLocale
  version <- versionToUse
  request $ GET_ITEMS version locale

getSpells :: RiotT Spells
getSpells = do
  locale  <- getLocale
  version <- versionToUse
  request $ GET_SUMMONERS version locale

getProfileIcons :: RiotT ProfileIcons
getProfileIcons = do
  locale  <- getLocale
  version <- versionToUse
  request $ GET_PROFILE_ICONS version locale

-- Utils

getLastestVersion :: RiotT Text
getLastestVersion = do
  Prelude.head <$> getVersions

versionToUse :: RiotT Text
versionToUse = do
  version <- getVersion
  case version of
    Version a -> return a
    Latest    -> getLastestVersion

{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.LeagueEntry where

import           Data.Text
import           Data.Aeson
import           GHC.Generics
import           Web.Riot.LOL.Tier
import           Web.Riot.LOL.QueueType

type LeagueEntries = [LeagueEntry]

data MiniSeries
  = MiniSeries
  { losses   :: Int
  , progress :: Text
  , target   :: Int
  , wins     :: Int
  } deriving (Show, Generic)


instance FromJSON MiniSeries where
  parseJSON = withObject "miniSeries" $ \o -> do
    losses   <- o .: "losses"
    progress <- o .: "progress"
    target   <- o .: "target"
    wins     <- o .: "wins"
    return MiniSeries { .. }

instance ToJSON MiniSeries where
  toJSON MiniSeries {..} = object
    [ "losses" .= losses
    , "progress" .= progress
    , "target" .= target
    , "wins" .= wins
    ]

data LeagueEntry
    = LeagueEntry
    { id           :: Maybe Text
    , queueType    :: Maybe QueueType
    , tier         :: Maybe Tier
    , rank         :: Division
    , summonerId   :: Text
    , summonerName :: Text
    , leaguePoints :: Int
    , wins         :: Int
    , losses       :: Int
    , veteran      :: Bool
    , inactive     :: Bool
    , freshBlood   :: Bool
    , hotStreak    :: Bool
    , miniSeries   :: Maybe MiniSeries
    } deriving (Show, Generic)

instance FromJSON LeagueEntry where
  parseJSON = withObject "leagueEntry" $ \o -> do
    id           <- o .:? "leagueId"
    queueType    <- o .:? "queueType"
    tier         <- o .:? "tier"
    rank         <- o .: "rank"
    summonerId   <- o .: "summonerId"
    summonerName <- o .: "summonerName"
    leaguePoints <- o .: "leaguePoints"
    wins         <- o .: "wins"
    losses       <- o .: "losses"
    veteran      <- o .: "veteran"
    inactive     <- o .: "inactive"
    freshBlood   <- o .: "freshBlood"
    hotStreak    <- o .: "hotStreak"
    miniSeries   <- o .:? "miniSeries"
    return LeagueEntry { .. }

instance ToJSON LeagueEntry where
  toJSON LeagueEntry {..} = object
    [ "leagueId" .= id
    , "queueType" .= queueType
    , "tier" .= tier
    , "rank" .= rank
    , "summonerId" .= summonerId
    , "summonerName" .= summonerName
    , "leaguePoints" .= leaguePoints
    , "wins" .= wins
    , "losses" .= losses
    , "veteran" .= veteran
    , "inactive" .= inactive
    , "freshBlood" .= freshBlood
    , "hotStreak" .= hotStreak
    , "miniSeries" .= miniSeries
    ]

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE RecordWildCards   #-}

module Web.Riot.LOL.MatchReference where

import           Data.Text
import           Data.Aeson
import           GHC.Generics

data MatchReference
    = MatchReference
    { gameId     :: Int
    , role       :: Text
    , season     :: Int
    , platformId :: Text
    , champion   :: Int
    , queue      :: Int
    , lane       :: Text
    , timestamp  :: Int
    } deriving (Show, Generic)

instance FromJSON MatchReference where
  parseJSON = withObject "match_reference" $ \o -> do
    gameId     <- o .: "gameId"
    role       <- o .: "role"
    season     <- o .: "season"
    platformId <- o .: "platformId"
    champion   <- o .: "champion"
    queue      <- o .: "queue"
    lane       <- o .: "lane"
    timestamp  <- o .: "timestamp"
    return MatchReference { .. }

instance ToJSON MatchReference where
  toJSON MatchReference {..} = object
    [ "gameId"     .= gameId
    , "role"       .= role
    , "season"     .= season
    , "platformId" .= platformId
    , "champion"   .= champion
    , "queue"      .= queue
    , "lane"       .= lane
    , "timestamp"  .= timestamp
    ]

data MatchReferences
    = MatchReferences
    { matches    :: [MatchReference]
    , totalGames :: Int
    , endIndex   :: Int
    , beginIndex :: Int
    } deriving (Show, Generic)

instance FromJSON MatchReferences where
  parseJSON = withObject "match_references" $ \o -> do
    matches    <- o .: "matches"
    totalGames <- o .: "totalGames"
    endIndex   <- o .: "endIndex"
    beginIndex <- o .: "startIndex"
    return MatchReferences { .. }

instance ToJSON MatchReferences where
  toJSON MatchReferences {..} = object
    [ "matches"    .= matches
    , "totalGames" .= totalGames
    , "endIndex"   .= endIndex
    , "startIndex" .= beginIndex
    ]
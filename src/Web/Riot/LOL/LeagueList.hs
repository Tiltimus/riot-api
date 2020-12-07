{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.LeagueList where

import           Data.Text
import           Data.Aeson
import           GHC.Generics
import           Web.Riot.LOL.LeagueEntry

data LeagueList
    = LeagueList
    { leagueId :: Text
    , entries  :: [LeagueEntry]
    , tier     :: Text
    , name     :: Text
    , queue    :: Text
    } deriving (Show, Generic)

instance FromJSON LeagueList where
  parseJSON = withObject "leagueList" $ \o -> do
    leagueId <- o .: "leagueId"
    entries  <- o .: "entries"
    tier     <- o .: "tier"
    name     <- o .: "name"
    queue    <- o .: "queue"
    return LeagueList { .. }

instance ToJSON LeagueList where
  toJSON LeagueList {..} = object
    [ "leagueId" .= leagueId
    , "entries" .= entries
    , "tier" .= tier
    , "name" .= name
    , "queue" .= queue
    ]

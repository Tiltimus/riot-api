{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Clash.ClashTeam where

import           Data.Text
import           Data.Aeson
import           GHC.Generics
import           Web.Riot.LOL.Clash.ClashPlayer

data ClashTeam
    = ClashTeam
    { id           :: Text
    , tournamentId :: Int
    , name         :: Text
    , iconId       :: Int
    , tier         :: Int
    , captain      :: Text
    , abbreviation :: Text
    , players      :: [ClashPlayer]
    } deriving (Generic, Show)

instance FromJSON ClashTeam where
  parseJSON = withObject "clashTeam" $ \o -> do
    id           <- o .: "id"
    tournamentId <- o .: "tournamentId"
    iconId       <- o .: "iconId"
    name         <- o .: "name"
    tier         <- o .: "tier"
    captain      <- o .: "captain"
    abbreviation <- o .: "abbreviation"
    players      <- o .: "players"
    return ClashTeam { .. }

instance ToJSON ClashTeam where
  toJSON ClashTeam {..} = object
    [ "id" .= id
    , "tournamentId" .= tournamentId
    , "iconId" .= iconId
    , "name" .= name
    , "tier" .= tier
    , "captain" .= captain
    , "abbreviation" .= abbreviation
    , "players" .= players
    ]

{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Clash.Tournament where

import           Data.Text
import           Data.Aeson
import           GHC.Generics
import           Web.Riot.LOL.Clash.TournamentPhase

data Tournament
    = Tournament
    { id               :: Int
    , themeId          :: Int
    , nameKey          :: Text
    , nameKeySecondary :: Text
    , schedule         :: [TournamentPhase]
    } deriving (Generic, Show)

instance FromJSON Tournament where
  parseJSON = withObject "tournament" $ \o -> do
    id               <- o .: "id"
    themeId          <- o .: "themeId"
    nameKey          <- o .: "nameKey"
    nameKeySecondary <- o .: "nameKeySecondary"
    schedule         <- o .: "schedule"
    return Tournament { .. }

instance ToJSON Tournament where
  toJSON Tournament {..} = object
    [ "id" .= id
    , "themeId" .= themeId
    , "nameKey" .= nameKey
    , "nameKeySecondary" .= nameKeySecondary
    , "schedule" .= schedule
    ]

{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Clash.TournamentPhase where

import           Data.Text
import           Data.Aeson
import           GHC.Generics

data TournamentPhase
    = TournamentPhase
    { id               :: Int
    , registrationTime :: Int
    , startTime        :: Int
    , cancelled        :: Bool
    } deriving (Generic, Show)

instance FromJSON TournamentPhase where
  parseJSON = withObject "tournamentPhase" $ \o -> do
    id               <- o .: "id"
    registrationTime <- o .: "registrationTime"
    startTime        <- o .: "startTime"
    cancelled        <- o .: "cancelled"
    return TournamentPhase { .. }

instance ToJSON TournamentPhase where
  toJSON TournamentPhase {..} = object
    [ "id" .= id
    , "registrationTime" .= registrationTime
    , "startTime" .= startTime
    , "cancelled" .= cancelled
    ]

{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.CurrentGameInfo.BannedChampion where

import           Control.Applicative
import           Data.Text
import           Data.Aeson
import           GHC.Generics

data BannedChampion
    = BannedChampion
    { pickTurn  :: Int
    , championId :: Int
    , teamId :: Int
    } deriving (Generic, Show)

instance FromJSON BannedChampion where
  parseJSON = withObject "bannedChampion" $ \o -> do
    pickTurn   <- o .: "pickTurn"
    championId <- o .: "championId"
    teamId     <- o .: "teamId"
    return BannedChampion { .. }

instance ToJSON BannedChampion where
  toJSON BannedChampion {..} = object
    ["pickTurn" .= pickTurn, "championId" .= championId, "teamId" .= teamId]

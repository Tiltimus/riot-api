{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.ChampionRotation where

import           Data.Text
import           Data.Aeson
import           GHC.Generics

data ChampionRotation
    = ChampionRotation
    { maxNewPlayerLevel            :: Int
    , freeChampionIdsForNewPlayers :: [Int]
    , freeChampionIds              :: [Int]
    } deriving (Generic, Show)

instance FromJSON ChampionRotation where
  parseJSON = withObject "ChampionRotation" $ \o -> do
    maxNewPlayerLevel            <- o .: "maxNewPlayerLevel"
    freeChampionIdsForNewPlayers <- o .: "freeChampionIdsForNewPlayers"
    freeChampionIds              <- o .: "freeChampionIds"
    return ChampionRotation { .. }

instance ToJSON ChampionRotation where
  toJSON ChampionRotation {..} = object
    [ "maxNewPlayerLevel" .= maxNewPlayerLevel
    , "freeChampionIdsForNewPlayers" .= freeChampionIdsForNewPlayers
    , "freeChampionIds" .= freeChampionIds
    ]

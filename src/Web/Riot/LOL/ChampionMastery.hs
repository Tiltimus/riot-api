{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.ChampionMastery where

import           Data.Text
import           Data.Aeson
import           GHC.Generics

data ChampionMastery
    = ChampionMastery
    { championPointsUntilNextLevel :: Int
    , chestGranted                 :: Bool
    , championId                   :: Int
    , lastPlayTime                 :: Int
    , championLevel                :: Int
    , summonerId                   :: Text
    , championPoints               :: Int
    , championPointsSinceLastLevel :: Int
    , tokensEarned                 :: Int
    } deriving (Generic, Show)

instance FromJSON ChampionMastery where
  parseJSON = withObject "championMastery" $ \o -> do
    championPointsUntilNextLevel <- o .: "championPointsUntilNextLevel"
    chestGranted                 <- o .: "chestGranted"
    championId                   <- o .: "championId"
    lastPlayTime                 <- o .: "lastPlayTime"
    championLevel                <- o .: "championLevel"
    summonerId                   <- o .: "summonerId"
    championPoints               <- o .: "championPoints"
    championPointsSinceLastLevel <- o .: "championPointsSinceLastLevel"
    tokensEarned                 <- o .: "tokensEarned"
    return ChampionMastery { .. }

instance ToJSON ChampionMastery where
  toJSON ChampionMastery {..} = object
    [ "championPointsUntilNextLevel" .= championPointsUntilNextLevel
    , "chestGranted" .= chestGranted
    , "championId" .= championId
    , "lastPlayTime" .= lastPlayTime
    , "championLevel" .= championLevel
    , "summonerId" .= summonerId
    , "championPoints" .= championPoints
    , "championPointsSinceLastLevel" .= championPointsSinceLastLevel
    , "tokensEarned" .= tokensEarned
    ]

{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Match.Team where

import           Control.Monad
import           Data.Aeson
import           Data.Text
import           GHC.Generics
import           Web.Riot.LOL.Match.Bans

data Team = Team
  { towerKills           :: Int
  , firstBaron           :: Bool
  , dominionVictoryScore :: Int
  , dragonKills          :: Int
  , teamId               :: Int
  , firstDragon          :: Bool
  , riftHeraldKills      :: Int
  , bans                 :: [Bans]
  , firstTower           :: Bool
  , vilemawKills         :: Int
  , inhibitorKills       :: Int
  , firstRiftHerald      :: Bool
  , win                  :: Text
  , firstBlood           :: Bool
  , firstInhibitor       :: Bool
  , baronKills           :: Int
  } deriving (Show, Eq, Generic)

instance FromJSON Team where
  parseJSON (Object v) =
    Team
      <$> v
      .:  "towerKills"
      <*> v
      .:  "firstBaron"
      <*> v
      .:  "dominionVictoryScore"
      <*> v
      .:  "dragonKills"
      <*> v
      .:  "teamId"
      <*> v
      .:  "firstDragon"
      <*> v
      .:  "riftHeraldKills"
      <*> v
      .:  "bans"
      <*> v
      .:  "firstTower"
      <*> v
      .:  "vilemawKills"
      <*> v
      .:  "inhibitorKills"
      <*> v
      .:  "firstRiftHerald"
      <*> v
      .:  "win"
      <*> v
      .:  "firstBlood"
      <*> v
      .:  "firstInhibitor"
      <*> v
      .:  "baronKills"

  parseJSON _ = mzero

instance ToJSON Team where
  toJSON Team {..} = object
    [ "towerKills"           .= towerKills
    , "firstBaron"           .= firstBaron
    , "dominionVictoryScore" .= dominionVictoryScore
    , "dragonKills"          .= dragonKills
    , "teamId"               .= teamId
    , "firstDragon"          .= firstDragon
    , "riftHeraldKills"      .= riftHeraldKills
    , "bans"                 .= bans
    , "firstTower"           .= firstTower
    , "vilemawKills"         .= vilemawKills
    , "inhibitorKills"       .= inhibitorKills
    , "firstRiftHerald"      .= firstRiftHerald
    , "win"                  .= win
    , "firstBlood"           .= firstBlood
    , "firstInhibitor"       .= firstInhibitor
    , "baronKills"           .= baronKills
    ]
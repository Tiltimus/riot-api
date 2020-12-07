{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.Champions.ChampionStats where

import           Control.Monad
import           Data.Aeson
import           GHC.Generics

data ChampionStats
    = ChampionStats
    { crit                 :: Int
    , attackspeed          :: Double
    , mpregenperlevel      :: Double
    , attackrange          :: Int
    , spellblock           :: Double
    , armorperlevel        :: Double
    , critperlevel         :: Int
    , armor                :: Double
    , movespeed            :: Int
    , mpperlevel           :: Double
    , hpregenperlevel      :: Double
    , attackdamageperlevel :: Double
    , mp                   :: Double
    , hp                   :: Double
    , attackdamage         :: Double
    , hpregen              :: Double
    , mpregen              :: Double
    , attackspeedperlevel  :: Double
    , spellblockperlevel   :: Double
    , hpperlevel           :: Int
  } deriving (Show, Eq, Generic)

instance FromJSON ChampionStats where
  parseJSON (Object v) =
    ChampionStats
      <$> v
      .:  "crit"
      <*> v
      .:  "attackspeed"
      <*> v
      .:  "mpregenperlevel"
      <*> v
      .:  "attackrange"
      <*> v
      .:  "spellblock"
      <*> v
      .:  "armorperlevel"
      <*> v
      .:  "critperlevel"
      <*> v
      .:  "armor"
      <*> v
      .:  "movespeed"
      <*> v
      .:  "mpperlevel"
      <*> v
      .:  "hpregenperlevel"
      <*> v
      .:  "attackdamageperlevel"
      <*> v
      .:  "mp"
      <*> v
      .:  "hp"
      <*> v
      .:  "attackdamage"
      <*> v
      .:  "hpregen"
      <*> v
      .:  "mpregen"
      <*> v
      .:  "attackspeedperlevel"
      <*> v
      .:  "spellblockperlevel"
      <*> v
      .:  "hpperlevel"

  parseJSON _ = mzero

instance ToJSON ChampionStats where
  toJSON ChampionStats {..} = object
    [ "crit"                 .= crit
    , "attackspeed"          .= attackspeed
    , "mpregenperlevel"      .= mpregenperlevel
    , "attackrange"          .= attackrange
    , "spellblock"           .= spellblock
    , "armorperlevel"        .= armorperlevel
    , "critperlevel"         .= critperlevel
    , "armor"                .= armor
    , "movespeed"            .= movespeed
    , "mpperlevel"           .= mpperlevel
    , "hpregenperlevel"      .= hpregenperlevel
    , "attackdamageperlevel" .= attackdamageperlevel
    , "mp"                   .= mp
    , "hp"                   .= hp
    , "attackdamage"         .= attackdamage
    , "hpregen"              .= hpregen
    , "mpregen"              .= mpregen
    , "attackspeedperlevel"  .= attackspeedperlevel
    , "spellblockperlevel"   .= spellblockperlevel
    , "hpperlevel"           .= hpperlevel
    ]
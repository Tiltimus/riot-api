{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.Champions.Info where

import           Data.Aeson
import           GHC.Generics

data Info
    = Info
    { attack     :: Int
    , defense    :: Int
    , magic      :: Int
    , difficulty :: Int
    } deriving (Show, Generic)

instance FromJSON Info where
  parseJSON = withObject "info" $ \o -> do
    attack     <- o .: "attack"
    defense    <- o .: "defense"
    magic      <- o .: "magic"
    difficulty <- o .: "difficulty"
    return Info { .. }

instance ToJSON Info where
  toJSON Info {..} = object
    [ "attack"     .= attack
    , "defense"    .= defense
    , "magic"      .= magic
    , "difficulty" .= difficulty
    ]

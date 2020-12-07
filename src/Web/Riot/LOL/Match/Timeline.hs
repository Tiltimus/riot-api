{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Match.Timeline where

import           Control.Monad
import           Data.Aeson
import           Data.Text
import           GHC.Generics
import           Web.Riot.LOL.Match.XpDiff

data Timeline = Timeline
  { participantId               :: Int
  , damageTakenDiffPerMinDeltas :: Maybe XpDiffPerMinDeltas
  , damageTakenPerMinDeltas     :: Maybe XpDiffPerMinDeltas
  , goldPerMinDeltas            :: Maybe XpDiffPerMinDeltas
  , xpPerMinDeltas              :: Maybe XpDiffPerMinDeltas
  , creepsPerMinDeltas          :: Maybe XpDiffPerMinDeltas
  , role                        :: Text
  , csDiffPerMinDeltas          :: Maybe XpDiffPerMinDeltas
  , xpDiffPerMinDeltas          :: Maybe XpDiffPerMinDeltas
  , lane                        :: Text
  } deriving (Show, Eq, Generic)

instance FromJSON Timeline where
  parseJSON (Object v) =
    Timeline
      <$> v
      .:  "participantId"
      <*> v
      .:?  "damageTakenDiffPerMinDeltas"
      <*> v
      .:?  "damageTakenPerMinDeltas"
      <*> v
      .:?  "goldPerMinDeltas"
      <*> v
      .:?  "xpPerMinDeltas"
      <*> v
      .:?  "creepsPerMinDeltas"
      <*> v
      .:  "role"
      <*> v
      .:?  "csDiffPerMinDeltas"
      <*> v
      .:?  "xpDiffPerMinDeltas"
      <*> v
      .:  "lane"

  parseJSON _ = mzero

instance ToJSON Timeline where
  toJSON Timeline {..} = object
    [ "participantId"               .= participantId
    , "damageTakenDiffPerMinDeltas" .= damageTakenDiffPerMinDeltas
    , "damageTakenPerMinDeltas"     .= damageTakenPerMinDeltas
    , "goldPerMinDeltas"            .= goldPerMinDeltas
    , "xpPerMinDeltas"              .= xpPerMinDeltas
    , "creepsPerMinDeltas"          .= creepsPerMinDeltas
    , "role"                        .= role
    , "csDiffPerMinDeltas"          .= csDiffPerMinDeltas
    , "xpDiffPerMinDeltas"          .= xpDiffPerMinDeltas
    , "lane"                        .= lane
    ]
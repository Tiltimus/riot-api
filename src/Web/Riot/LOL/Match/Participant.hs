{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Match.Participant where
  
import           Control.Monad
import           Data.Aeson
import           GHC.Generics
import           Web.Riot.LOL.Match.Timeline
import           Web.Riot.LOL.Match.Stats

type PP = Participant

data Participant = Participant
  { id            :: Int
  , teamId        :: Int
  , stats         :: Stats
  , spell2Id      :: Int
  , spell1Id      :: Int
  , championId    :: Int
  , timeline      :: Timeline
  }  deriving (Show, Eq, Generic)

instance FromJSON Participant where
  parseJSON (Object v) =
    Participant
      <$> v
      .:  "participantId"
      <*> v
      .:  "teamId"
      <*> v
      .:  "stats"
      <*> v
      .:  "spell2Id"
      <*> v
      .:  "spell1Id"
      <*> v
      .:  "championId"
      <*> v
      .:  "timeline"
  parseJSON _ = mzero

instance ToJSON Participant where
  toJSON Participant {..} = object
    [ "participantId" .= id
    , "teamId"        .= teamId
    , "stats"         .= stats
    , "spell2Id"      .= spell2Id
    , "spell1Id"      .= spell1Id
    , "championId"    .= championId
    , "timeline"      .= timeline
    ]
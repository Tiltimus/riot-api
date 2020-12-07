{-# LANGUAGE DeriveGeneric                #-}
{-# LANGUAGE OverloadedStrings            #-}
{-# LANGUAGE AllowAmbiguousTypes          #-}
{-# LANGUAGE DataKinds                    #-}
{-# LANGUAGE DuplicateRecordFields        #-}
{-# LANGUAGE FlexibleContexts             #-}
{-# LANGUAGE GADTs                        #-}
{-# LANGUAGE NoMonomorphismRestriction    #-}
{-# LANGUAGE PartialTypeSignatures        #-}
{-# LANGUAGE Rank2Types                   #-}
{-# LANGUAGE ScopedTypeVariables          #-}
{-# LANGUAGE UndecidableInstances         #-}
{-# LANGUAGE RecordWildCards              #-}

module Web.Riot.LOL.Match
  ( module Web.Riot.LOL.Match.Bans
  , module Web.Riot.LOL.Match.Participant
  , module Web.Riot.LOL.Match.ParticipantIdentity
  , module Web.Riot.LOL.Match.Player
  , module Web.Riot.LOL.Match.Stats
  , module Web.Riot.LOL.Match.Team
  , module Web.Riot.LOL.Match.Timeline
  , module Web.Riot.LOL.Match.XpDiff
  , Match
  , gameVersion
  , pi
  , matchId
  , teams
  , mapId
  , pp
  , queueId
  , gameCreation
  , regionId
  , gameMode
  , gameDuration
  , seasonId
  , gameType
  )
where

import           Control.Monad
import           Data.Aeson
import           Data.Text
import           GHC.Generics
import           Web.Riot.LOL.Summoner
import           Web.Riot.LOL.Match.Bans
import           Web.Riot.LOL.Match.Participant
import           Web.Riot.LOL.Match.ParticipantIdentity
import           Web.Riot.LOL.Match.Player
import           Web.Riot.LOL.Match.Stats
import           Web.Riot.LOL.Match.Team
import           Web.Riot.LOL.Match.Timeline
import           Web.Riot.LOL.Match.XpDiff

data Match = Match
  { gameVersion  :: Text
  , pis          :: [ParticipantIdentity]
  , matchId      :: Int
  , teams        :: [Team]
  , mapId        :: Int
  , pp           :: [Participant]
  , queueId      :: Int
  , gameCreation :: Int
  , regionId     :: Text
  , gameMode     :: Text
  , gameDuration :: Int
  , seasonId     :: Int
  , gameType     :: Text
  } deriving (Show, Eq, Generic)

instance FromJSON Match where
  parseJSON (Object v) =
    Match
      <$> v
      .:  "gameVersion"
      <*> v
      .:  "participantIdentities"
      <*> v
      .:  "gameId"
      <*> v
      .:  "teams"
      <*> v
      .:  "mapId"
      <*> v
      .:  "participants"
      <*> v
      .:  "queueId"
      <*> v
      .:  "gameCreation"
      <*> v
      .:  "platformId"
      <*> v
      .:  "gameMode"
      <*> v
      .:  "gameDuration"
      <*> v
      .:  "seasonId"
      <*> v
      .:  "gameType"

  parseJSON _ = mzero

instance ToJSON Match where
  toJSON Match {..} = object
    [ "gameVersion"           .= gameVersion
    , "participantIdentities" .= pis
    , "gameId"                .= matchId
    , "teams"                 .= teams
    , "mapId"                 .= mapId
    , "participants"          .= pp
    , "queueId"               .= queueId
    , "gameCreation"          .= gameCreation
    , "platformId"            .= regionId
    , "gameMode"              .= gameMode
    , "gameDuration"          .= gameDuration
    , "seasonId"              .= seasonId
    , "gameType"              .= gameType
    ]
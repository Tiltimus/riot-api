{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.CurrentGameInfo where

import           Control.Applicative
import           Data.Text
import           Data.Aeson
import           GHC.Generics
import           Web.Riot.LOL.CurrentGameInfo.CurrentGameParticipant
import           Web.Riot.LOL.CurrentGameInfo.BannedChampion
import           Web.Riot.LOL.CurrentGameInfo.Observer

data CurrentGameInfo
    = CurrentGameInfo
    { gameId            :: Int
    , gameType          :: Text
    , gameStartTime     :: Int
    , mapId             :: Int
    , gameLength        :: Int
    , platformId        :: Text
    , gameMode          :: Text
    , bannedChampions   :: [BannedChampion]
    , gameQueueConfigId :: Int
    , observers         :: Observer
    , participants      :: [CurrentGameParticipant]
    } deriving (Generic, Show)

instance FromJSON CurrentGameInfo where
  parseJSON = withObject "currentGameInfo" $ \o -> do
    gameId            <- o .: "gameId"
    gameType          <- o .: "gameType"
    gameStartTime     <- o .: "gameStartTime"
    mapId             <- o .: "mapId"
    gameLength        <- o .: "gameLength"
    platformId        <- o .: "platformId"
    gameMode          <- o .: "gameMode"
    bannedChampions   <- o .: "bannedChampions"
    gameQueueConfigId <- o .: "gameQueueConfigId"
    observers         <- o .: "observers"
    participants      <- o .: "participants"
    return CurrentGameInfo { .. }

instance ToJSON CurrentGameInfo where
  toJSON CurrentGameInfo {..} = object
    [ "gameId" .= gameId
    , "gameType" .= gameType
    , "gameStartTime" .= gameStartTime
    , "mapId" .= mapId
    , "gameLength" .= gameLength
    , "platformId" .= platformId
    , "gameMode" .= gameMode
    , "bannedChampions" .= bannedChampions
    , "gameQueueConfigId" .= gameQueueConfigId
    , "observers" .= observers
    , "participants" .= participants
    ]

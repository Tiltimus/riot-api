{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.CurrentGameInfo.CurrentGameParticipant where

import           Control.Applicative
import           Data.Text
import           Data.Aeson
import           GHC.Generics
import           Web.Riot.LOL.CurrentGameInfo.GameCustomization
import           Web.Riot.LOL.CurrentGameInfo.Perks

data CurrentGameParticipant
    = CurrentGameParticipant
    { championId        :: Int
    , perks             :: Maybe Perks
    , profileIconId     :: Int
    , bot               :: Bool
    , teamId            :: Int
    , summonerId        :: Maybe Text
    , summonerName      :: Text
    , spell1Id          :: Int
    , spell2Id          :: Int
    , gameCustomization :: Maybe [GameCustomization]
    } deriving (Generic, Show)

instance FromJSON CurrentGameParticipant where
  parseJSON = withObject "currentGameParticipant" $ \o -> do
    championId        <- o .: "championId"
    perks             <- o .:? "perks"
    profileIconId     <- o .: "profileIconId"
    bot               <- o .: "bot"
    teamId            <- o .: "teamId"
    summonerId        <- o .:? "summonerId"
    summonerName      <- o .: "summonerName"
    spell1Id          <- o .: "spell1Id"
    spell2Id          <- o .: "spell2Id"
    gameCustomization <- o .:? "gameCustomizationObjects"
    return CurrentGameParticipant { .. }

instance ToJSON CurrentGameParticipant where
  toJSON CurrentGameParticipant {..} = object
    [ "championId" .= championId
    , "perks" .= perks
    , "profileIconId" .= profileIconId
    , "bot" .= bot
    , "teamId" .= teamId
    , "summonerId" .= summonerId
    , "summonerName" .= summonerName
    , "spell1Id" .= spell1Id
    , "spell2Id" .= spell2Id
    , "gameCustomizationObjects" .= gameCustomization
    ]


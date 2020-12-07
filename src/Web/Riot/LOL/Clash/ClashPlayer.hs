{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Clash.ClashPlayer where

import           Data.Text
import           Data.Aeson
import           GHC.Generics

data ClashPlayer
    = ClashPlayer
    { summonerId :: Maybe Text
    , teamId     :: Maybe Text
    , position   :: Text
    , role       :: Text
    } deriving (Generic, Show)

instance FromJSON ClashPlayer where
  parseJSON = withObject "clashPlayer" $ \o -> do
    summonerId <- o .:? "summonerId"
    teamId     <- o .:? "teamId"
    position   <- o .:  "position"
    role       <- o .:  "role"
    return ClashPlayer { .. }

instance ToJSON ClashPlayer where
  toJSON ClashPlayer {..} = object
    [ "summonerId" .= summonerId
    , "teamId" .= teamId
    , "position" .= position
    , "role" .= role
    ]

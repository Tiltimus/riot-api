{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.GameMode where

import           Data.Text
import           Data.Aeson
import           GHC.Generics

type GameModes = [GameMode]

data GameMode
    = GameMode
    { gameMode    :: Text
    , description :: Text
    } deriving (Show, Eq, Generic)

instance FromJSON GameMode where
  parseJSON = withObject "gameMode" $ \o -> do
    gameMode    <- o .: "gameMode"
    description <- o .: "description"
    return GameMode { .. }

instance ToJSON GameMode where
  toJSON GameMode {..} =
    object ["gameMode" .= gameMode, "description" .= description]

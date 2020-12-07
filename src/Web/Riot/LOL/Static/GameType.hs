{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.GameType where

import           Data.Text
import           Data.Aeson
import           GHC.Generics

type GameTypes = [GameType]

data GameType
    = GameType
    { gameType    :: Text
    , description :: Text
    } deriving (Show, Eq, Generic)

instance FromJSON GameType where
  parseJSON = withObject "gameType" $ \o -> do
    gameType    <- o .: "gametype"
    description <- o .: "description"
    return GameType { .. }

instance ToJSON GameType where
  toJSON GameType {..} =
    object ["gametype" .= gameType, "description" .= description]

{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.Season where

import           Data.Text
import           Data.Aeson
import           GHC.Generics

type Seasons = [Season]

data Season
    = Season
    { id     :: Int
    , season :: Text
    } deriving (Show, Eq, Generic)

instance FromJSON Season where
  parseJSON = withObject "season" $ \o -> do
    id     <- o .: "id"
    season <- o .: "season"
    return Season { .. }

instance ToJSON Season where
  toJSON Season {..} = object ["id" .= id, "season" .= season]

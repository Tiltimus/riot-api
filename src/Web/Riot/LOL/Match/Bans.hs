{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Match.Bans where

import           Control.Monad
import           Data.Aeson
import           GHC.Generics

data Bans = Bans
  { pickTurn   :: Int
  , championId :: Int
  }
  deriving (Show, Eq, Generic)

instance FromJSON Bans where
  parseJSON (Object v) = Bans <$> v .: "pickTurn" <*> v .: "championId"

  parseJSON _          = mzero

instance ToJSON Bans where
  toJSON Bans {..} =
    object ["pickTurn" .= pickTurn, "championId" .= championId]

  toEncoding Bans {..} =
    pairs ("pickTurn" .= pickTurn <> "championId" .= championId)

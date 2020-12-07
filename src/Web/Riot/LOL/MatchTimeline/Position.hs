{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.MatchTimeline.Position where

import           Control.Monad
import           Data.Aeson
import           GHC.Generics

data Position = Position
  { x :: Int
  , y :: Int
  }  deriving (Show, Eq, Generic)

instance FromJSON Position where
  parseJSON (Object v) = Position <$> v .: "x" <*> v .: "y"

  parseJSON _          = mzero

instance ToJSON Position where
  toJSON Position {..} = object ["x" .= x, "y" .= y]

{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.MatchTimeline where

import           Control.Monad
import           Data.Aeson
import           Data.Text
import           Data.Map
import           GHC.Generics
import           Web.Riot.LOL.MatchTimeline.Frame

data MatchTimeline = MatchTimeline
  { frames :: [Frame]
  , frameInterval :: Int
  }  deriving (Show, Eq, Generic)

instance FromJSON MatchTimeline where
  parseJSON = withObject "matchTimeline" $ \o -> do
    frames        <- o .: "frames"
    frameInterval <- o .: "frameInterval"
    return MatchTimeline { .. }

instance ToJSON MatchTimeline where
  toJSON MatchTimeline {..} =
    object ["frames" .= frames, "frameInterval" .= frameInterval]

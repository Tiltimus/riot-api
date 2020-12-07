{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.MatchTimeline.Frame where

import           Control.Monad
import           Data.Aeson
import           Data.Text
import           Data.Map
import           GHC.Generics
import           Web.Riot.LOL.MatchTimeline.ParticipantFrame
import           Web.Riot.LOL.MatchTimeline.Event

data Frame = Frame
  { participantFrames :: Map String ParticipantFrame
  , events :: [Event]
  , timestamp :: Int
  }  deriving (Show, Eq, Generic)

instance FromJSON Frame where
parseJSON = withObject "frame" $ \o -> do
  participantFrames <- o .: "participantFrames"
  events            <- o .: "events"
  timestamp         <- o .: "timestamp"
  return Frame { .. }

instance ToJSON Frame where
  toJSON Frame {..} = object
    [ "participantFrames" .= participantFrames
    , "events" .= events
    , "timestamp" .= timestamp
    ]

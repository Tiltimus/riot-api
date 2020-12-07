{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.MatchTimeline.ParticipantFrame where

import           Control.Monad
import           Data.Aeson
import           Data.Text
import           GHC.Generics
import           Web.Riot.LOL.MatchTimeline.Position

data ParticipantFrame = ParticipantFrame
  { participantId       :: Maybe Int
  , minionsKilled       :: Maybe Int
  , teamScore           :: Maybe Int
  , dominionScore       :: Maybe Int
  , totalGold           :: Maybe Int
  , level               :: Maybe Int
  , xp                  :: Maybe Int
  , currentGold         :: Maybe Int
  , position            :: Maybe Position
  , jungleMinionsKilled :: Maybe Int
  }  deriving (Show, Eq, Generic)

instance FromJSON ParticipantFrame where
parseJSON = withObject "participantFrame" $ \o -> do
  participantId       <- o .:? "participantId"
  minionsKilled       <- o .:? "minionsKilled"
  teamScore           <- o .:? "teamScore"
  dominionScore       <- o .:? "dominionScore"
  totalGold           <- o .:? "totalGold"
  level               <- o .:? "level"
  xp                  <- o .:? "xp"
  currentGold         <- o .:? "currentGold"
  position            <- o .:? "position"
  jungleMinionsKilled <- o .:? "jungleMinionsKilled"
  return ParticipantFrame { .. }

instance ToJSON ParticipantFrame where
  toJSON ParticipantFrame {..} = object
    [ "participantId" .= participantId
    , "minionsKilled" .= minionsKilled
    , "teamScore" .= teamScore
    , "dominionScore" .= dominionScore
    , "totalGold" .= totalGold
    , "level" .= level
    , "xp" .= xp
    , "currentGold" .= currentGold
    , "position" .= position
    , "jungleMinionsKilled" .= jungleMinionsKilled
    ]

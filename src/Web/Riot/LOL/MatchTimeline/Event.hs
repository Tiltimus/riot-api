{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.MatchTimeline.Event where

import           Control.Monad
import           Data.Aeson
import           Data.Text
import           GHC.Generics
import           Web.Riot.LOL.MatchTimeline.Position

data Event = Event
  { laneType                :: Maybe Text
  , skillSlot               :: Maybe Int
  , ascendedType            :: Maybe Text
  , creatorId               :: Maybe Int
  , afterId                 :: Maybe Int
  , eventType               :: Maybe Text
  , actionType              :: Maybe Text
  , levelUpType             :: Maybe Text
  , wardType                :: Maybe Text
  , participantId           :: Maybe Int
  , towerType               :: Maybe Text
  , itemId                  :: Maybe Int
  , beforeId                :: Maybe Int
  , pointCaptured           :: Maybe Text
  , monsterType             :: Maybe Text
  , monsterSubType          :: Maybe Text
  , teamId                  :: Maybe Int
  , position                :: Maybe Position
  , killerId                :: Maybe Int
  , timestamp               :: Maybe Int
  , assistingParticipantIds :: Maybe [Int]
  , buildingType            :: Maybe Text
  , victimId                :: Maybe Int
  }  deriving (Show, Eq, Generic)

instance FromJSON Event where
parseJSON = withObject "event" $ \o -> do
  laneType                <- o .:? "laneType"
  skillSlot               <- o .:? "skillSlot"
  ascendedType            <- o .:? "ascendedType"
  creatorId               <- o .:? "creatorId"
  afterId                 <- o .:? "afterId"
  eventType               <- o .:? "eventType"
  actionType              <- o .:? "type"
  levelUpType             <- o .:? "levelUpType"
  wardType                <- o .:? "wardType"
  participantId           <- o .:? "participantId"
  towerType               <- o .:? "towerType"
  itemId                  <- o .:? "itemId"
  beforeId                <- o .:? "beforeId"
  pointCaptured           <- o .:? "pointCaptured"
  monsterType             <- o .:? "monsterType"
  monsterSubType          <- o .:? "monsterSubType"
  teamId                  <- o .:? "teamId"
  position                <- o .:? "position"
  killerId                <- o .:? "killerId"
  timestamp               <- o .:? "timestamp"
  assistingParticipantIds <- o .:? "assistingParticipantIds"
  buildingType            <- o .:? "buildingType"
  victimId                <- o .:? "victimId"
  return Event { .. }

instance ToJSON Event where
  toJSON Event {..} = object
    [ "laneType"                .= laneType
    , "skillSlot"               .= skillSlot
    , "ascendedType"            .= ascendedType
    , "creatorId"               .= creatorId
    , "afterId"                 .= afterId
    , "eventType"               .= eventType
    , "type"                    .= actionType
    , "levelUpType"             .= levelUpType
    , "wardType"                .= wardType
    , "participantId"           .= participantId
    , "towerType"               .= towerType
    , "itemId"                  .= itemId
    , "beforeId"                .= beforeId
    , "pointCaptured"           .= pointCaptured
    , "monsterType"             .= monsterType
    , "monsterSubType"          .= monsterSubType
    , "teamId"                  .= teamId
    , "position"                .= position
    , "killerId"                .= killerId
    , "timestamp"               .= timestamp
    , "assistingParticipantIds" .= assistingParticipantIds
    , "buildingType"            .= buildingType
    , "victimId"                .= victimId
    ]

{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Match.ParticipantIdentity where

import           Control.Monad
import           Data.Aeson
import           GHC.Generics
import           Control.Lens.TH
import           Web.Riot.LOL.Match.Player

type PI = ParticipantIdentity

data ParticipantIdentity = ParticipantIdentity
  { id     :: Int
  , player :: Player
  }
  deriving (Show, Eq, Generic)

instance FromJSON ParticipantIdentity where
  parseJSON (Object v) =
    ParticipantIdentity <$> v .: "participantId" <*> v .: "player"

  parseJSON _ = mzero

instance ToJSON ParticipantIdentity where
  toJSON ParticipantIdentity {..} = object
    [ "participantId" .= id
    , "player"        .= player
    ]
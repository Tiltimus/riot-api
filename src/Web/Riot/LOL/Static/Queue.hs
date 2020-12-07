{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.Queue where

import           Data.Text
import           Data.Aeson
import           GHC.Generics

type Queues = [Queue]

data Queue
    = Queue
    { id          :: Int
    , map         :: Text
    , description :: Maybe Text
    , notes       :: Maybe Text
    } deriving (Show, Eq, Generic)

instance FromJSON Queue where
  parseJSON = withObject "queue" $ \o -> do
    id          <- o .: "queueId"
    map         <- o .: "map"
    description <- o .: "description"
    notes       <- o .: "notes"
    return Queue { .. }

instance ToJSON Queue where
  toJSON Queue {..} = object
    [ "queueId"     .= id
    , "map"         .= map
    , "description" .= description
    , "notes"       .= notes
    ]

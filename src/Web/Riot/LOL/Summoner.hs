{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Summoner where

import           Data.Text
import           Data.Aeson
import           GHC.Generics

data Summoner
    = Summoner
    { id            :: Text
    , accountId     :: Text
    , puuid         :: Text
    , name          :: Text
    , profileIconId :: Int
    , revisionDate  :: Int
    , level         :: Int
    } deriving (Generic, Show)

instance FromJSON Summoner where
  parseJSON = withObject "summoner" $ \o -> do
    id            <- o .: "id"
    accountId     <- o .: "accountId"
    puuid         <- o .: "puuid"
    name          <- o .: "name"
    profileIconId <- o .: "profileIconId"
    revisionDate  <- o .: "revisionDate"
    level         <- o .: "summonerLevel"
    return Summoner { .. }

instance ToJSON Summoner where
  toJSON Summoner {..} = object
    [ "id"            .= id
    , "accountId"     .= accountId
    , "puuid"         .= puuid
    , "name"          .= name
    , "profileIconId" .= profileIconId
    , "revisionDate"  .= revisionDate
    , "summonerLevel" .= level
    ]
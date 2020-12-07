{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.PlatformData
  ( module Web.Riot.LOL.PlatformData.Status
  , module Web.Riot.LOL.PlatformData.Content
  , module Web.Riot.LOL.PlatformData.Update
  , PlatformData(..)
  )
where

import           Control.Applicative
import           Data.Text
import           Data.Aeson
import           GHC.Generics
import           Web.Riot.LOL.PlatformData.Status
import           Web.Riot.LOL.PlatformData.Content
import           Web.Riot.LOL.PlatformData.Update

data PlatformData
    = PlatformData
    { id           :: Text
    , name         :: Text
    , locales      :: [Text]
    , maintenances :: [Status]
    , incidents    :: [Status]
    } deriving (Generic, Show)

instance FromJSON PlatformData where
  parseJSON = withObject "platformData" $ \o -> do
    id           <- o .: "id"
    name         <- o .: "name"
    locales      <- o .: "locales"
    maintenances <- o .: "maintenances"
    incidents    <- o .: "incidents"
    return PlatformData { .. }

instance ToJSON PlatformData where
  toJSON PlatformData {..} = object
    [ "id" .= id
    , "name" .= name
    , "locales" .= locales
    , "maintenances" .= maintenances
    , "incidents" .= incidents
    ]

{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.PlatformData.Status where

import           Control.Applicative
import           Data.Text
import           Data.Aeson
import           GHC.Generics
import           Web.Riot.LOL.PlatformData.Update
import           Web.Riot.LOL.PlatformData.Content

data Status
    = Status
    { id                :: Int
    , maintenanceStatus :: Maybe Text
    , incidentSeverity  :: Text
    , titles            :: [Content]
    , updates           :: [Update]
    , createdAt         :: Text
    , archiveAt         :: Maybe Text
    , updatedAt         :: Maybe Text
    , platforms         :: [Text]
    } deriving (Generic, Show)

instance FromJSON Status where
  parseJSON = withObject "status" $ \o -> do
    id                <- o .: "id"
    maintenanceStatus <- o .:? "maintenanceStatus" <|> o .: "maintenance_status"
    incidentSeverity  <- o .: "incidentSeverity" <|> o .: "incident_severity"
    titles            <- o .: "titles"
    updates           <- o .: "updates"
    createdAt         <- o .: "createdAt" <|> o .: "created_at"
    archiveAt         <- o .:? "archiveAt" <|> o .:? "archive_at"
    updatedAt         <- o .:? "updatedAt" <|> o .:? "updated_at"
    platforms         <- o .: "platforms"
    return Status { .. }

instance ToJSON Status where
  toJSON Status {..} = object
    [ "id" .= id
    , "maintenanceStatus" .= maintenanceStatus
    , "incidentSeverity" .= incidentSeverity
    , "titles" .= titles
    , "updates" .= updates
    , "createdAt" .= createdAt
    , "archiveAt" .= archiveAt
    , "updatedAt" .= updatedAt
    , "platforms" .= platforms
    ]

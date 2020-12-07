{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.PlatformData.Update where

import           Control.Applicative
import           Data.Text
import           Data.Aeson
import           GHC.Generics
import           Web.Riot.LOL.PlatformData.Content

data Update
    = Update
    { id               :: Int
    , author           :: Text
    , publish          :: Bool
    , publishLocations :: Maybe Text
    , translations     :: [Content]
    , createdAt        :: Text
    , updatedAt        :: Maybe Text
    } deriving (Generic, Show)

instance FromJSON Update where
  parseJSON = withObject "update" $ \o -> do
    id               <- o .:  "id"
    author           <- o .:  "author"
    publish          <- o .:  "publish"
    publishLocations <- o .:? "publish_locations" <|> o .:? "publishLocations"
    translations     <- o .:  "translations" 
    createdAt        <- o .:  "created_at" <|> o .: "createdAt"
    updatedAt        <- o .:  "updatedAt" <|> o .: "updated_at"
    return Update { .. }

instance ToJSON Update where
  toJSON Update {..} = object
    [ "id" .= id
    , "author" .= author
    , "publish" .= publish
    , "publishLocations" .= publishLocations
    , "translations" .= translations
    , "createdAt" .= createdAt
    , "updatedAt" .= updatedAt
    ]

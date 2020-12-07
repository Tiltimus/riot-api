{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.ProfileIcons where

import           Data.Text
import           Data.Map
import           Data.Aeson
import           GHC.Generics
import           Web.Riot.LOL.Static.Image

data ProfileIcon
    = ProfileIcon
    { id :: Int
    , image :: Image
    } deriving (Show, Generic)

instance FromJSON ProfileIcon where
  parseJSON = withObject "profileIcon" $ \o -> do
    id    <- o .: "id"
    image <- o .: "image"
    return ProfileIcon { .. }

instance ToJSON ProfileIcon where
  toJSON ProfileIcon {..} = object ["id" .= id, "image" .= image]

data ProfileIcons
    = ProfileIcons
    { ptype    :: Text
    , version :: Text
    , pdata    :: Map Text ProfileIcon
    } deriving (Show, Generic)

instance FromJSON ProfileIcons where
  parseJSON = withObject "profileIcons" $ \o -> do
    ptype   <- o .: "type"
    version <- o .: "version"
    pdata   <- o .: "data"
    return ProfileIcons { .. }

instance ToJSON ProfileIcons where
  toJSON ProfileIcons {..} =
    object ["type" .= ptype, "version" .= version, "data" .= pdata]

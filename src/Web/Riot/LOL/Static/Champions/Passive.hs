{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.Champions.Passive where

import           Data.Aeson
import           Data.Text
import           GHC.Generics
import           Web.Riot.LOL.Static.Image

data Passive
    = Passive
    { name        :: Text
    , description :: Text
    , image       :: Image
    } deriving (Show, Generic)

instance FromJSON Passive where
  parseJSON = withObject "passive" $ \o -> do
    name        <- o .: "name"
    description <- o .: "description"
    image       <- o .: "image"
    return Passive { .. }

instance ToJSON Passive where
  toJSON Passive {..} =
    object ["name" .= name, "description" .= description, "image" .= image]

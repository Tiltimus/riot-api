{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.Items where

import           Data.Aeson
import           Data.Text
import           Data.Map
import           GHC.Generics
import           Web.Riot.LOL.Static.Items.Item

data Items
    = Items
    { itype   :: Text
    , version :: Text
    , idata   :: Map Int Item
    } deriving (Show, Eq, Generic)

instance FromJSON Items where
  parseJSON = withObject "items" $ \o -> do
    itype   <- o .: "type"
    version <- o .: "version"
    idata   <- o .: "data"
    return Items { .. }

instance ToJSON Items where
  toJSON Items {..} =
    object ["type" .= itype, "version" .= version, "data" .= idata]

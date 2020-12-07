{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.Items.Item where

import           Data.Aeson
import           Data.Text
import           Data.Map
import           GHC.Generics
import           Web.Riot.LOL.Static.Image
import           Web.Riot.LOL.Static.Items.Gold

data Item 
    = Item 
    { name        :: Text
    , description :: Text
    , colloq      :: Text
    , plainText   :: Maybe Text
    , into        :: Maybe [Text]
    , image       :: Image
    , gold        :: Gold
    , tags        :: [Text]
    , maps        :: Map Text Bool
    , stats       :: Map Text Double
    } deriving (Show, Eq, Generic)

instance FromJSON Item where
  parseJSON = withObject "item" $ \o -> do
    name        <- o .:  "name"
    description <- o .:  "description"
    colloq      <- o .:  "colloq"
    plainText   <- o .:! "plainText"
    into        <- o .:! "into"
    image       <- o .:  "image"
    gold        <- o .:  "gold"
    tags        <- o .:  "tags"
    maps        <- o .:  "maps"
    stats       <- o .:  "stats"     
    return Item { .. }

instance ToJSON Item where
  toJSON Item {..} = object
    [ "name"        .= name
    , "description" .= description
    , "colloq"      .= colloq
    , "plainText"   .= plainText
    , "into"        .= into
    , "image"       .= image
    , "gold"        .= gold
    , "tags"        .= tags
    , "maps"        .= maps
    , "stats"       .= stats
    ]

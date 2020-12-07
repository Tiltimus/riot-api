{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.Champions where

import           Data.Text
import           Data.Map
import           Data.Aeson
import           GHC.Generics
import           Web.Riot.LOL.Static.Champions.Champion

data Champions
    = Champions
    { ctype   :: Text
    , format  :: Text
    , version :: Text
    , cdata   :: Map Text Champion
    } deriving (Show, Generic)

instance FromJSON Champions where
  parseJSON = withObject "champions" $ \o -> do
    ctype   <- o .: "type"
    format  <- o .: "format"
    version <- o .: "version"
    cdata   <- o .: "data"
    return Champions { .. }

instance ToJSON Champions where
  toJSON Champions {..} = object
    [ "type"    .= ctype
    , "format"  .= format
    , "version" .= version
    , "data"    .= cdata
    ]

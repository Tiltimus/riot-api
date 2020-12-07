{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.Image where

import           Data.Text
import           Data.Aeson
import           GHC.Generics

data Image
    = Image
    { full    :: Text
    , sprite  :: Text
    , group   :: Text
    , x       :: Int
    , y       :: Int
    , w       :: Int
    , h       :: Int
    } deriving (Show, Eq, Generic)

instance FromJSON Image where
  parseJSON = withObject "image" $ \o -> do
    full   <- o .: "full"
    sprite <- o .: "sprite"
    group  <- o .: "group"
    x      <- o .: "x"
    y      <- o .: "y"
    w      <- o .: "w"
    h      <- o .: "h"
    return Image { .. }

instance ToJSON Image where
  toJSON Image {..} = object
    [ "full"   .= full
    , "sprite" .= sprite
    , "group"  .= group
    , "x"      .= x
    , "y"      .= y
    , "w"      .= w
    , "h"      .= h
    ]

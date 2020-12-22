{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.Runes.Rune where

import           Data.Aeson
import           Data.Text
import           Control.Monad
import           GHC.Generics

data Rune
    = Rune
    { id        :: Int
    , key       :: Text
    , icon      :: Text
    , name      :: Text
    , shortDesc :: Text
    , longDesc  :: Text
    } deriving (Show, Eq, Generic)

instance FromJSON Rune where
  parseJSON (Object v) =
    Rune
      <$> v
      .:  "id"
      <*> v
      .:  "key"
      <*> v
      .:  "icon"
      <*> v
      .:  "name"
      <*> v
      .:  "shortDesc"
      <*> v
      .:  "longDesc"

  parseJSON _ = mzero

instance ToJSON Rune where
  toJSON Rune {..} = object
    [ "id" .= id
    , "key" .= key
    , "icon" .= icon
    , "name" .= name
    , "shortDesc" .= shortDesc
    , "longDesc" .= longDesc
    ]

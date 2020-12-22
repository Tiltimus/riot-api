{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.Runes.Runes where

import           Data.Aeson
import           Control.Monad
import           GHC.Generics
import           Web.Riot.LOL.Static.Runes.Rune

newtype Runes
    = Runes
    { runes :: [Rune]
    } deriving (Show, Eq, Generic)

instance FromJSON Runes where
  parseJSON (Object v) = Runes <$> v .: "runes"

  parseJSON _          = mzero

instance ToJSON Runes where
  toJSON Runes {..} = object ["runes" .= runes]

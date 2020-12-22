{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.Runes.RuneTree where

import           Data.Aeson
import           Data.Text
import           Control.Monad
import           GHC.Generics
import           Web.Riot.LOL.Static.Runes.Runes

data RuneTree
    = RuneTree
    { id    :: Int
    , key   :: Text
    , icon  :: Text
    , name  :: Text
    , slots :: [Runes]
    } deriving (Show, Eq, Generic)

instance FromJSON RuneTree where
  parseJSON (Object v) =
    RuneTree
      <$> v
      .:  "id"
      <*> v
      .:  "key"
      <*> v
      .:  "icon"
      <*> v
      .:  "name"
      <*> v
      .:  "slots"

  parseJSON _ = mzero

instance ToJSON RuneTree where
  toJSON RuneTree {..} = object
    ["id" .= id, "key" .= key, "icon" .= icon, "name" .= name, "slots" .= slots]

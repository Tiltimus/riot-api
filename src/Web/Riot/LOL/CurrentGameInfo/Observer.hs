{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.CurrentGameInfo.Observer where

import           Control.Applicative
import           Data.Text
import           Data.Aeson
import           GHC.Generics

newtype Observer
    = Observer
    { encryptionKey :: Text
    } deriving (Generic, Show)

instance FromJSON Observer where
  parseJSON = withObject "observer" $ \o -> do
    encryptionKey <- o .: "encryptionKey"
    return Observer { .. }

instance ToJSON Observer where
  toJSON Observer {..} = object ["encryptionKey" .= encryptionKey]

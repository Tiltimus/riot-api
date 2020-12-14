{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.RIOT.Account where

import           Data.Text
import           Data.Aeson
import           GHC.Generics

data Account
    = Account
    { puuid    :: Text
    , gameName :: Text
    , tagLine  :: Text
    } deriving (Generic, Show)

instance FromJSON Account where
  parseJSON = withObject "account" $ \o -> do
    puuid    <- o .: "puuid"
    gameName <- o .: "gameName"
    tagLine  <- o .: "tagLine"
    return Account { .. }

instance ToJSON Account where
  toJSON Account {..} =
    object ["puuid" .= puuid, "gameName" .= gameName, "tagLine" .= tagLine]

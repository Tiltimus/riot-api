{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Match.Player where

import           Control.Monad
import           Data.Aeson
import           Data.Text
import           GHC.Generics

data Player = Player
  { matchHistoryUri   :: Text
  , currentAccountId  :: Text
  , profileIcon       :: Int
  , accountId         :: Text
  , summonerName      :: Text
  , platformId        :: Text
  , summonerId        :: Text
  , currentPlatformId :: Text
  }
  deriving (Show, Eq, Generic)

instance FromJSON Player where
  parseJSON (Object v) =
    Player
      <$> v
      .:  "matchHistoryUri"
      <*> v
      .:  "currentAccountId"
      <*> v
      .:  "profileIcon"
      <*> v
      .:  "accountId"
      <*> v
      .:  "summonerName"
      <*> v
      .:  "platformId"
      <*> v
      .:  "summonerId"
      <*> v
      .:  "currentPlatformId"

  parseJSON _ = mzero

instance ToJSON Player where
  toJSON Player {..} = object
    [ "matchHistoryUri"   .= matchHistoryUri
    , "currentAccountId"  .= currentAccountId
    , "profileIcon"       .= profileIcon
    , "accountId"         .= accountId
    , "summonerName"      .= summonerName
    , "platformId"        .= platformId
    , "summonerId"        .= summonerId
    , "currentPlatformId" .= currentPlatformId
    ]
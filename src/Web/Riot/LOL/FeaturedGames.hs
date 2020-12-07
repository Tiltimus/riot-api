{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.FeaturedGames where

import           Control.Applicative
import           Data.Text
import           Data.Aeson
import           GHC.Generics
import           Web.Riot.LOL.CurrentGameInfo

data FeaturedGames
    = FeaturedGames
    { gameList :: [CurrentGameInfo]
    , clientRefreshInterval :: Int
    } deriving (Generic, Show)

instance FromJSON FeaturedGames where
  parseJSON = withObject "featuredGames" $ \o -> do
    gameList              <- o .: "gameList"
    clientRefreshInterval <- o .: "clientRefreshInterval"
    return FeaturedGames { .. }

instance ToJSON FeaturedGames where
  toJSON FeaturedGames {..} = object
    ["gameList" .= gameList, "clientRefreshInterval" .= clientRefreshInterval]

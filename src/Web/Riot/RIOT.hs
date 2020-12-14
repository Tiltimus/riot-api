{-# LANGUAGE DuplicateRecordFields     #-}

module Web.Riot.RIOT
  ( module Web.Riot.RIOT.Types
  , getAccountByPuuid
  , getAccountByTagLine
  , getAccountByGame
  )
where

import           Data.Text
import           Web.Riot.RIOT.Types
import           Web.Riot.RiotT
import           Web.Riot.Endpoint
import           Web.Riot.Request

-- Account

getAccountByPuuid :: Text -> RiotT Account
getAccountByPuuid puuid = request $ GET_ACCOUNT_BY_PUUID puuid

getAccountByTagLine :: Text -> Text -> RiotT Account
getAccountByTagLine gameName tagLine =
  request $ GET_ACCOUNT_BY_TAGLINE gameName tagLine

getAccountByGame :: Text -> Text -> RiotT Account
getAccountByGame game puuid = request $ GET_ACCOUNT_BY_GAME game puuid

{-# LANGUAGE DeriveGeneric #-}

module Web.Riot.Config where

import           Data.Text
import           Data.Generics.Labels
import           GHC.Generics
import           Web.Riot.Platform
import           Web.Riot.Locale
import           Web.Riot.Loggit

data Limiter = DEV | PROD | NONE

data Version = Latest | Version Text 

data Config
    = Config
    { platform  :: Platform
    , key       :: Text
    , locale    :: Locale
    , logger    :: Maybe (Loggit -> IO ())
    , rateLimit :: Limiter
    , version   :: Version
    } deriving Generic

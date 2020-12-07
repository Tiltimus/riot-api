{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE DeriveAnyClass     #-}

module Web.Riot.RiotException where

import           Control.Exception
import           Data.Text
import           Data.Aeson
import           GHC.Generics

data RiotException
    = BadRequest
    | Unauthorized
    | Forbidden
    | NotFound
    | UnsupportedMT
    | RateExceeded
    | InternalError
    | ServiceUnavaliable
    | GatewayTimeout
    | UnableToParse Text
    | Unknown Text
    deriving (Show, Generic)

deriving instance ToJSON RiotException

deriving instance FromJSON RiotException

instance Exception RiotException

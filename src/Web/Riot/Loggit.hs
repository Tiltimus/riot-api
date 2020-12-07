{-# LANGUAGE DeriveGeneric                #-}
{-# LANGUAGE OverloadedStrings            #-}
{-# LANGUAGE AllowAmbiguousTypes          #-}
{-# LANGUAGE DataKinds                    #-}
{-# LANGUAGE DuplicateRecordFields        #-}
{-# LANGUAGE FlexibleContexts             #-}
{-# LANGUAGE GADTs                        #-}
{-# LANGUAGE NoMonomorphismRestriction    #-}
{-# LANGUAGE PartialTypeSignatures        #-}
{-# LANGUAGE Rank2Types                   #-}
{-# LANGUAGE ScopedTypeVariables          #-}
{-# LANGUAGE UndecidableInstances         #-}
{-# LANGUAGE RecordWildCards              #-}

module Web.Riot.Loggit where

import           Data.Text
import           Data.Aeson                     ( ToJSON, toJSON, object, (.=) )
import           Data.Time.Clock
import           GHC.Generics
import           Network.Wreq.Types

data Loggit = Loggit
    { url      :: Text
    , time     :: UTCTime
    , message  :: Text
    , options  :: Options
    } deriving (Show, Generic)

instance ToJSON Options where
  toJSON Options {..} = object ["headers" .= show headers, "params" .= params]

instance ToJSON Loggit where
  toJSON Loggit {..} = object
    ["url" .= url, "time" .= time, "message" .= message, "options" .= options]

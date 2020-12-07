{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.Items.Gold where

import           Data.Aeson
import           Control.Monad
import           GHC.Generics

data Gold 
    = Gold 
    { base        :: Int
    , sell        :: Int
    , purchasable :: Bool
    , total       :: Int
  } deriving (Show, Eq, Generic)

instance FromJSON Gold where
  parseJSON (Object v) =
    Gold <$> v .: "base" <*> v .: "sell" <*> v .: "purchasable" <*> v .: "total"

  parseJSON _ = mzero

instance ToJSON Gold where
  toJSON Gold {..} = object
    [ "base"        .= base
    , "sell"        .= sell
    , "purchasable" .= purchasable
    , "total"       .= total
    ]
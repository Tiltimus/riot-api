{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.CurrentGameInfo.Perks where

import           Control.Applicative
import           Data.Text
import           Data.Aeson
import           GHC.Generics

data Perks
    = Perks
    { perkIds  :: [Int]
    , perkStyle :: Int
    , perkSubStyle :: Int
    } deriving (Generic, Show)

instance FromJSON Perks where
  parseJSON = withObject "perks" $ \o -> do
    perkIds      <- o .: "perkIds"
    perkStyle    <- o .: "perkStyle"
    perkSubStyle <- o .: "perkSubStyle"
    return Perks { .. }

instance ToJSON Perks where
  toJSON Perks {..} = object
    [ "perkIds" .= perkIds
    , "perkStyle" .= perkStyle
    , "perkSubStyle" .= perkSubStyle
    ]

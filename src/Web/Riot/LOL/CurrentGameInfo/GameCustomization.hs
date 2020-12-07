{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.CurrentGameInfo.GameCustomization where

import           Control.Applicative
import           Data.Text
import           Data.Aeson
import           GHC.Generics

data GameCustomization
    = GameCustomization
    { category  :: Text
    , content :: Text
    } deriving (Generic, Show)

instance FromJSON GameCustomization where
  parseJSON = withObject "gameCustomization" $ \o -> do
    category <- o .: "category"
    content  <- o .: "content"
    return GameCustomization { .. }

instance ToJSON GameCustomization where
  toJSON GameCustomization {..} =
    object ["category" .= category, "content" .= content]

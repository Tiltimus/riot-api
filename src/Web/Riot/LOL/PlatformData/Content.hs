{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.PlatformData.Content where

import           Control.Applicative
import           Data.Text
import           Data.Aeson
import           GHC.Generics

data Content
    = Content
    { locale  :: Text
    , content :: Text
    } deriving (Generic, Show)

instance FromJSON Content where
  parseJSON = withObject "content" $ \o -> do
    locale  <- o .: "locale"
    content <- o .: "content"
    return Content { .. }

instance ToJSON Content where
  toJSON Content {..} = object ["locale" .= locale, "content" .= content]

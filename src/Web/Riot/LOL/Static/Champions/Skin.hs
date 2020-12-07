{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.Champions.Skin where

import           Data.Aeson
import           Data.Text
import           GHC.Generics
import           Web.Riot.LOL.Static.Image

data Skin
    = Skin
    { id      :: Text
    , num     :: Int
    , name    :: Text
    , chromas :: Bool
    } deriving (Show, Generic)

instance FromJSON Skin where
  parseJSON = withObject "skin" $ \o -> do
    id      <- o .: "id"
    num     <- o .: "num"
    name    <- o .: "name"
    chromas <- o .: "chromas"
    return Skin { .. }

instance ToJSON Skin where
  toJSON Skin {..} =
    object ["id" .= id, "num" .= num, "name" .= name, "chromas" .= chromas]

{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.Champions.ChampionSpell where

import           GHC.Generics
import           Data.Aeson
import           Data.Text
import           Data.Map
import           Web.Riot.LOL.Static.Image

data ChampionSpell
    = ChampionSpell
    { id           :: Text
    , name         :: Text
    , description  :: Text
    , tooltip      :: Text
    , maxrank      :: Int
    , cooldown     :: [Int]
    , cooldownBurn :: Text
    , cost         :: [Int]
    , image        :: Image
    }
    deriving (Show, Eq, Generic)

instance FromJSON ChampionSpell where
  parseJSON = withObject "championSpell" $ \o -> do
    id           <- o .: "id"
    name         <- o .: "name"
    description  <- o .: "description"
    tooltip      <- o .: "tooltip"
    maxrank      <- o .: "maxrank"
    cooldown     <- o .: "cooldown"
    cooldownBurn <- o .: "cooldownBurn"
    cost         <- o .: "cost"
    image        <- o .: "image"
    return ChampionSpell { .. }

instance ToJSON ChampionSpell where
  toJSON ChampionSpell {..} = object
    [ "id"           .= id
    , "name"         .= name
    , "description"  .= description
    , "tooltip"      .= tooltip
    , "maxrank"      .= maxrank
    , "cooldown"     .= cooldown
    , "cooldownBurn" .= cooldownBurn
    , "cost"         .= cost
    , "image"        .= image
    ]
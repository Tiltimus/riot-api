{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.Spell where

import           GHC.Generics
import           Data.Aeson
import           Data.Text
import           Data.Map
import           Web.Riot.LOL.Static.Image

data Spell
    = Spell
    { id           :: Text
    , name         :: Text
    , description  :: Text
    , tooltip      :: Text
    , maxrank      :: Int
    , cooldown     :: [Int]
    , cooldownBurn :: Text
    , cost         :: [Int]
    , key          :: Maybe Text
    , image        :: Image
    }
    deriving (Show, Eq, Generic)

instance FromJSON Spell where
  parseJSON = withObject "spell" $ \o -> do
    id           <- o .: "id"
    name         <- o .: "name"
    description  <- o .: "description"
    tooltip      <- o .: "tooltip"
    maxrank      <- o .: "maxrank"
    cooldown     <- o .: "cooldown"
    cooldownBurn <- o .: "cooldownBurn"
    cost         <- o .: "cost"
    key          <- o .:? "key"
    image        <- o .: "image"
    return Spell { .. }

instance ToJSON Spell where
  toJSON Spell {..} = object
    [ "id"           .= id
    , "name"         .= name
    , "description"  .= description
    , "tooltip"      .= tooltip
    , "maxrank"      .= maxrank
    , "cooldown"     .= cooldown
    , "cooldownBurn" .= cooldownBurn
    , "cost"         .= cost
    , "key"          .= key
    , "image"        .= image
    ]

data Spells 
    = Spells
    { stype :: Text
    , version :: Text
    , sdata :: Map Text Spell
    } deriving (Show, Eq, Generic) 

instance FromJSON Spells where
  parseJSON = withObject "spells" $ \o -> do
    stype    <- o .: "type"
    version <- o .: "version"
    sdata    <- o .: "data"
    return Spells { .. }

instance ToJSON Spells where
  toJSON Spells {..} = object
    [ "type"    .= stype
    , "version" .= version
    , "data"    .= sdata
    ]
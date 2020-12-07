{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Static.Champions.Champion where

import           Data.Text
import           Data.Aeson
import           GHC.Generics
import           Web.Riot.LOL.Static.Image
import           Web.Riot.LOL.Static.Champions.Info
import           Web.Riot.LOL.Static.Champions.ChampionStats
import           Web.Riot.LOL.Static.Champions.Passive
import           Web.Riot.LOL.Static.Champions.Skin
import           Web.Riot.LOL.Static.Spell

data Champion
    = Champion
    { version   :: Maybe Text
    , id        :: Text
    , key       :: Text
    , name      :: Text
    , title     :: Text
    , blurb     :: Text
    , info      :: Info
    , image     :: Image
    , tags      :: [Text]
    , partype   :: Text
    , stats     :: ChampionStats
    , skins     :: Maybe [Skin]
    , lore      :: Maybe Text
    , allytips  :: Maybe [Text]
    , enemytips :: Maybe [Text]
    , spells    :: Maybe [Spell]
    , passive   :: Maybe Passive
    } deriving (Show, Generic)

instance FromJSON Champion where
  parseJSON = withObject "champion" $ \o -> do
    version   <- o .:? "version"
    id        <- o .: "id"
    key       <- o .: "key"
    name      <- o .: "name"
    title     <- o .: "title"
    blurb     <- o .: "blurb"
    info      <- o .: "info"
    image     <- o .: "image"
    tags      <- o .: "tags"
    partype   <- o .: "partype"
    stats     <- o .: "stats"
    skins     <- o .:? "skins"
    lore      <- o .:? "lore"
    allytips  <- o .:? "allytips"
    enemytips <- o .:? "enemytips"
    spells    <- o .:? "spells"
    passive   <- o .:? "passive"
    return Champion { .. }

instance ToJSON Champion where
  toJSON Champion {..} = object
    [ "version"   .= version
    , "id"        .= id
    , "key"       .= key
    , "name"      .= name
    , "title"     .= title
    , "blurb"     .= blurb
    , "info"      .= info
    , "image"     .= image
    , "tags"      .= tags
    , "partype"   .= partype
    , "stats"     .= stats
    , "skins"     .= lore
    , "lore"      .= blurb
    , "blurb"     .= blurb
    , "allytips"  .= allytips
    , "enemytips" .= enemytips
    , "spells"    .= spells
    , "passive"   .= passive
    ]

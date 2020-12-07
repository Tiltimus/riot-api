{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Match.XpDiff where

import           Control.Monad
import           Data.Aeson
import           GHC.Generics

data XpDiffPerMinDeltas = XpDiffPerMinDeltas
  { xpDiffPerMinDeltas_1020  :: Maybe Double
  , xpDiffPerMinDeltas_30End :: Maybe Double
  , xpDiffPerMinDeltas_2030  :: Maybe Double
  , xpDiffPerMinDeltas_010   :: Maybe Double
  } deriving (Show, Eq, Generic)

instance FromJSON XpDiffPerMinDeltas where
  parseJSON (Object v) =
    XpDiffPerMinDeltas
      <$> v
      .:?  "10-20"
      <*> v
      .:?  "30-end"
      <*> v
      .:?  "20-30"
      <*> v
      .:?  "0-10"

  parseJSON _ = mzero

instance ToJSON XpDiffPerMinDeltas where
  toJSON XpDiffPerMinDeltas {..} = object
    [ "10-20"  .= xpDiffPerMinDeltas_1020
    , "30-end" .= xpDiffPerMinDeltas_30End
    , "20-30"  .= xpDiffPerMinDeltas_2030
    , "0-10"   .= xpDiffPerMinDeltas_010
    ]
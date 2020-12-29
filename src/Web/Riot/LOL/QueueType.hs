{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}

module Web.Riot.LOL.QueueType where

import           Data.Text
import           Data.Aeson

data QueueType
    = RANKED_SOLO_5x5
    | RANKED_FLEX_SR
    | RANKED_FLEX_TT
    deriving (Show, Eq)

instance FromJSON QueueType where
  parseJSON = withText
    "queueType"
    (\case
      -- Uppercase
      "RANKED_SOLO_5x5" -> return RANKED_SOLO_5x5
      "RANKED_FLEX_SR"  -> return RANKED_FLEX_SR
      "RANKED_FLEX_TT"  -> return RANKED_FLEX_TT
      -- Lowercase
      "ranked_solo_5x5" -> return RANKED_SOLO_5x5
      "ranked_flex_sr"  -> return RANKED_FLEX_SR
      "ranked_flex_tt"  -> return RANKED_FLEX_TT
      value             -> fail $ "Invalid queue type value: " ++ unpack value
    )

instance ToJSON QueueType where
  toJSON RANKED_SOLO_5x5 = "ranked_solo_5x5"
  toJSON RANKED_FLEX_SR  = "ranked_flex_sr"
  toJSON RANKED_FLEX_TT  = "ranked_flex_tt"

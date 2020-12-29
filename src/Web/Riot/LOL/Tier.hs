{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}

module Web.Riot.LOL.Tier where

import           Data.Text
import           Data.Aeson

data Tier
    = CHALLENGER
    | GRANDMASTER
    | MASTER
    | DIAMOND
    | PLATINUM
    | GOLD
    | SILVER
    | BRONZE
    | IRON

instance Show Tier where
  show CHALLENGER  = "CHALLENGER"
  show GRANDMASTER = "GRANDMASTER"
  show MASTER      = "MASTER"
  show DIAMOND     = "DIAMOND"
  show PLATINUM    = "PLATINUM"
  show GOLD        = "GOLD"
  show SILVER      = "SILVER"
  show BRONZE      = "BRONZE"
  show IRON        = "IRON"

data Division
    = I
    | II
    | III
    | IV

instance Show Division where
  show I   = "I"
  show II  = "II"
  show III = "III"
  show IV  = "IV"

instance FromJSON Tier where
  parseJSON = withText
    "tier"
    (\case
      -- Uppercases
      "CHALLENGER"  -> return CHALLENGER
      "GRANDMASTER" -> return GRANDMASTER
      "MASTER"      -> return MASTER
      "DIAMOND"     -> return DIAMOND
      "PLATINUM"    -> return PLATINUM
      "GOLD"        -> return GOLD
      "SILVER"      -> return SILVER
      "BRONZE"      -> return BRONZE
      "IRON"        -> return IRON
      -- Lowercases
      "challenger"  -> return CHALLENGER
      "grandmaster" -> return GRANDMASTER
      "master"      -> return MASTER
      "diamond"     -> return DIAMOND
      "platinum"    -> return PLATINUM
      "gold"        -> return GOLD
      "silver"      -> return SILVER
      "bronze"      -> return BRONZE
      "iron"        -> return IRON
      value         -> fail $ "Invalid tier value: " ++ unpack value
    )

instance ToJSON Tier where
  toJSON CHALLENGER  = "challenger"
  toJSON GRANDMASTER = "grandmaster"
  toJSON MASTER      = "master"
  toJSON DIAMOND     = "diamond"
  toJSON PLATINUM    = "platinum"
  toJSON GOLD        = "gold"
  toJSON SILVER      = "silver"
  toJSON BRONZE      = "bronze"
  toJSON IRON        = "iron"

instance FromJSON Division where
  parseJSON = withText
    "division"
    (\case
      -- Uppercase
      "I"   -> return I
      "II"  -> return II
      "III" -> return III
      "IV"  -> return IV
      -- Lowercase
      "i"   -> return I
      "ii"  -> return II
      "iii" -> return III
      "iv"  -> return IV
      value -> fail $ "Invalid division value." ++ unpack value
    )

instance ToJSON Division where
  toJSON I   = "i"
  toJSON II  = "ii"
  toJSON III = "iii"
  toJSON IV  = "iv"

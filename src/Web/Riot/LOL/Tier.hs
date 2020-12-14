
module Web.Riot.LOL.Tier where

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
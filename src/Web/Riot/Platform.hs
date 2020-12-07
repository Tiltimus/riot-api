module Web.Riot.Platform where

data Platform
    = BR1
    | EUN1
    | EUW1
    | JP1
    | KR
    | LA1
    | LA2
    | NA1
    | OC1
    | RU
    | TR1
    | AMERICAS
    | ASIA
    | EUROPE

instance Show Platform where
  show BR1      = "br1"
  show EUN1     = "eun1"
  show EUW1     = "euw1"
  show JP1      = "jp1"
  show KR       = "kr"
  show LA1      = "la1"
  show LA2      = "la2"
  show NA1      = "na1"
  show OC1      = "oc1"
  show RU       = "ru"
  show TR1      = "tr1"
  show AMERICAS = "americas"
  show ASIA     = "asia"
  show EUROPE   = "europe"

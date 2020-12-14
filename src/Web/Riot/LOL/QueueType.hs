module Web.Riot.LOL.QueueType where

data QueueType
    = RANKED_SOLO_5x5
    | RANKED_FLEX_SR
    | RANKED_FLEX_TT 

instance Show QueueType where
  show RANKED_SOLO_5x5 = "RANKED_SOLO_5x5"
  show RANKED_FLEX_SR  = "RANKED_FLEX_SR"
  show RANKED_FLEX_TT  = "RANKED_FLEX_TT"
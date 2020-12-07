{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Web.Riot.LOL.Match.Stats where

import           Control.Monad
import           Data.Aeson
import           GHC.Generics

data Stats = Stats
  { statPerk2                       :: Int
  , perk0                           :: Int
  , perk4Var1                       :: Int
  , firstInhibitorKill              :: Maybe Bool
  , assists                         :: Int
  , item1                           :: Int
  , doubleKills                     :: Int
  , tripleKills                     :: Int
  , playerScore4                    :: Int
  , perkSubStyle                    :: Maybe Int
  , deaths                          :: Int
  , neutralMinionsKilledEnemyJungle :: Maybe Int
  , trueDamageDealtToChampions      :: Int
  , magicDamageDealt                :: Int
  , totalHeal                       :: Int
  , perk1Var2                       :: Int
  , perk0Var3                       :: Int
  , longestTimeSpentLiving          :: Int
  , playerScore9                    :: Int
  , perk2Var1                       :: Int
  , participantId                   :: Int
  , item0                           :: Int
  , trueDamageDealt                 :: Int
  , perk5Var1                       :: Int
  , totalTimeCrowdControlDealt      :: Int
  , perk1                           :: Int
  , damageSelfMitigated             :: Int
  , playerScore3                    :: Int
  , unrealKills                     :: Int
  , totalMinionsKilled              :: Int
  , sightWardsBoughtInGame          :: Int
  , perk0Var2                       :: Int
  , largestCriticalStrike           :: Int
  , playerScore8                    :: Int
  , perk3Var1                       :: Int
  , item6                           :: Int
  , quadraKills                     :: Int
  , firstTowerKill                  :: Maybe Bool
  , perk1Var3                       :: Int
  , perk5Var2                       :: Int
  , statPerk0                       :: Int
  , perk2                           :: Int
  , perk4Var3                       :: Int
  , item3                           :: Int
  , totalDamageDealt                :: Int
  , champLevel                      :: Int
  , firstInhibitorAssist            :: Maybe Bool
  , turretKills                     :: Int
  , largestKillingSpree             :: Int
  , playerScore2                    :: Int
  , goldEarned                      :: Int
  , objectivePlayerScore            :: Int
  , totalScoreRank                  :: Int
  , visionScore                     :: Int
  , wardsPlaced                     :: Maybe Int
  , damageDealtToObjectives         :: Int
  , totalDamageTaken                :: Int
  , goldSpent                       :: Int
  , playerScore7                    :: Int
  , perk3                           :: Int
  , perk4Var2                       :: Int
  , perkPrimaryStyle                :: Int
  , item2                           :: Int
  , firstBloodAssist                :: Maybe Bool
  , perk5Var3                       :: Int
  , statPerk1                       :: Int
  , pentaKills                      :: Int
  , neutralMinionsKilled            :: Int
  , firstBloodKill                  :: Maybe Bool
  , timeCCingOthers                 :: Int
  , playerScore1                    :: Int
  , magicalDamageTaken              :: Int
  , inhibitorKills                  :: Int
  , playerScore6                    :: Int
  , combatPlayerScore               :: Int
  , visionWardsBoughtInGame         :: Int
  , magicDamageDealtToChampions     :: Int
  , neutralMinionsKilledTeamJungle  :: Maybe Int
  , item5                           :: Int
  , win                             :: Bool
  , trueDamageTaken                 :: Int
  , perk0Var1                       :: Int
  , perk4                           :: Int
  , perk2Var3                       :: Int
  , wardsKilled                     :: Maybe Int
  , killingSprees                   :: Int
  , perk3Var2                       :: Int
  , physicalDamageTaken             :: Int
  , damageDealtToTurrets            :: Int
  , playerScore0                    :: Int
  , playerScore5                    :: Int
  , firstTowerAssist                :: Maybe Bool
  , physicalDamageDealt             :: Int
  , totalUnitsHealed                :: Int
  , totalDamageDealtToChampions     :: Int
  , kills                           :: Int
  , perk5                           :: Int
  , perk2Var2                       :: Int
  , physicalDamageDealtToChampions  :: Int
  , perk3Var3                       :: Int
  , item4                           :: Int
  , largestMultiKill                :: Int
  , totalPlayerScore                :: Int
  , perk1Var1                       :: Int
  }
  deriving (Show, Eq, Generic)

instance FromJSON Stats where
  parseJSON (Object v) =
    Stats
      <$> v
      .:  "statPerk2"
      <*> v
      .:  "perk0"
      <*> v
      .:  "perk4Var1"
      <*> v
      .:?  "firstInhibitorKill"
      <*> v
      .:  "assists"
      <*> v
      .:  "item1"
      <*> v
      .:  "doubleKills"
      <*> v
      .:  "tripleKills"
      <*> v
      .:  "playerScore4"
      <*> v
      .:? "perkSubStyle"
      <*> v
      .:  "deaths"
      <*> v
      .:? "neutralMinionsKilledEnemyJungle"
      <*> v
      .:  "trueDamageDealtToChampions"
      <*> v
      .:  "magicDamageDealt"
      <*> v
      .:  "totalHeal"
      <*> v
      .:  "perk1Var2"
      <*> v
      .:  "perk0Var3"
      <*> v
      .:  "longestTimeSpentLiving"
      <*> v
      .:  "playerScore9"
      <*> v
      .:  "perk2Var1"
      <*> v
      .:  "participantId"
      <*> v
      .:  "item0"
      <*> v
      .:  "trueDamageDealt"
      <*> v
      .:  "perk5Var1"
      <*> v
      .:  "totalTimeCrowdControlDealt"
      <*> v
      .:  "perk1"
      <*> v
      .:  "damageSelfMitigated"
      <*> v
      .:  "playerScore3"
      <*> v
      .:  "unrealKills"
      <*> v
      .:  "totalMinionsKilled"
      <*> v
      .:  "sightWardsBoughtInGame"
      <*> v
      .:  "perk0Var2"
      <*> v
      .:  "largestCriticalStrike"
      <*> v
      .:  "playerScore8"
      <*> v
      .:  "perk3Var1"
      <*> v
      .:  "item6"
      <*> v
      .:  "quadraKills"
      <*> v
      .:? "firstTowerKill"
      <*> v
      .:  "perk1Var3"
      <*> v
      .:  "perk5Var2"
      <*> v
      .:  "statPerk0"
      <*> v
      .:  "perk2"
      <*> v
      .:  "perk4Var3"
      <*> v
      .:  "item3"
      <*> v
      .:  "totalDamageDealt"
      <*> v
      .:  "champLevel"
      <*> v
      .:?  "firstInhibitorAssist"
      <*> v
      .:  "turretKills"
      <*> v
      .:  "largestKillingSpree"
      <*> v
      .:  "playerScore2"
      <*> v
      .:  "goldEarned"
      <*> v
      .:  "objectivePlayerScore"
      <*> v
      .:  "totalScoreRank"
      <*> v
      .:  "visionScore"
      <*> v
      .:? "wardsPlaced"
      <*> v
      .:  "damageDealtToObjectives"
      <*> v
      .:  "totalDamageTaken"
      <*> v
      .:  "goldSpent"
      <*> v
      .:  "playerScore7"
      <*> v
      .:  "perk3"
      <*> v
      .:  "perk4Var2"
      <*> v
      .:  "perkPrimaryStyle"
      <*> v
      .:  "item2"
      <*> v
      .:? "firstBloodAssist"
      <*> v
      .:  "perk5Var3"
      <*> v
      .:  "statPerk1"
      <*> v
      .:  "pentaKills"
      <*> v
      .:  "neutralMinionsKilled"
      <*> v
      .:? "firstBloodKill"
      <*> v
      .:  "timeCCingOthers"
      <*> v
      .:  "playerScore1"
      <*> v
      .:  "magicalDamageTaken"
      <*> v
      .:  "inhibitorKills"
      <*> v
      .:  "playerScore6"
      <*> v
      .:  "combatPlayerScore"
      <*> v
      .:  "visionWardsBoughtInGame"
      <*> v
      .:  "magicDamageDealtToChampions"
      <*> v
      .:? "neutralMinionsKilledTeamJungle"
      <*> v
      .:  "item5"
      <*> v
      .:  "win"
      <*> v
      .:  "trueDamageTaken"
      <*> v
      .:  "perk0Var1"
      <*> v
      .:  "perk4"
      <*> v
      .:  "perk2Var3"
      <*> v
      .:? "wardsKilled"
      <*> v
      .:  "killingSprees"
      <*> v
      .:  "perk3Var2"
      <*> v
      .:  "physicalDamageTaken"
      <*> v
      .:  "damageDealtToTurrets"
      <*> v
      .:  "playerScore0"
      <*> v
      .:  "playerScore5"
      <*> v
      .:? "firstTowerAssist"
      <*> v
      .:  "physicalDamageDealt"
      <*> v
      .:  "totalUnitsHealed"
      <*> v
      .:  "totalDamageDealtToChampions"
      <*> v
      .:  "kills"
      <*> v
      .:  "perk5"
      <*> v
      .:  "perk2Var2"
      <*> v
      .:  "physicalDamageDealtToChampions"
      <*> v
      .:  "perk3Var3"
      <*> v
      .:  "item4"
      <*> v
      .:  "largestMultiKill"
      <*> v
      .:  "totalPlayerScore"
      <*> v
      .:  "perk1Var1"
  parseJSON _ = mzero

instance ToJSON Stats where
  toJSON Stats {..} = object
    [ "statPerk2"                       .= statPerk2
    , "perk0"                           .= perk0
    , "perk4Var1"                       .= perk4Var1
    , "firstInhibitorKill"              .= firstInhibitorKill
    , "assists"                         .= assists
    , "item1"                           .= item1
    , "doubleKills"                     .= doubleKills
    , "tripleKills"                     .= tripleKills
    , "playerScore4"                    .= playerScore4
    , "perkSubStyle"                    .= perkSubStyle
    , "deaths"                          .= deaths
    , "neutralMinionsKilledEnemyJungle" .= neutralMinionsKilledEnemyJungle
    , "trueDamageDealtToChampions"      .= trueDamageDealtToChampions
    , "magicDamageDealt"                .= magicDamageDealt
    , "totalHeal"                       .= totalHeal
    , "perk1Var2"                       .= perk1Var2
    , "perk0Var3"                       .= perk0Var3
    , "longestTimeSpentLiving"          .= longestTimeSpentLiving
    , "playerScore9"                    .= playerScore9
    , "perk2Var1"                       .= perk2Var1
    , "participantId"                   .= participantId
    , "item0"                           .= item0
    , "trueDamageDealt"                 .= trueDamageDealt
    , "perk5Var1"                       .= perk5Var1
    , "totalTimeCrowdControlDealt"      .= totalTimeCrowdControlDealt
    , "perk1"                           .= perk1
    , "damageSelfMitigated"             .= damageSelfMitigated
    , "playerScore3"                    .= playerScore3
    , "unrealKills"                     .= unrealKills
    , "totalMinionsKilled"              .= totalMinionsKilled
    , "sightWardsBoughtInGame"          .= sightWardsBoughtInGame
    , "perk0Var2"                       .= perk0Var2
    , "largestCriticalStrike"           .= largestCriticalStrike
    , "playerScore8"                    .= playerScore8
    , "perk3Var1"                       .= perk3Var1
    , "item6"                           .= item6
    , "quadraKills"                     .= quadraKills
    , "firstTowerKill"                  .= firstTowerKill
    , "perk1Var3"                       .= perk1Var3
    , "perk5Var2"                       .= perk5Var2
    , "statPerk0"                       .= statPerk0
    , "perk2"                           .= perk2
    , "perk4Var3"                       .= perk4Var3
    , "item3"                           .= item3
    , "totalDamageDealt"                .= totalDamageDealt
    , "champLevel"                      .= champLevel
    , "firstInhibitorAssist"            .= firstInhibitorAssist
    , "turretKills"                     .= turretKills
    , "largestKillingSpree"             .= largestKillingSpree
    , "playerScore2"                    .= playerScore2
    , "goldEarned"                      .= goldEarned
    , "objectivePlayerScore"            .= objectivePlayerScore
    , "totalScoreRank"                  .= totalScoreRank
    , "visionScore"                     .= visionScore
    , "wardsPlaced"                     .= wardsPlaced
    , "damageDealtToObjectives"         .= damageDealtToObjectives
    , "totalDamageTaken"                .= totalDamageTaken
    , "goldSpent"                       .= goldSpent
    , "playerScore7"                    .= playerScore7
    , "perk3"                           .= perk3
    , "perk4Var2"                       .= perk4Var2
    , "perkPrimaryStyle"                .= perkPrimaryStyle
    , "item2"                           .= item2
    , "firstBloodAssist"                .= firstBloodAssist
    , "perk5Var3"                       .= perk5Var3
    , "statPerk1"                       .= statPerk1
    , "pentaKills"                      .= pentaKills
    , "neutralMinionsKilled"            .= neutralMinionsKilled
    , "firstBloodKill"                  .= firstBloodKill
    , "timeCCingOthers"                 .= timeCCingOthers
    , "playerScore1"                    .= playerScore1
    , "magicalDamageTaken"              .= magicalDamageTaken
    , "inhibitorKills"                  .= inhibitorKills
    , "playerScore6"                    .= playerScore6
    , "combatPlayerScore"               .= combatPlayerScore
    , "visionWardsBoughtInGame"         .= visionWardsBoughtInGame
    , "magicDamageDealtToChampions"     .= magicDamageDealtToChampions
    , "neutralMinionsKilledTeamJungle"  .= neutralMinionsKilledTeamJungle
    , "item5"                           .= item5
    , "win"                             .= win
    , "trueDamageTaken"                 .= trueDamageTaken
    , "perk0Var1"                       .= perk0Var1
    , "perk4"                           .= perk4
    , "perk2Var3"                       .= perk2Var3
    , "wardsKilled"                     .= wardsKilled
    , "killingSprees"                   .= killingSprees
    , "perk3Var2"                       .= perk3Var2
    , "physicalDamageTaken"             .= physicalDamageTaken
    , "damageDealtToTurrets"            .= damageDealtToTurrets
    , "playerScore0"                    .= playerScore0
    , "playerScore5"                    .= playerScore5
    , "firstTowerAssist"                .= firstTowerAssist
    , "physicalDamageDealt"             .= physicalDamageDealt
    , "totalUnitsHealed"                .= totalUnitsHealed
    , "totalDamageDealtToChampions"     .= totalDamageDealtToChampions
    , "kills"                           .= kills
    , "perk5"                           .= perk5
    , "perk2Var2"                       .= perk2Var2
    , "physicalDamageDealtToChampions"  .= physicalDamageDealtToChampions
    , "perk3Var3"                       .= perk3Var3
    , "item4"                           .= item4
    , "largestMultiKill"                .= largestMultiKill
    , "totalPlayerScore"                .= totalPlayerScore
    , "perk1Var1"                       .= perk1Var1
    ]
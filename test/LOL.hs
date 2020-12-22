{-# LANGUAGE OverloadedStrings         #-}
{-# LANGUAGE AllowAmbiguousTypes       #-}
{-# LANGUAGE DataKinds                 #-}
{-# LANGUAGE DuplicateRecordFields     #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE GADTs                     #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE OverloadedLabels          #-}
{-# LANGUAGE PartialTypeSignatures     #-}
{-# LANGUAGE Rank2Types                #-}
{-# LANGUAGE ScopedTypeVariables       #-}
{-# LANGUAGE UndecidableInstances      #-}

module LOL where

import           Data.Text
import           Data.Maybe
import           Web.Riot.LOL
import           Web.Riot
import           Test.Hspec
import           Test.HUnit
import           Control.Lens
import           System.Environment
import           Test.Hspec.Core.Runner (defaultConfig, runSpec,  evaluateSummary)

summoner :: Summoner
summoner = Summoner
  { id            = "T-T23TxNtkswd6HuJfbST0OuTlObjC9RF0kPlZTvXtXYJhk"
  , accountId     = "U3lfudEn3SKPEBp95dZYJo-dR39qW3Dan_CcxqX73gPuSA"
  , puuid         =
    "ZP-8ZbBqMvuQposzXL5UcNcEVlB6F6y-tMXlImBlgdahTLWjGKGr54QHqHOV5OV7VE90T4CfPPoRng"
  , name          = "TILTIMUS PRIME"
  , profileIconId = 4216
  , revisionDate  = 1605733084000
  , level         = 344
  }

clashPlayer :: ClashPlayer
clashPlayer = ClashPlayer
  { summonerId = Just "T-T23TxNtkswd6HuJfbST0OuTlObjC9RF0kPlZTvXtXYJhk"
  , teamId     = Just "cff8c85e-fe70-48b4-ae03-e8c134ae06f5"
  , position   = "BOTTOM"
  , role       = "CAPTAIN"
  }

lolSpec :: IO ()
lolSpec = do
  args <- getArgs
  case args of
    ["--key", apikey] -> do
      let config = Config EUW1 (pack apikey) EN_GB (Just print) DEV Latest
      summary <- runSpec (lolTests config) defaultConfig
      evaluateSummary summary
    _ -> fail "Please provide api key"

lolTests :: Config -> SpecWith ()
lolTests config = do
  championMasteryTests config
  championTests config
  clashTests config
  leagueTests config
  statusTests config
  summonerTests config
  matchesTests config
  spectatorTests config
  staticDataTests config

championMasteryTests :: Config -> SpecWith ()
championMasteryTests config = describe "Riot LOL champion mastery tests." $ do
  it "Returns a list of champion masteries for an account id." $ do
    value <- execRiotT config (getMasteryBySummonerId $ summoner ^. #id)
    case value of
      Left  _ -> assertFailure "Failed to get champion masteries."
      Right a -> return ()

  it "Returns champion mastery for an account id for a champion id." $ do
    value <- execRiotT config
                       (getMasteryByIdWithChampionId (summoner ^. #id) 203)
    case value of
      Left  _ -> assertFailure "Failed to get champion mastery."
      Right a -> return ()

  it "Returns champion mastery score for a id." $ do
    value <- execRiotT config (getMasteryScoreById $ summoner ^. #id)
    case value of
      Left  _ -> assertFailure "Failed to get mastery score."
      Right a -> return ()

championTests :: Config -> SpecWith ()
championTests config = describe "Riot LOL champion rotation." $ do
  it "Returns champion rotation." $ do
    value <- execRiotT config getChampionRotation
    case value of
      Left  _ -> assertFailure "Failed to get champion rotation."
      Right a -> return ()

clashTests :: Config -> SpecWith ()
clashTests config = describe "Riot LOL clash." $ do
  it "Returns clash stats for summoner id." $ do
    value <- execRiotT config (getClashBySummonerId $ summoner ^. #id)
    case value of
      Left  _ -> assertFailure "Failed to get clash information."
      Right a -> return ()

  it "Returns clash team from team id." $ do
    value <- execRiotT config
                       (getClashTeamById $ clashPlayer ^. #teamId . non "")
    case value of
      Left  _ -> assertFailure "Failed to get clash team information."
      Right a -> return ()

  it "Returns clash tournaments." $ do
    value <- execRiotT config getTournaments
    case value of
      Left  _ -> assertFailure "Failed to get tournament information."
      Right a -> return ()

  it "Returns clash tournament by team id." $ do
    value <- execRiotT config
                       (getTournamentByTeam $ clashPlayer ^. #teamId . non "")
    case value of
      Left  _ -> assertFailure "Failed to get tournament information."
      Right a -> return ()

  it "Returns clash tournament by id." $ do
    value <- execRiotT config (getTournamentById "2462")
    case value of
      Left  _ -> assertFailure "Failed to get tournament information."
      Right a -> return ()

leagueTests :: Config -> SpecWith ()
leagueTests config = describe "Riot LOL leagues." $ do
  it "Returns challenger leagues RANKED_SOLO_5x5." $ do
    value <- execRiotT config (getChallengerLeagues "RANKED_SOLO_5x5")
    case value of
      Left  _ -> assertFailure "Failed to get league information."
      Right a -> return ()

  it "Returns leagues entries for a summoner." $ do
    value <- execRiotT config (getLeagueEntriesBySummoner $ summoner ^. #id)
    case value of
      Left  _ -> assertFailure "Failed to get league information."
      Right a -> return ()

  it "Returns leagues entries for a particular division." $ do
    value <- execRiotT
      config
      (getLeagueEntries RANKED_SOLO_5x5 I DIAMOND Nothing)
    case value of
      Left  _ -> assertFailure "Failed to get league information."
      Right a -> return ()

  it "Returns grandmaster leagues RANKED_SOLO_5x5." $ do
    value <- execRiotT config (getGrandMasterLeagues "RANKED_SOLO_5x5")
    case value of
      Left  _ -> assertFailure "Failed to get league information."
      Right a -> return ()

  it "Returns league by id" $ do
    value <- execRiotT config
                       (getLeagueById "5ae26d6d-c07a-3d29-ae0f-1ac9ca4a4f4a")
    case value of
      Left  _ -> assertFailure "Failed to get league information."
      Right a -> return ()

  it "Returns master leagues RANKED_SOLO_5x5." $ do
    value <- execRiotT config (getMasterLeagues "RANKED_SOLO_5x5")
    case value of
      Left  _ -> assertFailure "Failed to get league information."
      Right a -> return ()

statusTests :: Config -> SpecWith ()
statusTests config = describe "Riot LOL status." $ do
  it "Returns leagues current status." $ do
    value <- execRiotT config getStatus
    case value of
      Left  _ -> assertFailure "Failed to get status information."
      Right a -> return ()

summonerTests :: Config -> SpecWith ()
summonerTests config = describe "Riot LOL summoners." $ do
  it "Returns summoners by name" $ do
    value <- execRiotT config (getSummonerByName "Tiltimus Prime")
    case value of
      Left  _ -> assertFailure "Failed to get summoner information."
      Right a -> return ()

  it "Returns summoners by account" $ do
    value <- execRiotT config (getSummonerByAccount $ summoner ^. #accountId)
    case value of
      Left  _ -> assertFailure "Failed to get summoner information."
      Right a -> return ()

  it "Returns summoners by puuid" $ do
    value <- execRiotT config (getSummonerByPuuid $ summoner ^. #puuid)
    case value of
      Left  _ -> assertFailure "Failed to get summoner information."
      Right a -> return ()

  it "Returns summoners by id" $ do
    value <- execRiotT config (getSummonerById $ summoner ^. #id)
    case value of
      Left  _ -> assertFailure "Failed to get summoner information."
      Right a -> return ()

matchesTests :: Config -> SpecWith ()
matchesTests config = describe "Riot LOL matches." $ do
  it "Returns match by id" $ do
    value <- execRiotT config (getMatchById 4896853700)
    case value of
      Left  _ -> assertFailure "Failed to get match information."
      Right a -> return ()

  it "Returns match refs by account" $ do
    value <- execRiotT
      config
      (getMatchRefsByAccount (summoner ^. #accountId)
                             []
                             []
                             Nothing
                             Nothing
                             Nothing
                             Nothing
      )
    case value of
      Left  _ -> assertFailure "Failed to get matchrefs information."
      Right a -> return ()

  it "Returns all match refs by account" $ do
    value <- execRiotT
      config
      (getAllMatchReferences (summoner ^. #accountId)
                             []
                             []
                             Nothing
                             Nothing
                             Nothing
                             Nothing
      )
    case value of
      Left  _ -> assertFailure "Failed to get match refs information."
      Right a -> return ()

  it "Returns all timeline information by id" $ do
    value <- execRiotT config (getMatchTimelineById 4896853700)
    case value of
      Left  _ -> assertFailure "Failed to get timelines information."
      Right a -> return ()

spectatorTests :: Config -> SpecWith ()
spectatorTests config = describe "Riot LOL spectators." $ do
  -- it "Returns spectator game if found" $ do
  --   value <- execRiotT config (getActiveGame (summoner ^. #id))
  --   case value of
  --     Left  _ -> assertFailure "Failed to get spectator games."
  --     Right a -> return ()

  it "Returns featured games" $ do
    value <- execRiotT config getFeaturedGames
    case value of
      Left  _ -> assertFailure "Failed to get featured games."
      Right a -> return ()

staticDataTests :: Config -> SpecWith ()
staticDataTests config = describe "Riot LOL static data calls." $ do
  it "Returns all seasons." $ do
    value <- execRiotT config getSeasons
    case value of
      Left  _  -> assertFailure "Failed to get seasons."
      Right [] -> assertFailure "Failed to get seasons."
      Right a -> return ()
  
  it "Returns all queues." $ do
    value <- execRiotT config getQueues
    case value of
      Left  _  -> assertFailure "Failed to get queues."
      Right [] -> assertFailure "Failed to get queues."
      Right a -> return ()

  it "Returns all games modes." $ do
    value <- execRiotT config getGameModes
    case value of
      Left  _  -> assertFailure "Failed to get game modes."
      Right [] -> assertFailure "Failed to get game modes."
      Right a -> return ()

  it "Returns all games types." $ do
    value <- execRiotT config getGameTypes
    case value of
      Left  _  -> assertFailure "Failed to get game types."
      Right [] -> assertFailure "Failed to get game types."
      Right a -> return ()

  it "Returns all versions." $ do
    value <- execRiotT config getVersions
    case value of
      Left  _  -> assertFailure "Failed to get versions."
      Right [] -> assertFailure "Failed to get versions."
      Right a -> return ()

  it "Returns all languages." $ do
    value <- execRiotT config getLanguages
    case value of
      Left  _  -> assertFailure "Failed to get languages."
      Right [] -> assertFailure "Failed to get languages."
      Right a -> return ()

  it "Returns all champions." $ do
    value <- execRiotT config getChampions
    case value of
      Left  _  -> assertFailure "Failed to get champions."
      Right a -> return ()
  
  it "Returns a champion by name." $ do
    value <- execRiotT config (getChampionByName "Aatrox")
    case value of
      Left  e  -> assertFailure (show e ++ "Failed to get champion.")
      Right a -> return ()

  it "Returns all items." $ do
    value <- execRiotT config getItems
    case value of
      Left  _  -> assertFailure "Failed to get items."
      Right a -> return ()

  it "Returns all spells." $ do
    value <- execRiotT config getSpells
    case value of
      Left  _  -> assertFailure "Failed to get spells."
      Right a -> return ()

  it "Returns all profile icons." $ do
    value <- execRiotT config getProfileIcons
    case value of
      Left  _  -> assertFailure "Failed to get profile icons."
      Right a -> return ()

  it "Returns all the runes." $ do
    value <- execRiotT config getRunes
    case value of
      Left  _  -> assertFailure "Failed to get runes icons."
      Right a -> return ()
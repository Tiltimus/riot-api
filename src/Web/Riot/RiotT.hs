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
{-# LANGUAGE DeriveGeneric             #-}

module Web.Riot.RiotT where

import           Control.Monad.IO.Class
import           Control.Lens
import           Data.Text
import           Data.Time.Clock
import           GHC.Generics
import           Network.Wreq.Session
import           Web.Riot.Config
import           Web.Riot.Locale
import           Web.Riot.Platform
import           Web.Riot.RiotException
import           Web.Riot.Loggit

data State
  = State
  { rate :: Float
  , count :: Int
  , startTime :: UTCTime
  , lastExecuted :: UTCTime
  , session :: Session
  , bucket :: Float
  } deriving (Show, Generic)

newtype RiotT a
    = RiotT { runRiotT :: Config -> State -> IO (Config, State, Either RiotException a) }

instance Functor RiotT where
  fmap func m = RiotT $ \config state -> do
    (_, newState, x) <- runRiotT m config state
    case x of
      Left  e -> return (config, newState, Left e)
      Right a -> return (config, newState, Right $ func a)

instance Applicative RiotT where
  pure a = RiotT $ \config state -> return (config, state, Right a)

  RiotT mx <*> RiotT my = RiotT $ \config state -> do
    (_, newState , x) <- mx config state
    (_, newState', y) <- my config newState
    case (x, y) of
      (Left  e1, Left _  ) -> return (config, newState', Left e1)
      (Left  e1, Right _ ) -> return (config, newState', Left e1)
      (Right _ , Left e1 ) -> return (config, newState', Left e1)
      (Right a1, Right a2) -> return (config, newState', Right $ a1 a2)

instance Monad RiotT where
  RiotT mx >>= f = RiotT $ \config state -> do
    (_, newState, x) <- mx config state
    case x of
      Left  e -> return (config, newState, Left e)
      Right a -> runRiotT (f a) config newState

  return a = pure a

instance MonadIO RiotT where
  liftIO mx = RiotT $ \config state -> do
    x <- mx
    return (config, state, Right x)

createState :: IO State
createState = do
  session <- newAPISession
  time    <- getCurrentTime
  return $ State 0 0 time time session 0

execRiotT' :: Config -> RiotT a -> IO (Config, State, Either RiotException a)
execRiotT' config rx = do
  state <- createState
  runRiotT rx config state

execRiotT :: Config -> RiotT a -> IO (Either RiotException a)
execRiotT config rx = do
  (_, _, x) <- execRiotT' config rx
  return x

getKey :: RiotT Text
getKey =
  RiotT $ \config state -> return (config, state, Right $ config ^. #key)

getSession :: RiotT Session
getSession =
  RiotT $ \config state -> return (config, state, Right $ state ^. #session)

getPlatform :: RiotT Platform
getPlatform =
  RiotT $ \config state -> return (config, state, Right $ config ^. #platform)

getLocale :: RiotT Locale
getLocale =
  RiotT $ \config state -> return (config, state, Right $ config ^. #locale)

getVersion :: RiotT Version
getVersion =
  RiotT $ \config state -> return (config, state, Right $ config ^. #version)

getLimiter :: RiotT Limiter
getLimiter =
  RiotT $ \config state -> return (config, state, Right $ config ^. #rateLimit)

getRate :: RiotT Float
getRate =
  RiotT $ \config state -> return (config, state, Right $ state ^. #rate)

getCount :: RiotT Int
getCount =
  RiotT $ \config state -> return (config, state, Right $ state ^. #count)

setCount :: Int -> RiotT State
setCount value = RiotT $ \config state ->
  return (config, state & #count .~ value, Right $ state & #count .~ value)

getBucket :: RiotT Float
getBucket =
  RiotT $ \config state -> return (config, state, Right $ state ^. #bucket)

setBucket :: Float -> RiotT State
setBucket value = RiotT $ \config state ->
  return (config, state & #bucket .~ value, Right $ state & #bucket .~ value)

getLastExecuted :: RiotT UTCTime
getLastExecuted = RiotT
  $ \config state -> return (config, state, Right $ state ^. #lastExecuted)

setLastExectued :: UTCTime -> RiotT State
setLastExectued value = RiotT $ \config state -> return
  ( config
  , state & #lastExecuted .~ value
  , Right $ state & #lastExecuted .~ value
  )

setError :: RiotException -> RiotT a
setError e = RiotT $ \config state -> return (config, state, Left e)

_throttle :: Float -> RiotT a -> RiotT a
_throttle r rx = do
  count        <- getCount
  bucket       <- getBucket
  currentTime  <- liftIO getCurrentTime
  lastExecuted <- getLastExecuted
  if bucket == 1
    then do
      setBucket 0
      setCount $ count + 1
      setLastExectued currentTime
      rx
    else do
      if toRational r * toRational (currentTime `diffUTCTime` lastExecuted) >= 1
        then do
          setBucket 1
          _throttle r rx
        else _throttle r rx

throttle :: RiotT a -> RiotT a
throttle rx = do
  limiter <- getLimiter
  case limiter of
    NONE -> rx
    DEV  -> _throttle (80 / 120) rx
    PROD -> _throttle (30000 / 600) rx

loggit :: Loggit -> RiotT ()
loggit message = RiotT $ \config state -> do
  case config ^. #logger of
    Just func -> func message
    Nothing   -> return ()
  return (config, state, Right ())

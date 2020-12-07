{-# LANGUAGE OverloadedStrings #-}

module Web.Riot.Request where

import qualified Network.Wreq                  as Wreq
import           Data.Text
import           Data.Aeson
import           Data.Time.Clock
import           Control.Exception
import           Control.Concurrent
import           Control.Lens
import           Control.Monad.IO.Class
import           Web.Riot.Endpoint
import           Web.Riot.Platform
import           Web.Riot.RiotT
import           Web.Riot.RiotException
import           Web.Riot.Loggit
import           Network.HTTP.Client
import           Network.HTTP.Types.Status
import           Network.Wreq.Session

request :: FromJSON a => Endpoint -> RiotT a
request endpoint = throttle $ do
  apikey   <- getKey
  platform <- getPlatform
  let (url, options) = endpointToUrlAndOptions endpoint apikey platform
  session <- getSession
  result  <- liftIO $ try $ getWith options session (unpack url)
  time    <- liftIO getCurrentTime
  case result of
    Left error -> do
      loggit $ Loggit url time "Failed request." options
      setError $ handleHttpException error
    Right response -> case eitherDecode $ response ^. Wreq.responseBody of
      Left message -> do
        loggit $ Loggit url time "Failed to parse request." options
        setError $ UnableToParse $ pack message
      Right value -> do
        loggit $ Loggit url time "Success." options
        return value
 where
  handleHttpException e = case e of
    HttpExceptionRequest _ (StatusCodeException response _) ->
      case response ^. Wreq.responseStatus of
        Status 400 _ -> BadRequest
        Status 401 _ -> Unauthorized
        Status 403 _ -> Forbidden
        Status 404 _ -> NotFound
        Status 415 _ -> UnsupportedMT
        Status 429 _ -> RateExceeded
        Status 500 _ -> InternalError
        Status 503 _ -> ServiceUnavaliable
        Status 504 _ -> GatewayTimeout
        Status _   _ -> Unknown "Unexpected status code."

    _ -> Unknown "Handler for http exception request failed."

{-# LANGUAGE OverloadedStrings #-}
module Main where

import Prelude()
import Relude
import qualified Data.Text as T
import qualified Chronos as Ch
import qualified Data.CaseInsensitive as CI
import qualified Network.HTTP.Types as H
import qualified Network.Wai as W
import qualified Network.Wai.Middleware.RequestLogger as WM
import qualified Options.Applicative as O
import qualified Network.Wai.Handler.Warp as Warp

main :: IO ()
main = do
  port <- O.execParser opts
  putTextLn $ "Listen on port: " <> show port
  Warp.run port
    . reqLogMiddleware
    $ \req respond -> respond $ W.responseLBS H.status200 [] ""

-- TODO: pretty printer / color
-- query
-- with co-log
reqLogMiddleware :: W.Middleware
reqLogMiddleware app req respond = do
  putTextLn $ T.replicate 60 "-"
  putTextLn =<< encodeTime <$> Ch.now
  putBSLn $ W.requestMethod req <> " " <> W.rawPathInfo req <> " " <> show (W.httpVersion req)
  for_ (W.requestHeaders req) $ \(name, value) -> putBSLn $ CI.original name <> ": " <> value
  app req respond


opt :: O.Parser Int
opt = O.option O.auto
  $ O.short 'p'
  <> O.long "port"
  <> O.value 8080
  <> O.showDefault
  <> O.help "Port number"
  <> O.metavar "PORT"

opts = O.info (opt <**> O.helper)
  $ O.fullDesc
  <> O.header "rin - HTTP server for dev/debug"

-- e.g. 2019-08-17T03:33:51.99+0900
encodeTime :: Ch.Time -> Text
encodeTime time =
  Ch.encode_YmdHMSz offsetFormat subsecondPrecision Ch.w3c offsetDatetime
  where
    jstOffset          = Ch.Offset (9 * 60)
    offsetDatetime     = Ch.timeToOffsetDatetime jstOffset time
    offsetFormat       = Ch.OffsetFormatColonOff
    subsecondPrecision = Ch.SubsecondPrecisionFixed 2

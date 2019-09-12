module Main where

import Prelude()
import Relude
import qualified Options.Applicative as O

main :: IO ()
main = do
  port <- O.execParser opts
  print port

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
  <> O.header "rin - HTTP/HTTPS server for dev/debug"

-- | Main module
module Main where

import Network.HTTP.Conduit
import System.Environment (getArgs)
import qualified Data.Text as T
import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as L
import Control.Monad.IO.Class (liftIO)
import Text.Playlist

-- | Application entry point
main :: IO ()
main = do
    args <- getArgs
    case args of
        [urlString] ->
            case parseUrl urlString of
                Nothing -> putStrLn "Sorry, invalid URL"
                Just req -> withManager $ \manager -> do
                    res <- httpLbs req manager
                    let body = responseBody res
                    let playlist = parsePlaylist M3U $ L.toStrict body
                    case playlist of
                        Left err -> fail $ "failed to parse playlist on stdin: " ++ err
                        Right x  -> liftIO $ putStr $ unlines $ map (T.unpack . trackURL) x
        _ -> putStrLn "Sorry, please provide exactly one URL"

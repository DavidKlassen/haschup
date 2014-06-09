-- | Main module
module Main where

import Network.HTTP.Conduit
import System.Environment (getArgs)
import qualified Data.Text as T
import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as L
import Control.Monad.IO.Class (liftIO)
import Text.Playlist

-- | Fetches the playlist from the given url
fetchPlaylist :: String -> IO BS.ByteString
fetchPlaylist urlString = do
    case parseUrl urlString of
        Nothing -> fail "Sorry, invalid URL"
        Just req -> withManager $ \manager -> do
            res <- httpLbs req manager
            return $ L.toStrict $ responseBody res

-- | Application entry point
main :: IO ()
main = do
    args <- getArgs
    case args of
        [urlString] -> do
            content <- fetchPlaylist urlString
            case parsePlaylist M3U content of
                Left err -> fail $ "failed to parse playlist on stdin: " ++ err
                Right x  -> liftIO $ putStr $ unlines $ map (T.unpack . trackURL) x
        _ -> putStrLn "Sorry, please provide exactly one URL"

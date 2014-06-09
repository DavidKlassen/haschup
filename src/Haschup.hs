-- | Main module
module Main where

import qualified Data.ByteString as BS
import qualified Data.Text as T
import Text.Playlist

-- | Reads playlist from stdin
readPlaylist :: Format -> IO Playlist
readPlaylist fmt = do
    content <- BS.getContents
    case parsePlaylist fmt content of
        Left err -> fail $ "failed to parse playlist on stdin: " ++ err
        Right x  -> return x

-- | Application entry point
main :: IO ()
main = do
    playlist <- readPlaylist M3U
    mapM_ (putStrLn . T.unpack . trackURL) playlist
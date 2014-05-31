--
-- Copyright (c) 2014 David Klassen
--
module Haschup(main) where

import System.Environment
 
-- | 'main' runs the main program
main :: IO ()
main = getArgs >>= print . hello . head
 
-- | 'hello' adds "Hello! " prefix to the passed string
hello :: String -> String
hello s = "Hello! " ++ s

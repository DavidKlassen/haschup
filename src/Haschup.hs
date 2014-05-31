--
-- Copyright (c) 2014 David Klassen
--
module Main(main) where

import System.Environment
 
-- | 'main' runs the main program
main :: IO ()
main = getArgs >>= print . hello . head
    where hello s = "Hello! " ++ s

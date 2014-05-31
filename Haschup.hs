--
-- Copyright (c) 2014 David Klassen
--
import System.Environment
 
-- | 'main' runs the main program
main :: IO ()
main = getArgs >>= print . hello . head
 
hello s = "Hello! " ++ s

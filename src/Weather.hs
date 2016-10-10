-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Weather
  (
    -- * Domain types
    Weather(..)
    -- * Domain functions
  , spread
  , answer1
    -- * Util functions
  , parseFile
  ) where

import Control.Arrow ((&&&))
import Data.Maybe (catMaybes, listToMaybe)
import Data.List (sortOn)

data Weather = Weather { dy::Int, mxT::Int, mnT::Int }

spread :: Weather -> Int
spread = uncurry (-) . (mxT &&& mnT)

maybeRead :: (Read a) => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

maybeWord :: Int -> String -> Maybe String
maybeWord n = listToMaybe . drop n . words

parse :: String -> Maybe Weather
parse s = Weather <$> (maybeRead =<< maybeWord 0 s) <*> (maybeRead =<< maybeWord 1 s) <*> (maybeRead =<< maybeWord 2 s)

parseFile :: String -> [Weather]
parseFile =  catMaybes . map parse . lines

answer1 :: String -> Maybe Int
answer1 = fmap dy . listToMaybe . sortOn spread . parseFile

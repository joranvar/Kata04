-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Record
  (
    -- * Class
    Record(..)
    -- * Parsing utils
  , maybeRead
  , maybeWord
  , find
  ) where

import Data.List (minimumBy)
import Data.Maybe (catMaybes, listToMaybe)

class Record r where
  parse :: String -> Maybe r
  parseFile :: String -> [r]
  -- * Default implementation
  parseFile = catMaybes . map parse . lines

find :: (r -> a) -> (r -> r -> Ordering) -> [r] -> a
find label ord = label . minimumBy ord

maybeRead :: (Read a) => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

maybeWord :: Int -> String -> Maybe String
maybeWord n = listToMaybe . drop n . words

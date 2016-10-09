-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Record
  (
    -- * Class
    Record(..)
    -- * Parsing utils
  , maybeRead
  , maybeWord
  ) where

import Data.Maybe (catMaybes, listToMaybe)

class Record r where
  parse :: String -> Maybe r
  parseFile :: String -> [r]
  -- * Default implementation
  parseFile = catMaybes . map parse . lines

maybeRead :: (Read a) => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

maybeWord :: Int -> String -> Maybe String
maybeWord n = listToMaybe . drop n . words

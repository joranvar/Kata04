-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Record
  (
    -- * Class
    Record(..)
    -- * Util functions
  , parseFile
  , maybeRead
  , minimumOn
  ) where

import Data.Maybe (catMaybes, listToMaybe)
import Data.List (sortOn)

class Record r where
  parse :: String -> Maybe r

maybeRead :: (Read a) => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

parseFile :: (Record r) => String -> [r]
parseFile =  catMaybes . map parse . lines

minimumOn :: (Ord o) => (r -> o) -> [r] -> Maybe r
minimumOn p = listToMaybe . sortOn p

-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Record
  (
    -- * Class
    Record(..)
    -- * Util functions
  , parseFile
  , maybeRead
  ) where

import Data.Maybe (catMaybes, listToMaybe)

class Record r where
  parse :: String -> Maybe r

maybeRead :: (Read a) => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

parseFile :: (Record r) => String -> [r]
parseFile =  catMaybes . map parse . lines

-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Record
  (
    -- * Class
    Record(..)
  ) where

import Data.Maybe (catMaybes)

class Record r where
  parse :: String -> Maybe r
  parseFile :: String -> [r]
  -- * Default implementation
  parseFile = catMaybes . map parse . lines

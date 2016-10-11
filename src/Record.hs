-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Record
  (
    -- * Class
    Record(..)
  ) where

class Record r where
  parse :: String -> Maybe r

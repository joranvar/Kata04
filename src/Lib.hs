-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Lib
  (
    -- * Exported types
    Weather(..)
  -- * Exported functions
  , parse
  ) where

-- | A weather record
data Weather = Weather { day::Int
                       , mx::Int
                       , mn::Int }
  deriving (Eq, Show)

-- | Parse a record from a string
parse :: String -> Maybe Weather
parse _ = Nothing

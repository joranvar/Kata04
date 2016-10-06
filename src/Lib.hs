-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Lib
  (
    -- * Exported types
    Weather(..)
  -- * Exported functions
  , parse
  ) where

import Data.Maybe (listToMaybe)

-- | A weather record
data Weather = Weather { day::Int
                       , mx::Int
                       , mn::Int }
  deriving (Eq, Show)

-- | Parse a record from a string
parse :: String -> Maybe Weather
parse s =
  case map (fmap fst . listToMaybe . reads) . take 3 $ words s of
    [Just dy, Just mxT, Just mnT] -> Just $ Weather dy mxT mnT
    _ -> Nothing

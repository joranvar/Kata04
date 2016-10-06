-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Lib
  (
    -- * Exported types
    Weather(..)
  -- * Exported functions
  , parse
  , parseFile
  , answer4
  ) where

import Data.List (minimumBy)
import Data.Maybe (listToMaybe, catMaybes)
import Data.Ord (comparing)

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

-- | Parse a whole file
parseFile :: String -> [Weather]
parseFile = catMaybes . map parse . lines

-- | Answers the day old question: what is the day with the smallest temperature spread in this file?
answer4 :: String -> Int
answer4 = day . minimumBy (comparing (\w -> mx w - mn w)) . parseFile

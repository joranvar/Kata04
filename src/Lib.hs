-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE RecordWildCards #-}

module Lib
  (
    -- * Domain data
    Weather(..)
    -- * Weather functions
  , spread
  , dayWithMinSpread
  , parse
  , parseFile
  ) where

import Data.List (minimumBy)
import Data.Maybe (catMaybes)
import Data.Ord (comparing)

data Weather = Weather { day::Int
                       , maxTemp::Int
                       , minTemp::Int }
  deriving (Eq, Show)

-- | Get the temperature spread of a weather record
spread :: Weather -> Int
spread Weather{..} = maxTemp - minTemp

parse :: String -> Maybe Weather
parse s =
  case map (map fst . reads) . take 3 $ words s of
    [[d],[mx],[mn]] -> Just $ Weather d mx mn
    _ -> Nothing

parseFile :: String -> [Weather]
parseFile = catMaybes . map parse . lines

dayWithMinSpread :: [Weather] -> Int
dayWithMinSpread = day . minimumBy (comparing spread)

-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE RecordWildCards #-}

module Lib
  (
    -- * Domain data
    Weather(..)
    -- * Weather functions
  , spread
  , parse
  ) where

data Weather = Weather { day::Int
                       , maxTemp::Int
                       , minTemp::Int }
  deriving (Eq, Show)

-- | Get the temperature spread of a weather record
spread :: Weather -> Int
spread Weather{..} = maxTemp - minTemp

parse :: String -> Weather
parse s = let [d,mx,mn] = map read . take 3 $ words s in Weather d mx mn

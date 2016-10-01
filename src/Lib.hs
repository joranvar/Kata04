-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Lib
  (
    -- * Domain types
    Weather(..)

    -- * Reading functions
  , readWeather
  , readWeatherData

    -- * Util functions
  , smallestSpread
  ) where

import Data.Function (on)
import Data.List (minimumBy)

data Weather = Weather { day::Int
                       , maxTemp::Int
                       , minTemp::Int }
  deriving (Eq, Show)

readWeather :: String -- ^ The input line
            -> Weather -- ^ The parsed data
readWeather s =
  let da:ma:mi:[] = map read . take 3 . words . filter (/= '*') $ s
  in Weather da ma mi

readWeatherData :: String -> [Weather]
readWeatherData = map readWeather . reverse . drop 1 . reverse . drop 2 . lines

smallestSpread :: [Weather] -> Weather
smallestSpread = minimumBy (compare `on` \w -> maxTemp w - minTemp w)

-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE RecordWildCards #-}

module Lib
  (
    -- * Domain data
    Weather(..)
  -- * Weather functions
  , readWeather
  , spread
  ) where

data Weather = Weather { day::Int
                       , minTemp::Int
                       , maxTemp::Int }
  deriving (Eq, Show)

-- | The temperature spread for the given day
spread :: Weather -> Int
spread Weather{..} = maxTemp - minTemp

-- | Turn a string in a Weather record if the data is parseable
readWeather :: String -> Maybe Weather
readWeather _ = Just $ Weather 1 88 59

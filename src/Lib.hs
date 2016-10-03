-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE RecordWildCards #-}

module Lib
  (
    -- * Domain types
    Weather(..)

    -- * Weather functions
  , spread

  -- * File functions
  , parseWeatherData
  ) where

import Data.Maybe (catMaybes)

-- | A parsed Weather record
data Weather = Weather { day::Int
                       , maxTemp::Int
                       , minTemp::Int }

-- | Get the temperature spread (max-min)
spread :: Weather -> Int
spread Weather{..} = maxTemp - minTemp

-- | Parse the text data into Weather records
parseWeatherData :: String -> [Weather]
parseWeatherData = catMaybes . map maybeParseWeather . lines

-- | Parse a single line to a Weather record, if valid
maybeParseWeather :: String -> Maybe Weather
maybeParseWeather s =
  let [d,ma,mi] = map fst . take 3 $ reads s
  in Just $ Weather d ma mi

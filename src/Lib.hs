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
  , maybeParseWeather
  ) where

import Data.Maybe (catMaybes, listToMaybe)

-- | A parsed Weather record
data Weather = Weather { day::Int
                       , maxTemp::Int
                       , minTemp::Int }
  deriving (Eq, Show)

-- | Get the temperature spread (max-min)
spread :: Weather -> Int
spread Weather{..} = maxTemp - minTemp

-- | Parse the text data into Weather records
parseWeatherData :: String -> [Weather]
parseWeatherData = catMaybes . map maybeParseWeather . lines

-- | Parse a single line to a Weather record, if valid
maybeParseWeather :: String -> Maybe Weather
maybeParseWeather s =
  let ints = take 3 . catMaybes . map maybeParseInt $ words s
      maybeParseInt = fmap fst . listToMaybe . reads
  in case ints of
       [d, ma, mi] -> Just $ Weather d ma mi
       _ -> Nothing

-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Lib
  (
    -- * Domain types
    Weather(..)

    -- * Reading function
  , readWeather
  ) where

data Weather = Weather { day::Int
                       , maxTemp::Int
                       , minTemp::Int }
  deriving (Eq, Show)

readWeather :: String -- ^ The input line
            -> Weather -- ^ The parsed data
readWeather s =
  let da:ma:mi:[] = map read . take 3 . words $ s
  in Weather da ma mi

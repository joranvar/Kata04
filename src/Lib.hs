-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE RecordWildCards #-}

module Lib
  (
    -- * Domain data
    Weather(..)
    -- * Weather functions
  , spread
  ) where

data Weather = Weather { day::Int
                       , maxTemp::Int
                       , minTemp::Int }

-- | Get the temperature spread of a weather record
spread :: Weather -> Int
spread Weather{..} = maxTemp - minTemp

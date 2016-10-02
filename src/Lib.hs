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
                       , minTemp::Int
                       , maxTemp::Int }

-- | The temperature spread for the given day
spread :: Weather -> Int
spread Weather{..} = maxTemp - minTemp

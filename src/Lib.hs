-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE RecordWildCards #-}

module Lib
  (
    -- * Domain types
    Weather(..)
    -- * Weather functions
  , spread
  ) where

-- | A parsed Weather record
data Weather = Weather { day::Int
                       , maxTemp::Int
                       , minTemp::Int }

-- | Get the temperature spread (max-min)
spread :: Weather -> Int
spread Weather{..} = maxTemp - minTemp

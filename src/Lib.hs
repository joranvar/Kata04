-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Lib
  (
    -- * Domain types
    Weather (..)
  ) where

-- | A weather record
data Weather = Weather { day::Int
                       , maxTemp::Float
                       , minTemp::Float }

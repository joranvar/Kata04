-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Lib
  (
    -- * Domain types
    Weather(..)
  ) where

-- | A parsed Weather record
data Weather = Weather { day::Int
                       , maxTemp::Int
                       , minTemp::Int }

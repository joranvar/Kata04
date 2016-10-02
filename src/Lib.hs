-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Lib
  (
    -- * Domain data
    Weather(..)
  ) where

data Weather = Weather { day::Int
                       , min::Int
                       , max::Int }

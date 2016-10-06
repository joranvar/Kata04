-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Lib
  (
    -- * Exported types
    Weather(..)
  ) where

-- | A weather record
data Weather = Weather { day::Int
                       , mx::Int
                       , mn::Int }

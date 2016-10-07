-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Lib
  (
    -- * Domain types
    Weather(..)
  ) where

data Weather = Weather { day::Int, mnT::Int, mxT::Int }
  deriving (Eq, Show)

-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Weather
  (
    -- * Domain types
    Weather(..)
    -- * Domain functions
  , spread
  ) where

import Control.Arrow ((&&&))

data Weather = Weather { dy::Int, mxT::Int, mnT::Int }

spread :: Weather -> Int
spread = uncurry (-) . (mxT &&& mnT)

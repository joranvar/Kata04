-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Weather
  (
    -- * Domain types
    Weather(..)
    -- * Domain functions
  , spread
  , answer1
  ) where

import Control.Arrow ((&&&))
import Data.Maybe (listToMaybe)
import Data.List (sortOn)
import Record

data Weather = Weather { dy::Int, mxT::Int, mnT::Int }
instance Record Weather where
  parse s = case words s of
              dy':mxT':mnT':_ -> Weather <$> maybeRead dy' <*> maybeRead mxT' <*> maybeRead mnT'
              _ -> Nothing

spread :: Weather -> Int
spread = uncurry (-) . (mxT &&& mnT)

answer1 :: String -> Maybe Int
answer1 = fmap dy . listToMaybe . sortOn spread . parseFile

-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Weather
  (
    -- * Domain types
    Weather(..)
    -- * Domain functions
  , spread
  , answer1
    -- * Parse functions
  , parseFile
  ) where

import Control.Arrow ((&&&))
import Data.List (sortOn)
import Data.Maybe (listToMaybe)

import Record

data Weather = Weather { dy::Int, mxT::Int, mnT::Int }
  deriving (Eq, Show)
instance Record Weather where
  parseWords (dy':mxT':mnT':_) = Weather <$> maybeRead dy' <*> maybeRead mxT' <*> maybeRead mnT'
  parseWords _ = Nothing

spread :: Weather -> Int
spread = uncurry (-) . (mxT &&& mnT)

answer1 :: String -> Maybe Int
answer1 = fmap dy . listToMaybe . sortOn spread . parseFile

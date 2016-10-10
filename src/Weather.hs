-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE MultiParamTypeClasses #-}
module Weather
  (
    -- * Domain types
    Weather(..)
    -- * Domain functions
  , spread
  , answer1
  ) where

import Control.Arrow ((&&&))
import Record

data Weather = Weather { dy::Int, mxT::Int, mnT::Int }
instance Record Int Weather where
  parseWords (dy':mxT':mnT':_) = Weather <$> maybeRead dy' <*> maybeRead mxT' <*> maybeRead mnT'
  parseWords _ = Nothing
  label = dy

spread :: Weather -> Int
spread = uncurry (-) . (mxT &&& mnT)

answer1 :: String -> Maybe Int
answer1 = labelOfMinimumInFile spread

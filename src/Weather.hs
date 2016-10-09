-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE MultiParamTypeClasses, FlexibleInstances, TypeSynonymInstances #-}
module Weather
  (
    -- * Domain type
    Weather(..)
    -- * Functionality
  , minDayBySpread
  ) where

import Record (Record(..), maybeRead, maybeWord)

import Control.Arrow ((&&&))
import Data.Ord (comparing)

data Weather = Weather { dy::Int, mxT::Int, mnT::Int }
  deriving (Eq, Show)

instance Record Int Weather where
  parse s = Weather
            <$> (maybeRead =<< maybeWord 0 s)
            <*> (maybeRead =<< maybeWord 1 s)
            <*> (maybeRead =<< maybeWord 2 s)
  label = dy

spread :: Weather -> Int
spread = uncurry (-) . (mxT &&& mnT)

minDayBySpread :: [Weather] -> Int
minDayBySpread = find (comparing spread)

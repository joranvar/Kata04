-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE RecordWildCards #-}

module Lib
  (
    -- * Record class
    Record(..)
    -- * Record helper functions
  , maybeParse
    -- * Domain types
  , Weather(..)
    -- * Weather functions
  , spread
  ) where

import Data.Maybe (listToMaybe)

class Record r where
  parse :: String -> Maybe r

maybeParse :: (Read a) => String -> Maybe a
maybeParse = fmap fst . listToMaybe . reads

data Weather = Weather { day::Int, mnT::Int, mxT::Int }
  deriving (Eq, Show)

spread :: Weather -> Int
spread Weather{..} = mxT - mnT

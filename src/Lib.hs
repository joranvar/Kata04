-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE RecordWildCards #-}

module Lib
  (
    -- * Record class
    Record(..)
    -- * Domain types
  , Weather(..)
    -- * Weather functions
  , spread
  ) where

class Record r where
  parse :: String -> Maybe r

data Weather = Weather { day::Int, mnT::Int, mxT::Int }
  deriving (Eq, Show)

spread :: Weather -> Int
spread Weather{..} = mxT - mnT

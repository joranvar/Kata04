-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE RecordWildCards #-}

module Lib
  (
    -- * Record class
    Record(..)
    -- * Record helper functions
  , maybeParse
  , maybeWord
  , parseMany
    -- * Domain types
  , Weather(..)
    -- * Weather functions
  , spread
  ) where

import Data.Maybe (listToMaybe, catMaybes)

class Record r where
  parse :: String -> Maybe r

maybeParse :: (Read a) => String -> Maybe a
maybeParse = fmap fst . listToMaybe . reads

maybeWord :: Int -> String -> Maybe String
maybeWord n = listToMaybe . drop n . words

parseMany :: (Record r) => String -> [r]
parseMany = catMaybes . map parse . lines

data Weather = Weather { day::Int, mnT::Int, mxT::Int }
  deriving (Eq, Show)
instance Record Weather where
  parse s = Weather
            <$> (maybeParse =<< maybeWord 0 s)
            <*> (maybeParse =<< maybeWord 1 s)
            <*> (maybeParse =<< maybeWord 2 s)

spread :: Weather -> Int
spread Weather{..} = mxT - mnT

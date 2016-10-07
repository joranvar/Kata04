-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE RecordWildCards #-}

module Lib
  (
    -- * Record class
    Record(..)
    -- * Record helper functions
  , maybeRead
  , maybeWord
  , parseMany
    -- * Domain types
  , Weather(..)
  , Soccer(..)
    -- * Weather functions
  , spread
  , minSpreadDay
    -- * Soccer functions
  , goalDiff
  , minGoalDiffTeam
  ) where

import Data.List (minimumBy)
import Data.Maybe (listToMaybe, catMaybes)
import Data.Ord (comparing)

class Record r where
  parse :: String -> Maybe r

maybeRead :: (Read a) => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

maybeWord :: Int -> String -> Maybe String
maybeWord n = listToMaybe . drop n . words

parseMany :: (Record r) => String -> [r]
parseMany = catMaybes . map parse . lines

data Weather = Weather { day::Int, mxT::Int, mnT::Int }
  deriving (Eq, Show)
instance Record Weather where
  parse s = Weather
            <$> (maybeRead =<< maybeWord 0 s)
            <*> (maybeRead =<< maybeWord 1 s)
            <*> (maybeRead =<< maybeWord 2 s)

spread :: Weather -> Int
spread Weather{..} = mxT - mnT

minSpreadDay :: [Weather] -> Int
minSpreadDay = day . minimumBy (comparing spread)

data Soccer = Soccer { team::String, f::Int, a::Int }
  deriving (Eq, Show)
instance Record Soccer where
  parse s = Soccer
            <$> (maybeWord 1 s)
            <*> (maybeRead =<< maybeWord 6 s)
            <*> (maybeRead =<< maybeWord 8 s)

goalDiff :: Soccer -> Int
goalDiff Soccer{..} = abs $ a - f

minGoalDiffTeam :: [Soccer] -> String
minGoalDiffTeam = team . minimumBy (comparing goalDiff)

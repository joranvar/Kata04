-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE MultiParamTypeClasses, FlexibleInstances, TypeSynonymInstances #-}
module Soccer
  (
    -- * Domain type
    Soccer(..)
    -- * Functionality
  , minTeamByDiffScores
  ) where

import Record (Record(..), maybeRead, maybeWord)

import Control.Arrow ((&&&))
import Data.Ord (comparing)

data Soccer = Soccer { team::String, f::Int, a::Int }
  deriving (Eq, Show)

instance Record String Soccer where
  parse s = Soccer
            <$> (maybeWord 1 s)
            <*> (maybeRead =<< maybeWord 6 s)
            <*> (maybeRead =<< maybeWord 8 s)
  label = team

diffScores :: Soccer -> Int
diffScores = abs . uncurry (-) . (f &&& a)

minTeamByDiffScores :: [Soccer] -> String
minTeamByDiffScores = find (comparing diffScores)

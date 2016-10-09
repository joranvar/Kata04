-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Soccer
  (
    -- * Domain type
    Soccer(..)
    -- * Functionality
  , parse
  , parseFile
  , minTeamByDiffScores
  ) where

import Record (Record(..), maybeRead, maybeWord)

import Control.Arrow ((&&&))
import Data.List (minimumBy)
import Data.Ord (comparing)

data Soccer = Soccer { team::String, f::Int, a::Int }
  deriving (Eq, Show)

instance Record Soccer where
  parse s = Soccer
            <$> (maybeWord 1 s)
            <*> (maybeRead =<< maybeWord 6 s)
            <*> (maybeRead =<< maybeWord 8 s)

diffScores :: Soccer -> Int
diffScores = abs . uncurry (-) . (f &&& a)

minTeamByDiffScores :: [Soccer] -> String
minTeamByDiffScores = team . minimumBy (comparing diffScores)

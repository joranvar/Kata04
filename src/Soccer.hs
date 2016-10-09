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

import Control.Arrow ((&&&))
import Data.List (minimumBy)
import Data.Maybe (listToMaybe, catMaybes)
import Data.Ord (comparing)

data Soccer = Soccer { team::String, f::Int, a::Int }
  deriving (Eq, Show)

maybeRead :: (Read a) => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

maybeWord :: Int -> String -> Maybe String
maybeWord n = listToMaybe . drop n . words

parse :: String -> Maybe Soccer
parse s = Soccer
          <$> (maybeWord 1 s)
          <*> (maybeRead =<< maybeWord 6 s)
          <*> (maybeRead =<< maybeWord 8 s)

parseFile :: String -> [Soccer]
parseFile = catMaybes . map parse . lines

diffScores :: Soccer -> Int
diffScores = abs . uncurry (-) . (f &&& a)

minTeamByDiffScores :: [Soccer] -> String
minTeamByDiffScores = team . minimumBy (comparing diffScores)

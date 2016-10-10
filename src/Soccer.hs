-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Soccer
  (
    -- * Domain types
    Soccer(..)
    -- * Domain functions
  , spread
  , answer2
    -- * Util functions
  , parseFile
  ) where

import Control.Arrow ((&&&))
import Data.Maybe (catMaybes, listToMaybe)
import Data.List (sortOn)

data Soccer = Soccer { team::String, f::Int, a::Int }

spread :: Soccer -> Int
spread = abs . uncurry (-) . (f &&& a)

maybeRead :: (Read a) => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

maybeWord :: Int -> String -> Maybe String
maybeWord n = listToMaybe . drop n . words

parse :: String -> Maybe Soccer
parse s = Soccer <$> (maybeWord 1 s) <*> (maybeRead =<< maybeWord 6 s) <*> (maybeRead =<< maybeWord 8 s)

parseFile :: String -> [Soccer]
parseFile =  catMaybes . map parse . lines

answer2 :: String -> Maybe String
answer2 = fmap team . listToMaybe . sortOn spread . parseFile

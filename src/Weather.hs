-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Weather
  (
    -- * Domain type
    Weather(..)
    -- * Functionality
  , parse
  , parseFile
  , minDayBySpread
  ) where

import Control.Arrow ((&&&))
import Data.List (minimumBy)
import Data.Maybe (listToMaybe, catMaybes)
import Data.Ord (comparing)

data Weather = Weather { dy::Int, mxT::Int, mnT::Int }
  deriving (Eq, Show)

maybeRead :: (Read a) => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

maybeWord :: Int -> String -> Maybe String
maybeWord n = listToMaybe . drop n . words

parse :: String -> Maybe Weather
parse s = Weather
          <$> (maybeRead =<< maybeWord 0 s)
          <*> (maybeRead =<< maybeWord 1 s)
          <*> (maybeRead =<< maybeWord 2 s)

parseFile :: String -> [Weather]
parseFile = catMaybes . map parse . lines

spread :: Weather -> Int
spread = uncurry (-) . (mxT &&& mnT)

minDayBySpread :: [Weather] -> Int
minDayBySpread = dy . minimumBy (comparing spread)

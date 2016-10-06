-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Lib
  (
    -- * Exported types
    Weather(..)
  , Team(..)
    -- * Record exports
  , Record(..)
    -- * Exported weather functions
  , answer4
  -- * Exported team functions
  , answer4T
  ) where

import Data.List (minimumBy, uncons)
import Data.Maybe (listToMaybe, catMaybes)
import Data.Ord (comparing)

class Record r where
  -- | Parse a record from a string
  parse :: String -> Maybe r
-- | Parse a whole file
  parses :: String -> [r]
  parses = catMaybes . map parse . lines

-- | A weather record
data Weather = Weather { day::Int
                       , mx::Int
                       , mn::Int }
  deriving (Eq, Show)

instance Record Weather where
  parse s = Weather
            <$> (maybeRead =<< (maybeAt 0 $ words s))
            <*> (maybeRead =<< (maybeAt 1 $ words s))
            <*> (maybeRead =<< (maybeAt 2 $ words s))

maybeRead :: (Read a) => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

maybeHead :: [a] -> Maybe a
maybeHead = fmap fst . uncons

maybeAt :: Int -> [a] -> Maybe a
maybeAt n = maybeHead . drop n

-- | Answers the day old question: what is the day with the smallest temperature spread in this file?
answer4 :: String -> Int
answer4 = day . minimumBy (comparing (\w -> mx w - mn w)) . parses

-- | A team record
data Team = Team { name::String
                 , for::Int
                 , against::Int }
  deriving (Eq, Show)

instance Record Team where
  parse s = Team
            <$> (maybeAt 1 $ words s)
            <*> (maybeRead =<< (maybeAt 6 $ words s))
            <*> (maybeRead =<< (maybeAt 8 $ words s))

-- | Answers the burning question: what team has the smallest difference between for and against?
answer4T :: String -> String
answer4T = name . minimumBy (comparing (\t -> abs $ for t - against t)) . parses

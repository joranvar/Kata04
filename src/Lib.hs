-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Lib
  (
    -- * Exported types
    Weather(..)
  , Team(..)
  -- * Exported weather functions
  , parse
  , parseFile
  , answer4
  -- * Exported team functions
  , parseT
  , parseFileT
  , answer4T
  ) where

import Control.Arrow ((***))
import Data.List (minimumBy)
import Data.Maybe (listToMaybe, catMaybes)
import Data.Ord (comparing)

-- | A weather record
data Weather = Weather { day::Int
                       , mx::Int
                       , mn::Int }
  deriving (Eq, Show)

maybeRead :: (Read a) => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

-- | Parse a record from a string
parse :: String -> Maybe Weather
parse s =
  case map maybeRead . take 3 $ words s of
    [dy, mxT, mnT] -> Weather <$> dy <*> mxT <*> mnT
    _ -> Nothing

-- | Parse a whole file
parseFile :: String -> [Weather]
parseFile = catMaybes . map parse . lines

-- | Answers the day old question: what is the day with the smallest temperature spread in this file?
answer4 :: String -> Int
answer4 = day . minimumBy (comparing (\w -> mx w - mn w)) . parseFile

-- | A team record
data Team = Team { name::String
                 , for::Int
                 , against::Int }
  deriving (Eq, Show)

-- | Parse a record from a string
parseT :: String -> Maybe Team
parseT s =
  case (take 1 . drop 1) *** (map maybeRead) $ splitAt 2 $ words s of
    ([team], [_p, _w, _l, _d, f, _dash, a, _pts]) -> Team team <$> f <*> a
    _ -> Nothing

-- | Parse a whole file
parseFileT :: String -> [Team]
parseFileT = catMaybes . map parseT . lines

-- | Answers the burning question: what team has the smallest difference between for and against?
answer4T :: String -> String
answer4T = name . minimumBy (comparing (\t -> abs $ for t - against t)) . parseFileT

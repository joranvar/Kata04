-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE RecordWildCards #-}

module Record
  (
    -- * Class
    Record(..)
    -- * Helper functions
  , maybeRead
  , maybeWord
  , maybeRange
  , trim
  ) where

import Data.Maybe (listToMaybe)

class Record r where
  parse :: String -> Maybe r

maybeRead :: (Read a) => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

maybeWord :: Int -> String -> Maybe String
maybeWord n = listToMaybe . drop n . words

maybeRange :: (Int, Int) -> String -> String
maybeRange (x, y) = take (y - x) . drop x

trim :: String -> String
trim = reverse . dropWhile (== ' ') . reverse . dropWhile (== ' ')

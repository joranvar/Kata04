-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies #-}
module Record
  (
    -- * Class
    Record(..)
    -- * Parsing utils
  , maybeRead
  , maybeWord
  ) where

import Data.List (minimumBy)
import Data.Maybe (catMaybes, listToMaybe)

class Record l r | r -> l where
  parse :: String -> Maybe r
  parseFile :: String -> [r]
  label :: r -> l
  find :: (r -> r -> Ordering) -> [r] -> l
  -- * Default implementation
  parseFile = catMaybes . map parse . lines
  find ord = label . minimumBy ord

maybeRead :: (Read a) => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

maybeWord :: Int -> String -> Maybe String
maybeWord n = listToMaybe . drop n . words

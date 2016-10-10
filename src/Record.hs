-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies #-}
module Record
  (
    -- * Class
    Record(..)
    -- * Util functions
  , parseFile
  , maybeRead
  , labelOfMinimumInFile
  ) where

import Data.Maybe (catMaybes, listToMaybe)
import Data.List (sortOn)

class Record l r | r -> l where
  parse :: String -> Maybe r
  label :: r -> l

maybeRead :: (Read a) => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

parseFile :: (Record l r) => String -> [r]
parseFile =  catMaybes . map parse . lines

minimumOn :: (Ord o) => (r -> o) -> [r] -> Maybe r
minimumOn p = listToMaybe . sortOn p

labelOfMinimumInFile :: (Record l r, Ord o) => (r -> o) -> String -> Maybe l
labelOfMinimumInFile p = fmap label . minimumOn p . parseFile

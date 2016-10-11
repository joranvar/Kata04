-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies #-}
module Record
  (
    -- * Class
    Record(..)
    -- * Util functions
  , maybeRead
  , (!!?)
  , parseFile
  ) where

import Data.Maybe (listToMaybe, catMaybes)

class Record l r | r -> l where
  parse :: String -> Maybe r
  parseWords :: [String] -> Maybe r
  label :: r -> l

  -- * Default implementation
  parse = parseWords . words

maybeRead :: (Read a) => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

(!!?) :: [a] -> Int -> Maybe a
xs !!? n = listToMaybe . drop n $ xs

parseFile :: (Record l r) => String -> [r]
parseFile = catMaybes . map parse . lines

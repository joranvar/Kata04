-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies, PartialTypeSignatures #-}
module Record
  (
    -- * Class
    Record(..)
    -- * Util functions
  , maybeRead
  , (!!?)
  , parseFile
  , queryFirst
  , ranges
  ) where

import Data.List (sortOn, sort)
import Data.Maybe (listToMaybe, catMaybes)

class Record l r | r -> l where
  parse :: String -> Maybe r
  parseWords :: [String] -> Maybe r
  label :: r -> l

maybeRead :: (Read a) => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

(!!?) :: [a] -> Int -> Maybe a
xs !!? n = listToMaybe . drop n $ xs

parseFile :: (Record l r) => String -> [r]
parseFile = catMaybes . map parse . lines

queryFirst :: (Ord o, Record l r) => (r -> o) -> (r -> Bool) -> [r] -> Maybe l
queryFirst sort' filter' = fmap label . listToMaybe . sortOn sort' . filter filter'

ranges :: [(Int, Int)] -> String -> [String]
ranges rs s = map (\(x, y) -> take y . drop x $ s) $ sort rs

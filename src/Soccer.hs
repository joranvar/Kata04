-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Soccer
  (
    -- * Domain types
    Soccer(..)
    -- * Domain functions
  , spread
  , answer2
    -- * Parse functions
  , parse
  , parseFile
  ) where

import Control.Arrow ((&&&))
import Data.List (sortOn)
import Data.Maybe (listToMaybe, catMaybes)

data Soccer = Soccer { team::String, f::Int, a::Int }
  deriving (Eq, Show)

maybeRead :: (Read a) => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

(!!?) :: [a] -> Int -> Maybe a
xs !!? n = listToMaybe . drop n $ xs

parse :: String -> Maybe Soccer
parse s = let w = words s
          in Soccer
             <$> (w !!? 1)
             <*> (maybeRead =<< (w !!? 6))
             <*> (maybeRead =<< (w !!? 8))

parseFile :: String -> [Soccer]
parseFile = catMaybes . map parse . lines

spread :: Soccer -> Int
spread = abs . uncurry (-) . (f &&& a)

answer2 :: String -> Maybe String
answer2 = fmap team . listToMaybe . sortOn spread . parseFile

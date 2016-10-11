-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Soccer
  (
    -- * Domain types
    Soccer(..)
    -- * Domain functions
  , spread
  , answer2
  ) where

import Control.Arrow ((&&&))
import Data.List (sortOn)
import Data.Maybe (listToMaybe)

import Record

data Soccer = Soccer { team::String, f::Int, a::Int }
  deriving (Eq, Show)
instance Record Soccer where
  parse s = let w = words s
            in Soccer
               <$> (w !!? 1)
               <*> (maybeRead =<< (w !!? 6))
               <*> (maybeRead =<< (w !!? 8))

spread :: Soccer -> Int
spread = abs . uncurry (-) . (f &&& a)

answer2 :: String -> Maybe String
answer2 = fmap team . listToMaybe . sortOn spread . parseFile

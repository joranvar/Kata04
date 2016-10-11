-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Weather
  (
    -- * Domain types
    Weather(..)
    -- * Domain functions
  , spread
  , answer1
    -- * Parse functions
  , parseFile
  ) where

import Control.Arrow ((&&&))
import Data.List (sortOn)
import Data.Maybe (listToMaybe)

import Record

data Weather = Weather { dy::Int, mxT::Int, mnT::Int }
  deriving (Eq, Show)
instance Record Weather where
  parse s = let w = words s
            in Weather
               <$> (maybeRead =<< (w !!? 0))
               <*> (maybeRead =<< (w !!? 1))
               <*> (maybeRead =<< (w !!? 2))

spread :: Weather -> Int
spread = uncurry (-) . (mxT &&& mnT)

answer1 :: String -> Maybe Int
answer1 = fmap dy . listToMaybe . sortOn spread . parseFile

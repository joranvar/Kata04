-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Weather
  (
    -- * Domain types
    Weather(..)
    -- * Domain functions
  , spread
  , answer1
    -- * Util functions
  , parseFile
  ) where

import Control.Arrow ((&&&))
import Data.Maybe (catMaybes, listToMaybe)
import Data.List (sortOn)

data Weather = Weather { dy::Int, mxT::Int, mnT::Int }

spread :: Weather -> Int
spread = uncurry (-) . (mxT &&& mnT)

maybeRead :: (Read a) => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

parse :: String -> Maybe Weather
parse s = case words s of
            dy':mxT':mnT':_ -> Weather <$> maybeRead dy' <*> maybeRead mxT' <*> maybeRead mnT'
            _ -> Nothing

parseFile :: String -> [Weather]
parseFile =  catMaybes . map parse . lines

answer1 :: String -> Maybe Int
answer1 = fmap dy . listToMaybe . sortOn spread . parseFile

-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Soccer
  (
    -- * Domain types
    Soccer(..)
    -- * Domain functions
  , spread
  , answer2
    -- * Util functions
  , parseFile
  ) where

import Control.Arrow ((&&&))
import Data.Maybe (catMaybes, listToMaybe)
import Data.List (sortOn)

data Soccer = Soccer { team::String, f::Int, a::Int }

spread :: Soccer -> Int
spread = abs . uncurry (-) . (f &&& a)

maybeRead :: (Read a) => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

parse :: String -> Maybe Soccer
parse s = case words s of
            _:team':_:_:_:_:f':_:a':_ -> Soccer team' <$> maybeRead f' <*> maybeRead a'
            _ -> Nothing

parseFile :: String -> [Soccer]
parseFile =  catMaybes . map parse . lines

answer2 :: String -> Maybe String
answer2 = fmap team . listToMaybe . sortOn spread . parseFile

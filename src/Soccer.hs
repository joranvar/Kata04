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
import Record

data Soccer = Soccer { team::String, f::Int, a::Int }
instance Record Soccer where
  parse s = case words s of
              _:team':_:_:_:_:f':_:a':_ -> Soccer team' <$> maybeRead f' <*> maybeRead a'
              _ -> Nothing

spread :: Soccer -> Int
spread = abs . uncurry (-) . (f &&& a)

answer2 :: String -> Maybe String
answer2 = fmap team . minimumOn spread . parseFile

-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE MultiParamTypeClasses, TypeSynonymInstances, FlexibleInstances, LambdaCase #-}
module Soccer
  (
    -- * Domain types
    Soccer(..)
    -- * Domain functions
  , spread
  , answer2
  ) where

import Control.Arrow ((&&&))
import Data.Function ((&))

import Record (maybeRead, parseFile, queryFirst, Record(..))

data Soccer = Soccer { team::String, f::Int, a::Int }
  deriving (Eq, Show)
instance Record String Soccer where
  label = team
  parse = words & \case
    (_:team':_:_:_:_:f':_:a':_) -> Soccer team' <$> maybeRead f' <*> maybeRead a'
    _ -> Nothing

spread :: Soccer -> Int
spread = abs . uncurry (-) . (f &&& a)

answer2 :: String -> Maybe String
answer2 = queryFirst spread (const True) . parseFile

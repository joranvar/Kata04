-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE RecordWildCards #-}

module Lib
  (
    -- * Domain data
    Weather(..)
    -- * Weather functions
  , spread
  , parse
  ) where

data Weather = Weather { day::Int
                       , maxTemp::Int
                       , minTemp::Int }
  deriving (Eq, Show)

-- | Get the temperature spread of a weather record
spread :: Weather -> Int
spread Weather{..} = maxTemp - minTemp

parse :: String -> Maybe Weather
parse s =
  case map (map fst . reads) . take 3 $ words s of
    [[d],[mx],[mn]] -> Just $ Weather d mx mn
    _ -> Nothing

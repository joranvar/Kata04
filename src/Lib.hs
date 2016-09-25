-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Lib
  (
    -- * Domain types
    Weather (..)
    -- * Functions
  , parse
  ) where

-- | A weather record
data Weather = Weather { day::Int
                       , maxTemp::Float
                       , minTemp::Float }
  deriving (Eq, Show)

-- | Parsing a record from the file
parse :: String  -- ^ The line from the file
      -> Weather -- ^ The corresponding Weather data
parse s = let (d:ma:mi:_) = words s in Weather (read d) (read ma) (read mi)

{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.SmallCheck
import Test.SmallCheck.Series

import Lib
instance (Monad m, Enum a, Bounded a) => Serial m a where
  series = generate (\d -> take d [minBound .. maxBound])

main :: IO ()
main = do
  weatherDat <- readFile "data/weather.dat"
  defaultMain $ testGroup "all-tests" $ tests weatherDat

tests :: String -> [TestTree]
tests weatherDat =
  [ testGroup "SmallCheck" scTests
  , testGroup "Unit tests" $ huTests weatherDat
  ]

scTests :: [TestTree]
scTests =
  [ testProperty "id x == x" $
    \x -> id (x::Int) == x
  ]

huTests :: String -> [TestTree]
huTests weatherDat =
  [ testCase "Can parse first line" $
    parse (head . lines $ weatherDat) @?= Nothing
  ]

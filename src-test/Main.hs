{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.SmallCheck
import Test.SmallCheck.Series

import Weather

instance (Monad m, Enum a, Bounded a) => Serial m a where
  series = generate (\d -> take d [minBound .. maxBound])

main :: IO ()
main = do
  weatherDat <- readFile "data/weather.dat"
  defaultMain $ testGroup "all-tests" $ tests weatherDat

tests :: String -> [TestTree]
tests weatherDat =
  [ testGroup "SmallCheck" scTests
  , testGroup "Weather tests" $ weatherTests weatherDat
  ]

scTests :: [TestTree]
scTests =
  [ testProperty "id x == x" $
    \x -> id (x::Int) == x
  ]

weatherTests :: String -> [TestTree]
weatherTests dat =
  [ testCase "Can parse file" $
    (length $ parseFile dat) @?= 30
  , testCase "Answer is correct" $
    answer1 dat @?= Just 14
  ]

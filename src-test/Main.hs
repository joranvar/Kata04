{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.SmallCheck
import Test.SmallCheck.Series

import Weather
import Soccer
instance (Monad m, Enum a, Bounded a) => Serial m a where
  series = generate (\d -> take d [minBound .. maxBound])

main :: IO ()
main = do
  weatherDat <- readFile "data/weather.dat"
  footballDat <- readFile "data/football.dat"
  defaultMain $ testGroup "all-tests" $
    [ testGroup "Weather tests" $ weatherTests weatherDat
    , testGroup "Football tests" $ footballTests footballDat
    , testGroup "SmallCheck" scTests
    ]

scTests :: [TestTree]
scTests =
  [ testProperty "id x == x" $
    \x -> id (x::Int) == x
  ]

weatherTests :: String -> [TestTree]
weatherTests dat =
  [ testCase "Parsing empty line -> Nothing" $
    Weather.parse "" @?= Nothing
  , testCase "Parsing file -> 30 entries" $
    (length $ Weather.parseFile dat) @?= 30
  , testCase "Answer = 14" $
    answer1 dat @?= Just 14
  ]

footballTests :: String -> [TestTree]
footballTests dat =
  [ testCase "Parsing empty line -> Nothing" $
    Soccer.parse "" @?= Nothing
  , testCase "Parsing file -> 20 entries" $
    (length $ Soccer.parseFile dat) @?= 20
  , testCase "Answer = Aston_Villa" $
    answer2 dat @?= Just "Aston_Villa"
  ]

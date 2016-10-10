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
  soccerDat <- readFile "data/football.dat"
  defaultMain $ testGroup "all-tests" $ tests (weatherDat, soccerDat)

tests :: (String, String) -> [TestTree]
tests (weatherDat, soccerDat) =
  [ testGroup "SmallCheck" scTests
  , testGroup "Weather tests" $ weatherTests weatherDat
  , testGroup "Soccer tests" $ soccerTests soccerDat
  ]

scTests :: [TestTree]
scTests =
  [ testProperty "id x == x" $
    \x -> id (x::Int) == x
  ]

weatherTests :: String -> [TestTree]
weatherTests dat =
  [ testCase "Can parse file" $
    (length $ Weather.parseFile dat) @?= 30
  , testCase "Answer is correct" $
    answer1 dat @?= Just 14
  ]

soccerTests :: String -> [TestTree]
soccerTests dat =
  [ testCase "Can parse file" $
    (length $ Soccer.parseFile dat) @?= 20
  , testCase "Answer is correct" $
    answer2 dat @?= Just "Aston_Villa"
  ]

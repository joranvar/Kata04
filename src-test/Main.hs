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
  defaultMain $ testGroup "all-tests" $
    [ testGroup "Weather tests" $ weatherTests weatherDat
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
    parse "" @?= Nothing
  , testCase "Parsing file -> 30 entries" $
    (length $ parseFile dat) @?= 30
  , testCase "Answer = 14" $
    answer1 dat @?= Just 14
  ]

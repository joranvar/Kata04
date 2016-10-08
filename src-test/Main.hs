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
  weather <- readFile "data/weather.dat"
  defaultMain $ testGroup "all-tests" $ tests weather

tests :: String -> [TestTree]
tests weather =
  [ testGroup "SmallCheck" scTests
  , testGroup "Unit tests" $ huTests weather
  ]

scTests :: [TestTree]
scTests =
  [ testProperty "id x == x" $
    \x -> id (x::Int) == x
  ]

huTests :: String -> [TestTree]
huTests weather =
  [ testCase "Can parse first record" $
    parse (head . drop 2 $ lines weather) @?= (Just $ Weather 1 88 59 74 53.8 0.00 "F" 280 9.6 270 17 1.6 93 23 1004.5)
  ]

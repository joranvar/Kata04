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
main = defaultMain $ testGroup "all-tests" tests

tests :: [TestTree]
tests =
  [ testGroup "SmallCheck" scTests
  , testGroup "Unit tests" huTests
  ]

scTests :: [TestTree]
scTests =
  [ testProperty "id x == x" $
    \x -> id (x::Int) == x
  ]

huTests :: [TestTree]
huTests =
  [ testCase "Can parse first line of weather data" $
    readWeather "   1  88    59    74          53.8       0.00 F       280  9.6 270  17  1.6  93 23 1004.5"
    @?= Weather 1 88 59
  ]

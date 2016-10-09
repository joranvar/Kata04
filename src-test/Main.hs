{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.SmallCheck
import Test.SmallCheck.Series

import Weather (Weather(..), parse)
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
  let _header:_emptyline:record1:_rest = lines dat in
  [ testCase "Can parse first record" $
    parse record1 @?= (Just $ Weather 1 88 59)
  ]

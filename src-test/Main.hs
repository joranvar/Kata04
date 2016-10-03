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
  dat <- readFile "data/weather.dat"
  defaultMain $ testGroup "all-tests" $ tests dat

tests :: String -> [TestTree]
tests dat =
  [ testGroup "SmallCheck" scTests
  , testGroup "Unit tests" $ huTests dat
  ]

scTests :: [TestTree]
scTests =
  [ testProperty "id x == x" $
    \x -> id (x::Int) == x
  ]

huTests :: String -> [TestTree]
huTests dat =
  [ testCase "Can parse the first record of weather.dat" $
    maybeParseWeather "   1  88    59    74          53.8       0.00 F       280  9.6 270  17  1.6  93 23 1004.5"
      @?= (Just $ Weather 1 88 59)
  , testCase "Can skip the header line" $
    maybeParseWeather "  Dy MxT   MnT   AvT   HDDay  AvDP 1HrP TPcpn WxType PDir AvSp Dir MxS SkyC MxR MnR AvSLP"
      @?= Nothing
  , testCase "Can parse the ninth record of weather.dat (asterisk)" $
    maybeParseWeather "   9  86    32*   59       6  61.5       0.00         240  7.6 220  12  6.0  78 46 1018.6"
      @?= (Just $ Weather 9 86 32)
  , testCase "Can parse the twentysixth record of weather.dat (asterisk)" $
    maybeParseWeather "  26  97*   64    81          70.4       0.00 H       050  5.1 200  12  4.0 107 45 1014.9"
      @?= (Just $ Weather 26 97 64)
  , testCase "Will skip the totals line" $
    maybeParseWeather "  mo  82.9  60.5  71.7    16  58.8       0.00              6.9          5.3"
      @?= Nothing
  , testCase "Can parse the whole file" $
    (head $ parseWeatherData dat) @?= Weather 1 88 59
  ]

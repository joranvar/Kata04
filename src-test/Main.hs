{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.SmallCheck
import Test.SmallCheck.Series

import Control.Arrow ((&&&))
import Data.Function (on)
import Data.List (minimumBy)
import Data.Maybe (catMaybes)

import Lib
instance (Monad m, Enum a, Bounded a) => Serial m a where
  series = generate (\d -> take d [minBound .. maxBound])

main :: IO ()
main = do
  dat <- readFile "data/weather.dat"
  defaultMain $ testGroup "all-tests" $ tests [dat]

tests :: [String] -> [TestTree]
tests dat =
  [ testGroup "SmallCheck" scTests
  , testGroup "Unit tests" $ huTests dat
  ]

scTests :: [TestTree]
scTests =
  [ testProperty "id x == x" $
    \x -> id (x::Int) == x
  ]

huTests :: [String] -> [TestTree]
huTests dat =
  let weatherData = head dat
  in
    [ testCase "Can read first line of record" $
      readWeather "   1  88    59    74          53.8       0.00 F       280  9.6 270  17  1.6  93 23 1004.5"
        @?= Just (Weather 1 88 59)
    , testCase "Can read ninth line of record" $
      readWeather "   9  86    32*   59       6  61.5       0.00         240  7.6 220  12  6.0  78 46 1018.6"
        @?= Just (Weather 9 86 32)
    , testCase "Can solve the kata part one" $
      (day $ fst $ minimumBy (compare `on` snd) $ map ((id &&& spread)) $ catMaybes . map readWeather $ lines weatherData)
        @?= 14
  ]

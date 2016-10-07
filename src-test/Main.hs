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
  weather <- readFile "data/weather.dat"
  football <- readFile "data/football.dat"
  defaultMain $ testGroup "all-tests" $ tests (weather, football)

tests :: (String, String) -> [TestTree]
tests (weather, football) =
  [ testGroup "SmallCheck" scTests
  , testGroup "Unit tests" $ huTests
  , testGroup "Weather unit tests" $ huWeatherTests weather
  , testGroup "Soccer League unit tests" $ huSoccerTests football
  ]

scTests :: [TestTree]
scTests =
  [ testProperty "maybeParse . show (x::Int) -> Just x" $
    \x -> (maybeParse . show) (x::Int) == Just x
  , testProperty "maybeParse . show (x::Int) ++ '*' ++ String -> Just x" $
    \x s -> maybeParse (show (x::Int) ++ ":" ++ s) == Just x
  ]

huTests :: [TestTree]
huTests =
  [ testCase "maybeWord 1 'a b c' == Just b" $
    maybeWord 1 "a b c" @?= Just "b"
  , testCase "maybeWord 1 'abc' == Nothing" $
    maybeWord 1 "abc" @?= Nothing
  ]

huWeatherTests :: String -> [TestTree]
huWeatherTests weather =
  [ testCase "Can parse first record from weather file" $
    (parse $ (lines weather)!!2) @?= Just (Weather 1 88 59)
  , testCase "Can parse whole weather file" $
    length (parseMany weather :: [Weather]) @?= 30
  , testCase "Can solve weather question" $
    minSpreadDay (parseMany weather) @?= 14
  ]

huSoccerTests :: String -> [TestTree]
huSoccerTests soccer =
  [ testCase "Can parse first record from soccer file" $
    (parse $ (lines soccer)!!1) @?= Just (Soccer "Arsenal" 79 36)
  -- , testCase "Can parse whole soccer file" $
  --   length (parseMany soccer :: [Soccer]) @?= 30
  -- , testCase "Can solve soccer question" $
  --   minSpreadDay (parseMany soccer) @?= 14
  ]

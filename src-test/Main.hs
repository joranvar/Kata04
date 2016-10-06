{-# LANGUAGE LambdaCase #-}
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
  weatherDat <- readFile "data/weather.dat"
  footballDat <- readFile "data/football.dat"
  defaultMain $ testGroup "all-tests" $ tests [weatherDat, footballDat]

tests :: [String] -> [TestTree]
tests = \case
  [weather, football] ->
    [ testGroup "SmallCheck" scTests
    , testGroup "Weather unit tests" $ huTests weather
    , testGroup "Football unit tests" $ footballTests football
    ]
  _ -> undefined

scTests :: [TestTree]
scTests =
  [ testProperty "id x == x" $
    \x -> id (x::Int) == x
  ]

huTests :: String -> [TestTree]
huTests weatherDat =
  [ testCase "Can parse first line" $
    parse (head . lines $ weatherDat) @?= Nothing
  , testCase "Can parse first real data line" $
    parse (head . drop 2 . lines $ weatherDat) @?= Just (Weather 1 88 59)
  , testCase "Can parse whole file" $ (length $ parseFile weatherDat) @?= 30
  , testCase "Can answer the question" $ answer4 weatherDat @?= 14
  ]

footballTests :: String -> [TestTree]
footballTests footballDat =
  [ testCase "Can parse first line" $
    parseT (head . lines $ footballDat) @?= Nothing
  , testCase "Can parse first real data line" $
    parseT (head . drop 1 . lines $ footballDat) @?= Just (Team "Arsenal" 79 36)
  , testCase "Can parse whole file" $ (length $ parseFileT footballDat) @?= 20
  ]

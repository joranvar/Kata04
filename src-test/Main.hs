{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.SmallCheck
import Test.SmallCheck.Series

import Record (Record(..))
import Weather (Weather(..), minDayBySpread)
import Soccer (Soccer(..), minTeamByDiffScores)
instance (Monad m, Enum a, Bounded a) => Serial m a where
  series = generate (\d -> take d [minBound .. maxBound])

main :: IO ()
main = do
  weatherDat <- readFile "data/weather.dat"
  footballDat <- readFile "data/football.dat"
  defaultMain $ testGroup "all-tests" $ tests (weatherDat, footballDat)

tests :: (String, String) -> [TestTree]
tests (weatherDat, footballDat) =
  [ testGroup "SmallCheck" scTests
  , testGroup "Weather tests" $ weatherTests weatherDat
  , testGroup "Soccer tests" $ soccerTests footballDat
  ]

scTests :: [TestTree]
scTests =
  [ testProperty "id x == x" $
    \x -> id (x::Int) == x
  ]

weatherTests :: String -> [TestTree]
weatherTests dat =
  let header:emptyline:record1:_rest = lines dat in
  [ testCase "Can parse first record" $
    parse record1 @?= (Just $ Weather 1 88 59)
  , testCase "Will skip header" $
    parse header @?= (Nothing :: Maybe Weather)
  , testCase "Will skip empty line" $
    parse emptyline @?= (Nothing :: Maybe Weather)
  , testCase "Can parse whole file" $
    (length $ (parseFile dat :: [Weather])) @?= 30
  , testCase "Can solve question of part one" $
    (minDayBySpread $ parseFile dat) @?= 14
  ]

soccerTests :: String -> [TestTree]
soccerTests dat =
  let header:record1:_rest = lines dat in
  [ testCase "Can parse first record" $
    parse record1 @?= (Just $ Soccer "Arsenal" 79 36)
  , testCase "Will skip header" $
    parse header @?= (Nothing :: Maybe Soccer)
  , testCase "Can parse whole file" $
    (length $ (parseFile dat :: [Soccer])) @?= 20
  , testCase "Can solve question of part one" $
    (minTeamByDiffScores $ parseFile dat) @?= "Aston_Villa"
  ]

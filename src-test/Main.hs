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

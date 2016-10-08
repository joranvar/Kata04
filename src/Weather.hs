-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
{-# LANGUAGE RecordWildCards #-}

module Weather
  (
    -- * Domain types
    Weather(..)
  , Record(..)
    -- * Functions
  , spread
  ) where

import Record

data Weather = Weather { dy::Int
                       , mxt::Int
                       , mnt::Int
                       , avt::Int
                       , hdday::Maybe Int
                       , avdp::Double
                       , tpcpn::Double
                       , wxtype::String
                       , pdir::Int
                       , avsp::Double
                       , dir::Int
                       , mxs::Int
                       , skyc::Double
                       , mxr::Int
                       , mnr::Int
                       , avslp::Double }
  deriving (Eq, Show)

instance Record Weather where
  parse s = Weather
            <$> (maybeRead $ maybeRange (0,4) s)
            <*> (maybeRead $ maybeRange (4,8) s)
            <*> (maybeRead $ maybeRange (8,14) s)
            <*> (maybeRead $ maybeRange (14,20) s)
            <*> Just Nothing -- (maybeRead $ maybeRange (20,28) s)
            <*> (maybeRead $ maybeRange (28,34) s)
            <*> (maybeRead $ maybeRange (39,45) s)
            <*> (Just $ maybeRange (45,52) s)
            <*> (maybeRead $ maybeRange (52,57) s)
            <*> (maybeRead $ maybeRange (57,62) s)
            <*> (maybeRead $ maybeRange (62,66) s)
            <*> (maybeRead $ maybeRange (66,70) s)
            <*> (maybeRead $ maybeRange (70,75) s)
            <*> (maybeRead $ maybeRange (75,79) s)
            <*> (maybeRead $ maybeRange (79,83) s)
            <*> (maybeRead $ maybeRange (83,89) s)

spread :: Weather -> Int
spread Weather{..} = mxt - mnt

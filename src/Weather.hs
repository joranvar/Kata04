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
            <$> (maybeRead =<< maybeWord 0 s)
            <*> (maybeRead =<< maybeWord 1 s)
            <*> (maybeRead =<< maybeWord 2 s)
            <*> (maybeRead =<< maybeWord 3 s)
            <*> (maybeRead =<< maybeWord 4 s)
            <*> (maybeRead =<< maybeWord 5 s)
            <*> (maybeWord 6 s)
            <*> (maybeRead =<< maybeWord 7 s)
            <*> (maybeRead =<< maybeWord 8 s)
            <*> (maybeRead =<< maybeWord 9 s)
            <*> (maybeRead =<< maybeWord 10 s)
            <*> (maybeRead =<< maybeWord 11 s)
            <*> (maybeRead =<< maybeWord 12 s)
            <*> (maybeRead =<< maybeWord 13 s)
            <*> (maybeRead =<< maybeWord 14 s)

spread :: Weather -> Int
spread Weather{..} = mxt - mnt

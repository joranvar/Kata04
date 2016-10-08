-- | Kata04 - http://codekata.com/kata/kata04-data-munging/
module Weather
  (
    -- * Domain types
    Weather(..)
  ) where

data Weather = Weather { dy::Int
                       , mxt::Int
                       , avt::Int
                       , hdday::Int
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

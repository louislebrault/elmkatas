module Main exposing (..)

calculateString str = if str == "" then 0 else Maybe.withDefault 0 (String.toInt str)

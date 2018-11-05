module Main exposing (..)

zeroOr = Maybe.withDefault 0

normalizeOperators : String -> String
normalizeOperators = String.replace "\n" ","

mapStringToInt : String -> Int
mapStringToInt x = zeroOr (String.toInt x)

splitOnComma = String.split(",")

calculateString : String -> Result String Int
calculateString str =
  if str == "" then Ok 0
  else if String.length str == 1 then Ok (zeroOr (String.toInt str))
  else Ok (List.foldr
  (\x a -> x + a)
  0
  (List.map mapStringToInt (splitOnComma (normalizeOperators str))))

-- https://guide.elm-lang.org/v/a4b34b537117aa92fd8eba28cbdb3c93454f28db/error_handling/

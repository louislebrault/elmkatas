module Main exposing (..)

zeroOr = Maybe.withDefault 0

normalizeOperators : String -> String
normalizeOperators = String.replace "\n" ","

mapStringToInt : String -> Int
mapStringToInt x = zeroOr (String.toInt x)

splitOnComma = String.split(",")

calculateString : String -> Int
calculateString str =
  if str == "" then 0
  else if String.length str == 1 then zeroOr (String.toInt str)
  else List.foldr
  (\x a -> x + a)
  0
  (List.map mapStringToInt (splitOnComma (normalizeOperators str)))


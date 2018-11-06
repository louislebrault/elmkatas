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
  else if String.contains "-" str then Err "Negative numbers are not supported."
  else Ok (List.foldr
  (\x a -> if x <= 1000 then x + a else a)
  0
  (List.map mapStringToInt (splitOnComma (normalizeOperators str))))

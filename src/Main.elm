module Main exposing (..)

calculateString : String -> Int
calculateString str =
  if str == "" then 0
  else if String.length str == 1 then Maybe.withDefault 0 (String.toInt str)
  else List.foldr
  (\x a -> x + a)
  0
  (List.map (\x -> Maybe.withDefault 0 (String.toInt x)) (String.split "," str))

splitStringOnComma : String -> List String
splitStringOnComma str = String.split "," str

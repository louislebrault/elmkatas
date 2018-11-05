module MainTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Main exposing (calculateString)

-- An empty string returns zero
-- A single number returns the value
-- Two numbers, comma delimited, returns the sum
-- Two numbers, newline delimited, returns the sum
-- Three numbers, delimited either way, returns the sum
-- Negative numbers throw an exception
-- Numbers greater than 1000 are ignored
-- A single char delimiter can be defined on the first line (e.g. //# for a ‘#’ as the delimiter)
-- A multi char delimiter can be defined on the first line (e.g. //[###] for ‘###’ as the delimiter)

suite : Test
suite =
    describe "The String Calculator"
        [ test "An empty string returns zero" <|
            \_ -> Expect.equal (Ok 0) (calculateString "")

        , test "A single number returns the value" <|
            \_ ->
                Expect.equal (Ok 3) (calculateString "3")

        , test "Two numbers, comma delimited, returns the sum" <|
            \_ -> Expect.equal (Ok 9) (calculateString "3,6")

        , test "Two numbers, newline delimited, returns the sum" <|
            \_ -> Expect.equal (Ok 12) (calculateString "5\n7")

        , test "Three numbers, delimited either way, returns the sum" <|
            \_ -> Expect.equal (Ok 32) (calculateString "4\n20,8")

        , test "Negative numbers throw an exception" <|
            \_ -> Expect.err (calculateString "-2")
        ]



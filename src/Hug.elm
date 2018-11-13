import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

-- Next : Display a random message, changing on click

-- MAIN
main = Browser.sandbox { init = init, update = update, view = view }

-- MODEL
type alias Model = String

init : Model
init = "(>'.')>"

-- UPDATE

type Msg = Dance

update : Msg -> Model -> Model
update msg model =
  case msg of
    Dance ->
      if model == "(>'.')>" then "<('.'<)" else "(>'.')>"

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Dance ] [ text "Make meh dance <3" ]
    , div [] [ text model ]
    ]

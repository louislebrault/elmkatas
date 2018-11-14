import Array
import Random
import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)


-- Next : Display a random message, changing on click

messageList = Array.fromList ["cc", "tavu", "sposé", "Lorem ipsum.", "booh"]
-- randomMessage = Array.get (Random.generate (Random.int 0 (List.length messageList))) messageList

-- MAIN
main = Browser.sandbox { init = init, update = update, view = view }

-- MODEL
type alias Model =
  {
  kirby: String,
  message: String
  }

init : Model
init = { kirby = "(>'.')>", message = randomMessage }

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

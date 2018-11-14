import Array
import Random
import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)


-- Next : Display a random message, changing on click

-- MAIN
main = Browser.sandbox { init = init, update = update, view = view }

-- MODEL
type alias Model =
  {
  kirby: String,
  message: String
  }

init : Model
init = { kirby = "(>'.')>", message = "" }

-- UPDATE
messageList = Array.fromList ["cc", "tavu", "sposé", "Lorem ipsum.", "booh"]

randomIndex = Random.generate getMessageByIndex (Random.int 0 2)

getMessageByIndex : Int -> String
getMessageByIndex idx = Maybe.withDefault "Moga" (Array.get idx messageList)
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

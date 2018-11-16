import Array
import Random
import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

-- Next : Do something with subscriptions

-- MAIN
main = Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

-- MODEL
type alias Model =
  {
  kirby: String,
  message: String
  }

init : () -> (Model, Cmd Msg)
init _ =
  ( Model "(>'.')>" ""
  , Cmd.none
  )

-- UPDATE
type Msg
  = Dance
  | RandomIndex Int

messageList = Array.fromList ["cc", "tavu", "sposé", "Calin.", "booh"]

getMessageByIndex : Int -> String
getMessageByIndex idx = Maybe.withDefault "Moga" (Array.get idx messageList)

generateRandomInt : Cmd Msg
generateRandomInt = Random.generate RandomIndex (Random.int 0 (Array.length messageList))

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Dance ->
      if model.kirby == "(>'.')>"
      then ( {kirby = "<('.'<)", message = model.message }, generateRandomInt)
      else ( {kirby = "(>'.')>", message = model.message }, generateRandomInt)

    RandomIndex idx ->
      ( {kirby = model.kirby, message = getMessageByIndex idx }, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Dance ] [ text "Make meh dance <3" ]
    , div [] [ text model.kirby ]
    , div [] [ text model.message ]
    ]

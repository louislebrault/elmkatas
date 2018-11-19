import Array
import Random
import Browser
import Browser.Events as Events
import Json.Decode as Decode
import Platform.Sub as Sub
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

-- Next : A chaque fois qu'on appuie sur espace, changer la couleur de la page
-- Comment definir quelle touche a été pressée : https://github.com/elm/browser/blob/1.0.0/notes/keyboard.md

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
  | KeyMsg

messageList = Array.fromList ["cc", "tavu", "sposé", "Calin.", "booh"]

getMessageByIndex : Int -> String
getMessageByIndex idx = Maybe.withDefault "Moga" (Array.get idx messageList)

generateRandomInt : Cmd Msg
generateRandomInt = Random.generate RandomIndex (Random.int 0 (Array.length messageList))

type Key
  = Character Char
  | Control String

keyDecoder : Decode.Decoder Msg
keyDecoder =
  Decode.map toKey (Decode.field "key" Decode.string)

toKey : String -> Key
toKey string =
  case String.uncons string of
    Just (char, "") ->
      Character char

    _ ->
      Control string

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Dance ->
      if model.kirby == "(>'.')>"
      then ( { kirby = "<('.'<)", message = model.message }, generateRandomInt)
      else ( { kirby = "(>'.')>", message = model.message }, generateRandomInt)

    RandomIndex idx ->
      ( { kirby = model.kirby, message = getMessageByIndex idx }, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ Events.onKeyDown keyDecoder ]

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Dance ] [ text "Make meh dance <3" ]
    , div [] [ text model.kirby ]
    , div [] [ text model.message ]
    ]

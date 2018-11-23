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
-- D'abord changer background color sur n'importe quel keydown
-- Puis ensuite n'écouter qu'espace
-- Comment faire pour me servir de ma methode generateRandomInt pour generer soit une couleur random soit un index random ?

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
  message: String,
  bgColor: String
  }

init : () -> (Model, Cmd Msg)
init _ =
  ( Model "(>'.')>" "" ""
  , Cmd.none
  )

-- UPDATE
type Msg
  = Dance
  | RandomIndex Int
  | KeyMsg

messageList = Array.fromList ["cc", "tavu", "sposé", "sandun", "booh"]
colorList = Array.fromList ["green", "pink", "red", "yellow", "gray", "orange", "lightblue"]

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

toKey : String -> Msg
toKey string =
  case String.uncons string of
    Just (char, "") ->
      KeyMsg

    _ ->
      KeyMsg

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Dance ->
      if model.kirby == "(>'.')>"
      then ( { kirby = "<('.'<)", message = model.message, bgColor = model.bgColor }, generateRandomInt)
      else ( { kirby = "(>'.')>", message = model.message, bgColor = model.bgColor }, generateRandomInt)

    RandomIndex idx ->
      ( { kirby = model.kirby, message = getMessageByIndex idx, bgColor = model.bgColor }, Cmd.none)

    KeyMsg ->
      ( { kirby = model.kirby, message = model.message, bgColor = "green" }, Cmd.none )

-- SUBSCRIPTIONS

subscriptions model =
  Sub.batch
    [ Events.onKeyDown keyDecoder ]

-- VIEW

view : Model -> Html Msg
view model =
  div [
      style "background-color" model.bgColor,
      style "height"  "100vh"
    ]
    [ button [ onClick Dance ] [ text "Make meh dance <3" ]
    , div [] [ text model.kirby ]
    , div [] [ text model.message ]
    ]

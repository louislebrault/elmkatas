import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Random



-- MAIN


main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }



-- MODEL

type alias Model =
  { dieFace : Int
  }

init : () -> (Model, Cmd Msg)
init _ =
  ( Model 1
  , Cmd.none
  )

-- UPDATE

-- Ca veut dire quoi ces opérateurs = et | ?
type Msg
  = Roll
  | NewFace Int

-- Cmd c'est pour gérer les side effects, apparemment généré un chiffre random c'est considéré comme un
-- side effect
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
  -- Cette syntaxe avec les parenthèses, ca représente un Tupple. C'est une data stucture qui permet
  -- de retourner plusieurs valeurs.
    Roll ->
      ( model
      , Random.generate NewFace (Random.int 1 6)
      )

    NewFace newFace ->
      ( Model newFace
      , Cmd.none
      )

-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text (String.fromInt model.dieFace) ]
    , button [ onClick Roll ] [ text "Roll" ]
    ]

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Random



main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { dieFace : Int,
    dieFace2 : Int
  }


init : (Model, Cmd Msg)
init =
  (Model 1 1, Cmd.none)



-- UPDATE


type Msg
  = Roll
  | NewFace (Int, Int)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace (Random.pair (Random.int 1 6) (Random.int 1 6)))

    NewFace (newFace, newFace2) ->
      (Model newFace newFace2, Cmd.none)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ div [style [("float", "left")]]
      [ h1 [] [ text (toString model.dieFace) ]
      , img [src ("http://www.wpclipart.com/recreation/games/dice/die_face_" ++ (toString model.dieFace) ++ ".png")] []
      ]
    , div [style [("float", "left")]]
      [ h1 [] [ text (toString model.dieFace2) ]
      , img [src ("http://www.wpclipart.com/recreation/games/dice/die_face_" ++ (toString model.dieFace2) ++ ".png")] []
      ]
    , div [style [("clear", "left")]]
      [ button [ onClick Roll] [ text "Roll" ] ]
    ]

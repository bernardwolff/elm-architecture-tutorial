import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Regex exposing (contains, regex)

main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  }


model : Model
model =
  Model "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ input [ type_ "text", placeholder "Name", onInput Name ] []
    , input [ type_ "text", placeholder "Password", onInput Password ] []
    , input [ type_ "text", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , viewValidation model
    ]

allRegexesMatch value regexes =
  List.foldr (&&) True (List.map (\a -> contains (regex a) value == True) regexes)

viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if model.password == model.passwordAgain then
        if (String.length model.password) > 2 then
          if allRegexesMatch model.password ["[a-z]", "[A-Z]", "[0-9]"] then
            ("green", "OK")
          else
            ("red", "Password does not contain regex.")
        else
          ("red", "Password is less than 3 characters.")
      else
        ("red", "Passwords do not match!")
  in
    div [ style [("color", color)] ] [ text message ]

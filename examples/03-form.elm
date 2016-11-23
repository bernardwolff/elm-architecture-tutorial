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
  , age : String
  }


model : Model
model =
  Model "" "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }

    Age age ->
      { model | age = age }


-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ input [ type_ "text", placeholder "Name", onInput Name ] []
    , input [ type_ "text", placeholder "Password", onInput Password ] []
    , input [ type_ "text", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , input [ type_ "text", placeholder "Age", onInput Age ] []
    , viewValidation model
    ]

allRegexesMatch value regexes =
  if List.foldr (&&) True (List.map (\a -> contains (regex a) value) regexes) then
    ""
  else
    "Password does not meet requirements"

lengthValidation value minLength =
  if String.length value > minLength then
    ""
  else
    "Password must be greater than " ++ (toString minLength) ++ " characters"

valuesMatch password1 password2 =
  if password1 == password2 then
    ""
  else
    "Passwords do not match"

ageIsNumber age =
  if contains (regex "^[0-9]+$") age then
    ""
  else
    "Age is not a number"

doValidation password1 password2 age =
  String.join ", " (List.filter (\a -> (String.length a > 0))
    [ valuesMatch password1 password2
    , lengthValidation password1 8
    ,  allRegexesMatch password1 ["[a-z]", "[A-Z]", "[0-9]"]
    ,  ageIsNumber age])

viewValidation : Model -> Html msg
viewValidation model =
  let
      message =
        doValidation model.password model.passwordAgain model.age
      (color, actualMessage) =
        if String.length message > 0 then
          ("red", message)
        else
          ("green", "OK")
  in
    div [ style [("color", color)] ] [ text actualMessage ]

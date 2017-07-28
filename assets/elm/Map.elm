import Html exposing (..)

main = 
  Html.beginnerProgram
  { model = model
  , view = view
  , update = update
  }

-- MODEL
type alias Model = String

model : Model
model =
  "Hello"

-- UPDATE
type Msg
  = Update String

update : Msg -> Model -> Model
update msg model = 
  case msg of
    Update newStr -> 
      newStr

-- VIEW
view : Model -> Html Msg
view model = 
  div [] 
    [
      Html.text model
    ]


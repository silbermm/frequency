import Html exposing (..)
import Http exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode
import Frequency.Ports exposing (..)
import Frequency.Common exposing (..)
import Jwt exposing (..)
import Html.Events exposing (onClick)

main =
  Html.programWithFlags
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

-- MODEL
type alias Model = 
  { jwt : String
  }

type alias Flags =
  { jwt : String
  }

model : Model
model =
  { jwt = ""
  }

-- UPDATE
type Msg =
  Update

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Update -> (model, Cmd.none)

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [
       Html.text model.jwt
    ]

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

-- INIT
init : Flags -> ( Model, Cmd Msg )
init flags =
    (Model flags.jwt, Cmd.none)

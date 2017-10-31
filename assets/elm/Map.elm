import Html exposing (..)
import Html.Attributes exposing (..)
import Frequency.Ports exposing (..)

main =
  Html.program
  { init = init
  , update = update
  , view = view
  , subscriptions = subscriptions
  }

-- MODEL
type alias Model =
  { latitude : Float
  , longitude : Float
  }

model : Model
model =
  { latitude = 0.0
  , longitude = 0.0
  }

-- UPDATE
type Msg
  = Location {latitude : Float, longitude : Float}

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Location rec ->
      ( {model | latitude = rec.latitude, longitude = rec.longitude }, Cmd.none )

-- VIEW
view : Model -> Html Msg
view model =
  node "good-map"
    [ attribute "api-key" "AIzaSyDtWv0jHYZRDOidnfsLndKUsezu7OrXrXU"
    , attribute "latitude" (toString model.latitude)
    , attribute "longitude" (toString model.longitude)
    , attribute "zoom" "10"
    ]
    []

init : (Model, Cmd Msg)
init =
    (Model 0.0 0.0, Frequency.Ports.queryLocation(""))

subscriptions : Model -> Sub Msg
subscriptions model =
  locationResult Location

import Html exposing (..)
import Html.Attributes exposing (..)
import Http exposing (..)
import Task
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode
import Geolocation exposing (Location, Error(..))
import Jwt exposing (..)
import Html.Events exposing (onClick)

main =
  Html.programWithFlags
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

type alias Logo =
  { rel : String
  , href : String
  , content_type : String
  }

type alias Station =
  { stream : String
  , id : String
  , frequency : String
  , band : String
  , call_letters : String
  , logo : Logo
  }

-- MODEL
type alias Model =
  { jwt : String
  , longitude : Float
  , latitude : Float
  , error : String
  , stations : List Station
  }

type alias Flags =
  { jwt : String
  }

model : Model
model =
  { jwt = ""
  , longitude = 0.0
  , latitude = 0.0
  , error = ""
  , stations = []
  }

-- UPDATE
type Msg =
  Update
  | Geolocation Location
  | InitGeolocation (Result Geolocation.Error Location)
  | StationResult (Result Http.Error (List Station))

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Update -> (model, Cmd.none)

    StationResult (Ok stations) ->
      ({model | stations = stations}, Cmd.none)

    StationResult (Err error) ->
      ({model | error = matchHttpError(error)}, Cmd.none)

    InitGeolocation result ->
      case result of
        Err error ->
          ({model | error = matchGeolocationError(error)}, Cmd.none)

        Ok location ->
          ({model | latitude = location.latitude, longitude = location.longitude}, Cmd.none)

    Geolocation { latitude, longitude} ->
        ({ model | latitude = latitude, longitude = longitude }, getStations model)

-- VIEW
view : Model -> Html Msg
view model =
  div [ class "container" ]
  [
    div [ class "row" ] []
  , div [ class "row" ]
      [
        div [ class "col-md-9" ]
        [
          h3 [ style [("color", "white")] ] 
            [
              text(toString(List.length(model.stations)) ++ " ")
            , small [] [ text "NPR stations near you" ]
            ]
        ]
      ]
  , div [ ] (List.map renderStation model.stations)
  ]

renderStation station =
  div [ class "media" ]
   [
    div [ class "media-left" ]
      [
        div [ class "media-object" ] [ text(station.frequency ++ " " ++ station.band) ]
      ]
    , div [ class "media-body" ]
      [
        h4 [ class "media-heading" ] [ text station.call_letters ]
      , p [] [ text "Listen to the station" ]
      ]
   ]

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = 
  Sub.batch
      [ Geolocation.changes Geolocation ]

-- INIT
init : Flags -> ( Model, Cmd Msg )
init flags =
  (Model flags.jwt 0.0 0.0 "" [], Task.attempt InitGeolocation Geolocation.now)

matchGeolocationError : Geolocation.Error -> String
matchGeolocationError error =
  case error of
    PermissionDenied error_ ->
      "Permission denied " ++ error_

    LocationUnavailable error_ ->
      "Location unavailable " ++ error_

    Geolocation.Timeout error_ ->
      "Timeout " ++ error_

matchHttpError : Http.Error -> String
matchHttpError error = 
  case error of
    BadUrl error_ ->
      "Bad Url " ++ error_
    Http.Timeout ->
      "Timed out"
    NetworkError ->
      "Network error"
    BadStatus (response) ->
      "Got a bad status code "
    BadPayload error_ (response) ->
      "Something else happened " ++ error_


getStations : Model -> Cmd Msg
getStations model = 
  let
      url = "/api/stations?lat=" ++ toString model.latitude ++ "&long=" ++ toString model.longitude
      request = Http.get url stationListDecoder
  in
     Http.send StationResult request

stationDecoder : Decoder Station
stationDecoder =
  Decode.map6 Station
    (field "id" string)
    (field "stream" string)
    (field "frequency" string)
    (field "band" string)
    (field "call_letters" string)
    (field "logo" logoDecoder)

logoDecoder : Decoder Logo
logoDecoder =
  Decode.map3 Logo
    (field "rel" string)
    (field "href" string)
    (field "content-type" string)

stationListDecoder : Decoder (List Station)
stationListDecoder =
  Decode.list stationDecoder

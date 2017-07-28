import Html exposing (..)
import Http exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode
import Frequency.Ports exposing (..)
import Frequency.Common exposing (..)
import Jwt exposing (..)
import Html.Events exposing (onClick)


main = 
  Html.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }


-- MODEL
type alias Model = 
  { username : String
  , user : Maybe User
  , storageResult : String
  }

model : Model
model =
  { username = ""
  , user = Nothing
  , storageResult = ""
  }

-- UPDATE
type Msg
  = JwtValidResult (Result JwtError User)
  | StorageResult (String)
  | Logout
  | LogoutResponse (Result JwtError String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
  case msg of
    JwtValidResult (Ok res) ->
      ({ model | username = res.username, user = Just(res) }, Cmd.none )
    JwtValidResult (Err err) ->
      ( model, Cmd.none )
    StorageResult (val) ->
      ({ model | storageResult = val }, getJwtValid val JwtValidResult )
    Logout ->
      ( model, deleteToken model.storageResult )
    LogoutResponse (Ok res) ->
      ({ model | username = "", user = Nothing }, Frequency.Ports.removeFromStorage "jwt" )
    LogoutResponse (Err res) ->
      ( model, Cmd.none)

-- VIEW
view : Model -> Html Msg
view model = 
  case model.user of
    Nothing -> 
      div [] 
        [
           Html.text "Hello not logged in user..."
        ]
    Just user ->
      div []
      [
        span [] [ text ("Welcome " ++ user.first_name ++ " " ++ user.last_name) ]
      , button [ onClick Logout ] [ text "Logout" ]
      ]

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    storageResult  StorageResult

-- INIT
init : (Model, Cmd Msg)
init =
    (Model "" Nothing "", Frequency.Ports.queryStorage("jwt"))

deleteToken : String -> Cmd Msg
deleteToken jwt = 
  let
    url = "/api/token"
  in
    Jwt.delete jwt url decodeValidJwtDelete 
        |> Jwt.sendCheckExpired jwt LogoutResponse



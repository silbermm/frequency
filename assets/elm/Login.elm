import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Http exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode
import Frequency.Ports exposing (..)
import Jwt exposing (..)
import Frequency.Common exposing (..)
import Debug

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
  , password : String
  , user: Maybe User
  , storageResult: String
  , validJwtError: String
  }

model : Model
model =
  { username = ""
  , password = ""
  , user = Nothing
  , storageResult = ""
  , validJwtError = ""
  }

-- UPDATE
type Msg = Login
        | ChangeUsername String
        | ChangePassword String
        | LoginResult (Result Http.Error String)
        | JwtValidResult (Result JwtError User)
        | StorageResult (String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ChangeUsername newusername ->
       ({ model | username = newusername }, Cmd.none)
    ChangePassword newpassword ->
       ({ model | password = newpassword }, Cmd.none)
    Login ->
      ( model, postLogin model )
    LoginResult (Ok jwt) ->
      ({ model | storageResult = jwt, password = "", username = ""}, Frequency.Ports.addToStorage { jwt = jwt })
    LoginResult (Err _) ->
      ( model, Cmd.none )
    JwtValidResult (Ok res) ->
      ({ model | username = res.username, user = Just(res) }, Frequency.Ports.navigateTo "/" )
    JwtValidResult (Err err) ->
      ({ model | validJwtError = "Unable to find a valid user!" }, Cmd.none )
    StorageResult (val) ->
      -- runs when we query for the jwt and we get a result back
      ({ model | storageResult = val }, getJwtValid val JwtValidResult )

-- VIEW
view : Model -> Html Msg
view model =
    case model.user of
      Nothing ->
        -- show the login form
        div [ class "container"]
          [
            div [ class "onl_login" ]
              [
                h3 [ class "onl_authTitle" ]
                  [
                    text "Login Or " , a [ href "/register" ] [ text "Register" ] 
                  ]
              , div [ class "row onl_row-sm-offset-3 onl_socialButtons" ]
                  [
                    div [ class "col-xs-2 col-sm-2" ]
                      [
                        a [
                            href "/auth/google"
                          , class "btn btn-lg btn-block onl_btn-google-plus"
                          , title "Google" 
                          ]
                          [
                            i [ class "fa fa-google fa-2x" ] []
                          , span [ class "hidden-xs" ] []
                          ]
                      ]
                  ]
              , div [ class "row onl_row-sm-offset-3 onl_loginOr" ]
                  [
                    div [ class "col-xs-12 col-sm-6" ]
                      [
                        hr [ class "onl_hrOr" ] []
                      , span [ class "onl_spanOr" ] [ text "or" ]
                      ]
                  ]
              , div [ class "row onl_row-sm-offset-3" ] 
                  [
                    div [ class "col-xs-12 col-sm-6" ]
                      [
                        Html.form [ class "onl_loginForm" ]
                          [
                            div [ class "input-group" ] 
                              [
                                span [ class "input-group-addon" ] [ span [ class "glyphicon glyphicon-user" ] [] ]
                              , input [ placeholder "Username", class "form-control", onInput ChangeUsername, Html.Attributes.value model.username ] []
                              ]
                          , span [ class "help-block" ] [ text "Error message here" ]
                          , div [ class "input-group" ] 
                              [
                                span [ class "input-group-addon" ] [ span [ class "glyphicon glyphicon-lock" ] [] ]
                              , input [ placeholder "Password", class "form-control", type_ "password", onInput ChangePassword ] []
                              ]
                          , span [ class "help-block" ] [ text "Password Errorm message here" ]
                          , button [ class "btn btn-lg btn-primary btn-block", type_ "submit",  onClick Login ] 
                            [
                              i [ class "fa fa-sign-in" ] []
                            , text " Login"
                            ]
                          ]
                      ]
                  ]
              ]
          ]
      Just user ->
        -- show the logged in user info
        div []
          [
            span [] [ text ("Welcome " ++ user.first_name ++ " " ++ user.last_name) ]
          ]

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    storageResult  StorageResult

-- INIT
init : (Model, Cmd Msg)
init =
    (Model "" "" Nothing "" "", Frequency.Ports.queryStorage("jwt"))

postLogin : Model -> Cmd Msg
postLogin model =
  let
    url = "/api/token"
    body =
      model
         |> loginEncoded
         |> Http.jsonBody
    request = Http.post url body decodeLoginUrl
  in
     Http.send LoginResult request

decodeLoginUrl : Decode.Decoder String
decodeLoginUrl =
  Decode.at ["jwt"] Decode.string

loginEncoded : Model -> Encode.Value
loginEncoded data =
    let
        list =
            [ ( "username", Encode.string data.username )
            , ( "password", Encode.string data.password )
            ]
    in
        list
            |> Encode.object


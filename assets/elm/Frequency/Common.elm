module Frequency.Common exposing (..)

import Jwt exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode

type alias User = { username : String, email : String, id : Int, first_name : String, last_name : String }

getJwtValid : String -> (Result JwtError User -> msg) -> Cmd msg
getJwtValid jwt thing =
  let
    url = "/api/token"
    request = Jwt.get jwt url decodeValidJwtResult
  in
   Jwt.send thing request


decodeValidJwtResult : Decode.Decoder User
decodeValidJwtResult =
  -- Decode.at ["username", "id", "first_name", "last_name", "email"] Decode.string
  map5 User (field "username" string)
            (field "email" string)
            (field "id" int)
            (field "first_name" string)
            (field "last_name" string)

decodeValidJwtDelete : Decode.Decoder String
decodeValidJwtDelete = 
  Decode.at ["result"] Decode.string

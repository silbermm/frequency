port module Frequency.Ports exposing (..)

port storageResult : (String -> msg) -> Sub msg

port locationResult : ({latitude : Float, longitude : Float} ->  msg) -> Sub msg

port addToStorage: {jwt : String} -> Cmd msg

port removeFromStorage: String -> Cmd msg

port queryStorage: String -> Cmd msg

port queryLocation: String -> Cmd msg

port navigateTo: String -> Cmd msg

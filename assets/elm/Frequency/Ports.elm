port module Frequency.Ports exposing (..)

port storageResult : (String -> msg) -> Sub msg

port addToStorage: {jwt : String} -> Cmd msg

port removeFromStorage: String -> Cmd msg

port queryStorage: String -> Cmd msg

port navigateTo: String -> Cmd msg

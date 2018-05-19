module Main exposing (..)

---- ELM ----

import Html exposing (Html)
import Http
import RemoteData exposing (WebData)


---- OWN ----

import Commands exposing (fetchRandomQuestion)
import Types exposing (Msg(..), Model, initialModel)
import Update exposing (update)
import View exposing (view)


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.batch [ fetchRandomQuestion ] )


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }

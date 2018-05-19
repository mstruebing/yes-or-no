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


init : Maybe String -> ( Model, Cmd Msg )
init maybeUserHash =
    case maybeUserHash of
        Just userHash ->
            ( { initialModel | userHash = userHash }
            , Cmd.batch [ fetchRandomQuestion ]
            )

        Nothing ->
            ( initialModel
            , Cmd.batch [ fetchRandomQuestion ]
            )


main : Program (Maybe String) Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }

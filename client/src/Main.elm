module Main exposing (..)

import Commands exposing (fetchCount, fetchRandomQuestion)
import Html exposing (Html)
import Http
import RemoteData exposing (WebData)
import Types exposing (Model, Msg(..), initialModel)
import Update exposing (update)
import View exposing (view)


init : Maybe String -> ( Model, Cmd Msg )
init maybeUserHash =
    case maybeUserHash of
        Just userHash ->
            ( { initialModel | userHash = userHash }
            , Cmd.batch [ fetchRandomQuestion userHash, fetchCount ]
            )

        Nothing ->
            ( initialModel
            , Cmd.none
            )


main : Program (Maybe String) Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }

module Main exposing (..)

---- ELM ----

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Http
import RemoteData exposing (WebData)


---- OWN ----

import Lib.Question exposing (Question, randomQuestionsUrl, questionDecoder, emptyQuestion)
import Types exposing (Msg(..), Model, initialModel)
import Update exposing (update)
import View exposing (view)


fetchRandomQuestion : Cmd Msg
fetchRandomQuestion =
    Http.get randomQuestionsUrl questionDecoder
        |> RemoteData.sendRequest
        |> Cmd.map OnFetchRandomQuestion


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

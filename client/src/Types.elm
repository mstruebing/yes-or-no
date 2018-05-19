module Types exposing (..)

---- ELM ----

import Http
import RemoteData exposing (WebData)


---- OWN ----

import Lib.Question exposing (Question)


type alias Model =
    { question : WebData Question
    }


initialModel : Model
initialModel =
    { question = RemoteData.Loading }


type Msg
    = NoOp
    | OnFetchRandomQuestion (WebData Question)

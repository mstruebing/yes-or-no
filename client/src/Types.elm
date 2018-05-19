module Types exposing (..)

---- ELM ----

import RemoteData exposing (WebData)
import Http


---- OWN ----

import Lib.Question exposing (Question, Answer)


type alias Model =
    { question : WebData Question
    , userHash : String
    }


initialModel : Model
initialModel =
    { question = RemoteData.Loading
    , userHash = ""
    }


type Msg
    = NoOp
    | OnFetchRandomQuestion (WebData Question)
    | OnAnswerQuestion (Result Http.Error Question)
    | AnswerQuestion Int Int

module Types exposing (..)

---- ELM ----
---- OWN ----

import Http
import Lib.Question exposing (Answer, Question, Statistics, emptyStatistic)
import RemoteData exposing (WebData)


type alias Model =
    { question : WebData Question
    , statistics : WebData Statistics
    , userHash : String
    , answered : Int
    }


initialModel : Model
initialModel =
    { question = RemoteData.Loading
    , userHash = ""
    , statistics = RemoteData.Loading
    , answered = 0
    }


type Msg
    = NoOp
    | OnFetchRandomQuestion (WebData Question)
    | OnAnswerQuestion (Result Http.Error Question)
    | AnswerQuestion Int Int
    | OnFetchStatistics (WebData Statistics)
    | FetchRandomQuestion

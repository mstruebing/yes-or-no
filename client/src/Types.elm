module Types exposing (..)

import Http
import Lib.Question exposing (Answer, Count, Question, Statistics, emptyQuestion, emptyStatistic)
import RemoteData exposing (WebData)


type alias Model =
    { question : WebData Question
    , statistics : WebData Statistics
    , userHash : String
    , answered : Int
    , count : WebData Count
    , newQuestion : Question
    , message : String
    }


initialModel : Model
initialModel =
    { question = RemoteData.Loading
    , userHash = ""
    , statistics = RemoteData.Loading
    , answered = 0
    , count = RemoteData.Loading
    , newQuestion = emptyQuestion
    , message = ""
    }


type Msg
    = NoOp
    | OnFetchRandomQuestion (WebData Question)
    | OnAnswerQuestion (Result Http.Error Question)
    | AnswerQuestion Int Int
    | OnFetchStatistics (WebData Statistics)
    | OnFetchCount (WebData Count)
    | FetchRandomQuestion
    | OnUpdateNewQuestionOptionOne String
    | OnUpdateNewQuestionOptionTwo String
    | AddNewQuestion
    | OnAddNewQuestion (Result Http.Error Question)

module Commands exposing (..)

import Http
import Lib.Question
    exposing
        ( Answer
        , Question
        , Statistics
        , answerEncoder
        , answerQuestionsUrl
        , emptyQuestion
        , questionDecoder
        , randomQuestionsUrl
        , statisticsDecoder
        , statisticsUrl
        )
import RemoteData
import Types exposing (Msg(..))


fetchRandomQuestion : String -> Cmd Msg
fetchRandomQuestion userHash =
    Http.get (String.append "/" userHash |> String.append randomQuestionsUrl) questionDecoder
        |> RemoteData.sendRequest
        |> Cmd.map OnFetchRandomQuestion


fetchStatistics : Int -> String -> Cmd Msg
fetchStatistics questionId userHash =
    Http.get
        (String.append "/" userHash
            |> String.append (toString questionId)
            |> String.append "/"
            |> String.append statisticsUrl
        )
        statisticsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map OnFetchStatistics


answerQuestion : Answer -> String -> Cmd Msg
answerQuestion answer userHash =
    answerQuestionRequest answer userHash
        |> Http.send OnAnswerQuestion


answerQuestionRequest : Answer -> String -> Http.Request Question
answerQuestionRequest answer userHash =
    Http.request
        { body = answerEncoder answer userHash |> Http.jsonBody
        , expect = Http.expectJson questionDecoder
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = answerQuestionsUrl
        , withCredentials = True
        }

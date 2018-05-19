module Commands exposing (..)

import RemoteData
import Http
import Lib.Question exposing (Question, Answer, randomQuestionsUrl, answerQuestionsUrl, questionDecoder, answerEncoder, emptyQuestion)
import Types exposing (Msg(..))


fetchRandomQuestion : Cmd Msg
fetchRandomQuestion =
    Http.get randomQuestionsUrl questionDecoder
        |> RemoteData.sendRequest
        |> Cmd.map OnFetchRandomQuestion


answerQuestion : Answer -> Cmd Msg
answerQuestion answer =
    answerQuestionRequest answer
        |> Http.send OnAnswerQuestion


answerQuestionRequest : Answer -> Http.Request Question
answerQuestionRequest answer =
    Http.request
        { body = answerEncoder answer |> Http.jsonBody
        , expect = Http.expectJson questionDecoder
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = answerQuestionsUrl
        , withCredentials = True
        }

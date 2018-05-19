module Commands exposing (..)

import RemoteData
import Http
import Lib.Question exposing (Question, Answer, randomQuestionsUrl, answerQuestionsUrl, questionDecoder, answerEncoder, emptyQuestion)
import Types exposing (Msg(..))


fetchRandomQuestion : String -> Cmd Msg
fetchRandomQuestion userHash =
    Http.get (String.append "/" userHash |> String.append randomQuestionsUrl) questionDecoder
        |> RemoteData.sendRequest
        |> Cmd.map OnFetchRandomQuestion


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

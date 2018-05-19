module View exposing (view)

---- ELM -----

import Html exposing (Html, div, text, p)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import RemoteData exposing (WebData)


---- OWN ----

import Types exposing (Model, Msg(..))
import Lib.Question exposing (Question)


view : Model -> Html Msg
view model =
    div [ class "app" ]
        [ printQuestion model.question ]


printQuestion : WebData Question -> Html Msg
printQuestion maybeQuestion =
    case maybeQuestion of
        RemoteData.Success question ->
            div [ class "question" ]
                [ p [ class "option", AnswerQuestion question.id 1 |> onClick ]
                    [ text question.option1 ]
                , p [ class "seperator" ]
                    [ text "or" ]
                , p
                    [ class "option", AnswerQuestion question.id 2 |> onClick ]
                    [ text question.option2 ]
                ]

        _ ->
            div [] [ text "LOADING" ]

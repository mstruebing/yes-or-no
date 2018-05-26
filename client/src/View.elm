module View exposing (view)

---- ELM -----
---- OWN ----

import Html exposing (Html, div, p, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Lib.Question exposing (Question, Statistics)
import RemoteData exposing (WebData)
import Types exposing (Model, Msg(..))


view : Model -> Html Msg
view model =
    div [ class "app", onClick FetchRandomQuestion ]
        [ printQuestion model.question model.statistics model.answered
        ]


shouldPrintStatistics : WebData Question -> WebData Statistics -> Bool
shouldPrintStatistics maybeQuestion maybeStatistics =
    case maybeQuestion of
        RemoteData.Success question ->
            case maybeStatistics of
                RemoteData.Success statistics ->
                    statistics.id == question.id

                _ ->
                    False

        _ ->
            False



-- this is hacky as hell and should be refactored asap


printStatistics : Int -> Int -> Int -> Int -> Html Msg
printStatistics option1 option2 answered target =
    if target == 1 then
        toString
            (if answered == 1 then
                option1 + 1
             else
                option1
            )
            |> String.append "% / "
            |> String.append
                (toString
                    (100
                        // (option1 + 1 + option2)
                        * (if answered == 1 then
                            option1 + 1
                           else
                            option1
                          )
                    )
                )
            |> text
    else
        toString
            (if answered == 2 then
                option2 + 1
             else
                option2
            )
            |> String.append "% / "
            |> String.append
                (toString
                    (100
                        // (option1 + option2 + 1)
                        * (if answered == 2 then
                            option2 + 1
                           else
                            option2
                          )
                    )
                )
            |> text


printQuestion : WebData Question -> WebData Statistics -> Int -> Html Msg
printQuestion maybeQuestion maybeStatistics answered =
    case maybeQuestion of
        RemoteData.Success question ->
            div [ class "question" ]
                [ p [ class "option", AnswerQuestion question.id 1 |> onClick ]
                    [ text question.option1
                    , if shouldPrintStatistics maybeQuestion maybeStatistics then
                        p [ class "statistics" ]
                            [ case maybeStatistics of
                                RemoteData.Success statistics ->
                                    printStatistics statistics.option1 statistics.option2 answered 1

                                _ ->
                                    text ""
                            ]
                      else
                        text ""
                    ]
                , p [ class "seperator" ]
                    [ text "or"
                    , if shouldPrintStatistics maybeQuestion maybeStatistics then
                        p [ class "statistics" ]
                            [ case maybeStatistics of
                                RemoteData.Success statistics ->
                                    statistics.option1
                                        + statistics.option2
                                        + 1
                                        |> toString
                                        |> text

                                _ ->
                                    text ""
                            ]
                      else
                        text ""
                    ]
                , p
                    [ class "option", AnswerQuestion question.id 2 |> onClick ]
                    [ text question.option2
                    , if shouldPrintStatistics maybeQuestion maybeStatistics then
                        p [ class "statistics" ]
                            [ case maybeStatistics of
                                RemoteData.Success statistics ->
                                    printStatistics statistics.option1 statistics.option2 answered 2

                                _ ->
                                    text ""
                            ]
                      else
                        text ""
                    ]
                ]

        _ ->
            div [] [ text "LOADING" ]

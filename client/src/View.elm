module View exposing (view)

import Html exposing (Html, a, button, div, form, input, p, text)
import Html.Attributes exposing (class, placeholder, type_, value)
import Html.Events exposing (onClick, onInput, onSubmit)
import Lib.Question exposing (Count, Question, Statistics)
import RemoteData exposing (WebData)
import Types exposing (Model, Msg(..))


view : Model -> Html Msg
view model =
    div
        [ class "app"
        , case model.question of
            RemoteData.Success currentQuestion ->
                case model.statistics of
                    RemoteData.Success currentStatistics ->
                        if currentStatistics.id == currentQuestion.id then
                            onClick FetchRandomQuestion
                        else
                            onClick NoOp

                    _ ->
                        onClick NoOp

            _ ->
                onClick NoOp
        ]
        [ printStatistics model.count
        , printMessage model.message
        , printAddQuestionForm model.newQuestion.option1 model.newQuestion.option2
        , printQuestion model.question model.statistics model.answered
        , printClickNote model.answered
        ]


printClickNote : Int -> Html Msg
printClickNote answered =
    if answered /= 0 then
        p [ class "clickNote" ] [ text "Click anywhere to continue" ]
    else
        text ""


printStatistics : WebData Count -> Html Msg
printStatistics maybeCount =
    case maybeCount of
        RemoteData.Success count ->
            div [ class "statistics" ] [ text <| "users: " ++ toString count.users ++ " - questions: " ++ toString count.questions ++ " - answers: " ++ toString count.answers ]

        _ ->
            text "Loading ..."


printAddQuestionForm : String -> String -> Html Msg
printAddQuestionForm firstOption secondOption =
    div [ class "addQuestion" ]
        [ p [] [ text "Add your own question!" ]
        , form [ onSubmit AddNewQuestion ]
            [ input [ value firstOption, onInput OnUpdateNewQuestionOptionOne, placeholder "First option" ] []
            , p [ class "seperator" ] [ text "or" ]
            , input [ value secondOption, onInput OnUpdateNewQuestionOptionTwo, placeholder "Second option" ] []
            , button [ type_ "submit" ] [ text "submit" ]
            ]
        ]


printMessage : String -> Html Msg
printMessage message =
    if String.isEmpty message then
        text ""
    else
        div [ class "message", onClick ClearMessage ] [ text message ]


shouldPrintQuestionStatistics : WebData Question -> WebData Statistics -> Bool
shouldPrintQuestionStatistics maybeQuestion maybeStatistics =
    case maybeQuestion of
        RemoteData.Success question ->
            case maybeStatistics of
                RemoteData.Success statistics ->
                    statistics.id == question.id

                _ ->
                    False

        _ ->
            False


printQuestionStatistics : Int -> Int -> Int -> Int -> Html Msg
printQuestionStatistics option1 option2 answered target =
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
                        // (option1 + option2 + 1)
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
                    [ a [] [ text question.option1 ]
                    , if shouldPrintQuestionStatistics maybeQuestion maybeStatistics then
                        p [ class "statistics" ]
                            [ case maybeStatistics of
                                RemoteData.Success statistics ->
                                    printQuestionStatistics statistics.option1 statistics.option2 answered 1

                                _ ->
                                    text ""
                            ]
                      else
                        text ""
                    ]
                , p [ class "seperator" ]
                    [ text "or"
                    , if shouldPrintQuestionStatistics maybeQuestion maybeStatistics then
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
                    [ a [] [ text question.option2 ]
                    , if shouldPrintQuestionStatistics maybeQuestion maybeStatistics then
                        p [ class "statistics" ]
                            [ case maybeStatistics of
                                RemoteData.Success statistics ->
                                    printQuestionStatistics statistics.option1 statistics.option2 answered 2

                                _ ->
                                    text ""
                            ]
                      else
                        text ""
                    ]
                ]

        _ ->
            div [] [ text "LOADING" ]

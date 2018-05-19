module View exposing (view)

---- ELM -----

import Html exposing (Html, div, text, p)
import Html.Attributes exposing (class)
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
                [ p [ class "option" ]
                    [ text question.option1 ]
                , p [ class "seperator" ]
                    [ text "or" ]
                , p
                    [ class "option" ]
                    [ text question.option2 ]
                ]

        _ ->
            div [] [ text "LOADING" ]

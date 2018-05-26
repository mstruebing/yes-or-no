module Update exposing (update)

---- OWN ----

import Commands exposing (answerQuestion, fetchRandomQuestion, fetchStatistics)
import RemoteData
import Types exposing (Model, Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        FetchRandomQuestion ->
            ( model
            , case model.question of
                RemoteData.Success currentQuestion ->
                    case model.statistics of
                        RemoteData.Success currentStatistics ->
                            if currentQuestion.id == currentStatistics.id then
                                Cmd.batch [ fetchRandomQuestion model.userHash ]
                            else
                                Cmd.none

                        _ ->
                            Cmd.none

                _ ->
                    Cmd.none
            )

        OnFetchRandomQuestion response ->
            ( { model | question = response }, Cmd.none )

        OnFetchStatistics response ->
            ( { model | statistics = response }, Cmd.none )

        OnAnswerQuestion _ ->
            ( model, Cmd.none )

        AnswerQuestion id option ->
            ( { model | answered = option }, Cmd.batch [ answerQuestion { id = id, option = option } model.userHash, fetchStatistics id model.userHash ] )

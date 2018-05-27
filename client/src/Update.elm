module Update exposing (update)

import Commands exposing (addNewQuestion, answerQuestion, fetchCount, fetchRandomQuestion, fetchStatistics)
import Lib.Question exposing (emptyQuestion)
import Types exposing (Model, Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ClearMessage ->
            ( { model | message = "" }
            , Cmd.none
            )

        FetchRandomQuestion ->
            ( { model | answered = 0, message = "" }
            , Cmd.batch
                [ fetchRandomQuestion model.userHash ]
            )

        OnFetchRandomQuestion response ->
            ( { model | question = response }
            , Cmd.none
            )

        OnFetchStatistics response ->
            ( { model | statistics = response }
            , Cmd.none
            )

        OnFetchCount response ->
            ( { model | count = response }
            , Cmd.none
            )

        OnAnswerQuestion _ ->
            ( model
            , Cmd.none
            )

        AnswerQuestion id option ->
            ( { model | answered = option }
            , Cmd.batch
                [ answerQuestion { id = id, option = option } model.userHash
                , fetchStatistics id model.userHash
                , fetchCount
                ]
            )

        AddNewQuestion ->
            ( model
            , Cmd.batch [ addNewQuestion model.newQuestion ]
            )

        OnAddNewQuestion (Ok result) ->
            ( { model | newQuestion = emptyQuestion, message = "Question submitted" }
            , Cmd.none
            )

        OnAddNewQuestion (Err err) ->
            ( { model | message = "Question already in database" }
            , Cmd.none
            )

        OnUpdateNewQuestionOptionOne input ->
            let
                oldQuestion =
                    model.newQuestion

                newQuestion =
                    { oldQuestion | option1 = input }
            in
            ( { model | newQuestion = newQuestion }, Cmd.none )

        OnUpdateNewQuestionOptionTwo input ->
            let
                oldQuestion =
                    model.newQuestion

                newQuestion =
                    { oldQuestion | option2 = input }
            in
            ( { model | newQuestion = newQuestion }, Cmd.none )

module Update exposing (update)

---- OWN ----

import Types exposing (Model, Msg(..))
import Commands exposing (answerQuestion)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        OnFetchRandomQuestion response ->
            ( { model | question = response }, Cmd.none )

        OnAnswerQuestion _ ->
            ( model, Cmd.none )

        AnswerQuestion id option ->
            ( model, Cmd.batch [ answerQuestion { id = id, option = option } model.userHash ] )

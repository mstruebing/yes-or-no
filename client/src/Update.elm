module Update exposing (update)

---- OWN ----

import Types exposing (Model, Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        OnFetchRandomQuestion response ->
            ( { model | question = response }, Cmd.none )

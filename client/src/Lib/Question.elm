module Lib.Question exposing (..)

---- ELM ----

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)


---- OWN ----


type alias Question =
    { id : Int
    , option1 : String
    , option2 : String
    }


emptyQuestion : Question
emptyQuestion =
    { id = 0
    , option1 = ""
    , option2 = ""
    }


randomQuestionsUrl : String
randomQuestionsUrl =
    "http://localhost:3001/random"


questionDecoder : Decode.Decoder Question
questionDecoder =
    decode Question
        |> required "id" Decode.int
        |> required "option1" Decode.string
        |> required "option2" Decode.string

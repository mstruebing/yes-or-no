module Lib.Question exposing (..)

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode


type alias Question =
    { id : Int
    , option1 : String
    , option2 : String
    }


type alias Answer =
    { id : Int
    , option : Int
    }


type alias Statistics =
    { id : Int
    , option1 : Int
    , option2 : Int
    }


type alias Count =
    { answers : Int
    , questions : Int
    , users : Int
    }


emptyQuestion : Question
emptyQuestion =
    { id = 0
    , option1 = ""
    , option2 = ""
    }


emptyStatistic : Statistics
emptyStatistic =
    { id = 0
    , option1 = 0
    , option2 = 0
    }


randomQuestionsUrl : String
randomQuestionsUrl =
    "http://localhost:3001/random"


statisticsUrl : String
statisticsUrl =
    "http://localhost:3001/statistics"


countUrl : String
countUrl =
    "http://localhost:3001/count"


answerQuestionsUrl : String
answerQuestionsUrl =
    "http://localhost:3001/answer"


questionDecoder : Decode.Decoder Question
questionDecoder =
    decode Question
        |> required "id" Decode.int
        |> required "option1" Decode.string
        |> required "option2" Decode.string


statisticsDecoder : Decode.Decoder Statistics
statisticsDecoder =
    decode Statistics
        |> required "id" Decode.int
        |> required "option1" Decode.int
        |> required "option2" Decode.int


countDecoder : Decode.Decoder Count
countDecoder =
    decode Count
        |> required "answers" Decode.int
        |> required "questions" Decode.int
        |> required "users" Decode.int


answerEncoder : Answer -> String -> Encode.Value
answerEncoder answer userHash =
    let
        attributes =
            [ ( "id", Encode.int answer.id ), ( "option", Encode.int answer.option ), ( "userHash", Encode.string userHash ) ]
    in
    Encode.object attributes

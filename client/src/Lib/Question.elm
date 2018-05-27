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


baseUrl : String
baseUrl =
    "http://localhost:3001"


emptyStatistic : Statistics
emptyStatistic =
    { id = 0
    , option1 = 0
    , option2 = 0
    }


randomQuestionsUrl : String
randomQuestionsUrl =
    String.append baseUrl "/random"


statisticsUrl : String
statisticsUrl =
    String.append baseUrl "/statistics"


countUrl : String
countUrl =
    String.append baseUrl "/count"


answerQuestionsUrl : String
answerQuestionsUrl =
    String.append baseUrl "/answer"


newQuestionsUrl : String
newQuestionsUrl =
    String.append baseUrl "/addQuestion"


questionDecoder : Decode.Decoder Question
questionDecoder =
    decode Question
        |> required "id" Decode.int
        |> required "option1" Decode.string
        |> required "option2" Decode.string


questionEncoder : Question -> Encode.Value
questionEncoder question =
    let
        attributes =
            [ ( "id", Encode.int question.id ), ( "option1", Encode.string question.option1 ), ( "option2", Encode.string question.option2 ) ]
    in
    Encode.object attributes


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

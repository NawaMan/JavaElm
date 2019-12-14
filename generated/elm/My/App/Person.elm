module My.App.Person exposing
    ( Person
    , personEncoder
    , personDecoder
    , encodePerson
    , decodePerson
    , personListEncoder
    , personListDecoder
    , encodePersonList
    , decodePersonList
    )

import Json.Decode
import Json.Decode.Pipeline
import Json.Encode


-- elm install elm/json
-- elm install NoRedInk/elm-json-decode-pipeline

type alias Person = 
    { name : String
    , age : Int
    }


personEncoder : Person -> Json.Encode.Value
personEncoder person = 
    Json.Encode.object
        [ ( "name", Json.Encode.string person.name )
        , ( "age", Json.Encode.int person.age )
        ]


personDecoder : Json.Decode.Decoder Person
personDecoder = 
    Json.Decode.succeed Person
        |> Json.Decode.Pipeline.required "name" Json.Decode.string
        |> Json.Decode.Pipeline.required "age" Json.Decode.int


encodePerson : Person -> Int -> String
encodePerson person indent = 
    personEncoder person |> Json.Encode.encode indent


decodePerson : String -> Result Json.Decode.Error Person
decodePerson = 
    Json.Decode.decodeString personDecoder


personListEncoder : List Person -> Json.Encode.Value
personListEncoder personList = 
    Json.Encode.list personEncoder personList


personListDecoder : Json.Decode.Decoder (List Person)
personListDecoder = 
    Json.Decode.list personDecoder


encodePersonList : List Person -> Int -> String
encodePersonList personList indent = 
    personListEncoder personList |> Json.Encode.encode indent


decodePersonList : String -> Result Json.Decode.Error (List Person)
decodePersonList = 
    Json.Decode.decodeString personListDecoder

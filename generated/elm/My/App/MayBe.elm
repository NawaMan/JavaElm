module My.App.MayBe exposing
    ( MayBe
    , mayBeEncoder
    , mayBeDecoder
    , encodeMayBe
    , decodeMayBe
    , mayBeListEncoder
    , mayBeListDecoder
    , encodeMayBeList
    , decodeMayBeList
    )

import Json.Decode
import Json.Decode.Pipeline
import Json.Encode


-- elm install elm/json
-- elm install NoRedInk/elm-json-decode-pipeline

type MayBe
    = Just (Maybe T)
    | Nothing


mayBeEncoder : MayBe -> Json.Encode.Value
mayBeEncoder mayBe = 
    case mayBeEncoder of
        Just data ->
            Json.Encode.object
                [ ( "__tagged", Json.Encode.string "Just" )
                , ( "data", Maybe.withDefault Json.Encode.null (Maybe.map tEncoder data) )
                ]
        Nothing  ->
            Json.Encode.object
                [ ( "__tagged", Json.Encode.string "Nothing" )
                ]


mayBeDecoder : Json.Decode.Decoder MayBe
mayBeDecoder = 
    Json.Decode.field "__tagged" Json.Decode.string
        |> Json.Decode.andThen
            (\str ->
                case str of
                    "Just" ->
                        Json.Decode.succeed Just
                            |> Json.Decode.Pipeline.optional "data" (Json.Decode.nullable tDecoder) Nothing
                    
                    "Nothing" ->
                        Json.Decode.succeed Nothing
                    
                    somethingElse ->
                        Json.Decode.fail <| "Unknown tagged: " ++ somethingElse
    )


encodeMayBe : MayBe -> Int -> String
encodeMayBe mayBe indent = 
    mayBeEncoder mayBe |> Json.Encode.encode indent


decodeMayBe : String -> Result Json.Decode.Error MayBe
decodeMayBe = 
    Json.Decode.decodeString mayBeDecoder


mayBeListEncoder : List MayBe -> Json.Encode.Value
mayBeListEncoder mayBeList = 
    Json.Encode.list mayBeEncoder mayBeList


mayBeListDecoder : Json.Decode.Decoder (List MayBe)
mayBeListDecoder = 
    Json.Decode.list mayBeDecoder


encodeMayBeList : List MayBe -> Int -> String
encodeMayBeList mayBeList indent = 
    mayBeListEncoder mayBeList |> Json.Encode.encode indent


decodeMayBeList : String -> Result Json.Decode.Error (List MayBe)
decodeMayBeList = 
    Json.Decode.decodeString mayBeListDecoder
